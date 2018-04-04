// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.utils.colors.Tint

package io.decagames.rotmg.utils.colors
{
import flash.display.DisplayObject;
import flash.geom.ColorTransform;

public class Tint 
    {


        public static function add(_arg_1:DisplayObject, _arg_2:uint, _arg_3:Number):void
        {
            var _local_4:ColorTransform = _arg_1.transform.colorTransform;
            _local_4.color = _arg_2;
            var _local_5:Number = (_arg_3 / (1 - (((_local_4.redMultiplier + _local_4.greenMultiplier) + _local_4.blueMultiplier) / 3)));
            _local_4.redOffset = (_local_4.redOffset * _local_5);
            _local_4.greenOffset = (_local_4.greenOffset * _local_5);
            _local_4.blueOffset = (_local_4.blueOffset * _local_5);
            _local_4.redMultiplier = (_local_4.greenMultiplier = (_local_4.blueMultiplier = (1 - _arg_3)));
            _arg_1.transform.colorTransform = _local_4;
        }


    }
}//package io.decagames.rotmg.utils.colors

