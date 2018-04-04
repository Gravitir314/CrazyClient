// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.popups.header.PopupHeader

package io.decagames.rotmg.ui.popups.header
{
import flash.display.Sprite;

import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class PopupHeader extends Sprite
    {

        public static const LEFT_BUTTON:String = "left_button";
        public static const RIGHT_BUTTON:String = "right_button";
        public static var TYPE_FULL:String = "full";
        public static var TYPE_MODAL:String = "modal";

        private var backgroundBitmap:SliceScalingBitmap;
        private var titleBackgroundBitmap:SliceScalingBitmap;
        private var _titleLabel:UILabel;
        private var buttonsContainers:Vector.<Sprite>;
        private var buttons:Vector.<SliceScalingButton>;
        private var _coinsField:CoinsField;
        private var _fameField:FameField;
        private var headerWidth:int;
        private var headerType:String;

        public function PopupHeader(_arg_1:int, _arg_2:String)
        {
            this.headerWidth = _arg_1;
            this.headerType = _arg_2;
            if (_arg_2 == TYPE_FULL)
            {
                this.backgroundBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "popup_header", _arg_1);
                addChild(this.backgroundBitmap);
            };
            this.buttonsContainers = new Vector.<Sprite>();
            this.buttons = new Vector.<SliceScalingButton>();
        }

        public function setTitle(_arg_1:String, _arg_2:int, _arg_3:Function=null):void
        {
            if (!this.titleBackgroundBitmap)
            {
                if (this.headerType == TYPE_FULL)
                {
                    this.titleBackgroundBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "popup_header_title", _arg_2);
                    addChild(this.titleBackgroundBitmap);
                    this.titleBackgroundBitmap.x = Math.round(((this.headerWidth - _arg_2) / 2));
                    this.titleBackgroundBitmap.y = 29;
                }
                else
                {
                    this.titleBackgroundBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "modal_header_title", _arg_2);
                    addChild(this.titleBackgroundBitmap);
                    this.titleBackgroundBitmap.x = Math.round(((this.headerWidth - _arg_2) / 2));
                };
                this._titleLabel = new UILabel();
                if (_arg_3 != null)
                {
                    (_arg_3(this._titleLabel));
                };
                this._titleLabel.text = _arg_1;
                this._titleLabel.x = (this.titleBackgroundBitmap.x + ((this.titleBackgroundBitmap.width - this._titleLabel.textWidth) / 2));
                this._titleLabel.y = (this.titleBackgroundBitmap.y + ((this.titleBackgroundBitmap.height - this._titleLabel.height) / 2));
                addChild(this._titleLabel);
            };
        }

        public function addButton(_arg_1:SliceScalingButton, _arg_2:String):void
        {
            var _local_4:SliceScalingBitmap;
            var _local_3:Sprite = new Sprite();
            if (this.headerType == TYPE_FULL)
            {
                _local_4 = TextureParser.instance.getSliceScalingBitmap("UI", "popup_header_button_decor");
                _local_3.addChild(_local_4);
            };
            _local_3.addChild(_arg_1);
            addChild(_local_3);
            this.buttonsContainers.push(_local_3);
            this.buttons.push(_arg_1);
            if (this.headerType == TYPE_FULL)
            {
                _local_4.y = ((this.backgroundBitmap.height - _local_4.height) / 2);
                _arg_1.y = (_local_4.y + 8);
            }
            else
            {
                _arg_1.y = 5;
            };
            if (_arg_2 == RIGHT_BUTTON)
            {
                if (this.headerType == TYPE_FULL)
                {
                    _local_4.x = (this.headerWidth - _local_4.width);
                    _arg_1.x = (_local_4.x + 6);
                }
                else
                {
                    _arg_1.x = (((this.titleBackgroundBitmap.x + this.titleBackgroundBitmap.width) - _arg_1.width) - 3);
                };
            }
            else
            {
                if (this.headerType == TYPE_FULL)
                {
                    _local_4.x = _local_4.width;
                    _local_4.scaleX = -1;
                    _arg_1.x = 16;
                }
                else
                {
                    _arg_1.x = (this.titleBackgroundBitmap.x + 3);
                };
            };
        }

        public function showCoins(_arg_1:int):CoinsField
        {
            var _local_2:Sprite;
            this._coinsField = new CoinsField(_arg_1);
            this._coinsField.y = 39;
            this._coinsField.x = 44;
            addChild(this._coinsField);
            for each (_local_2 in this.buttonsContainers)
            {
                addChild(_local_2);
            };
            return (this._coinsField);
        }

        public function showFame(_arg_1:int):FameField
        {
            this._fameField = new FameField(_arg_1);
            this._fameField.y = 63;
            this._fameField.x = 44;
            addChild(this._fameField);
            return (this._fameField);
        }

        public function dispose():void
        {
            var _local_1:SliceScalingButton;
            if (this.backgroundBitmap)
            {
                this.backgroundBitmap.dispose();
            };
            this.titleBackgroundBitmap.dispose();
            if (this._coinsField)
            {
                this._coinsField.dispose();
            };
            if (this._fameField)
            {
                this._fameField.dispose();
            };
            for each (_local_1 in this.buttons)
            {
                _local_1.dispose();
            };
            this.buttonsContainers = null;
            this.buttons = null;
        }

        public function get titleLabel():UILabel
        {
            return (this._titleLabel);
        }

        public function get coinsField():CoinsField
        {
            return (this._coinsField);
        }

        public function get fameField():FameField
        {
            return (this._fameField);
        }


    }
}//package io.decagames.rotmg.ui.popups.header

