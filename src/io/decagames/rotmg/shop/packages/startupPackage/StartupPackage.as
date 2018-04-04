// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.packages.startupPackage.StartupPackage

package io.decagames.rotmg.shop.packages.startupPackage
{
import io.decagames.rotmg.shop.packages.PackageBoxTile;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.popups.BasePopup;
import io.decagames.rotmg.ui.popups.header.PopupHeader;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.packages.model.PackageInfo;

public class StartupPackage extends BasePopup 
    {

        public var closeButton:SliceScalingButton;
        public var infoButton:SliceScalingButton;
        private var header:PopupHeader;
        private var _info:PackageInfo;

        public function StartupPackage(_arg_1:PackageInfo)
        {
            super(550, 385);
            this._info = _arg_1;
            showOnFullScreen = true;
            var _local_2:PackageBoxTile = new PackageBoxTile(_arg_1, true);
            addChild(_local_2);
            _local_2.resize(550, 385);
            this.header = new PopupHeader(550, PopupHeader.TYPE_MODAL);
            this.header.setTitle(_arg_1.title, (popupWidth - 18), DefaultLabelFormat.defaultModalTitle);
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.infoButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "info_button"));
            this.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.header.addButton(this.infoButton, PopupHeader.LEFT_BUTTON);
            this.header.y = ((-(this.header.height) / 2) + 4);
            addChild(this.header);
        }

        public function dispose():void
        {
            this.closeButton.dispose();
            this.infoButton.dispose();
            this.header.dispose();
        }

        public function get info():PackageInfo
        {
            return (this._info);
        }


    }
}//package io.decagames.rotmg.shop.packages.startupPackage

