//ru.inspirit.net.events.MultipartURLLoaderEvent

package ru.inspirit.net.events
{
import flash.events.Event;

public class MultipartURLLoaderEvent extends Event 
    {

        public static const DATA_PREPARE_PROGRESS:String = "dataPrepareProgress";
        public static const DATA_PREPARE_COMPLETE:String = "dataPrepareComplete";

        public var bytesWritten:uint = 0;
        public var bytesTotal:uint = 0;

        public function MultipartURLLoaderEvent(_arg_1:String, _arg_2:uint=0, _arg_3:uint=0)
        {
            super(_arg_1);
            this.bytesTotal = _arg_3;
            this.bytesWritten = _arg_2;
        }

    }
}//package ru.inspirit.net.events

