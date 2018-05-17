//kabam.rotmg.classes.control.ParseCharListXmlCommand

package kabam.rotmg.classes.control
{
import io.decagames.rotmg.characterMetrics.tracker.CharactersMetricsTracker;

import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.CharacterSkinState;
import kabam.rotmg.classes.model.ClassesModel;

import robotlegs.bender.framework.api.ILogger;

public class ParseCharListXmlCommand
    {

        [Inject]
        public var data:XML;
        [Inject]
        public var model:ClassesModel;
        [Inject]
        public var logger:ILogger;
        [Inject]
        public var statsTracker:CharactersMetricsTracker;


        public function execute():void
        {
            this.parseMaxLevelsAchieved();
            this.parseItemCosts();
            this.parseOwnership();
            this.statsTracker.parseCharListData(this.data);
        }

        private function parseMaxLevelsAchieved():void
        {
            var _local_1:XML;
            var _local_2:CharacterClass;
            var _local_3:XMLList = this.data.MaxClassLevelList.MaxClassLevel;
            for each (_local_1 in _local_3)
            {
                _local_2 = this.model.getCharacterClass(_local_1.@classType);
                _local_2.setMaxLevelAchieved(_local_1.@maxLevel);
            }
        }

        private function parseItemCosts():void
        {
            var _local_1:XML;
            var _local_2:CharacterSkin;
            var _local_3:XMLList = this.data.ItemCosts.ItemCost;
            for each (_local_1 in _local_3)
            {
                _local_2 = this.model.getCharacterSkin(_local_1.@type);
                if (_local_2)
                {
                    _local_2.cost = int(_local_1);
                    _local_2.limited = Boolean(int(_local_1.@expires));
                    if (((!(Boolean(int(_local_1.@purchasable)))) && (!(_local_2.id == 0))))
                    {
                        _local_2.setState(CharacterSkinState.UNLISTED);
                    }
                }
                else
                {
                    this.logger.warn("Cannot set Character Skin cost: type {0} not found", [_local_1.@type]);
                }
            }
        }

        private function parseOwnership():void
        {
            var _local_1:int;
            var _local_2:CharacterSkin;
            var _local_3:Array = ((this.data.OwnedSkins.length()) ? this.data.OwnedSkins.split(",") : []);
            for each (_local_1 in _local_3)
            {
                _local_2 = this.model.getCharacterSkin(_local_1);
                if (_local_2)
                {
                    _local_2.setState(CharacterSkinState.OWNED);
                }
                else
                {
                    this.logger.warn("Cannot set Character Skin ownership: type {0} not found", [_local_1]);
                }
            }
        }


    }
}//package kabam.rotmg.classes.control

