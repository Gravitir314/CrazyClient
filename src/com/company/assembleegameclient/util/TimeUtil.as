//com.company.assembleegameclient.util.TimeUtil

package com.company.assembleegameclient.util
{
    public class TimeUtil 
    {

        public static const DAY_IN_MS:int = 86400000;
        public static const DAY_IN_S:int = 86400;
        public static const HOUR_IN_S:int = 3600;
        public static const MIN_IN_S:int = 60;


        public static function secondsToDays(_arg_1:Number):Number
        {
            return (_arg_1 / DAY_IN_S);
        }

        public static function secondsToHours(_arg_1:Number):Number
        {
            return (_arg_1 / HOUR_IN_S);
        }

        public static function secondsToMins(_arg_1:Number):Number
        {
            return (_arg_1 / MIN_IN_S);
        }

        public static function parseUTCDate(_arg_1:String):Date
        {
            var _local_2:Array = _arg_1.match(/(\d\d\d\d)-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d)/);
            var _local_3:Date = new Date();
            _local_3.setUTCFullYear(int(_local_2[1]), (int(_local_2[2]) - 1), int(_local_2[3]));
            _local_3.setUTCHours(int(_local_2[4]), int(_local_2[5]), int(_local_2[6]), 0);
            return (_local_3);
        }

        public static function humanReadableTime(_arg_1:int):String{
            var _local_2:String;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            _local_6 = ((_arg_1 >= 0) ? _arg_1 : 0);
            _local_3 = int((_local_6 / DAY_IN_S));
            _local_6 = (_local_6 % DAY_IN_S);
            _local_4 = int((_local_6 / HOUR_IN_S));
            _local_6 = (_local_6 % HOUR_IN_S);
            _local_5 = int((_local_6 / MIN_IN_S));
            return (_getReadableTime(_arg_1, _local_3, _local_4, _local_5));
        }

        private static function _getReadableTime(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):String{
            var _local_5:String;
            if (_arg_1 >= DAY_IN_S){
                if (((_arg_3 == 0) && (_arg_4 == 0))){
                    _local_5 = (_arg_2.toString() + ((_arg_2 > 1) ? "days" : "day"));
                    return (_local_5);
                }
                if (_arg_4 == 0){
                    _local_5 = (_arg_2.toString() + ((_arg_2 > 1) ? " days" : " day"));
                    _local_5 = (_local_5 + ((", " + _arg_3.toString()) + ((_arg_3 > 1) ? " hours" : " hour")));
                    return (_local_5);
                }
                _local_5 = (_arg_2.toString() + ((_arg_2 > 1) ? " days" : " day"));
                _local_5 = (_local_5 + ((", " + _arg_3.toString()) + ((_arg_3 > 1) ? " hours" : " hour")));
                _local_5 = (_local_5 + ((" and " + _arg_4.toString()) + ((_arg_4 > 1) ? " minutes" : " minute")));
                return (_local_5);
            }
            if (_arg_1 >= HOUR_IN_S){
                if (_arg_4 == 0){
                    _local_5 = (_arg_3.toString() + ((_arg_3 > 1) ? " hours" : " hour"));
                    return (_local_5);
                }
                _local_5 = (_arg_3.toString() + ((_arg_3 > 1) ? " hours" : " hour"));
                _local_5 = (_local_5 + ((" and " + _arg_4.toString()) + ((_arg_4 > 1) ? " minutes" : " minute")));
                return (_local_5);
            }
            _local_5 = (_arg_4.toString() + ((_arg_4 > 1) ? " minutes" : " minute"));
            return (_local_5);
        }


    }
}//package com.company.assembleegameclient.util

