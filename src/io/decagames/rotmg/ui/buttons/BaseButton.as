// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.buttons.BaseButton

package io.decagames.rotmg.ui.buttons
{
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

public class BaseButton extends Sprite
    {

        protected var _disabled:Boolean;
        public var clickSignal:Signal = new Signal();
        public var rollOverSignal:Signal = new Signal();
        public var rollOutSignal:Signal = new Signal();
        private var _instanceName:String;

        public function BaseButton()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        }

        protected function onAddedToStage(_arg_1:Event):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.addEventListener(MouseEvent.CLICK, this.onClickHandler);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.onRollOutHandler);
            this.addEventListener(MouseEvent.MOUSE_OVER, this.onRollOverHandler);
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownHandler);
        }

        public function dispose():void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.removeEventListener(MouseEvent.CLICK, this.onClickHandler);
            this.removeEventListener(MouseEvent.MOUSE_OUT, this.onRollOutHandler);
            this.removeEventListener(MouseEvent.MOUSE_OVER, this.onRollOverHandler);
            this.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownHandler);
            this.clickSignal.removeAll();
            this.rollOverSignal.removeAll();
            this.rollOutSignal.removeAll();
        }

        protected function onClickHandler(_arg_1:MouseEvent):void
        {
            if (!this._disabled)
            {
                this.clickSignal.dispatch(this);
            }
        }

        protected function onMouseDownHandler(_arg_1:MouseEvent):void
        {
        }

        protected function onRollOutHandler(_arg_1:MouseEvent):void
        {
            this.rollOutSignal.dispatch(this);
        }

        protected function onRollOverHandler(_arg_1:MouseEvent):void
        {
            this.rollOverSignal.dispatch(this);
        }

        public function set disabled(_arg_1:Boolean):void
        {
            this._disabled = _arg_1;
        }

        public function get disabled():Boolean
        {
            return (this._disabled);
        }

        public function get instanceName():String
        {
            return (this._instanceName);
        }

        public function set instanceName(_arg_1:String):void
        {
            this._instanceName = _arg_1;
        }


    }
}//package io.decagames.rotmg.ui.buttons

