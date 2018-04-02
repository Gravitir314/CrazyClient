// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.util.AnimatedChars

package com.company.assembleegameclient.util
{
import flash.display.BitmapData;
import flash.utils.Dictionary;

public class AnimatedChars
    {

        private static var nameMap_:Dictionary = new Dictionary();


        public static function getAnimatedChar(_arg_1:String, _arg_2:int):AnimatedChar
        {
            var _local_3:Vector.<AnimatedChar> = nameMap_[_arg_1];
            if (((_local_3 == null) || (_arg_2 >= _local_3.length)))
            {
                return (null);
            };
            return (_local_3[_arg_2]);
        }

        public static function add(_arg_1:String, _arg_2:BitmapData, _arg_3:BitmapData, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:int):void
        {
            var _local_9:MaskedImage;
            var _local_10:Vector.<AnimatedChar> = new Vector.<AnimatedChar>();
            var _local_11:MaskedImageSet = new MaskedImageSet();
            _local_11.addFromBitmapData(_arg_2, _arg_3, _arg_6, _arg_7);
            for each (_local_9 in _local_11.images_)
            {
                _local_10.push(new AnimatedChar(_local_9, _arg_4, _arg_5, _arg_8));
            };
            nameMap_[_arg_1] = _local_10;
        }


    }
}//package com.company.assembleegameclient.util

