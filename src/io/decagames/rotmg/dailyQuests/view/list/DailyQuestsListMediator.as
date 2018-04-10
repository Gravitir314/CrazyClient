// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.list.DailyQuestsListMediator

package io.decagames.rotmg.dailyQuests.view.list
{
import io.decagames.rotmg.dailyQuests.model.DailyQuest;
import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
import io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfo;

import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class DailyQuestsListMediator extends Mediator 
    {

        [Inject]
        public var view:DailyQuestsList;
        [Inject]
        public var model:DailyQuestsModel;
        [Inject]
        public var hud:HUDModel;
        private var hasEvent:Boolean;


        override public function initialize():void
        {
            var _local_4:DailyQuest;
            var _local_5:DailyQuestListElement;
            var _local_1:Vector.<DailyQuest> = this.model.questsList;
            var _local_2:Boolean = true;
            this.view.tabs.buttonsRenderedSignal.addOnce(this.onAddedHandler);
            var _local_3:Vector.<int> = ((this.hud.gameSprite.map.player_) ? this.hud.gameSprite.map.player_.equipment_.slice((GeneralConstants.NUM_EQUIPMENT_SLOTS - 1), (GeneralConstants.NUM_EQUIPMENT_SLOTS + (GeneralConstants.NUM_INVENTORY_SLOTS * 2))) : new Vector.<int>());
            for each (_local_4 in _local_1)
            {
                _local_5 = new DailyQuestListElement(_local_4.id, _local_4.name, _local_4.completed, DailyQuestInfo.hasAllItems(_local_4.requirements, _local_3), _local_4.category);
                if (_local_2)
                {
                    _local_5.isSelected = true;
                }
                _local_2 = false;
                if (_local_4.category == 3){
                    this.hasEvent = true;
                    this.view.addEventToList(_local_5);
                } else {
                    this.view.addQuestToList(_local_5);
                }
            }
        }

        private function onAddedHandler():void{
            if (this.hasEvent){
                this.view.addIndicator(this.hasEvent);
            }
        }


        override public function destroy():void
        {
            this.view.tabs.buttonsRenderedSignal.remove(this.onAddedHandler);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.list

