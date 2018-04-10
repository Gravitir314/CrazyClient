// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.scroll.UIScrollbar

package io.decagames.rotmg.ui.scroll
{
import flash.display.DisplayObject;
import flash.display.Sprite;

import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class UIScrollbar extends Sprite 
    {

        public static const SCROLL_SLIDER_MINIMUM_HEIGHT:int = 39;
        public static const SCROLL_SLIDER_SCALE_FACTOR:Number = 0.5;

        private var _slider:Sprite;
        private var background:SliceScalingBitmap;
        private var sliderAsset:SliceScalingBitmap;
        private var _content:DisplayObject;
        private var _scrollObject:DisplayObject;
        private var contentHeight:int;
        private var percent:Number;
        private var initalPosition:int = 0;
        private var _mouseRollSpeedFactor:Number = 1.3;

        public function UIScrollbar(_arg_1:int)
        {
            this.contentHeight = _arg_1;
            this.background = TextureParser.instance.getSliceScalingBitmap("UI", "scrollbar_background", 17);
            this.background.height = _arg_1;
            addChild(this.background);
            this._slider = new Sprite();
            this.sliderAsset = TextureParser.instance.getSliceScalingBitmap("UI", "scrollbar_slider");
            this.sliderAsset.height = 10;
            this._slider.addChild(this.sliderAsset);
            this._slider.x = 1;
            this._slider.y = 1;
            addChild(this._slider);
        }

        public function set content(_arg_1:DisplayObject):void
        {
            this._content = _arg_1;
            this.initalPosition = this._content.y;
            this.update();
        }

        public function update():void
        {
            var _local_1:int;
            if (this._content.height <= this.contentHeight)
            {
                this.sliderAsset.height = this.contentHeight;
            }
            else
            {
                this.percent = ((this._content.height - this.contentHeight) / this.contentHeight);
                _local_1 = ((1 - (this.percent * SCROLL_SLIDER_SCALE_FACTOR)) * this.contentHeight);
                if (_local_1 < SCROLL_SLIDER_MINIMUM_HEIGHT)
                {
                    _local_1 = SCROLL_SLIDER_MINIMUM_HEIGHT;
                }
                this.sliderAsset.height = _local_1;
            }
        }

        public function updatePosition(_arg_1:Number):void
        {
            this._slider.y = (this._slider.y + Math.round(_arg_1));
            if (this._slider.y < 0)
            {
                this._slider.y = 0;
            }
            var _local_2:int = (this.contentHeight - this._slider.height);
            if (this._slider.y > _local_2)
            {
                this._slider.y = _local_2;
            }
            this._content.y = (this.initalPosition + -(Math.round((((this._content.height - this.contentHeight) * this._slider.y) / _local_2))));
        }

        public function get content():DisplayObject
        {
            return (this._content);
        }

        public function get slider():Sprite
        {
            return (this._slider);
        }

        public function get scrollObject():DisplayObject
        {
            if (this._scrollObject)
            {
                return (this._scrollObject);
            }
            return (this._content);
        }

        public function set scrollObject(_arg_1:DisplayObject):void
        {
            this._scrollObject = _arg_1;
        }

        public function dispose():void
        {
            this.background.dispose();
            this.sliderAsset.dispose();
        }

        public function get mouseRollSpeedFactor():Number
        {
            return (this._mouseRollSpeedFactor);
        }

        public function set mouseRollSpeedFactor(_arg_1:Number):void
        {
            this._mouseRollSpeedFactor = _arg_1;
        }


    }
}//package io.decagames.rotmg.ui.scroll

