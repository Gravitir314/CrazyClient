// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.packages.contentPopup.PackageBoxContentPopup

package io.decagames.rotmg.shop.packages.contentPopup
{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import kabam.rotmg.packages.model.PackageInfo;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import io.decagames.rotmg.ui.labels.UILabel;

    public class PackageBoxContentPopup extends ModalPopup 
    {

        private var _info:PackageInfo;

        public function PackageBoxContentPopup(_arg_1:PackageInfo)
        {
            this._info = _arg_1;
            super(280, 0, _arg_1.title, DefaultLabelFormat.defaultSmallPopupTitle);
            var _local_2:UILabel = new UILabel();
            DefaultLabelFormat.mysteryBoxContentInfo(_local_2);
            _local_2.text = "The package contains all the following items:";
            _local_2.x = ((280 - _local_2.textWidth) / 2);
            addChild(_local_2);
        }

        public function get info():PackageInfo
        {
            return (this._info);
        }


    }
}//package io.decagames.rotmg.shop.packages.contentPopup

