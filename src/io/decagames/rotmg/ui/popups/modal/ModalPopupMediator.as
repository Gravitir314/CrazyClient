// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.popups.modal.ModalPopupMediator

package io.decagames.rotmg.ui.popups.modal
{
import flash.events.Event;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ModalPopupMediator extends Mediator 
    {

        [Inject]
        public var view:ModalPopup;
        private var lastContentHeight:int = 0;


        override public function initialize():void
        {
            if (this.view.autoSize)
            {
                this.lastContentHeight = this.view.contentContainer.height;
                this.view.resize();
                this.view.addEventListener(Event.ENTER_FRAME, this.checkForUpdates);
            }
        }

        override public function destroy():void
        {
            this.view.removeEventListener(Event.ENTER_FRAME, this.checkForUpdates);
            this.view.dispose();
        }

        private function checkForUpdates(_arg_1:Event):void
        {
            if (this.view.contentContainer.height != this.lastContentHeight)
            {
                this.lastContentHeight = this.view.contentContainer.height;
                this.view.resize();
            }
        }


    }
}//package io.decagames.rotmg.ui.popups.modal

