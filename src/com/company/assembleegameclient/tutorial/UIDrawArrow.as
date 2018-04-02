// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.tutorial.UIDrawArrow

package com.company.assembleegameclient.tutorial
{
import com.company.util.ConversionUtil;
import com.company.util.PointUtil;

import flash.display.Graphics;
import flash.geom.Point;

public class UIDrawArrow 
    {

        public const ANIMATION_MS:int = 500;

        public var p0_:Point;
        public var p1_:Point;
        public var color_:uint;

        public function UIDrawArrow(_arg_1:XML)
        {
            var _local_2:Array = ConversionUtil.toPointPair(_arg_1);
            this.p0_ = _local_2[0];
            this.p1_ = _local_2[1];
            this.color_ = uint(_arg_1.@color);
        }

        public function draw(_arg_1:int, _arg_2:Graphics, _arg_3:int):void
        {
            var _local_4:Point;
            var _local_5:Point = new Point();
            if (_arg_3 < this.ANIMATION_MS)
            {
                _local_5.x = (this.p0_.x + (((this.p1_.x - this.p0_.x) * _arg_3) / this.ANIMATION_MS));
                _local_5.y = (this.p0_.y + (((this.p1_.y - this.p0_.y) * _arg_3) / this.ANIMATION_MS));
            }
            else
            {
                _local_5.x = this.p1_.x;
                _local_5.y = this.p1_.y;
            };
            _arg_2.lineStyle(_arg_1, this.color_);
            _arg_2.moveTo(this.p0_.x, this.p0_.y);
            _arg_2.lineTo(_local_5.x, _local_5.y);
            var _local_6:Number = PointUtil.angleTo(_local_5, this.p0_);
            _local_4 = PointUtil.pointAt(_local_5, (_local_6 + (Math.PI / 8)), 30);
            _arg_2.lineTo(_local_4.x, _local_4.y);
            _local_4 = PointUtil.pointAt(_local_5, (_local_6 - (Math.PI / 8)), 30);
            _arg_2.moveTo(_local_5.x, _local_5.y);
            _arg_2.lineTo(_local_4.x, _local_4.y);
        }


    }
}//package com.company.assembleegameclient.tutorial

