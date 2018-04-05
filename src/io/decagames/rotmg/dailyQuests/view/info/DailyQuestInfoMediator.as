// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfoMediator

package io.decagames.rotmg.dailyQuests.view.info
{
import com.company.assembleegameclient.objects.Player;

import flash.events.MouseEvent;

import io.decagames.rotmg.dailyQuests.model.DailyQuest;
import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
import io.decagames.rotmg.dailyQuests.signal.LockQuestScreenSignal;
import io.decagames.rotmg.dailyQuests.signal.QuestRedeemCompleteSignal;
import io.decagames.rotmg.dailyQuests.signal.ShowQuestInfoSignal;

import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class DailyQuestInfoMediator extends Mediator 
    {

        [Inject]
        public var showInfoSignal:ShowQuestInfoSignal;
        [Inject]
        public var view:DailyQuestInfo;
        [Inject]
        public var model:DailyQuestsModel;
        [Inject]
        public var hud:HUDModel;
        [Inject]
        public var redeemCompleteSignal:QuestRedeemCompleteSignal;
        [Inject]
        public var lockScreen:LockQuestScreenSignal;


        override public function initialize():void
        {
            this.showInfoSignal.add(this.showQuestInfo);
            var _local_1:DailyQuest = this.model.first;
            if (_local_1)
            {
                this.showQuestInfo(_local_1.id);
            }
            this.view.completeButton.addEventListener(MouseEvent.CLICK, this.onCompleteButtonClickHandler);
        }

        override public function destroy():void
        {
            this.view.completeButton.removeEventListener(MouseEvent.CLICK, this.onCompleteButtonClickHandler);
            this.showInfoSignal.remove(this.showQuestInfo);
        }

        private function showQuestInfo(_arg_1:String):void
        {
            this.view.clear();
            this.model.currentQuest = this.model.getQuestById(_arg_1);
            this.view.show(this.model.currentQuest, this.model.playerItemsFromInventory);
        }

        private function makeSlotObject(_arg_1:int, _arg_2:int):SlotObjectData
        {
            var _local_3:SlotObjectData;
            _local_3 = new SlotObjectData();
            _local_3.objectId_ = this.hud.gameSprite.map.player_.objectId_;
            _local_3.objectType_ = _arg_2;
            _local_3.slotId_ = _arg_1;
            return (_local_3);
        }

        private function onCompleteButtonClickHandler(_arg_1:MouseEvent):void
        {
            var _local_2:Vector.<SlotObjectData>;
            var _local_3:Vector.<int>;
            var _local_4:int;
            var _local_5:int;
            var _local_6:Player = this.hud.gameSprite.map.player_;
            if (((this.view.completeButton.enabled) && (!(this.view.completeButton.completed))))
            {
                _local_2 = new Vector.<SlotObjectData>();
                _local_3 = this.model.currentQuest.requirements.concat();
                _local_4 = 4;
                while (_local_4 < _local_6.equipment_.length)
                {
                    if (_local_6.equipment_[_local_4] != -1)
                    {
                        _local_5 = _local_6.equipment_[_local_4];
                        if (_local_3.indexOf(_local_5) > -1)
                        {
                            _local_2.push(this.makeSlotObject(_local_4, _local_5));
                            _local_3.splice(_local_3.indexOf(_local_5), 1);
                        }
                    }
                    _local_4++;
                }
                this.lockScreen.dispatch();
                this.hud.gameSprite.gsc_.questRedeem(this.model.currentQuest.id, _local_2);
            }
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.info

