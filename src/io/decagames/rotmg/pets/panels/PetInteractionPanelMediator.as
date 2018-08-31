//io.decagames.rotmg.pets.panels.PetInteractionPanelMediator

package io.decagames.rotmg.pets.panels
{
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.StageProxy;

import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import io.decagames.rotmg.pets.windows.wardrobe.PetWardrobeWindow;
import io.decagames.rotmg.ui.popups.signals.ClosePopupByClassSignal;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.dialogs.control.OpenDialogNoModalSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PetInteractionPanelMediator extends Mediator
    {

        [Inject]
        public var view:PetInteractionPanel;
        [Inject]
        public var openNoModalDialog:OpenDialogNoModalSignal;
        [Inject]
        public var openDialog:ShowPopupSignal;
        [Inject]
        public var closePopupByClassSignal:ClosePopupByClassSignal;
        private var stageProxy:StageProxy;
        private var open:Boolean;


        override public function initialize():void
        {
            this.open = false;
            this.view.init();
            this.stageProxy = new StageProxy(this.view);
            this.setEventListeners();
        }

        private function setEventListeners():void
        {
            this.view.wardrobeButton.addEventListener(MouseEvent.CLICK, this.onWardrobe);
            this.stageProxy.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        }

        override public function destroy():void
        {
            this.view.wardrobeButton.removeEventListener(MouseEvent.CLICK, this.onWardrobe);
            this.stageProxy.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            this.closePopupByClassSignal.dispatch(PetWardrobeWindow);
            super.destroy();
        }

        protected function onWardrobe(_arg_1:MouseEvent):void
        {
            this.openWardrobe();
        }

        protected function onKeyDown(_arg_1:KeyboardEvent):void
        {
            if (((_arg_1.keyCode == Parameters.data_.interact) && (this.view.stage.focus == null)))
            {
                this.openWardrobe();
            }
        }

        private function openWardrobe():void
        {
            this.openDialog.dispatch(new PetWardrobeWindow());
        }


    }
}//package io.decagames.rotmg.pets.panels

