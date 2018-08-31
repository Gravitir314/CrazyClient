//io.decagames.rotmg.shop.ShopBuyButton

package io.decagames.rotmg.shop
{
import com.company.assembleegameclient.util.Currency;

import flash.display.Bitmap;
import flash.display.BitmapData;

import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.assets.services.IconFactory;

public class ShopBuyButton extends SliceScalingButton 
    {

        private var _priceLabel:UILabel;
        private var coinBitmap:Bitmap;
        private var _price:int;
        private var _soldOut:Boolean;
        private var _currency:int;

        public function ShopBuyButton(_arg_1:int, _arg_2:int=0)
        {
            super(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this._price = _arg_1;
            this._priceLabel = new UILabel();
            this._priceLabel.text = _arg_1.toString();
            this._priceLabel.y = 7;
            this._currency = _arg_2;
            var _local_3:BitmapData = ((_arg_2 == Currency.GOLD) ? IconFactory.makeCoin() : IconFactory.makeFame());
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
            super.width = _arg_1;
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
            this.priceLabel.text = _arg_1.toString();
            this.updateLabelPosition();
        }

        public function get priceLabel():UILabel
        {
            return (this._priceLabel);
        }

        public function get soldOut():Boolean
        {
            return (this._soldOut);
        }

        public function set soldOut(_arg_1:Boolean):void
        {
            this._soldOut = _arg_1;
            disabled = _arg_1;
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

        public function get price():int
        {
            return (this._price);
        }

        public function get currency():int
        {
            return (this._currency);
        }


    }
}//package io.decagames.rotmg.shop

