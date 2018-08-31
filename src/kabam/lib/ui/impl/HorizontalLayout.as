//kabam.lib.ui.impl.HorizontalLayout

package kabam.lib.ui.impl
{
import flash.display.DisplayObject;

import kabam.lib.ui.api.Layout;

public class HorizontalLayout implements Layout
    {

        private var padding:int = 0;


        public function getPadding():int
        {
            return (this.padding);
        }

        public function setPadding(_arg_1:int):void
        {
            this.padding = _arg_1;
        }

        public function layout(_arg_1:Vector.<DisplayObject>, _arg_2:int=0):void
        {
            var _local_3:DisplayObject;
            var _local_4:int;
            var _local_5:int = _arg_2;
            var _local_6:int = _arg_1.length;
            while (_local_4 < _local_6)
            {
                _local_3 = _arg_1[_local_4];
                _local_3.x = _local_5;
                _local_5 = (_local_5 + (_local_3.width + this.padding));
                _local_4++;
            }
        }


    }
}//package kabam.lib.ui.impl

