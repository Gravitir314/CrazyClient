// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap

package io.decagames.rotmg.ui.sliceScaling
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;
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
            }
        }

        public function clone():SliceScalingBitmap
        {
            return (new SliceScalingBitmap(this.bitmapDataToSlice.clone(), this.scaleType, this.scaleGrid, this.fillColor, this.fillColorAlpha));
        }

        override public function set width(_arg_1:Number):void
        {
            if (((!(_arg_1 == this.currentWidth)) || (this._forceRenderInNextFrame))){
                this.currentWidth = _arg_1;
                this.render();
            }
        }

        override public function set height(_arg_1:Number):void
        {
            if (_arg_1 != this.currentHeight){
                this.currentHeight = _arg_1;
                this.render();
            }
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
            }
            if (this.bitmapData)
            {
                this.bitmapData.dispose();
            }
            if (this._scaleType == SCALE_TYPE_3)
            {
                this.prepare3grid();
            }
            if (this._scaleType == SCALE_TYPE_9)
            {
                this.prepare9grid();
            }
            if (this._forceRenderInNextFrame)
            {
                this._forceRenderInNextFrame = false;
            }
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
                }
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
                }
                this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, (this.scaleGrid.y + this.scaleGrid.height), this.bitmapDataToSlice.width, (this.bitmapDataToSlice.height - (this.scaleGrid.y + this.scaleGrid.height))), new Point(this.margin.x, ((this.margin.y + this.scaleGrid.y) + _local_3)));
            }
        }

        private function prepare9grid():void{
            var _local_10:int;
            var _local_1:Rectangle = new Rectangle();
            var _local_2:Rectangle = new Rectangle();
            var _local_3:Matrix = new Matrix();
            var _local_4:BitmapData = new BitmapData((this.currentWidth + this.margin.x), (this.currentHeight + this.margin.y), true, 0);
            var _local_5:Array = [0, this.scaleGrid.top, this.scaleGrid.bottom, this.bitmapDataToSlice.height];
            var _local_6:Array = [0, this.scaleGrid.left, this.scaleGrid.right, this.bitmapDataToSlice.width];
            var _local_7:Array = [0, this.scaleGrid.top, (this.currentHeight - (this.bitmapDataToSlice.height - this.scaleGrid.bottom)), this.currentHeight];
            var _local_8:Array = [0, this.scaleGrid.left, (this.currentWidth - (this.bitmapDataToSlice.width - this.scaleGrid.right)), this.currentWidth];
            var _local_9:int;
            while (_local_9 < 3) {
                _local_10 = 0;
                while (_local_10 < 3) {
                    _local_1.setTo(_local_6[_local_9], _local_5[_local_10], (_local_6[(_local_9 + 1)] - _local_6[_local_9]), (_local_5[(_local_10 + 1)] - _local_5[_local_10]));
                    _local_2.setTo(_local_8[_local_9], _local_7[_local_10], (_local_8[(_local_9 + 1)] - _local_8[_local_9]), (_local_7[(_local_10 + 1)] - _local_7[_local_10]));
                    _local_3.identity();
                    _local_3.a = (_local_2.width / _local_1.width);
                    _local_3.d = (_local_2.height / _local_1.height);
                    _local_3.tx = (_local_2.x - (_local_1.x * _local_3.a));
                    _local_3.ty = (_local_2.y - (_local_1.y * _local_3.d));
                    _local_4.draw(this.bitmapDataToSlice, _local_3, null, null, _local_2);
                    _local_10++;
                }
                _local_9++;
            }
            this.bitmapData = _local_4;
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

