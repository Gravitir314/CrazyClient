// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.packages.startupPackage.StartupPackageMediator

package io.decagames.rotmg.shop.packages.startupPackage
{
import io.decagames.rotmg.shop.packages.contentPopup.PackageBoxContentPopup;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
import kabam.rotmg.packages.services.PackageModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class StartupPackageMediator extends Mediator 
    {

        [Inject]
        public var view:StartupPackage;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var flush:FlushPopupStartupQueueSignal;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var model:PackageModel;


        override public function initialize():void
        {
            this.view.closeButton.clickSignal.addOnce(this.onClose);
            this.view.infoButton.clickSignal.add(this.showInfo);
        }

        private function onClose(_arg_1:BaseButton):void
        {
            this.closePopupSignal.dispatch(this.view);
            this.flush.dispatch();
        }

        private function showInfo(_arg_1:BaseButton):void
        {
            this.showPopupSignal.dispatch(new PackageBoxContentPopup(this.view.info));
        }

        override public function destroy():void
        {
            this.view.infoButton.clickSignal.remove(this.showInfo);
            this.view.dispose();
        }


    }
}//package io.decagames.rotmg.shop.packages.startupPackage

