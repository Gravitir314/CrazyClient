// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.popup.DailyQuestRedeemPopupMediator

package io.decagames.rotmg.dailyQuests.view.popup
{
import flash.events.MouseEvent;

import io.decagames.rotmg.dailyQuests.signal.CloseRedeemPopupSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class DailyQuestRedeemPopupMediator extends Mediator 
    {

        [Inject]
        public var view:DailyQuestRedeemPopup;
        [Inject]
        public var closeRedeem:CloseRedeemPopupSignal;


        override public function destroy():void
        {
            this.view.thanksButton.removeEventListener(MouseEvent.CLICK, this.onThanksClickedHandler);
        }

        override public function initialize():void
        {
            this.view.thanksButton.addEventListener(MouseEvent.CLICK, this.onThanksClickedHandler);
        }

        private function onThanksClickedHandler(_arg_1:MouseEvent):void
        {
            this.view.thanksButton.removeEventListener(MouseEvent.CLICK, this.onThanksClickedHandler);
            this.closeRedeem.dispatch();
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.popup

