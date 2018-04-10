// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.utils.date.TimeLeft

package io.decagames.rotmg.utils.date
{
    public class TimeLeft 
    {


        public static function parse(_arg_1:int, _arg_2:String):String
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            if (_arg_2.indexOf("%d") >= 0)
            {
                _local_3 = int(Math.floor((_arg_1 / 86400)));
                _arg_1 = (_arg_1 - (_local_3 * 86400));
                _arg_2 = _arg_2.replace("%d", _local_3);
            }
            if (_arg_2.indexOf("%h") >= 0)
            {
                _local_4 = int(Math.floor((_arg_1 / 3600)));
                _arg_1 = (_arg_1 - (_local_4 * 3600));
                _arg_2 = _arg_2.replace("%h", _local_4);
            }
            if (_arg_2.indexOf("%m") >= 0)
            {
                _local_5 = int(Math.floor((_arg_1 / 60)));
                _arg_1 = (_arg_1 - (_local_5 * 60));
                _arg_2 = _arg_2.replace("%m", _local_5);
            }
            return (_arg_2.replace("%s", _arg_1));
        }


    }
}//package io.decagames.rotmg.utils.date

