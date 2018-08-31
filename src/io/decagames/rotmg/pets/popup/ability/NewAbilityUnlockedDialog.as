//io.decagames.rotmg.pets.popup.ability.NewAbilityUnlockedDialog

package io.decagames.rotmg.pets.popup.ability
{
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.popups.modal.ModalPopup;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class NewAbilityUnlockedDialog extends ModalPopup 
    {

        private var _okButton:SliceScalingButton;

        public function NewAbilityUnlockedDialog(_arg_1:String)
        {
            var _local_2:UILabel;
            var _local_4:UILabel;
            var _local_5:SliceScalingBitmap;
            super(270, 120, LineBuilder.getLocalizedStringFromKey("NewAbility.gratz"));
            _local_2 = new UILabel();
            DefaultLabelFormat.newAbilityInfo(_local_2);
            _local_2.y = 5;
            _local_2.width = _contentWidth;
            _local_2.wordWrap = true;
            _local_2.text = LineBuilder.getLocalizedStringFromKey("NewAbility.text");
            addChild(_local_2);
            var _local_3:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", 229);
            addChild(_local_3);
            _local_3.height = 35;
            _local_3.y = ((_local_2.y + _local_2.textHeight) + 10);
            _local_3.x = Math.round(((_contentWidth - _local_3.width) / 2));
            _local_4 = new UILabel();
            DefaultLabelFormat.newAbilityName(_local_4);
            _local_4.y = (_local_3.y + 8);
            _local_4.width = _contentWidth;
            _local_4.wordWrap = true;
            _local_4.text = _arg_1;
            addChild(_local_4);
            _local_5 = new TextureParser().getSliceScalingBitmap("UI", "main_button_decoration", 194);
            addChild(_local_5);
            _local_5.y = ((_local_3.y + _local_3.height) + 10);
            _local_5.x = Math.round(((_contentWidth - _local_5.width) / 2));
            this._okButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this._okButton.setLabel(LineBuilder.getLocalizedStringFromKey("NewAbility.righteous"), DefaultLabelFormat.questButtonCompleteLabel);
            this._okButton.width = 149;
            this._okButton.x = Math.round(((_contentWidth - this._okButton.width) / 2));
            this._okButton.y = (_local_5.y + 6);
            addChild(this._okButton);
        }

        public function get okButton():SliceScalingButton
        {
            return (this._okButton);
        }


    }
}//package io.decagames.rotmg.pets.popup.ability

