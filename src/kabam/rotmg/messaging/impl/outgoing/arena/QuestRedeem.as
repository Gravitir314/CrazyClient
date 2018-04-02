// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.outgoing.arena.QuestRedeem

package kabam.rotmg.messaging.impl.outgoing.arena
{
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;

public class QuestRedeem extends OutgoingMessage
    {

        public var questID:String;
        public var slots:Vector.<SlotObjectData>;

        public function QuestRedeem(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function writeToOutput(_arg_1:IDataOutput):void
        {
            var _local_2:SlotObjectData;
            _arg_1.writeUTF(this.questID);
            _arg_1.writeShort(this.slots.length);
            for each (_local_2 in this.slots)
            {
                _local_2.writeToOutput(_arg_1);
            };
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing.arena

