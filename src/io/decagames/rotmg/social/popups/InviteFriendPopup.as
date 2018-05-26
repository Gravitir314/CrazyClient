// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.social.popups.InviteFriendPopup

package io.decagames.rotmg.social.popups{
import flash.text.TextFormatAlign;

import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.popups.modal.ModalPopup;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.textField.InputTextField;
import io.decagames.rotmg.ui.texture.TextureParser;

public class InviteFriendPopup extends ModalPopup {

        public var sendButton:SliceScalingButton;
        public var search:InputTextField;

        public function InviteFriendPopup(){
            var _local_1:SliceScalingBitmap;
            super(400, 85, "Send invitation");
            _local_1 = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", 300);
            addChild(_local_1);
            _local_1.height = 30;
            _local_1.x = 50;
            _local_1.y = 10;
            this.search = new InputTextField("Account name");
            DefaultLabelFormat.defaultSmallPopupTitle(this.search, TextFormatAlign.CENTER);
            addChild(this.search);
            this.search.width = 290;
            this.search.x = (_local_1.x + 5);
            this.search.y = (_local_1.y + 7);
            this.sendButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this.sendButton.width = 100;
            this.sendButton.setLabel("Send", DefaultLabelFormat.defaultButtonLabel);
            this.sendButton.y = 50;
            this.sendButton.x = (Math.round((_contentWidth - this.sendButton.width)) / 2);
            addChild(this.sendButton);
        }

    }
}//package io.decagames.rotmg.social.popups

