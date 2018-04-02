// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.mysteryBox.MysteryBoxTile

package io.decagames.rotmg.shop.mysteryBox
{
import io.decagames.rotmg.shop.genericBox.GenericBoxTile;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.mysterybox.model.MysteryBoxInfo;

public class MysteryBoxTile extends GenericBoxTile
    {

        protected var chest:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "shop_chest");

        public function MysteryBoxTile(_arg_1:MysteryBoxInfo)
        {
            buyButtonBitmapBackground = "shop_box_button_background";
            super(_arg_1);
        }

        override protected function createBoxBackground():void
        {
            addChild(this.chest);
        }

        override public function resize(_arg_1:int, _arg_2:int=-1):void
        {
            background.width = _arg_1;
            backgroundTitle.width = _arg_1;
            backgroundButton.width = _arg_1;
            background.height = 184;
            backgroundTitle.y = 2;
            titleLabel.x = Math.round(((_arg_1 - titleLabel.textWidth) / 2));
            titleLabel.y = 6;
            backgroundButton.y = 133;
            _buyButton.y = (backgroundButton.y + 4);
            _buyButton.x = (_arg_1 - 110);
            _infoButton.x = 130;
            _infoButton.y = 45;
            this.chest.x = ((_arg_1 - this.chest.width) / 2);
            this.chest.y = 45;
            updateTimeEndString();
            updateSaleLabel();
        }

        override public function dispose():void
        {
            this.chest.dispose();
            super.dispose();
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox

