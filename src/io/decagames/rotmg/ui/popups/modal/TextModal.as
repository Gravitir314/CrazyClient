// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.popups.modal.TextModal

package io.decagames.rotmg.ui.popups.modal
{
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    

    public class TextModal extends ModalPopup 
    {

        private var buttonsMargin:int = 30;

        public function TextModal(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:Vector.<BaseButton>)
        {
            var _local_7:BaseButton;
            var _local_8:int;
            super(_arg_1, 0, _arg_2);
            var _local_5:UILabel = new UILabel();
            _local_5.multiline = true;
            DefaultLabelFormat.defaultTextModalText(_local_5);
            _local_5.multiline = true;
            _local_5.width = _arg_1;
            _local_5.text = _arg_3;
            _local_5.wordWrap = true;
            addChild(_local_5);
            var _local_6:int;
            for each (_local_7 in _arg_4)
            {
                _local_6 = (_local_6 + _local_7.width);
            };
            _local_6 = (_local_6 + (this.buttonsMargin * (_arg_4.length - 1)));
            _local_8 = int(((_arg_1 - _local_6) / 2));
            for each (_local_7 in _arg_4)
            {
                _local_7.x = _local_8;
                _local_8 = (_local_8 + (this.buttonsMargin + _local_7.width));
                _local_7.y = ((_local_5.y + _local_5.textHeight) + 15);
                addChild(_local_7);
                registerButton(_local_7);
            };
        }

    }
}//package io.decagames.rotmg.ui.popups.modal

