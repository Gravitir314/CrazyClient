// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.popup.DailyQuestRedeemPopup

package io.decagames.rotmg.dailyQuests.view.popup{
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

import io.decagames.rotmg.dailyQuests.data.DailyQuestItemSlotType;
import io.decagames.rotmg.dailyQuests.model.DailyQuest;
import io.decagames.rotmg.dailyQuests.utils.SlotsRendered;
import io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.popups.modal.ModalPopup;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class DailyQuestRedeemPopup extends ModalPopup {

    private var w_:int = 326;
    private var h_:int = 238;
    private var _thanksButton:SliceScalingButton;
    private var slots:Vector.<DailyQuestItemSlot>;
    private var slotContainerPosition:int = 15;

    public function DailyQuestRedeemPopup(_arg_1:DailyQuest, _arg_2:int=-1){
        super(this.w_, this.h_, "Quest Complete");
        var _local_3:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", this.w_);
        _local_3.height = 117;
        addChild(_local_3);
        this.slots = new Vector.<DailyQuestItemSlot>();
        var _local_4:SliceScalingBitmap = new TextureParser().getSliceScalingBitmap("UI", "main_button_decoration", 194);
        addChild(_local_4);
        _local_4.y = 179;
        _local_4.x = Math.round(((this.w_ - _local_4.width) / 2));
        this._thanksButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
        this._thanksButton.setLabel("Thanks", DefaultLabelFormat.questButtonCompleteLabel);
        this._thanksButton.width = 149;
        addChild(this._thanksButton);
        this._thanksButton.x = Math.round(((this.w_ - 149) / 2));
        this._thanksButton.y = 185;
        var _local_5:Sprite = new Sprite();
        addChild(_local_5);
        if (_arg_1.itemOfChoice){
            SlotsRendered.renderSlots(new <int>[_arg_2], new Vector.<int>(), DailyQuestItemSlotType.REWARD, _local_5, this.slotContainerPosition, 4, this.w_, this.slots);
        } else {
            SlotsRendered.renderSlots(_arg_1.rewards, new Vector.<int>(), DailyQuestItemSlotType.REWARD, _local_5, this.slotContainerPosition, 4, this.w_, this.slots);
        }
        var _local_6:UILabel = new UILabel();
        DefaultLabelFormat.questRefreshLabel(_local_6);
        _local_6.width = this.w_;
        _local_6.autoSize = TextFieldAutoSize.CENTER;
        _local_6.text = "Rewards are sent to the Gift Chest!";
        _local_6.y = 140;
        addChild(_local_6);
    }

    public function get thanksButton():SliceScalingButton{
        return (this._thanksButton);
    }


}
}//package io.decagames.rotmg.dailyQuests.view.popup

