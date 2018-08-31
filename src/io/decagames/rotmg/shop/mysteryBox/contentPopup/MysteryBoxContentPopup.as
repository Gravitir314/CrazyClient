//io.decagames.rotmg.shop.mysteryBox.contentPopup.MysteryBoxContentPopup

package io.decagames.rotmg.shop.mysteryBox.contentPopup
{
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.popups.modal.ModalPopup;

import kabam.rotmg.mysterybox.model.MysteryBoxInfo;

public class MysteryBoxContentPopup extends ModalPopup
    {

        private var _info:MysteryBoxInfo;

        public function MysteryBoxContentPopup(_arg_1:MysteryBoxInfo)
        {
            var _local_2:UILabel;
            this._info = _arg_1;
            super(280, 0, _arg_1.title, DefaultLabelFormat.defaultSmallPopupTitle);
            _local_2 = new UILabel();
            DefaultLabelFormat.mysteryBoxContentInfo(_local_2);
            _local_2.multiline = true;
            switch (_arg_1.rolls)
            {
                case 1:
                    _local_2.text = "You will win one\nof the rewards listed below!";
                    break;
                case 2:
                    _local_2.text = "You will win two\nof the rewards listed below!";
                    break;
                case 3:
                    _local_2.text = "You will win three\nof the rewards listed below!";
                    break;
            }
            _local_2.x = ((280 - _local_2.textWidth) / 2);
            addChild(_local_2);
        }

        public function get info():MysteryBoxInfo
        {
            return (this._info);
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.contentPopup

