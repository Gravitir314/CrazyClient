// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.packages.contentPopup.PackageBoxContentPopup

package io.decagames.rotmg.shop.packages.contentPopup
{
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.popups.modal.ModalPopup;

import kabam.rotmg.packages.model.PackageInfo;

public class PackageBoxContentPopup extends ModalPopup 
    {

        private var _info:PackageInfo;
        private var _infoLabel:UILabel;

        public function PackageBoxContentPopup(_arg_1:PackageInfo)
        {
            this._info = _arg_1;
            super(280, 0, _arg_1.title, DefaultLabelFormat.defaultSmallPopupTitle);
            this._infoLabel = new UILabel();
            DefaultLabelFormat.mysteryBoxContentInfo(this._infoLabel);
            this._infoLabel.multiline = true;
            this._infoLabel.wordWrap = true;
            this._infoLabel.width = 0xFF;
            this._infoLabel.text = ((_arg_1.description != "") ? _arg_1.description : "The package contains all the following items:");
            this._infoLabel.x = 10;
            addChild(this._infoLabel);
        }

        public function get info():PackageInfo
        {
            return (this._info);
        }

        public function get infoLabel():UILabel{
            return (this._infoLabel);
        }


    }
}//package io.decagames.rotmg.shop.packages.contentPopup

