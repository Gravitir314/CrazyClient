// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.outgoing.Reskin

package kabam.rotmg.messaging.impl.outgoing
{
import com.company.assembleegameclient.objects.Player;

import flash.utils.IDataOutput;

public class Reskin extends OutgoingMessage
    {

        public var skinID:int;
        public var player:Player;

        public function Reskin(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function writeToOutput(_arg_1:IDataOutput):void
        {
            _arg_1.writeInt(this.skinID);
        }

        override public function consume():void
        {
            super.consume();
            this.player = null;
        }

        override public function toString():String
        {
            return (formatToString("RESKIN", "skinID"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

