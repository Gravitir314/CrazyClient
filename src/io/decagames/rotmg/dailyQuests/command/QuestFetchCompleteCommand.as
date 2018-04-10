// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.command.QuestFetchCompleteCommand

package io.decagames.rotmg.dailyQuests.command
{
import io.decagames.rotmg.dailyQuests.messages.data.QuestData;
import io.decagames.rotmg.dailyQuests.messages.incoming.QuestFetchResponse;
import io.decagames.rotmg.dailyQuests.model.DailyQuest;
import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;

import robotlegs.bender.bundles.mvcs.Command;

public class QuestFetchCompleteCommand extends Command 
    {

        [Inject]
        public var response:QuestFetchResponse;
        [Inject]
        public var model:DailyQuestsModel;


        override public function execute():void
        {
            var _local_1:QuestData;
            var _local_2:DailyQuest;
            this.model.clear();
            for each (_local_1 in this.response.quests)
            {
                _local_2 = new DailyQuest();
                _local_2.id = _local_1.id;
                _local_2.name = _local_1.name;
                _local_2.description = _local_1.description;
                _local_2.requirements = _local_1.requirements;
                _local_2.rewards = _local_1.rewards;
                _local_2.completed = _local_1.completed;
                _local_2.category = _local_1.category;
                _local_2.itemOfChoice = _local_1.itemOfChoice;
                this.model.addQuest(_local_2);
            }
        }


    }
}//package io.decagames.rotmg.dailyQuests.command

