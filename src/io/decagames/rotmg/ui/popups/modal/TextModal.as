// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.ui.popups.modal.TextModal

package io.decagames.rotmg.ui.popups.modal{
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;

public class TextModal extends ModalPopup {

    private var buttonsMargin:int = 30;

    public function TextModal(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:Vector.<BaseButton>, _arg_5:Boolean=false){
        var _local_8:BaseButton;
        var _local_9:int;
        super(_arg_1, 0, _arg_2);
        var _local_6:UILabel = new UILabel();
        _local_6.multiline = true;
        DefaultLabelFormat.defaultTextModalText(_local_6);
        _local_6.multiline = true;
        _local_6.width = _arg_1;
        if (_arg_5){
            _local_6.htmlText = _arg_3;
        } else {
            _local_6.text = _arg_3;
        }
        _local_6.wordWrap = true;
        addChild(_local_6);
        var _local_7:int;
        for each (_local_8 in _arg_4) {
            _local_7 = (_local_7 + _local_8.width);
        }
        _local_7 = (_local_7 + (this.buttonsMargin * (_arg_4.length - 1)));
        _local_9 = int(((_arg_1 - _local_7) / 2));
        for each (_local_8 in _arg_4) {
            _local_8.x = _local_9;
            _local_9 = (_local_9 + (this.buttonsMargin + _local_8.width));
            _local_8.y = ((_local_6.y + _local_6.textHeight) + 15);
            addChild(_local_8);
            registerButton(_local_8);
        }
    }

}
}//package io.decagames.rotmg.ui.popups.modal

