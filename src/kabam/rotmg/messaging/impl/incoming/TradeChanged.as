// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.incoming.TradeChanged

package kabam.rotmg.messaging.impl.incoming
{
import flash.utils.IDataInput;

public class TradeChanged extends IncomingMessage
    {

        public var offer_:Vector.<Boolean> = new Vector.<Boolean>();

        public function TradeChanged(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function parseFromInput(_arg_1:IDataInput):void
        {
            var _local_2:int;
            this.offer_.length = 0;
            var _local_3:int = _arg_1.readShort();
            while (_local_2 < _local_3)
            {
                this.offer_.push(_arg_1.readBoolean());
                _local_2++;
            }
        }

        override public function toString():String
        {
            return (formatToString("TRADECHANGED", "offer_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

