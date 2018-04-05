// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.scroll.UIScrollbarMediator

package io.decagames.rotmg.ui.scroll
{
import flash.events.Event;
import flash.events.MouseEvent;

import robotlegs.bender.bundles.mvcs.Mediator;
import robotlegs.bender.framework.api.ILogger;

public class UIScrollbarMediator extends Mediator 
    {

        [Inject]
        public var view:UIScrollbar;
        [Inject]
        public var logger:ILogger;
        private var startDragging:Boolean;
        private var startY:Number;


        override public function initialize():void
        {
            this.view.addEventListener(Event.ENTER_FRAME, this.onUpdateHandler);
            this.view.slider.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            WebMain.STAGE.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }

        private function onMouseWheel(_arg_1:MouseEvent):void
        {
            _arg_1.stopImmediatePropagation();
            _arg_1.stopPropagation();
            this.view.updatePosition((-(_arg_1.delta) * this.view.mouseRollSpeedFactor));
        }

        private function onMouseDown(_arg_1:Event):void
        {
            this.startDragging = true;
            this.startY = WebMain.STAGE.mouseY;
        }

        private function onMouseUp(_arg_1:Event):void
        {
            this.startDragging = false;
        }

        override public function destroy():void
        {
            this.view.removeEventListener(Event.ENTER_FRAME, this.onUpdateHandler);
            this.view.slider.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            if (this.view.scrollObject)
            {
                this.view.scrollObject.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            }
            WebMain.STAGE.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            this.view.dispose();
        }

        private function onUpdateHandler(_arg_1:Event):void
        {
            if (((this.view.scrollObject) && (!(this.view.scrollObject.hasEventListener(MouseEvent.MOUSE_WHEEL)))))
            {
                this.view.scrollObject.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            }
            if (this.startDragging)
            {
                this.view.updatePosition((WebMain.STAGE.mouseY - this.startY));
                this.startY = WebMain.STAGE.mouseY;
            }
            this.view.update();
        }


    }
}//package io.decagames.rotmg.ui.scroll

