// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.dailyLogin.message.ClaimDailyRewardMessage

package kabam.rotmg.dailyLogin.message
{
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;

public class ClaimDailyRewardMessage extends OutgoingMessage
    {

        public var claimKey:String;
        public var type:String;

        public function ClaimDailyRewardMessage(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function writeToOutput(_arg_1:IDataOutput):void
        {
            _arg_1.writeUTF(this.claimKey);
            _arg_1.writeUTF(this.type);
        }

        override public function toString():String
        {
            return ("type");
        }


    }
}//package kabam.rotmg.dailyLogin.message

