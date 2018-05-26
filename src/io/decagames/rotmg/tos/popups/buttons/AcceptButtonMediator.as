// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.tos.popups.buttons.AcceptButtonMediator

package io.decagames.rotmg.tos.popups.buttons{
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;

import robotlegs.bender.bundles.mvcs.Mediator;

public class AcceptButtonMediator extends Mediator {

        [Inject]
        public var view:AcceptButton;
        [Inject]
        public var appEngineClient:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var closePopupSignal:CloseCurrentPopupSignal;


        override public function initialize():void{
            this.view.clickSignal.add(this.onClickHandler);
        }

        override public function destroy():void{
            this.view.clickSignal.remove(this.onClickHandler);
        }

        private function onClickHandler(_arg_1:BaseButton):void{
            var _local_2:Object = this.account.getCredentials();
            this.appEngineClient.sendRequest("account/acceptTOS", _local_2);
            this.closePopupSignal.dispatch();
        }


    }
}//package io.decagames.rotmg.tos.popups.buttons

