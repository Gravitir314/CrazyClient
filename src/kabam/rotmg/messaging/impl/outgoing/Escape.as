// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.outgoing.Escape

package kabam.rotmg.messaging.impl.outgoing
{
import flash.utils.IDataOutput;

public class Escape extends OutgoingMessage
    {

        public function Escape(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function writeToOutput(_arg_1:IDataOutput):void
        {
        }

        override public function toString():String
        {
            return (formatToString("ESCAPE"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

