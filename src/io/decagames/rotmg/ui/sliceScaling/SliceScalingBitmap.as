// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap

package io.decagames.rotmg.ui.sliceScaling
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

public class SliceScalingBitmap extends Bitmap
    {

        public static var SCALE_TYPE_NONE:String = "none";
        public static var SCALE_TYPE_3:String = "3grid";
        public static var SCALE_TYPE_9:String = "9grid";

        private var scaleGrid:Rectangle;
        private var currentWidth:int;
        private var currentHeight:int;
        private var bitmapDataToSlice:BitmapData;
        private var _scaleType:String;
        private var fillColor:uint;
        protected var margin:Point = new Point();
        private var fillColorAlpha:Number;
        private var _forceRenderInNextFrame:Boolean;
        private var _sourceBitmapName:String;

        public function SliceScalingBitmap(_arg_1:BitmapData, _arg_2:String, _arg_3:Rectangle=null, _arg_4:uint=0, _arg_5:Number=1)
        {
            this.bitmapDataToSlice = _arg_1;
            this.scaleGrid = _arg_3;
            this.currentWidth = _arg_1.width;
            this.currentHeight = _arg_1.height;
            this._scaleType = _arg_2;
            this.fillColor = _arg_4;
            this.fillColorAlpha = _arg_5;
            if (_arg_2 != SCALE_TYPE_NONE)
            {
                this.render();
            }
            else
            {
                this.bitmapData = _arg_1;
            };
        }

        public function clone():SliceScalingBitmap
        {
            return (new SliceScalingBitmap(this.bitmapDataToSlice.clone(), this.scaleType, this.scaleGrid, this.fillColor, this.fillColorAlpha));
        }

        override public function set width(_arg_1:Number):void
        {
            var _local_2:int = this.currentWidth;
            this.currentWidth = _arg_1;
            if (((!(_local_2 == this.currentWidth)) || (this._forceRenderInNextFrame)))
            {
                this.render();
            };
        }

        override public function set height(_arg_1:Number):void
        {
            var _local_2:int = this.currentHeight;
            this.currentHeight = _arg_1;
            if (_local_2 != this.currentHeight)
            {
                this.render();
            };
        }

        override public function get width():Number
        {
            return (this.currentWidth);
        }

        override public function get height():Number
        {
            return (this.currentHeight);
        }

        protected function render():void
        {
            if (this._scaleType == SCALE_TYPE_NONE)
            {
                return;
            };
            if (this.bitmapData)
            {
                this.bitmapData.dispose();
            };
            if (this._scaleType == SCALE_TYPE_3)
            {
                this.prepare3grid();
            };
            if (this._scaleType == SCALE_TYPE_9)
            {
                this.prepare9grid();
            };
            if (this._forceRenderInNextFrame)
            {
                this._forceRenderInNextFrame = false;
            };
        }

        private function prepare3grid():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            if (this.scaleGrid.y == 0)
            {
                _local_1 = ((this.currentWidth - this.bitmapDataToSlice.width) + this.scaleGrid.width);
                this.bitmapData = new BitmapData((this.currentWidth + this.margin.x), (this.currentHeight + this.margin.y), true, 0);
                this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, 0, this.scaleGrid.x, this.bitmapDataToSlice.height), new Point(this.margin.x, this.margin.y));
                _local_2 = 0;
                while (_local_2 < _local_1)
                {
                    this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(this.scaleGrid.x, 0, this.scaleGrid.width, this.bitmapDataToSlice.height), new Point(((this.scaleGrid.x + _local_2) + this.margin.x), this.margin.y));
                    _local_2++;
                };
                this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle((this.scaleGrid.x + this.scaleGrid.width), 0, (this.bitmapDataToSlice.width - (this.scaleGrid.x + this.scaleGrid.width)), this.bitmapDataToSlice.height), new Point(((this.scaleGrid.x + _local_1) + this.margin.x), this.margin.y));
            }
            else
            {
                _local_3 = ((this.currentHeight - this.bitmapDataToSlice.height) + this.scaleGrid.height);
                this.bitmapData = new BitmapData((this.currentWidth + this.margin.x), (this.currentHeight + this.margin.y), true, 0);
                this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, 0, this.bitmapDataToSlice.width, this.scaleGrid.y), new Point(this.margin.x, this.margin.y));
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, this.scaleGrid.y, this.scaleGrid.width, this.bitmapDataToSlice.height), new Point(this.margin.x, ((this.margin.y + this.scaleGrid.y) + _local_4)));
                    _local_4++;
                };
                this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, (this.scaleGrid.y + this.scaleGrid.height), this.bitmapDataToSlice.width, (this.bitmapDataToSlice.height - (this.scaleGrid.y + this.scaleGrid.height))), new Point(this.margin.x, ((this.margin.y + this.scaleGrid.y) + _local_3)));
            };
        }

        private function prepare9grid():void
        {
            var _local_5:int;
            this.bitmapData = new BitmapData((this.currentWidth + this.margin.x), (this.currentHeight + this.margin.y), true, 0);
            this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, 0, this.scaleGrid.x, this.scaleGrid.y), new Point(this.margin.x, this.margin.y));
            this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle((this.scaleGrid.x + this.scaleGrid.width), 0, this.scaleGrid.x, this.scaleGrid.y), new Point(((this.currentWidth - this.scaleGrid.x) + this.margin.x), this.margin.y));
            this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, (this.scaleGrid.y + this.scaleGrid.height), this.scaleGrid.x, this.scaleGrid.y), new Point(this.margin.x, ((this.currentHeight - this.scaleGrid.y) + this.margin.y)));
            this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle((this.scaleGrid.x + this.scaleGrid.width), (this.scaleGrid.y + this.scaleGrid.height), this.scaleGrid.x, this.scaleGrid.y), new Point(((this.currentWidth - this.scaleGrid.x) + this.margin.x), ((this.currentHeight - this.scaleGrid.y) + this.margin.y)));
            var _local_1:int = (this.currentWidth - (this.scaleGrid.x * 2));
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(this.scaleGrid.x, 0, this.scaleGrid.width, this.scaleGrid.y), new Point(((this.scaleGrid.x + _local_2) + this.margin.x), this.margin.y));
                _local_2++;
            };
            _local_2 = 0;
            while (_local_2 < _local_1)
            {
                this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(this.scaleGrid.x, (this.scaleGrid.y + this.scaleGrid.height), this.scaleGrid.width, this.scaleGrid.y), new Point(((this.scaleGrid.x + _local_2) + this.margin.x), ((this.currentHeight - this.scaleGrid.y) + this.margin.y)));
                _local_2++;
            };
            var _local_3:int = (this.currentHeight - (this.scaleGrid.y * 2));
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, this.scaleGrid.y, this.scaleGrid.x, this.scaleGrid.height), new Point(this.margin.x, ((this.scaleGrid.y + _local_2) + this.margin.y)));
                _local_2++;
            };
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle((this.scaleGrid.x + this.scaleGrid.width), this.scaleGrid.y, this.scaleGrid.x, this.scaleGrid.height), new Point(((this.currentWidth - this.scaleGrid.x) + this.margin.x), ((this.scaleGrid.y + _local_2) + this.margin.y)));
                _local_2++;
            };
            var _local_4:uint = this.bitmapDataToSlice.getPixel32((this.scaleGrid.x + this.scaleGrid.width), (this.scaleGrid.y + this.scaleGrid.height));
            this.bitmapData.lock();
            _local_2 = this.scaleGrid.x;
            while (_local_2 < (this.currentWidth - this.scaleGrid.x))
            {
                _local_5 = this.scaleGrid.y;
                while (_local_5 < (this.currentHeight - this.scaleGrid.y))
                {
                    this.bitmapData.setPixel32((_local_2 + this.margin.x), (_local_5 + this.margin.y), _local_4);
                    _local_5++;
                };
                _local_2++;
            };
            this.bitmapData.unlock();
        }

        public function addMargin(_arg_1:int, _arg_2:int):void
        {
            this.margin = new Point(_arg_1, _arg_2);
        }

        public function dispose():void
        {
            this.bitmapData.dispose();
            this.bitmapDataToSlice.dispose();
        }

        public function get scaleType():String
        {
            return (this._scaleType);
        }

        public function set scaleType(_arg_1:String):void
        {
            this._scaleType = _arg_1;
        }

        override public function set x(_arg_1:Number):void
        {
            super.x = Math.round(_arg_1);
        }

        override public function set y(_arg_1:Number):void
        {
            super.y = Math.round(_arg_1);
        }

        public function get forceRenderInNextFrame():Boolean
        {
            return (this._forceRenderInNextFrame);
        }

        public function set forceRenderInNextFrame(_arg_1:Boolean):void
        {
            this._forceRenderInNextFrame = _arg_1;
        }

        public function get marginX():int
        {
            return (this.margin.x);
        }

        public function get marginY():int
        {
            return (this.margin.y);
        }

        public function get sourceBitmapName():String
        {
            return (this._sourceBitmapName);
        }

        public function set sourceBitmapName(_arg_1:String):void
        {
            this._sourceBitmapName = _arg_1;
        }


    }
}//package io.decagames.rotmg.ui.sliceScaling

