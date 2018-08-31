//kabam.lib.util.VectorAS3Util

package kabam.lib.util
{
    public class VectorAS3Util 
    {


        public static function toArray(_arg_1:Object):Array
        {
            var _local_2:Object;
            var _local_3:Array = [];
            for each (_local_2 in _arg_1)
            {
                _local_3.push(_local_2);
            }
            return (_local_3);
        }


    }
}//package kabam.lib.util

