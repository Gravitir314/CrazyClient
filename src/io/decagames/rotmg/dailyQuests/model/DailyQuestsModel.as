// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.model.DailyQuestsModel

package io.decagames.rotmg.dailyQuests.model
{
import io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfo;
import io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot;

import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.ui.model.HUDModel;

public class DailyQuestsModel
    {

        private var _questsList:Vector.<DailyQuest> = new Vector.<DailyQuest>();
        private var slots:Vector.<DailyQuestItemSlot> = new Vector.<DailyQuestItemSlot>();
        public var currentQuest:DailyQuest;
        public var isPopupOpened:Boolean;
        public var categoriesWeight:Array = [1, 0, 2, 3, 4];
        public var selectedItem:int = -1;
        [Inject]
        public var hud:HUDModel;


        public function registerSelectableSlot(_arg_1:DailyQuestItemSlot):void{
            this.slots.push(_arg_1);
        }

        public function unregisterSelectableSlot(_arg_1:DailyQuestItemSlot):void{
            var _local_2:int = this.slots.indexOf(_arg_1);
            if (_local_2 != -1){
                this.slots.splice(_local_2, 1);
            }
        }

        public function unselectAllSlots(_arg_1:int):void{
            var _local_2:DailyQuestItemSlot;
            for each (_local_2 in this.slots) {
                if (_local_2.itemID != _arg_1){
                    _local_2.selected = false;
                }
            }
        }

        public function clear():void
        {
            this._questsList = new Vector.<DailyQuest>();
        }

        public function addQuest(_arg_1:DailyQuest):void
        {
            this._questsList.push(_arg_1);
        }

        public function markAsCompleted(_arg_1:String):void
        {
            var _local_2:DailyQuest;
            for each (_local_2 in this._questsList)
            {
                if (_local_2.id == _arg_1)
                {
                    _local_2.completed = true;
                }
            }
        }

        public function get playerItemsFromInventory():Vector.<int>
        {
            return ((this.hud.gameSprite.map.player_) ? this.hud.gameSprite.map.player_.equipment_.slice((GeneralConstants.NUM_EQUIPMENT_SLOTS - 1), (GeneralConstants.NUM_EQUIPMENT_SLOTS + (GeneralConstants.NUM_INVENTORY_SLOTS * 2))) : new Vector.<int>());
        }

        public function hasQuests():Boolean
        {
            return (this._questsList.length > 0);
        }

        public function get numberOfActiveQuests():int
        {
            return (this._questsList.length);
        }

        public function get numberOfCompletedQuests():int
        {
            var _local_2:DailyQuest;
            var _local_1:int;
            for each (_local_2 in this._questsList)
            {
                if (_local_2.completed)
                {
                    _local_1++;
                }
            }
            return (_local_1);
        }

        public function get questsList():Vector.<DailyQuest>
        {
            var _local_1:Vector.<DailyQuest> = this._questsList.concat();
            return (_local_1.sort(this.questsCompleteSort));
        }

        private function questsNameSort(_arg_1:DailyQuest, _arg_2:DailyQuest):int
        {
            if (_arg_1.name > _arg_2.name)
            {
                return (1);
            }
            return (-1);
        }

        private function sortByCategory(_arg_1:DailyQuest, _arg_2:DailyQuest):int
        {
            if (this.categoriesWeight[_arg_1.category] < this.categoriesWeight[_arg_2.category])
            {
                return (-1);
            }
            if (this.categoriesWeight[_arg_1.category] > this.categoriesWeight[_arg_2.category])
            {
                return (1);
            }
            return (this.questsNameSort(_arg_1, _arg_2));
        }

        private function questsReadySort(_arg_1:DailyQuest, _arg_2:DailyQuest):int
        {
            var _local_3:Boolean = DailyQuestInfo.hasAllItems(_arg_1.requirements, this.playerItemsFromInventory);
            var _local_4:Boolean = DailyQuestInfo.hasAllItems(_arg_2.requirements, this.playerItemsFromInventory);
            if (((_local_3) && (!(_local_4))))
            {
                return (-1);
            }
            if (((_local_3) && (_local_4)))
            {
                return (this.questsNameSort(_arg_1, _arg_2));
            }
            return (1);
        }

        private function questsCompleteSort(_arg_1:DailyQuest, _arg_2:DailyQuest):int
        {
            if (((_arg_1.completed) && (!(_arg_2.completed))))
            {
                return (1);
            }
            if (((_arg_1.completed) && (_arg_2.completed)))
            {
                return (this.sortByCategory(_arg_1, _arg_2));
            }
            if (((!(_arg_1.completed)) && (!(_arg_2.completed))))
            {
                return (this.sortByCategory(_arg_1, _arg_2));
            }
            return (-1);
        }

        public function getQuestById(_arg_1:String):DailyQuest
        {
            var _local_2:DailyQuest;
            for each (_local_2 in this._questsList)
            {
                if (_local_2.id == _arg_1)
                {
                    return (_local_2);
                }
            }
            return (null);
        }

        public function get first():DailyQuest
        {
            if (this._questsList.length > 0)
            {
                return (this.questsList[0]);
            }
            return (null);
        }


    }
}//package io.decagames.rotmg.dailyQuests.model

