// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.packages.PackageBoxTile

package io.decagames.rotmg.shop.packages
{
import flash.display.Loader;
import flash.display.Sprite;

import io.decagames.rotmg.shop.genericBox.GenericBoxTile;
import io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;

import kabam.rotmg.packages.model.PackageInfo;

public class PackageBoxTile extends GenericBoxTile 
    {

        private var backgroundContainer:Sprite = new Sprite();
        private var imageMask:SliceScalingBitmap;

        public function PackageBoxTile(_arg_1:GenericBoxInfo, _arg_2:Boolean=false)
        {
            buyButtonBitmapBackground = "buy_button_background";
            super(_arg_1, _arg_2);
        }

        override protected function createBoxBackground():void
        {
            addChild(this.backgroundContainer);
            this.resizeBackgroundImage();
        }

        private function resizeBackgroundImage():void
        {
            var _local_1:Loader;
            if (_isPopup)
            {
                _local_1 = PackageInfo(_boxInfo).popupLoader;
            }
            else
            {
                _local_1 = PackageInfo(_boxInfo).loader;
            }
            if (((_local_1) && (!(_local_1.parent == this.backgroundContainer))))
            {
                this.backgroundContainer.addChild(_local_1);
                this.backgroundContainer.cacheAsBitmap = true;
                this.imageMask = background.clone();
                addChild(this.imageMask);
                this.imageMask.cacheAsBitmap = true;
                this.backgroundContainer.mask = this.imageMask;
            }
            if (this.imageMask)
            {
                this.imageMask.width = (background.width - 6);
                this.imageMask.height = (background.height - 6);
                this.imageMask.x = (background.x + 3);
                this.imageMask.y = (background.y + 3);
                this.imageMask.cacheAsBitmap = true;
            }
        }

        override public function dispose():void
        {
            this.imageMask.dispose();
            super.dispose();
        }

        override public function resize(_arg_1:int, _arg_2:int=-1):void
        {
            background.width = _arg_1;
            if (backgroundTitle)
            {
                backgroundTitle.width = _arg_1;
                backgroundTitle.y = 2;
            }
            backgroundButton.width = 158;
            if (_arg_2 == -1)
            {
                background.height = 184;
            }
            else
            {
                background.height = _arg_2;
            }
            titleLabel.x = Math.round(((_arg_1 - titleLabel.textWidth) / 2));
            titleLabel.y = 6;
            backgroundButton.y = (background.height - 51);
            backgroundButton.x = Math.round(((_arg_1 - backgroundButton.width) / 2));
            _buyButton.y = (backgroundButton.y + 4);
            _buyButton.x = (((backgroundButton.x + backgroundButton.width) - _buyButton.width) - 6);
            if (_infoButton)
            {
                _infoButton.x = ((background.width - _infoButton.width) - 3);
                _infoButton.y = 2;
            }
            _spinner.x = (backgroundButton.x + 34);
            _spinner.y = (background.height - 53);
            updateTimeEndString();
            this.resizeBackgroundImage();
            updateSaleLabel();
            updateClickMask(_arg_1);
        }


    }
}//package io.decagames.rotmg.shop.packages

