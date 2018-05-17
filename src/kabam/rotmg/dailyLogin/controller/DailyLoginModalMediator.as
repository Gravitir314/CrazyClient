//kabam.rotmg.dailyLogin.controller.DailyLoginModalMediator

package kabam.rotmg.dailyLogin.controller
{
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.parameters.Parameters;

import flash.events.MouseEvent;
import flash.globalization.DateTimeFormatter;

import kabam.rotmg.dailyLogin.model.DailyLoginModel;
import kabam.rotmg.dailyLogin.view.DailyLoginModal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.game.signals.ExitGameSignal;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class DailyLoginModalMediator extends Mediator 
    {

        [Inject]
        public var view:DailyLoginModal;
        [Inject]
        public var closeDialogs:CloseDialogsSignal;
        [Inject]
        public var dailyLoginModel:DailyLoginModel;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var exitGameSignal:ExitGameSignal;
        [Inject]
        public var closeDialog:CloseDialogsSignal;


        override public function initialize():void
        {
            this.view.init(this.dailyLoginModel);
            this.view.addTitle("Login Rewards");
            this.view.addCloseButton();
            var _local_1:DateTimeFormatter = new DateTimeFormatter("en-US");
            _local_1.setDateTimePattern("yyyy-MM-dd hh:mm:ssa");
            var _local_2:Date = new Date();
            var _local_3:Date = new Date(_local_2.fullYear, (_local_2.month + 1), 1, 0, 0, 0);
            _local_3.time--;
            this.view.showLegend((this.hudModel.gameSprite.map.name_ == Map.DAILY_QUEST_ROOM));
            this.view.showServerTime(_local_1.formatUTC(this.dailyLoginModel.getServerTime()), _local_1.format(_local_3));
            if (this.hudModel.gameSprite.map.name_ != Map.DAILY_QUEST_ROOM)
            {
                this.view.claimButton.addEventListener(MouseEvent.CLICK, this.onClaimClickHandler);
                this.view.addEventListener(MouseEvent.CLICK, this.onPopupClickHandler);
            }
            Parameters.data_.calendarShowOnDay = this.dailyLoginModel.getTimestampDay();
            Parameters.save();
            this.dailyLoginModel.shouldDisplayCalendarAtStartup = false;
            this.view.closeButton.clicked.add(this.onCloseButtonClicked);
        }

        public function onCloseButtonClicked():*
        {
            this.view.closeButton.clicked.remove(this.onCloseButtonClicked);
            this.closeDialogs.dispatch();
        }

        override public function destroy():void
        {
            if (this.hudModel.gameSprite.map.name_ != Map.DAILY_QUEST_ROOM)
            {
                this.view.claimButton.removeEventListener(MouseEvent.CLICK, this.onClaimClickHandler);
                this.view.removeEventListener(MouseEvent.CLICK, this.onPopupClickHandler);
            }
            this.view.closeButton.clicked.remove(this.onCloseButtonClicked);
            super.destroy();
        }

        private function enterPortal():void
        {
            this.closeDialogs.dispatch();
            this.hudModel.gameSprite.gsc_.gotoQuestRoom();
        }

        private function onClaimClickHandler(_arg_1:MouseEvent):void
        {
            this.enterPortal();
        }

        private function onPopupClickHandler(_arg_1:MouseEvent):void
        {
            if (_arg_1.target != DialogCloseButton)
            {
                this.enterPortal();
            }
        }


    }
}//package kabam.rotmg.dailyLogin.controller

