// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.data.ObjectData

package kabam.rotmg.messaging.impl.data
{
import flash.utils.IDataInput;

public class ObjectData
    {

        public var objectType_:int;
        public var status_:ObjectStatusData = new ObjectStatusData();


        public function parseFromInput(_arg_1:IDataInput):void
        {
            this.objectType_ = _arg_1.readUnsignedShort();
            this.status_.parseFromInput(_arg_1);
        }

        public function toString():String
        {
            return ((("objectType_: " + this.objectType_) + " status_: ") + this.status_);
        }


    }
}//package kabam.rotmg.messaging.impl.data

