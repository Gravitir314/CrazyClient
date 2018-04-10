// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.ui.popups.modal.ConfirmationModalMediator

package io.decagames.rotmg.ui.popups.modal{
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ConfirmationModalMediator extends Mediator {

        [Inject]
        public var view:ConfirmationModal;
        [Inject]
        public var closeSignal:CloseCurrentPopupSignal;


        override public function initialize():void{
            this.view.confirmButton.clickSignal.addOnce(this.onConfirmClicked);
        }

        private function onConfirmClicked(_arg_1:BaseButton):void{
            this.closeSignal.dispatch();
        }

        override public function destroy():void{
            this.view.confirmButton.clickSignal.remove(this.onConfirmClicked);
        }


    }
}//package io.decagames.rotmg.ui.popups.modal

