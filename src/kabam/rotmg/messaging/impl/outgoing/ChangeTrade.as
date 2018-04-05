// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.outgoing.ChangeTrade

package kabam.rotmg.messaging.impl.outgoing
{
import flash.utils.IDataOutput;

public class ChangeTrade extends OutgoingMessage
    {

        public var offer_:Vector.<Boolean> = new Vector.<Boolean>();

        public function ChangeTrade(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function writeToOutput(_arg_1:IDataOutput):void
        {
            var _local_2:int;
            _arg_1.writeShort(this.offer_.length);
            while (_local_2 < this.offer_.length)
            {
                _arg_1.writeBoolean(this.offer_[_local_2]);
                _local_2++;
            }
        }

        override public function toString():String
        {
            return (formatToString("CHANGETRADE", "offer_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

