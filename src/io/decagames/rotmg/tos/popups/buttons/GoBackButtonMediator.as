// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.tos.popups.buttons.GoBackButtonMediator

package io.decagames.rotmg.tos.popups.buttons{
import io.decagames.rotmg.tos.popups.ToSPopup;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class GoBackButtonMediator extends Mediator {

        [Inject]
        public var view:GoBackButton;
        [Inject]
        public var closePopupSignal:CloseCurrentPopupSignal;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;


        override public function initialize():void{
            this.view.clickSignal.add(this.clickHandler);
        }

        override public function destroy():void{
            this.view.clickSignal.remove(this.clickHandler);
        }

        private function clickHandler(_arg_1:BaseButton):void{
            this.closePopupSignal.dispatch();
            this.showPopupSignal.dispatch(new ToSPopup());
        }


    }
}//package io.decagames.rotmg.tos.popups.buttons

