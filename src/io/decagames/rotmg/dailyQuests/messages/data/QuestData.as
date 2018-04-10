// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.messages.data.QuestData

package io.decagames.rotmg.dailyQuests.messages.data
{
    import __AS3__.vec.Vector;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    public class QuestData 
    {

        public var id:String;
        public var name:String;
        public var description:String;
        public var requirements:Vector.<int> = new Vector.<int>();
        public var rewards:Vector.<int> = new Vector.<int>();
        public var completed:Boolean;
        public var itemOfChoice:Boolean;
        public var category:int;


        public function parseFromInput(_arg_1:IDataInput):void
        {
            this.id = _arg_1.readUTF();
            this.name = _arg_1.readUTF();
            this.description = _arg_1.readUTF();
            this.category = _arg_1.readInt();
            var _local_2:int = _arg_1.readShort();
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                this.requirements.push(_arg_1.readInt());
                _local_3++;
            };
            _local_2 = _arg_1.readShort();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                this.rewards.push(_arg_1.readInt());
                _local_3++;
            };
            this.completed = _arg_1.readBoolean();
            this.itemOfChoice = _arg_1.readBoolean();
        }


    }
}//package io.decagames.rotmg.dailyQuests.messages.data

