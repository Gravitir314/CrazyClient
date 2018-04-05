// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.buttons.SliceScalingButton

package io.decagames.rotmg.ui.buttons
{
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.utils.Dictionary;

import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;
import io.decagames.rotmg.utils.colors.GreyScale;
import io.decagames.rotmg.utils.colors.Tint;

public class SliceScalingButton extends BaseButton
    {

        private var staticWidth:Boolean;
        private var _bitmapWidth:int;
        private var disableBitmap:SliceScalingBitmap;
        private var rollOverBitmap:SliceScalingBitmap;
        private var _label:UILabel;
        private var stateFactories:Dictionary;
        public var bitmap:SliceScalingBitmap;
        private var _autoDispose:Boolean;
        protected var _interactionEffects:Boolean = true;
        protected var labelMargin:Point = new Point();

        public function SliceScalingButton(_arg_1:SliceScalingBitmap, _arg_2:SliceScalingBitmap=null, _arg_3:SliceScalingBitmap=null)
        {
            this.bitmap = _arg_1;
            addChild(this.bitmap);
            this.rollOverBitmap = _arg_3;
            this.disableBitmap = _arg_2;
            this._label = new UILabel();
            this.stateFactories = new Dictionary();
            super();
        }

        public function setLabelMargin(_arg_1:int, _arg_2:int):void
        {
            this.labelMargin.x = _arg_1;
            this.labelMargin.y = _arg_2;
        }

        override protected function onRollOverHandler(_arg_1:MouseEvent):void
        {
            if (((this._interactionEffects) && (!(_disabled))))
            {
                Tint.add(this.bitmap, 0xFFFF, 0.1);
                this.bitmap.scaleX = 1;
                this.bitmap.scaleY = 1;
                this.bitmap.x = 0;
                this.bitmap.y = 0;
            }
            super.onRollOverHandler(_arg_1);
        }

        override protected function onMouseDownHandler(_arg_1:MouseEvent):void
        {
            if (((this._interactionEffects) && (!(_disabled))))
            {
                this.bitmap.scaleX = 0.9;
                this.bitmap.scaleY = 0.9;
                this.bitmap.x = ((this.bitmap.width * 0.1) / 2);
                this.bitmap.y = ((this.bitmap.height * 0.1) / 2);
            }
            super.onMouseDownHandler(_arg_1);
        }

        override protected function onClickHandler(_arg_1:MouseEvent):void
        {
            if (this._interactionEffects)
            {
                this.bitmap.scaleX = 1;
                this.bitmap.scaleY = 1;
                this.bitmap.x = 0;
                this.bitmap.y = 0;
            }
            super.onClickHandler(_arg_1);
        }

        override protected function onRollOutHandler(_arg_1:MouseEvent):void
        {
            if (this._interactionEffects)
            {
                this.bitmap.transform.colorTransform = new ColorTransform();
                this.bitmap.scaleX = 1;
                this.bitmap.scaleY = 1;
                this.bitmap.x = 0;
                this.bitmap.y = 0;
            }
            super.onRollOutHandler(_arg_1);
        }

        override public function set disabled(_arg_1:Boolean):void
        {
            super.disabled = _arg_1;
            if (this.stateFactories[ButtonStates.DISABLED])
            {
                (this.stateFactories[ButtonStates.DISABLED](this._label));
            }
            if (this._interactionEffects)
            {
                if (_arg_1)
                {
                    GreyScale.setGreyScale(this.bitmap.bitmapData);
                }
                else
                {
                    GreyScale.clear(this.bitmap.bitmapData);
                }
            }
            this.render();
        }

        public function setLabel(_arg_1:String, _arg_2:Function, _arg_3:String="idle"):void
        {
            if (_arg_3 == ButtonStates.IDLE)
            {
                if (_arg_2())
                {
                    (_arg_2()(this._label));
                }
                this._label.text = _arg_1;
                addChild(this._label);
                this.render();
            }
            this.stateFactories[_arg_3] = _arg_2;
        }

        override protected function onAddedToStage(_arg_1:Event):void
        {
            super.onAddedToStage(_arg_1);
            this.render();
        }

        override public function set width(_arg_1:Number):void
        {
            _arg_1 = Math.round(_arg_1);
            this.staticWidth = true;
            this._bitmapWidth = _arg_1;
            this.render();
        }

        public function render():void
        {
            if (this.staticWidth)
            {
                this.bitmap.width = this._bitmapWidth;
            }
            this._label.x = ((((this._bitmapWidth - this._label.textWidth) / 2) + this.bitmap.marginX) + this.labelMargin.y);
            this._label.y = ((((this.bitmap.height - this._label.textHeight) / 2) + this.bitmap.marginY) + this.labelMargin.y);
        }

        override public function dispose():void
        {
            this.bitmap.dispose();
            if (this.disableBitmap)
            {
                this.disableBitmap.dispose();
            }
            if (this.rollOverBitmap)
            {
                this.rollOverBitmap.dispose();
            }
            super.dispose();
        }

        public function changeBitmap(_arg_1:String, _arg_2:Point=null):void
        {
            removeChild(this.bitmap);
            this.bitmap.dispose();
            this.bitmap = TextureParser.instance.getSliceScalingBitmap("UI", _arg_1);
            if (_arg_2 != null)
            {
                this.bitmap.addMargin(_arg_2.x, _arg_2.y);
            }
            addChildAt(this.bitmap, 0);
            this.bitmap.forceRenderInNextFrame = true;
            this.render();
        }

        public function get label():UILabel
        {
            return (this._label);
        }

        public function get autoDispose():Boolean
        {
            return (this._autoDispose);
        }

        public function set autoDispose(_arg_1:Boolean):void
        {
            this._autoDispose = _arg_1;
        }

        public function get interactionEffects():Boolean
        {
            return (this._interactionEffects);
        }

        public function set interactionEffects(_arg_1:Boolean):void
        {
            this._interactionEffects = _arg_1;
        }


    }
}//package io.decagames.rotmg.ui.buttons

