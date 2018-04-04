// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.popup.DailyQuestRedeemPopup

package io.decagames.rotmg.dailyQuests.view.popup
{
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import io.decagames.rotmg.dailyQuests.assets.DailyQuestAssets;
import io.decagames.rotmg.dailyQuests.data.DailyQuestItemSlotType;
import io.decagames.rotmg.dailyQuests.model.DailyQuest;
import io.decagames.rotmg.dailyQuests.utils.SlotsRendered;
import io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class DailyQuestRedeemPopup extends Sprite 
    {

        private var w_:int = 326;
        private var h_:int = 238;
        private var _thanksButton:Sprite;
        private var slots:Vector.<DailyQuestItemSlot>;
        private var slotContainerPosition:int = 49;

        public function DailyQuestRedeemPopup(_arg_1:DailyQuest)
        {
            var _local_2:TextFieldDisplayConcrete;
            _local_2 = null;
            super();
            this.slots = new Vector.<DailyQuestItemSlot>();
            addChild(new DailyQuestAssets.DailyQuestsRewardBackground());
            _local_2 = new TextFieldDisplayConcrete().setSize(24).setColor(0xEAEAEA).setBold(true).setTextWidth(this.w_).setAutoSize(TextFieldAutoSize.CENTER).setHorizontalAlign(TextFormatAlign.CENTER);
            _local_2.setStringBuilder(new StaticStringBuilder("Quest Complete"));
            _local_2.y = 0;
            _local_2.y = 9;
            addChild(_local_2);
            this._thanksButton = new Sprite();
            this._thanksButton.addChild(new DailyQuestAssets.DailyQuestsRewardThanksButton());
            addChild(this._thanksButton);
            var _local_3:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setBold(true).setTextWidth(this._thanksButton.width).setAutoSize(TextFieldAutoSize.CENTER).setHorizontalAlign(TextFormatAlign.CENTER);
            _local_3.setStringBuilder(new StaticStringBuilder("Thanks"));
            this._thanksButton.addChild(_local_3);
            _local_3.y = 8;
            this._thanksButton.x = 89;
            this._thanksButton.y = 180;
            var _local_4:Sprite = new Sprite();
            addChild(_local_4);
            SlotsRendered.renderSlots(_arg_1.rewards, new Vector.<int>(), DailyQuestItemSlotType.REWARD, _local_4, this.slotContainerPosition, 4, width, this.slots);
            var _local_5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(14).setColor(0xA3A3A3).setBold(true).setTextWidth(this.w_).setAutoSize(TextFieldAutoSize.CENTER).setHorizontalAlign(TextFormatAlign.CENTER);
            _local_5.setStringBuilder(new StaticStringBuilder("Rewards are sent to the Gift Chest!"));
            _local_5.y = 150;
            addChild(_local_5);
        }

        public function get thanksButton():Sprite
        {
            return (this._thanksButton);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.popup

