// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfo

package io.decagames.rotmg.dailyQuests.view.info
{
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import flashx.textLayout.formats.TextAlign;

import io.decagames.rotmg.dailyQuests.data.DailyQuestItemSlotType;
import io.decagames.rotmg.dailyQuests.model.DailyQuest;
import io.decagames.rotmg.dailyQuests.utils.SlotsRendered;
import io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class DailyQuestInfo extends Sprite 
    {

        public static var INFO_WIDTH:int = 328;
        public static const INFO_HEIGHT:int = 434;

        private var questName:TextFieldDisplayConcrete;
        private var questDescription:TextFieldDisplayConcrete;
        private var slots:Vector.<DailyQuestItemSlot>;
        private var slotMargin:int = 4;
        private var requirementsTopMargin:int = 118;
        private var rewardsTopMargin:int = 261;
        private var requirementsContainer:Sprite;
        private var rewardsContainer:Sprite;
        private var _completeButton:DailyQuestCompleteButton;
        private var playerEquipment:Vector.<int>;

        public function DailyQuestInfo()
        {
            var _local_1:TextFieldDisplayConcrete;
            _local_1 = null;
            super();
            this.questName = new TextFieldDisplayConcrete().setSize(20).setColor(15241232).setBold(true).setTextWidth(INFO_WIDTH).setAutoSize(TextFieldAutoSize.CENTER).setHorizontalAlign(TextFormatAlign.CENTER);
            this.questName.y = 8;
            this.questName.x = 0;
            addChild(this.questName);
            this.requirementsContainer = new Sprite();
            addChild(this.requirementsContainer);
            this.rewardsContainer = new Sprite();
            addChild(this.rewardsContainer);
            this.questDescription = new TextFieldDisplayConcrete().setSize(16).setColor(13224136).setBold(true).setTextWidth((INFO_WIDTH - 30)).setMultiLine(true).setWordWrap(true).setHorizontalAlign(TextAlign.CENTER);
            this.questDescription.y = 44;
            this.questDescription.x = 15;
            addChild(this.questDescription);
            _local_1 = new TextFieldDisplayConcrete().setSize(16).setColor(0xEAEAEA).setBold(true).setTextWidth(120).setAutoSize(TextFieldAutoSize.CENTER).setHorizontalAlign(TextFormatAlign.CENTER);
            _local_1.y = 223;
            _local_1.x = 105;
            _local_1.setStringBuilder(new StaticStringBuilder("Rewards"));
            addChild(_local_1);
            this._completeButton = new DailyQuestCompleteButton();
            this._completeButton.x = 89;
            this._completeButton.y = 384;
        }

        public static function hasAllItems(_arg_1:Vector.<int>, _arg_2:Vector.<int>):Boolean
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:Vector.<int> = _arg_1.concat();
            for each (_local_3 in _arg_2)
            {
                _local_4 = _local_5.indexOf(_local_3);
                if (_local_4 >= 0)
                {
                    _local_5.splice(_local_4, 1);
                }
            }
            return (_local_5.length == 0);
        }


        public function clear():void
        {
            var _local_1:DailyQuestItemSlot;
            for each (_local_1 in this.slots)
            {
                _local_1.parent.removeChild(_local_1);
            }
            this.slots = new Vector.<DailyQuestItemSlot>();
        }

        public function show(_arg_1:DailyQuest, _arg_2:Vector.<int>):void
        {
            this.playerEquipment = _arg_2.concat();
            this.questName.setStringBuilder(new StaticStringBuilder(_arg_1.name));
            this.questDescription.setStringBuilder(new StaticStringBuilder(_arg_1.description));
            SlotsRendered.renderSlots(_arg_1.requirements, this.playerEquipment, DailyQuestItemSlotType.REQUIREMENT, this.requirementsContainer, this.requirementsTopMargin, this.slotMargin, INFO_WIDTH, this.slots);
            SlotsRendered.renderSlots(_arg_1.rewards, this.playerEquipment, DailyQuestItemSlotType.REWARD, this.rewardsContainer, this.rewardsTopMargin, this.slotMargin, INFO_WIDTH, this.slots);
            this._completeButton.enabled = hasAllItems(_arg_1.requirements, _arg_2);
            this._completeButton.completed = _arg_1.completed;
            this._completeButton.draw();
            addChild(this._completeButton);
        }

        public function get completeButton():DailyQuestCompleteButton
        {
            return (this._completeButton);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.info

