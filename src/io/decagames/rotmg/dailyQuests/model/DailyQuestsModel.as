// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.model.DailyQuestsModel

package io.decagames.rotmg.dailyQuests.model
{
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.constants.GeneralConstants;
    import io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfo;

    public class DailyQuestsModel 
    {

        private var _questsList:Vector.<DailyQuest> = new Vector.<DailyQuest>();
        public var currentQuest:DailyQuest;
        public var isPopupOpened:Boolean;
        [Inject]
        public var hud:HUDModel;


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
                };
            };
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
            var _local_1:DailyQuest;
            var _local_2:int;
            for each (_local_1 in this._questsList)
            {
                if (_local_1.completed)
                {
                    _local_2++;
                };
            };
            return (_local_2);
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
            };
            return (-1);
        }

        private function questsReadySort(_arg_1:DailyQuest, _arg_2:DailyQuest):int
        {
            var _local_3:Boolean = DailyQuestInfo.hasAllItems(_arg_1.requirements, this.playerItemsFromInventory);
            var _local_4:Boolean = DailyQuestInfo.hasAllItems(_arg_2.requirements, this.playerItemsFromInventory);
            if (((_local_3) && (!(_local_4))))
            {
                return (-1);
            };
            if (((_local_3) && (_local_4)))
            {
                return (this.questsNameSort(_arg_1, _arg_2));
            };
            return (1);
        }

        private function questsCompleteSort(_arg_1:DailyQuest, _arg_2:DailyQuest):int
        {
            if (((_arg_1.completed) && (!(_arg_2.completed))))
            {
                return (1);
            };
            if (((_arg_1.completed) && (_arg_2.completed)))
            {
                return (this.questsReadySort(_arg_1, _arg_2));
            };
            if (((!(_arg_1.completed)) && (!(_arg_2.completed))))
            {
                return (this.questsReadySort(_arg_1, _arg_2));
            };
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
                };
            };
            return (null);
        }

        public function get first():DailyQuest
        {
            if (this._questsList.length > 0)
            {
                return (this.questsList[0]);
            };
            return (null);
        }


    }
}//package io.decagames.rotmg.dailyQuests.model

