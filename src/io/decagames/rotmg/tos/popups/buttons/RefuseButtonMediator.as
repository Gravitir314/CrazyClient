// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.tos.popups.buttons.RefuseButtonMediator

package io.decagames.rotmg.tos.popups.buttons{
import io.decagames.rotmg.tos.popups.RefusePopup;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class RefuseButtonMediator extends Mediator {

        [Inject]
        public var view:RefuseButton;
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
            this.showPopupSignal.dispatch(new RefusePopup());
        }


    }
}//package io.decagames.rotmg.tos.popups.buttons

