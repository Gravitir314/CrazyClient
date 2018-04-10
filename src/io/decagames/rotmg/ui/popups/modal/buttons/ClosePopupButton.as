// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.popups.modal.buttons.ClosePopupButton

package io.decagames.rotmg.ui.popups.modal.buttons
{
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.texture.TextureParser;

public class ClosePopupButton extends SliceScalingButton 
    {

        public function ClosePopupButton(_arg_1:String)
        {
            super(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            setLabel(_arg_1, DefaultLabelFormat.defaultButtonLabel);
            width = 100;
        }

    }
}//package io.decagames.rotmg.ui.popups.modal.buttons

