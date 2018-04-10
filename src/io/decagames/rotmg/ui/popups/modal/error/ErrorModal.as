// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.popups.modal.error.ErrorModal

package io.decagames.rotmg.ui.popups.modal.error
{
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.modal.TextModal;
import io.decagames.rotmg.ui.popups.modal.buttons.ClosePopupButton;

public class ErrorModal extends TextModal 
    {

        public function ErrorModal(_arg_1:int, _arg_2:String, _arg_3:String)
        {
            var _local_4:Vector.<BaseButton> = new Vector.<BaseButton>();
            _local_4.push(new ClosePopupButton("Ok"));
            super(_arg_1, _arg_2, _arg_3, _local_4);
        }

    }
}//package io.decagames.rotmg.ui.popups.modal.error

