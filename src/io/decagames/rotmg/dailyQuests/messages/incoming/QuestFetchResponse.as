//io.decagames.rotmg.dailyQuests.messages.incoming.QuestFetchResponse

package io.decagames.rotmg.dailyQuests.messages.incoming
{
import flash.utils.IDataInput;

import io.decagames.rotmg.dailyQuests.messages.data.QuestData;

import kabam.rotmg.messaging.impl.incoming.IncomingMessage;

public class QuestFetchResponse extends IncomingMessage
    {

        public var quests:Vector.<QuestData> = new Vector.<QuestData>();

        public function QuestFetchResponse(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function parseFromInput(_arg_1:IDataInput):void
        {
            var _local_2:int = _arg_1.readShort();
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                this.quests[_local_3] = new QuestData();
                this.quests[_local_3].parseFromInput(_arg_1);
                _local_3++;
            }
        }

        override public function toString():String
        {
            return (formatToString("QUESTFETCHRESPONSE"));
        }


    }
}//package io.decagames.rotmg.dailyQuests.messages.incoming

