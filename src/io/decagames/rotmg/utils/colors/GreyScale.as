// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.utils.colors.GreyScale

package io.decagames.rotmg.utils.colors
{
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.filters.ColorMatrixFilter;
import flash.geom.Point;
import flash.geom.Rectangle;

public class GreyScale 
    {


        public static function setGreyScale(_arg_1:BitmapData):BitmapData
        {
            var _local_2:Number = 0.2225;
            var _local_3:Number = 0.7169;
            var _local_4:Number = 0.0606;
            var _local_5:Array = [_local_2, _local_3, _local_4, 0, 0, _local_2, _local_3, _local_4, 0, 0, _local_2, _local_3, _local_4, 0, 0, 0, 0, 0, 1, 0];
            var _local_6:ColorMatrixFilter = new ColorMatrixFilter(_local_5);
            _arg_1.applyFilter(_arg_1, new Rectangle(0, 0, _arg_1.width, _arg_1.height), new Point(0, 0), _local_6);
            return (_arg_1);
        }

        public static function greyScaleToDisplayObject(_arg_1:DisplayObject, _arg_2:Boolean):void
        {
            var _local_3:Number = 0.2225;
            var _local_4:Number = 0.7169;
            var _local_5:Number = 0.0606;
            var _local_6:Array = [_local_3, _local_4, _local_5, 0, 0, _local_3, _local_4, _local_5, 0, 0, _local_3, _local_4, _local_5, 0, 0, 0, 0, 0, 1, 0];
            var _local_7:ColorMatrixFilter = new ColorMatrixFilter(_local_6);
            if (_arg_2)
            {
                _arg_1.filters = [_local_7];
            }
            else
            {
                _arg_1.filters = [];
            }
        }


    }
}//package io.decagames.rotmg.utils.colors

