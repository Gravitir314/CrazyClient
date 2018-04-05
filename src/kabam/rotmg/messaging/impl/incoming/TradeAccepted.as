// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.incoming.TradeAccepted

package kabam.rotmg.messaging.impl.incoming
{
import flash.utils.IDataInput;

public class TradeAccepted extends IncomingMessage
    {

        public var myOffer_:Vector.<Boolean> = new Vector.<Boolean>();
        public var yourOffer_:Vector.<Boolean> = new Vector.<Boolean>();

        public function TradeAccepted(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function parseFromInput(_arg_1:IDataInput):void
        {
            var _local_2:int;
            this.myOffer_.length = 0;
            var _local_3:int = _arg_1.readShort();
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                this.myOffer_.push(_arg_1.readBoolean());
                _local_2++;
            }
            this.yourOffer_.length = 0;
            _local_3 = _arg_1.readShort();
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                this.yourOffer_.push(_arg_1.readBoolean());
                _local_2++;
            }
        }

        override public function toString():String
        {
            return (formatToString("TRADEACCEPTED", "myOffer_", "yourOffer_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

