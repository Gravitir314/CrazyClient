//kabam.rotmg.messaging.impl.outgoing.thunderboxer.ThunderMove

package kabam.rotmg.messaging.impl.outgoing.thunderboxer
{
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.WorldPosData;
import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;

public class ThunderMove extends OutgoingMessage
    {

        public var newPosition_:WorldPosData = new WorldPosData();

        public function ThunderMove(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function writeToOutput(_arg_1:IDataOutput):void
        {
            this.newPosition_.writeToOutput(_arg_1);
        }

        override public function toString():String
        {
            return (formatToString("THUNDERMOVE", "newPosition_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing.thunderboxer

