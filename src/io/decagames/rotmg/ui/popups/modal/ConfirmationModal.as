// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.ui.popups.modal.ConfirmationModal

package io.decagames.rotmg.ui.popups.modal{
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.popups.modal.buttons.ClosePopupButton;
import io.decagames.rotmg.ui.texture.TextureParser;

public class ConfirmationModal extends TextModal {

        public var confirmButton:SliceScalingButton;

        public function ConfirmationModal(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:int=100){
            var _local_7:Vector.<BaseButton>;
            _local_7 = new Vector.<BaseButton>();
            var _local_8:ClosePopupButton = new ClosePopupButton(_arg_5);
            _local_8.width = _arg_6;
            this.confirmButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this.confirmButton.setLabel(_arg_4, DefaultLabelFormat.defaultButtonLabel);
            this.confirmButton.width = _arg_6;
            _local_7.push(this.confirmButton);
            _local_7.push(_local_8);
            super(_arg_1, _arg_2, _arg_3, _local_7);
        }

    }
}//package io.decagames.rotmg.ui.popups.modal

