//com.company.util.MoreStringUtil

package com.company.util
{
import flash.utils.ByteArray;

public class MoreStringUtil 
    {


        public static function hexStringToByteArray(_arg_1:String):ByteArray
        {
            var _local_2:int;
            var _local_3:ByteArray = new ByteArray();
            while (_local_2 < _arg_1.length)
            {
                _local_3.writeByte(parseInt(_arg_1.substr(_local_2, 2), 16));
                _local_2 = (_local_2 + 2);
            }
            return (_local_3);
        }

        public static function cmp(_arg_1:String, _arg_2:String):Number
        {
            return (_arg_1.localeCompare(_arg_2));
        }


    }
}//package com.company.util

