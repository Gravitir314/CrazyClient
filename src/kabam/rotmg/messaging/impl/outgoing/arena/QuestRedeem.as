// Decompiled by AS3 Sorcerer 5.64
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.outgoing.arena.QuestRedeem

package kabam.rotmg.messaging.impl.outgoing.arena{
import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;
import kabam.rotmg.messaging.impl.data.SlotObjectData;
import flash.utils.IDataOutput;

public class QuestRedeem extends OutgoingMessage {

    public var questID:String;
    public var slots:Vector.<SlotObjectData>;
    public var item:int;

    public function QuestRedeem(_arg_1:uint, _arg_2:Function){
        super(_arg_1, _arg_2);
    }

    override public function writeToOutput(_arg_1:IDataOutput):void{
        var _local_2:SlotObjectData;
        _arg_1.writeUTF(this.questID);
        _arg_1.writeInt(this.item);
        _arg_1.writeShort(this.slots.length);
        for each (_local_2 in this.slots) {
            _local_2.writeToOutput(_arg_1);
        };
    }


}
}//package kabam.rotmg.messaging.impl.outgoing.arena

