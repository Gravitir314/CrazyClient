// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.popups.modal.buttons.BuyGoldButtonMediator

package io.decagames.rotmg.ui.popups.modal.buttons
{
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;

import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class BuyGoldButtonMediator extends Mediator 
    {

        [Inject]
        public var closeSignal:CloseCurrentPopupSignal;
        [Inject]
        public var view:BuyGoldButton;
        [Inject]
        public var openMoneyWindow:OpenMoneyWindowSignal;


        override public function initialize():void
        {
            this.view.clickSignal.addOnce(this.buyGoldHandler);
        }

        override public function destroy():void
        {
            this.view.clickSignal.remove(this.buyGoldHandler);
        }

        private function buyGoldHandler(_arg_1:BaseButton):void
        {
            this.closeSignal.dispatch();
            this.openMoneyWindow.dispatch();
        }


    }
}//package io.decagames.rotmg.ui.popups.modal.buttons

