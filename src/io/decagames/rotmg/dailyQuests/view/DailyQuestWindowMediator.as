// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.DailyQuestWindowMediator

package io.decagames.rotmg.dailyQuests.view
{
import com.company.assembleegameclient.ui.tooltip.TextToolTip;

import flash.events.Event;
import flash.events.MouseEvent;

import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
import io.decagames.rotmg.dailyQuests.signal.CloseRedeemPopupSignal;
import io.decagames.rotmg.dailyQuests.signal.LockQuestScreenSignal;
import io.decagames.rotmg.dailyQuests.signal.QuestRedeemCompleteSignal;
import io.decagames.rotmg.utils.date.TimeSpan;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.dailyLogin.model.DailyLoginModel;
import kabam.rotmg.messaging.impl.incoming.QuestRedeemResponse;
import kabam.rotmg.tooltips.HoverTooltipDelegate;

import robotlegs.bender.bundles.mvcs.Mediator;

public class DailyQuestWindowMediator extends Mediator 
    {

        [Inject]
        public var view:DailyQuestWindow;
        [Inject]
        public var lockScreen:LockQuestScreenSignal;
        [Inject]
        public var redeemCompleteSignal:QuestRedeemCompleteSignal;
        [Inject]
        public var dailyQuestsModel:DailyQuestsModel;
        [Inject]
        public var closeRedeem:CloseRedeemPopupSignal;
        [Inject]
        public var dailyLoginModel:DailyLoginModel;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipsSignal:HideTooltipsSignal;
        private var toolTip:TextToolTip;
        private var hoverTooltipDelegate:HoverTooltipDelegate = new HoverTooltipDelegate();


        override public function initialize():void
        {
            this.lockScreen.add(this.onLockScreen);
            this.redeemCompleteSignal.add(this.onRedeemComplete);
            this.closeRedeem.add(this.onRedeemClose);
            this.view.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseClickHandler);
            this.view.addEventListener(Event.ENTER_FRAME, this.updateTimeHandler);
            this.view.setCompletedCounter(this.dailyQuestsModel.numberOfCompletedQuests, this.dailyQuestsModel.numberOfActiveQuests);
            this.setToolTipTitle("Daily Quests", 'Complete the quests to earn great rewards!\n\nYou can select a quest from the list to display the quest requirements. Bring the items back to me to complete the quest and rewards will be sent directly to your Gift Chest.\n\nItems will be directly consumed from your inventory or backpack when you press "Complete!".\n\nYou can complete each quest only once per day but the Tinkerer will offer you new quests everyday!');
        }

        private function setToolTipTitle(_arg_1:String, _arg_2:String):void
        {
            this.toolTip = new TextToolTip(0x363636, 0x9B9B9B, _arg_1, _arg_2, 300, null);
            this.hoverTooltipDelegate.setDisplayObject(this.view.infoButton);
            this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipsSignal);
            this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.hoverTooltipDelegate.tooltip = this.toolTip;
        }

        private function updateTimeHandler(_arg_1:Event):void
        {
            var _local_2:Date = this.dailyLoginModel.getServerTime();
            var _local_3:Date = new Date();
            _local_3.setTime((_local_2.valueOf() + 86400000));
            _local_3.setUTCHours(0);
            _local_3.setUTCMinutes(0);
            _local_3.setUTCSeconds(0);
            _local_3.setUTCMilliseconds(0);
            var _local_4:TimeSpan = new TimeSpan((_local_3.valueOf() - _local_2.valueOf()));
            var _local_5:* = (((("Quests refresh in " + ((_local_4.hours > 9) ? _local_4.hours.toString() : ("0" + _local_4.hours.toString()))) + "h ") + ((_local_4.minutes > 9) ? _local_4.minutes.toString() : ("0" + _local_4.minutes.toString()))) + "m");
            this.view.setQuestRefreshHeader(_local_5);
        }

        override public function destroy():void
        {
            this.lockScreen.remove(this.onLockScreen);
            this.redeemCompleteSignal.remove(this.onRedeemComplete);
            this.closeRedeem.remove(this.onRedeemClose);
            this.view.closeButton.removeEventListener(MouseEvent.CLICK, this.onCloseClickHandler);
            this.view.removeEventListener(Event.ENTER_FRAME, this.updateTimeHandler);
            this.dailyQuestsModel.isPopupOpened = false;
            this.toolTip = null;
            this.hoverTooltipDelegate.removeDisplayObject();
            this.hoverTooltipDelegate = null;
        }

        private function onCloseClickHandler(_arg_1:MouseEvent):void
        {
            this.view.parent.removeChild(this.view);
        }

        private function onRedeemComplete(_arg_1:QuestRedeemResponse):void
        {
            var _local_2:String;
            if (_arg_1.ok)
            {
                _local_2 = this.dailyQuestsModel.currentQuest.id;
                this.dailyQuestsModel.markAsCompleted(this.dailyQuestsModel.currentQuest.id);
                this.dailyQuestsModel.currentQuest.completed = true;
                this.view.renderList();
                this.view.renderQuestInfo();
                this.view.setCompletedCounter(this.dailyQuestsModel.numberOfCompletedQuests, this.dailyQuestsModel.numberOfActiveQuests);
                this.view.hideFade();
                this.view.showFade(0x151515, (this.dailyQuestsModel.numberOfCompletedQuests == this.dailyQuestsModel.numberOfActiveQuests));
                this.showRewardsPopup(_local_2);
            };
        }

        private function onLockScreen():void
        {
            this.view.showFade();
        }

        private function onRedeemClose():void
        {
            this.view.hideFade();
            this.view.hideRewardsPopup();
        }

        private function showRewardsPopup(_arg_1:String):void
        {
            this.view.showRewardsPopup(this.dailyQuestsModel.getQuestById(_arg_1));
        }


    }
}//package io.decagames.rotmg.dailyQuests.view

