// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.config.DailyQuestsConfig

package io.decagames.rotmg.dailyQuests.config
{
import io.decagames.rotmg.dailyQuests.command.QuestFetchCompleteCommand;
import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
import io.decagames.rotmg.dailyQuests.signal.CloseRedeemPopupSignal;
import io.decagames.rotmg.dailyQuests.signal.LockQuestScreenSignal;
import io.decagames.rotmg.dailyQuests.signal.QuestFetchCompleteSignal;
import io.decagames.rotmg.dailyQuests.signal.QuestRedeemCompleteSignal;
import io.decagames.rotmg.dailyQuests.signal.SelectedItemSlotsSignal;
import io.decagames.rotmg.dailyQuests.signal.ShowQuestInfoSignal;
import io.decagames.rotmg.dailyQuests.signal.UnselectAllSlotsSignal;
import io.decagames.rotmg.dailyQuests.view.DailyQuestWindow;
import io.decagames.rotmg.dailyQuests.view.DailyQuestWindowMediator;
import io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfo;
import io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfoMediator;
import io.decagames.rotmg.dailyQuests.view.list.DailyQuestListElement;
import io.decagames.rotmg.dailyQuests.view.list.DailyQuestListElementMediator;
import io.decagames.rotmg.dailyQuests.view.list.DailyQuestsList;
import io.decagames.rotmg.dailyQuests.view.list.DailyQuestsListMediator;
import io.decagames.rotmg.dailyQuests.view.panel.DailyQuestsPanel;
import io.decagames.rotmg.dailyQuests.view.panel.DailyQuestsPanelMediator;
import io.decagames.rotmg.dailyQuests.view.popup.DailyQuestRedeemPopup;
import io.decagames.rotmg.dailyQuests.view.popup.DailyQuestRedeemPopupMediator;
import io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot;
import io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlotMediator;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class DailyQuestsConfig implements IConfig 
    {

        [Inject]
        public var injector:Injector;
        [Inject]
        public var mediatorMap:IMediatorMap;
        [Inject]
        public var commandMap:ISignalCommandMap;


        public function configure():void
        {
            this.mediatorMap.map(DailyQuestsPanel).toMediator(DailyQuestsPanelMediator);
            this.mediatorMap.map(DailyQuestsList).toMediator(DailyQuestsListMediator);
            this.mediatorMap.map(DailyQuestListElement).toMediator(DailyQuestListElementMediator);
            this.mediatorMap.map(DailyQuestInfo).toMediator(DailyQuestInfoMediator);
            this.mediatorMap.map(DailyQuestItemSlot).toMediator(DailyQuestItemSlotMediator);
            this.mediatorMap.map(DailyQuestWindow).toMediator(DailyQuestWindowMediator);
            this.mediatorMap.map(DailyQuestRedeemPopup).toMediator(DailyQuestRedeemPopupMediator);
            this.injector.map(DailyQuestsModel).asSingleton();
            this.injector.map(ShowQuestInfoSignal).asSingleton();
            this.injector.map(LockQuestScreenSignal).asSingleton();
            this.injector.map(CloseRedeemPopupSignal).asSingleton();
            this.injector.map(QuestRedeemCompleteSignal).asSingleton();
            this.injector.map(SelectedItemSlotsSignal).asSingleton();
            this.injector.map(UnselectAllSlotsSignal).asSingleton();
            this.commandMap.map(QuestFetchCompleteSignal).toCommand(QuestFetchCompleteCommand);
        }


    }
}//package io.decagames.rotmg.dailyQuests.config

