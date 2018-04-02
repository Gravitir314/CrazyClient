// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.defaults.DefaultLabelFormat

package io.decagames.rotmg.ui.defaults
{
import flash.filters.BitmapFilterQuality;
import flash.filters.DropShadowFilter;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import flashx.textLayout.formats.TextAlign;

import io.decagames.rotmg.ui.labels.UILabel;

import kabam.rotmg.text.model.FontModel;

public class DefaultLabelFormat
    {


        public static function defaultButtonLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFFFFF;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 16;
            _local_2.align = TextFormatAlign.CENTER;
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function defaultPopupTitle(_arg_1:UILabel):void
        {
            var _local_2:TextFormat;
            _local_2 = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 32;
            _arg_1.filters = [new DropShadowFilter(0, 90, 212992, 0.6, 4, 4)];
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function defaultSmallPopupTitle(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            _arg_1.filters = [new DropShadowFilter(0, 90, 212992, 0.6, 4, 4)];
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function characterFameInfoLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            _arg_1.filters = [new DropShadowFilter(0, 90, 212992, 0.6, 4, 4)];
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function coinsFieldLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFFFFF;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 18;
            _local_2.align = TextAlign.RIGHT;
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function numberSpinnerLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 18;
            _local_2.align = TextFormatAlign.CENTER;
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function shopTag(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFFFFF;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 12;
            _local_2.bold = true;
            _arg_1.filters = [new DropShadowFilter(1, 90, 0, 0.6, 4, 4)];
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function shopBoxTitle(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function backLaterLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFFFFF;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            _local_2.bold = true;
            _local_2.align = TextFormatAlign.CENTER;
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function defaultModalTitle(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFFFFF;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 18;
            _arg_1.filters = [new DropShadowFilter(0, 90, 212992, 0.6, 4, 4)];
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function defaultTextModalText(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFFFFF;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            _local_2.align = TextFormatAlign.CENTER;
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function mysteryBoxContentTitle(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFFFFF;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function mysteryBoxContentInfo(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0x999999;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 12;
            _local_2.bold = true;
            _local_2.align = TextFormatAlign.CENTER;
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function mysteryBoxContentItemName(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFFFFF;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function mysteryBoxEndsIn(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFE9700;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 12;
            _arg_1.filters = [new DropShadowFilter(1, 90, 0, 1, 2, 2), new DropShadowFilter(0, 90, 0, 0.4, 4, 4, 1, BitmapFilterQuality.HIGH)];
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function priceButtonLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 18;
            _arg_1.filters = [new DropShadowFilter(0, 90, 212992, 0.6, 4, 4)];
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function originalPriceButtonLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 16;
            _arg_1.filters = [new DropShadowFilter(1, 90, 0, 1, 2, 2), new DropShadowFilter(0, 90, 0, 0.4, 4, 4, 1, BitmapFilterQuality.HIGH)];
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function defaultInactiveTab(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0x616161;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function defaultActiveTab(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            _arg_1.filters = [new DropShadowFilter(1, 90, 0, 0.5, 4, 4)];
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function mysteryBoxVaultInfo(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFE9700;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            _local_2.bold = true;
            _arg_1.filters = [new DropShadowFilter(1, 90, 0, 0.5, 4, 4)];
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function defaultBoldLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 18;
            _local_2.align = TextFormatAlign.LEFT;
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function currentFameLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 16760388;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 22;
            _local_2.align = TextFormatAlign.RIGHT;
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }


    }
}//package io.decagames.rotmg.ui.defaults

