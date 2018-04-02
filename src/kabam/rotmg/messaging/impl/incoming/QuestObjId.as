// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.incoming.QuestObjId

package kabam.rotmg.messaging.impl.incoming
{
import flash.utils.IDataInput;

public class QuestObjId extends IncomingMessage
    {

        public var objectId_:int;

        public function QuestObjId(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function parseFromInput(_arg_1:IDataInput):void
        {
            this.objectId_ = _arg_1.readInt();
        }

        override public function toString():String
        {
            return (formatToString("QUESTOBJID", "objectId_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

