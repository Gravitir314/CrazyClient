// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.mysteryBox.contentPopup.UIItemContainer

package io.decagames.rotmg.shop.mysteryBox.contentPopup
{
import com.company.assembleegameclient.objects.ObjectLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.filters.DropShadowFilter;
import flash.text.TextFormat;

import io.decagames.rotmg.ui.gird.UIGridElement;
import io.decagames.rotmg.ui.labels.UILabel;

import kabam.rotmg.text.model.FontModel;

public class UIItemContainer extends UIGridElement 
    {

        private var _itemId:int;
        private var size:int;
        private var background:uint;
        private var backgroundAlpha:Number;
        private var _imageBitmap:Bitmap;
        private var _quantity:int = 1;
        private var _showTooltip:Boolean;

        public function UIItemContainer(_arg_1:int, _arg_2:uint, _arg_3:Number=0, _arg_4:int=40)
        {
            this._itemId = _arg_1;
            this.size = _arg_4;
            this.background = _arg_2;
            this.backgroundAlpha = _arg_3;
            this.graphics.clear();
            this.graphics.beginFill(_arg_2, _arg_3);
            this.graphics.drawRect(0, 0, _arg_4, _arg_4);
            this.graphics.endFill();
            var _local_5:BitmapData = ObjectLibrary.getRedrawnTextureFromType(int(_arg_1), (_arg_4 * 2), true, false);
            this._imageBitmap = new Bitmap(_local_5);
            this._imageBitmap.x = -(Math.round(((this._imageBitmap.width - _arg_4) / 2)));
            this._imageBitmap.y = -(Math.round(((this._imageBitmap.height - _arg_4) / 2)));
            this.addChild(this._imageBitmap);
        }

        override public function dispose():void
        {
            this._imageBitmap.bitmapData.dispose();
            super.dispose();
        }

        public function showQuantityLabel(_arg_1:int):void
        {
            var _local_2:UILabel;
            this._quantity = _arg_1;
            _local_2 = new UILabel();
            var _local_3:TextFormat = new TextFormat();
            _local_3.color = 0xFFFFFF;
            _local_3.bold = true;
            _local_3.font = FontModel.DEFAULT_FONT_NAME;
            _local_3.size = (this.size * 0.35);
            _local_2.defaultTextFormat = _local_3;
            _local_2.text = (_arg_1 + "x");
            _local_2.y = ((this.size - _local_2.textHeight) - (this.size * 0.1));
            _local_2.x = ((this.size - _local_2.textWidth) - (this.size * 0.1));
            _local_2.filters = [new DropShadowFilter(1, 90, 0, 0.5, 4, 4)];
            addChild(_local_2);
        }

        public function clone():UIItemContainer
        {
            var _local_1:UIItemContainer = new UIItemContainer(this._itemId, this.background, this.backgroundAlpha, this.size);
            if (this._quantity > 1)
            {
                _local_1.showQuantityLabel(this._quantity);
            }
            return (_local_1);
        }

        public function get itemId():int
        {
            return (this._itemId);
        }

        override public function get width():Number
        {
            return (this.size);
        }

        override public function get height():Number
        {
            return (this.size);
        }

        public function get imageBitmap():Bitmap
        {
            return (this._imageBitmap);
        }

        public function get showTooltip():Boolean
        {
            return (this._showTooltip);
        }

        public function set showTooltip(_arg_1:Boolean):void
        {
            this._showTooltip = _arg_1;
        }

        public function get quantity():int
        {
            return (this._quantity);
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.contentPopup

