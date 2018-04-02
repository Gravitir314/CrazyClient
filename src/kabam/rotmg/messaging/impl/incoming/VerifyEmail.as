// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.incoming.VerifyEmail

package kabam.rotmg.messaging.impl.incoming
{
import flash.utils.IDataInput;

public class VerifyEmail extends IncomingMessage
    {

        public function VerifyEmail(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function parseFromInput(_arg_1:IDataInput):void
        {
        }

        override public function toString():String
        {
            return (formatToString("VERIFYEMAIL", "asdf", "asdf"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

