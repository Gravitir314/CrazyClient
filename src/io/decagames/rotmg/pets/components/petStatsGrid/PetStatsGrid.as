//io.decagames.rotmg.pets.components.petStatsGrid.PetStatsGrid

package io.decagames.rotmg.pets.components.petStatsGrid
{
import flash.text.TextFormatAlign;

import io.decagames.rotmg.pets.data.vo.AbilityVO;
import io.decagames.rotmg.pets.data.vo.IPetVO;
import io.decagames.rotmg.ui.ProgressBar;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.gird.UIGrid;

public class PetStatsGrid extends UIGrid
    {

        private var _petVO:IPetVO;
        private var abilityBars:Vector.<ProgressBar>;

        public function PetStatsGrid(_arg_1:int, _arg_2:IPetVO)
        {
            super(_arg_1, 1, 3);
            this.abilityBars = new Vector.<ProgressBar>();
            this._petVO = _arg_2;
            if (_arg_2)
            {
                this.refreshAbilities(_arg_2);
            }
        }

        public function renderSimulation(_arg_1:Array):void
        {
            var _local_3:AbilityVO;
            var _local_2:int;
            for each (_local_3 in _arg_1)
            {
                this.renderAbilitySimulation(_local_3, _local_2);
                _local_2++;
            }
        }

        private function refreshAbilities(_arg_1:IPetVO):void
        {
            var _local_3:AbilityVO;
            var _local_2:int;
            for each (_local_3 in _arg_1.abilityList)
            {
                this.renderAbility(_local_3, _local_2);
                _local_2++;
            }
        }

        private function renderAbilitySimulation(_arg_1:AbilityVO, _arg_2:int):void
        {
            if (_arg_1.getUnlocked())
            {
                this.abilityBars[_arg_2].simulatedValue = _arg_1.level;
            }
        }

        private function renderAbility(_arg_1:AbilityVO, _arg_2:int):void
        {
            var _local_3:ProgressBar;
            if (this.abilityBars.length > _arg_2)
            {
                _local_3 = this.abilityBars[_arg_2];
                if (((!(_local_3.maxValue == this._petVO.maxAbilityPower)) && (_arg_1.getUnlocked())))
                {
                    _local_3.maxValue = this._petVO.maxAbilityPower;
                    _local_3.value = _arg_1.level;
                }
                if (((!(_local_3.value == _arg_1.level)) && (_arg_1.getUnlocked())))
                {
                    _local_3.dynamicLabelString = ((("Lvl. " + ProgressBar.DYNAMIC_LABEL_TOKEN) + " / ") + ProgressBar.MAX_VALUE_TOKEN);
                    _local_3.value = _arg_1.level;
                }
            }
            else
            {
                _local_3 = new ProgressBar(150, 4, _arg_1.name, ((_arg_1.getUnlocked()) ? ((("Lvl. " + ProgressBar.DYNAMIC_LABEL_TOKEN) + " / ") + ProgressBar.MAX_VALUE_TOKEN) : ""), 0, this._petVO.maxAbilityPower, ((_arg_1.getUnlocked()) ? _arg_1.level : 0), 0x545454, 15306295, 6538829);
                _local_3.showMaxLabel = true;
                _local_3.maxColor = 6538829;
                DefaultLabelFormat.petStatLabelLeft(_local_3.staticLabel, 0xFFFFFF);
                DefaultLabelFormat.petStatLabelRight(_local_3.dynamicLabel, 0xFFFFFF);
                DefaultLabelFormat.petStatLabelRight(_local_3.maxLabel, 6538829, true);
                _local_3.simulatedValueTextFormat = DefaultLabelFormat.createTextFormat(12, 6538829, TextFormatAlign.RIGHT, true);
                this.abilityBars.push(_local_3);
                addGridElement(_local_3);
            }
            if (!_arg_1.getUnlocked())
            {
                _local_3.alpha = 0.4;
            }
            else
            {
                if (_local_3.alpha != 1)
                {
                    _local_3.dynamicLabelString = ((("Lvl. " + ProgressBar.DYNAMIC_LABEL_TOKEN) + " / ") + ProgressBar.MAX_VALUE_TOKEN);
                    _local_3.maxValue = this._petVO.maxAbilityPower;
                    _local_3.value = _arg_1.level;
                }
                _local_3.alpha = 1;
            }
        }

        public function updateVO(_arg_1:IPetVO):void
        {
            if (this._petVO != _arg_1)
            {
                this.abilityBars = new Vector.<ProgressBar>();
                clearGrid();
            }
            this._petVO = _arg_1;
            if (this._petVO != null)
            {
                this.refreshAbilities(_arg_1);
            }
        }

        public function get petVO():IPetVO
        {
            return (this._petVO);
        }


    }
}//package io.decagames.rotmg.pets.components.petStatsGrid

