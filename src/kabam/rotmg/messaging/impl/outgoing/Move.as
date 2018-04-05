// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.outgoing.Move

package kabam.rotmg.messaging.impl.outgoing
{
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.MoveRecord;
import kabam.rotmg.messaging.impl.data.WorldPosData;

public class Move extends OutgoingMessage
    {

        public var tickId_:int;
        public var time_:int;
        public var newPosition_:WorldPosData = new WorldPosData();
        public var records_:Vector.<MoveRecord> = new Vector.<MoveRecord>();

        public function Move(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function writeToOutput(_arg_1:IDataOutput):void
        {
            var _local_2:int;
            _arg_1.writeInt(this.tickId_);
            _arg_1.writeInt(this.time_);
            this.newPosition_.writeToOutput(_arg_1);
            _arg_1.writeShort(this.records_.length);
            while (_local_2 < this.records_.length)
            {
                this.records_[_local_2].writeToOutput(_arg_1);
                _local_2++;
            }
        }

        override public function toString():String
        {
            return (formatToString("MOVE", "tickId_", "time_", "newPosition_", "records_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

