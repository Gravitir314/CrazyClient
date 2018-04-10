// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.ShopBuyButton

package io.decagames.rotmg.shop
{
import flash.display.Bitmap;
import flash.display.BitmapData;

import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.assets.services.IconFactory;

public class ShopBuyButton extends SliceScalingButton 
    {

        public static const CURRENCY_GOLD:int = 0;
        public static const CURRENCY_FAME:int = 1;

        private var _priceLabel:UILabel;
        private var coinBitmap:Bitmap;
        private var _price:int;

        public function ShopBuyButton(_arg_1:int, _arg_2:int=0)
        {
            super(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this._price = _arg_1;
            this._priceLabel = new UILabel();
            this._priceLabel.text = _arg_1.toString();
            this._priceLabel.y = 7;
            var _local_3:BitmapData = ((_arg_2 == CURRENCY_GOLD) ? IconFactory.makeCoin() : IconFactory.makeFame());
            this.coinBitmap = new Bitmap(_local_3);
            this.coinBitmap.y = (Math.round((this.coinBitmap.height / 2)) - 3);
            DefaultLabelFormat.priceButtonLabel(this._priceLabel);
            addChild(this._priceLabel);
            addChild(this.coinBitmap);
        }

        override public function dispose():void
        {
            this.coinBitmap.bitmapData.dispose();
            super.dispose();
        }

        override public function set width(_arg_1:Number):void
        {
            bitmap.width = _arg_1;
            this.updateLabelPosition();
        }

        private function updateLabelPosition():void
        {
            if (this.coinBitmap.parent)
            {
                this._priceLabel.x = ((bitmap.width - 38) - this._priceLabel.textWidth);
            }
            else
            {
                this._priceLabel.x = ((bitmap.width - this._priceLabel.textWidth) / 2);
            }
            this.coinBitmap.x = ((bitmap.width - this.coinBitmap.width) - 15);
        }

        public function set price(_arg_1:int):void
        {
            this._price = _arg_1;
            if (!_disabled)
            {
                this.priceLabel.text = _arg_1.toString();
                this.updateLabelPosition();
            }
        }

        override public function set disabled(_arg_1:Boolean):void
        {
            super.disabled = _arg_1;
            if (_arg_1)
            {
                this._priceLabel.text = "Sold out";
                removeChild(this.coinBitmap);
            }
            else
            {
                this._priceLabel.text = this._price.toString();
                addChild(this.coinBitmap);
            }
            this.updateLabelPosition();
        }

        public function get priceLabel():UILabel
        {
            return (this._priceLabel);
        }


    }
}//package io.decagames.rotmg.shop

