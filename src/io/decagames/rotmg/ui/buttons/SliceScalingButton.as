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
        private var _bitmap:SliceScalingBitmap;
        private var _autoDispose:Boolean;
        protected var _interactionEffects:Boolean = true;
        protected var labelMargin:Point = new Point();

        public function SliceScalingButton(_arg_1:SliceScalingBitmap, _arg_2:SliceScalingBitmap=null, _arg_3:SliceScalingBitmap=null)
        {
            this._bitmap = _arg_1;
            addChild(this._bitmap);
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
                Tint.add(this._bitmap, 0xFFFF, 0.1);
                this._bitmap.scaleX = 1;
                this._bitmap.scaleY = 1;
                this._bitmap.x = 0;
                this._bitmap.y = 0;
            }
            super.onRollOverHandler(_arg_1);
        }

        override protected function onMouseDownHandler(_arg_1:MouseEvent):void
        {
            if (((this._interactionEffects) && (!(_disabled))))
            {
                this._bitmap.scaleX = 0.9;
                this._bitmap.scaleY = 0.9;
                this._bitmap.x = ((this._bitmap.width * 0.1) / 2);
                this._bitmap.y = ((this._bitmap.height * 0.1) / 2);
            }
            super.onMouseDownHandler(_arg_1);
        }

        override protected function onClickHandler(_arg_1:MouseEvent):void
        {
            if (this._interactionEffects)
            {
                this._bitmap.scaleX = 1;
                this._bitmap.scaleY = 1;
                this._bitmap.x = 0;
                this._bitmap.y = 0;
            }
            super.onClickHandler(_arg_1);
        }

        override protected function onRollOutHandler(_arg_1:MouseEvent):void
        {
            if (this._interactionEffects)
            {
                this._bitmap.transform.colorTransform = new ColorTransform();
                this._bitmap.scaleX = 1;
                this._bitmap.scaleY = 1;
                this._bitmap.x = 0;
                this._bitmap.y = 0;
            }
            super.onRollOutHandler(_arg_1);
        }

        override public function set disabled(_arg_1:Boolean):void
        {
            super.disabled = _arg_1;
            var _local_2:Function = this.stateFactories[ButtonStates.DISABLED];
            if (_local_2 != null)
            {
                (_local_2(this._label));
            }
            if (this._interactionEffects)
            {
                if (_arg_1)
                {
                    GreyScale.setGreyScale(this._bitmap.bitmapData);
                }
                else
                {
                    this.changeBitmap(this._bitmap.sourceBitmapName, new Point(this._bitmap.marginX, this._bitmap.marginY));
                }
            }
            this.render();
        }

        public function setLabel(_arg_1:String, _arg_2:Function=null, _arg_3:String="idle"):void
        {
            if (_arg_3 == ButtonStates.IDLE)
            {
                if (_arg_2 != null)
                {
                    (_arg_2(this._label));
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
                this._bitmap.width = this._bitmapWidth;
            }
            this._label.x = ((((this._bitmapWidth - this._label.textWidth) / 2) + this._bitmap.marginX) + this.labelMargin.y);
            this._label.y = ((((this._bitmap.height - this._label.textHeight) / 2) + this._bitmap.marginY) + this.labelMargin.y);
        }

        override public function dispose():void
        {
            this._bitmap.dispose();
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
            removeChild(this._bitmap);
            this._bitmap.dispose();
            this._bitmap = TextureParser.instance.getSliceScalingBitmap("UI", _arg_1);
            if (_arg_2 != null)
            {
                this._bitmap.addMargin(_arg_2.x, _arg_2.y);
            }
            addChildAt(this._bitmap, 0);
            this._bitmap.forceRenderInNextFrame = true;
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

        public function get bitmapWidth():int{
            return (this._bitmapWidth);
        }

        public function get bitmap():SliceScalingBitmap{
            return (this._bitmap);
        }

    }
}//package io.decagames.rotmg.ui.buttons

