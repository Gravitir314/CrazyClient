﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.utils.display.ScaleBitmap

package io.decagames.rotmg.utils.display
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Rectangle;

public class ScaleBitmap extends Bitmap
    {

        protected var _originalBitmap:BitmapData;
        protected var _scale9Grid:Rectangle = null;

        public function ScaleBitmap(_arg_1:BitmapData=null, _arg_2:String="auto", _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
            this._originalBitmap = _arg_1.clone();
        }

        override public function set bitmapData(_arg_1:BitmapData):void
        {
            this._originalBitmap = _arg_1.clone();
            if (this._scale9Grid != null)
            {
                if (!this.validGrid(this._scale9Grid))
                {
                    this._scale9Grid = null;
                };
                this.setSize(_arg_1.width, _arg_1.height);
            }
            else
            {
                this.assignBitmapData(this._originalBitmap.clone());
            };
        }

        override public function set width(_arg_1:Number):void
        {
            if (_arg_1 != width)
            {
                this.setSize(_arg_1, height);
            };
        }

        override public function set height(_arg_1:Number):void
        {
            if (_arg_1 != height)
            {
                this.setSize(width, _arg_1);
            };
        }

        override public function set scale9Grid(_arg_1:Rectangle):void
        {
            var _local_2:Number = NaN;
            var _local_3:Number = NaN;
            if ((((this._scale9Grid == null) && (!(_arg_1 == null))) || ((!(this._scale9Grid == null)) && (!(this._scale9Grid.equals(_arg_1))))))
            {
                if (_arg_1 == null)
                {
                    _local_2 = width;
                    _local_3 = height;
                    this._scale9Grid = null;
                    this.assignBitmapData(this._originalBitmap.clone());
                    this.setSize(_local_2, _local_3);
                }
                else
                {
                    if (!this.validGrid(_arg_1))
                    {
                        throw (new Error("#001 - The _scale9Grid does not match the original BitmapData"));
                    };
                    this._scale9Grid = _arg_1.clone();
                    this.resizeBitmap(width, height);
                    scaleX = 1;
                    scaleY = 1;
                };
            };
        }

        private function assignBitmapData(_arg_1:BitmapData):void
        {
            super.bitmapData.dispose();
            super.bitmapData = _arg_1;
        }

        private function validGrid(_arg_1:Rectangle):Boolean
        {
            return ((_arg_1.right <= this._originalBitmap.width) && (_arg_1.bottom <= this._originalBitmap.height));
        }

        override public function get scale9Grid():Rectangle
        {
            return (this._scale9Grid);
        }

        public function setSize(_arg_1:Number, _arg_2:Number):void
        {
            if (this._scale9Grid == null)
            {
                super.width = _arg_1;
                super.height = _arg_2;
            }
            else
            {
                _arg_1 = Math.max(_arg_1, (this._originalBitmap.width - this._scale9Grid.width));
                _arg_2 = Math.max(_arg_2, (this._originalBitmap.height - this._scale9Grid.height));
                this.resizeBitmap(_arg_1, _arg_2);
            };
        }

        public function getOriginalBitmapData():BitmapData
        {
            return (this._originalBitmap);
        }

        protected function resizeBitmap(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Rectangle;
            var _local_4:Rectangle;
            var _local_5:int;
            var _local_12:int;
            var _local_6:BitmapData = new BitmapData(_arg_1, _arg_2, true, 0);
            var _local_7:Array = [0, this._scale9Grid.top, this._scale9Grid.bottom, this._originalBitmap.height];
            var _local_8:Array = [0, this._scale9Grid.left, this._scale9Grid.right, this._originalBitmap.width];
            var _local_9:Array = [0, this._scale9Grid.top, (_arg_2 - (this._originalBitmap.height - this._scale9Grid.bottom)), _arg_2];
            var _local_10:Array = [0, this._scale9Grid.left, (_arg_1 - (this._originalBitmap.width - this._scale9Grid.right)), _arg_1];
            var _local_11:Matrix = new Matrix();
            while (_local_12 < 3)
            {
                _local_5 = 0;
                while (_local_5 < 3)
                {
                    _local_3 = new Rectangle(_local_8[_local_12], _local_7[_local_5], (_local_8[(_local_12 + 1)] - _local_8[_local_12]), (_local_7[(_local_5 + 1)] - _local_7[_local_5]));
                    _local_4 = new Rectangle(_local_10[_local_12], _local_9[_local_5], (_local_10[(_local_12 + 1)] - _local_10[_local_12]), (_local_9[(_local_5 + 1)] - _local_9[_local_5]));
                    _local_11.identity();
                    _local_11.a = (_local_4.width / _local_3.width);
                    _local_11.d = (_local_4.height / _local_3.height);
                    _local_11.tx = (_local_4.x - (_local_3.x * _local_11.a));
                    _local_11.ty = (_local_4.y - (_local_3.y * _local_11.d));
                    _local_6.draw(this._originalBitmap, _local_11, null, null, _local_4, smoothing);
                    _local_5++;
                };
                _local_12++;
            };
            this.assignBitmapData(_local_6);
        }


    }
}//package io.decagames.rotmg.utils.display
