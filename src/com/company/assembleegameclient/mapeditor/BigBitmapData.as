// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.BigBitmapData

package com.company.assembleegameclient.mapeditor
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Rectangle;

public class BigBitmapData 
    {

        private static const CHUNK_SIZE:int = 0x0100;

        public var width_:int;
        public var height_:int;
        public var fillColor_:uint;
        private var maxChunkX_:int;
        private var maxChunkY_:int;
        private var chunks_:Vector.<BitmapData>;

        public function BigBitmapData(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:uint)
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            super();
            this.width_ = _arg_1;
            this.height_ = _arg_2;
            this.fillColor_ = _arg_4;
            this.maxChunkX_ = Math.ceil((this.width_ / CHUNK_SIZE));
            this.maxChunkY_ = Math.ceil((this.height_ / CHUNK_SIZE));
            this.chunks_ = new Vector.<BitmapData>((this.maxChunkX_ * this.maxChunkY_), true);
            while (_local_8 < this.maxChunkX_)
            {
                _local_5 = 0;
                while (_local_5 < this.maxChunkY_)
                {
                    _local_6 = Math.min(CHUNK_SIZE, (this.width_ - (_local_8 * CHUNK_SIZE)));
                    _local_7 = Math.min(CHUNK_SIZE, (this.height_ - (_local_5 * CHUNK_SIZE)));
                    this.chunks_[(_local_8 + (_local_5 * this.maxChunkX_))] = new BitmapDataSpy(_local_6, _local_7, _arg_3, this.fillColor_);
                    _local_5++;
                };
                _local_8++;
            };
        }

        public function copyTo(_arg_1:BitmapData, _arg_2:Rectangle, _arg_3:Rectangle):void
        {
            var _local_4:int;
            var _local_5:BitmapData;
            var _local_6:Rectangle;
            var _local_7:Number = (_arg_3.width / _arg_2.width);
            var _local_8:Number = (_arg_3.height / _arg_2.height);
            var _local_9:int = int(int((_arg_3.x / CHUNK_SIZE)));
            var _local_10:int = int(int((_arg_3.y / CHUNK_SIZE)));
            var _local_11:int = int(Math.ceil((_arg_3.right / CHUNK_SIZE)));
            var _local_12:int = int(Math.ceil((_arg_3.bottom / CHUNK_SIZE)));
            var _local_13:Matrix = new Matrix();
            var _local_14:int = _local_9;
            while (_local_14 < _local_11)
            {
                _local_4 = _local_10;
                while (_local_4 < _local_12)
                {
                    _local_5 = this.chunks_[(_local_14 + (_local_4 * this.maxChunkX_))];
                    _local_13.identity();
                    _local_13.scale(_local_7, _local_8);
                    _local_13.translate(((_arg_3.x - (_local_14 * CHUNK_SIZE)) - (_arg_2.x * _local_7)), ((_arg_3.y - (_local_4 * CHUNK_SIZE)) - (_arg_2.x * _local_8)));
                    _local_6 = new Rectangle((_arg_3.x - (_local_14 * CHUNK_SIZE)), (_arg_3.y - (_local_4 * CHUNK_SIZE)), _arg_3.width, _arg_3.height);
                    _local_5.draw(_arg_1, _local_13, null, null, _local_6, false);
                    _local_4++;
                };
                _local_14++;
            };
        }

        public function copyFrom(_arg_1:Rectangle, _arg_2:BitmapData, _arg_3:Rectangle):void
        {
            var _local_4:int;
            var _local_5:BitmapData;
            var _local_6:Number = (_arg_3.width / _arg_1.width);
            var _local_7:Number = (_arg_3.height / _arg_1.height);
            var _local_8:int = int(Math.max(0, int((_arg_1.x / CHUNK_SIZE))));
            var _local_9:int = int(Math.max(0, int((_arg_1.y / CHUNK_SIZE))));
            var _local_10:int = int(Math.min((this.maxChunkX_ - 1), int((_arg_1.right / CHUNK_SIZE))));
            var _local_11:int = int(Math.min((this.maxChunkY_ - 1), int((_arg_1.bottom / CHUNK_SIZE))));
            var _local_12:Rectangle = new Rectangle();
            var _local_13:Matrix = new Matrix();
            var _local_14:int = _local_8;
            while (_local_14 <= _local_10)
            {
                _local_4 = _local_9;
                while (_local_4 <= _local_11)
                {
                    _local_5 = this.chunks_[(_local_14 + (_local_4 * this.maxChunkX_))];
                    _local_13.identity();
                    _local_13.translate((((_arg_3.x / _local_6) - _arg_1.x) + (_local_14 * CHUNK_SIZE)), (((_arg_3.y / _local_7) - _arg_1.y) + (_local_4 * CHUNK_SIZE)));
                    _local_13.scale(_local_6, _local_7);
                    _arg_2.draw(_local_5, _local_13, null, null, _arg_3, false);
                    _local_4++;
                };
                _local_14++;
            };
        }

        public function erase(_arg_1:Rectangle):void
        {
            var _local_2:int;
            var _local_3:BitmapData;
            var _local_4:int = int(int((_arg_1.x / CHUNK_SIZE)));
            var _local_5:int = int(int((_arg_1.y / CHUNK_SIZE)));
            var _local_6:int = int(Math.ceil((_arg_1.right / CHUNK_SIZE)));
            var _local_7:int = int(Math.ceil((_arg_1.bottom / CHUNK_SIZE)));
            var _local_8:Rectangle = new Rectangle();
            var _local_9:int = _local_4;
            while (_local_9 < _local_6)
            {
                _local_2 = _local_5;
                while (_local_2 < _local_7)
                {
                    _local_3 = this.chunks_[(_local_9 + (_local_2 * this.maxChunkX_))];
                    _local_8.x = (_arg_1.x - (_local_9 * CHUNK_SIZE));
                    _local_8.y = (_arg_1.y - (_local_2 * CHUNK_SIZE));
                    _local_8.right = (_arg_1.right - (_local_9 * CHUNK_SIZE));
                    _local_8.bottom = (_arg_1.bottom - (_local_2 * CHUNK_SIZE));
                    _local_3.fillRect(_local_8, this.fillColor_);
                    _local_2++;
                };
                _local_9++;
            };
        }

        public function getDebugSprite():Sprite
        {
            var _local_1:int;
            var _local_2:BitmapData;
            var _local_3:Bitmap;
            var _local_4:int;
            var _local_5:Sprite = new Sprite();
            while (_local_4 < this.maxChunkX_)
            {
                _local_1 = 0;
                while (_local_1 < this.maxChunkY_)
                {
                    _local_2 = this.chunks_[(_local_4 + (_local_1 * this.maxChunkX_))];
                    _local_3 = new Bitmap(_local_2);
                    _local_3.x = (_local_4 * CHUNK_SIZE);
                    _local_3.y = (_local_1 * CHUNK_SIZE);
                    _local_5.addChild(_local_3);
                    _local_1++;
                };
                _local_4++;
            };
            return (_local_5);
        }


    }
}//package com.company.assembleegameclient.mapeditor

