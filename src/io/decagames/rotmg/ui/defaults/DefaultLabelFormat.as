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
            applyTextFromat(_local_2, _arg_1);
        }

        public static function defaultPopupTitle(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 32;
            _arg_1.filters = [new DropShadowFilter(0, 90, 212992, 0.6, 4, 4)];
            applyTextFromat(_local_2, _arg_1);
        }

        public static function defaultSmallPopupTitle(_arg_1:UILabel, _arg_2:String="left"):void
        {
            var _local_3:TextFormat = createTextFormat(14, 0xEAEAEA, _arg_2, true);
            _arg_1.filters = [new DropShadowFilter(0, 90, 212992, 0.6, 4, 4)];
            applyTextFromat(_local_3, _arg_1);
        }

        public static function friendsItemLabel(_arg_1:UILabel, _arg_2:Number=0xFFFFFF):void
        {
            var _local_3:TextFormat = createTextFormat(14, _arg_2, TextFormatAlign.LEFT, true);
            _arg_1.filters = [new DropShadowFilter(0, 90, 212992, 0.6, 4, 4)];
            applyTextFromat(_local_3, _arg_1);
        }

        public static function guildInfoLabel(_arg_1:UILabel, _arg_2:int=14, _arg_3:Number=0xFFFFFF, _arg_4:String="left"):void
        {
            var _local_5:TextFormat;
            _local_5 = createTextFormat(_arg_2, _arg_3, _arg_4, true);
            _arg_1.filters = [new DropShadowFilter(0, 90, 212992, 0.6, 4, 4)];
            applyTextFromat(_local_5, _arg_1);
        }

        public static function characterViewNameLabel(_arg_1:UILabel, _arg_2:int=18):void
        {
            var _local_3:TextFormat = createTextFormat(_arg_2, 0xB3B3B3, TextFormatAlign.LEFT, true);
            _arg_1.filters = [new DropShadowFilter(0, 0, 0)];
            applyTextFromat(_local_3, _arg_1);
        }

        public static function characterFameNameLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFFFFF;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 18;
            _arg_1.filters = [new DropShadowFilter(0, 90, 212992, 0.6, 4, 4)];
            applyTextFromat(_local_2, _arg_1);
        }

        public static function characterFameInfoLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0x8C8C8C;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 12;
            _arg_1.filters = [new DropShadowFilter(0, 90, 212992, 0.6, 4, 4)];
            applyTextFromat(_local_2, _arg_1);
        }

        public static function characterToolTipLabel(_arg_1:UILabel, _arg_2:Number):void
        {
            var _local_3:TextFormat = new TextFormat();
            _local_3.color = _arg_2;
            _local_3.bold = true;
            _local_3.font = FontModel.DEFAULT_FONT_NAME;
            _local_3.size = 12;
            applyTextFromat(_local_3, _arg_1);
        }

        public static function coinsFieldLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFFFFF;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 18;
            _local_2.align = TextAlign.RIGHT;
            applyTextFromat(_local_2, _arg_1);
        }

        public static function numberSpinnerLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 18;
            _local_2.align = TextFormatAlign.CENTER;
            applyTextFromat(_local_2, _arg_1);
        }

        public static function shopTag(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(12, 0xFFFFFF, TextFormatAlign.LEFT, true);
            _arg_1.filters = [new DropShadowFilter(1, 90, 0, 0.6, 4, 4)];
            applyTextFromat(_local_2, _arg_1);
        }

        public static function popupTag(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(24, 0xFFFFFF, TextFormatAlign.LEFT, true);
            _arg_1.filters = [new DropShadowFilter(1, 90, 0, 0.6, 4, 4)];
            applyTextFromat(_local_2, _arg_1);
        }

        public static function shopBoxTitle(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            applyTextFromat(_local_2, _arg_1);
        }

        public static function backLaterLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFFFFF;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            _local_2.bold = true;
            _local_2.align = TextFormatAlign.CENTER;
            applyTextFromat(_local_2, _arg_1);
        }

        public static function defaultModalTitle(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFFFFF;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 18;
            _arg_1.filters = [new DropShadowFilter(0, 90, 212992, 0.6, 4, 4)];
            applyTextFromat(_local_2, _arg_1);
        }

        public static function defaultTextModalText(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFFFFF;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            _local_2.align = TextFormatAlign.CENTER;
            applyTextFromat(_local_2, _arg_1);
        }

        public static function mysteryBoxContentTitle(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFFFFF;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            applyTextFromat(_local_2, _arg_1);
        }

        public static function mysteryBoxContentInfo(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0x999999;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 12;
            _local_2.bold = true;
            _local_2.align = TextFormatAlign.CENTER;
            applyTextFromat(_local_2, _arg_1);
        }

        public static function mysteryBoxContentItemName(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFFFFF;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            applyTextFromat(_local_2, _arg_1);
        }

        public static function popupEndsIn(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(24, 0xFE9700, TextFormatAlign.LEFT, true);
            _arg_1.filters = [new DropShadowFilter(1, 90, 0, 1, 2, 2), new DropShadowFilter(0, 90, 0, 0.4, 4, 4, 1, BitmapFilterQuality.HIGH)];
            applyTextFromat(_local_2, _arg_1);
        }

        public static function mysteryBoxEndsIn(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(12, 0xFE9700, TextFormatAlign.LEFT, true);
            _arg_1.filters = [new DropShadowFilter(1, 90, 0, 1, 2, 2), new DropShadowFilter(0, 90, 0, 0.4, 0, 0, 3, BitmapFilterQuality.HIGH)];
            applyTextFromat(_local_2, _arg_1);
        }

        public static function priceButtonLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 18;
            _arg_1.filters = [new DropShadowFilter(0, 90, 212992, 0.6, 4, 4)];
            applyTextFromat(_local_2, _arg_1);
        }

        public static function originalPriceButtonLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 16;
            _arg_1.filters = [new DropShadowFilter(1, 90, 0, 1, 2, 2), new DropShadowFilter(0, 90, 0, 0.4, 4, 4, 1, BitmapFilterQuality.HIGH)];
            applyTextFromat(_local_2, _arg_1);
        }

        public static function defaultInactiveTab(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0x616161;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            applyTextFromat(_local_2, _arg_1);
        }

        public static function defaultActiveTab(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            _arg_1.filters = [new DropShadowFilter(1, 90, 0, 0.5, 4, 4)];
            applyTextFromat(_local_2, _arg_1);
        }

        public static function mysteryBoxVaultInfo(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFE9700;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            _local_2.bold = true;
            _arg_1.filters = [new DropShadowFilter(1, 90, 0, 0.5, 4, 4)];
            applyTextFromat(_local_2, _arg_1);
        }

        public static function defaultBoldLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 18;
            _local_2.align = TextFormatAlign.LEFT;
            applyTextFromat(_local_2, _arg_1);
        }

        public static function currentFameLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 16760388;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 22;
            _local_2.align = TextFormatAlign.LEFT;
            applyTextFromat(_local_2, _arg_1);
        }

        public static function deathFameLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xEAEAEA;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 18;
            _local_2.align = TextFormatAlign.LEFT;
            applyTextFromat(_local_2, _arg_1);
        }

        public static function deathFameCount(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xFFC800;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 18;
            _local_2.align = TextFormatAlign.RIGHT;
            applyTextFromat(_local_2, _arg_1);
        }

        public static function tierLevelLabel(_arg_1:UILabel, _arg_2:int=12, _arg_3:Number=0xFFFFFF, _arg_4:String="right"):void
        {
            var _local_5:TextFormat = new TextFormat();
            _local_5.color = _arg_3;
            _local_5.bold = true;
            _local_5.font = FontModel.DEFAULT_FONT_NAME;
            _local_5.size = _arg_2;
            _local_5.align = _arg_4;
            applyTextFromat(_local_5, _arg_1);
        }

        public static function questRefreshLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 0xA3A3A3;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 14;
            _local_2.align = TextFormatAlign.CENTER;
            applyTextFromat(_local_2, _arg_1);
        }

        public static function questCompletedLabel(_arg_1:UILabel, _arg_2:Boolean, _arg_3:Boolean):void
        {
            var _local_4:TextFormat = new TextFormat();
            _local_4.color = ((_arg_2) ? 3971635 : 13224136);
            _local_4.bold = true;
            _local_4.font = FontModel.DEFAULT_FONT_NAME;
            _local_4.size = 16;
            _local_4.align = TextFormatAlign.LEFT;
            applyTextFromat(_local_4, _arg_1);
        }

        public static function questNameLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = new TextFormat();
            _local_2.color = 15241232;
            _local_2.bold = true;
            _local_2.font = FontModel.DEFAULT_FONT_NAME;
            _local_2.size = 20;
            _local_2.align = TextFormatAlign.CENTER;
            applyTextFromat(_local_2, _arg_1);
        }

        public static function notificationLabel(_arg_1:UILabel, _arg_2:int, _arg_3:Number, _arg_4:String, _arg_5:Boolean):void
        {
            var _local_6:TextFormat = createTextFormat(_arg_2, _arg_3, _arg_4, _arg_5);
            _arg_1.filters = [new DropShadowFilter(0, 90, 212992, 0.6, 4, 4)];
            applyTextFromat(_local_6, _arg_1);
        }

        private static function applyTextFromat(_arg_1:TextFormat, _arg_2:UILabel):void
        {
            _arg_2.defaultTextFormat = _arg_1;
            _arg_2.setTextFormat(_arg_1);
        }

        public static function createTextFormat(_arg_1:int, _arg_2:uint, _arg_3:String, _arg_4:Boolean):TextFormat
        {
            var _local_5:TextFormat = new TextFormat();
            _local_5.color = _arg_2;
            _local_5.bold = _arg_4;
            _local_5.font = FontModel.DEFAULT_FONT_NAME;
            _local_5.size = _arg_1;
            _local_5.align = _arg_3;
            return (_local_5);
        }

        public static function questDescriptionLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(16, 13224136, TextFormatAlign.CENTER, false);
            applyTextFromat(_local_2, _arg_1);
        }

        public static function questRewardLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(16, 0xFFFFFF, TextFormatAlign.CENTER, true);
            applyTextFromat(_local_2, _arg_1);
        }

        public static function questChoiceLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(14, 13224136, TextFormatAlign.CENTER, false);
            applyTextFromat(_local_2, _arg_1);
        }

        public static function questButtonCompleteLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(18, 0xFFFFFF, TextFormatAlign.CENTER, true);
            applyTextFromat(_local_2, _arg_1);
        }

        public static function questNameListLabel(_arg_1:UILabel, _arg_2:uint):void
        {
            var _local_3:TextFormat = createTextFormat(14, _arg_2, TextFormatAlign.LEFT, true);
            applyTextFromat(_local_3, _arg_1);
        }

        public static function petNameLabel(_arg_1:UILabel, _arg_2:uint):void
        {
            var _local_3:TextFormat = createTextFormat(18, _arg_2, TextFormatAlign.CENTER, true);
            _arg_1.defaultTextFormat = _local_3;
            _arg_1.setTextFormat(_local_3);
        }

        public static function petNameLabelSmall(_arg_1:UILabel, _arg_2:uint):void
        {
            var _local_3:TextFormat = createTextFormat(14, _arg_2, TextFormatAlign.CENTER, true);
            _arg_1.defaultTextFormat = _local_3;
            _arg_1.setTextFormat(_local_3);
        }

        public static function petFamilyLabel(_arg_1:UILabel, _arg_2:uint):void
        {
            var _local_3:TextFormat = createTextFormat(14, _arg_2, TextFormatAlign.CENTER, true);
            _arg_1.filters = [new DropShadowFilter(1, 90, 0, 1, 2, 2), new DropShadowFilter(0, 90, 0, 0.4, 4, 4, 1, BitmapFilterQuality.HIGH)];
            _arg_1.defaultTextFormat = _local_3;
            _arg_1.setTextFormat(_local_3);
        }

        public static function petFeedPower(_arg_1:UILabel, _arg_2:uint):TextFormat
        {
            var _local_3:TextFormat = createTextFormat(12, _arg_2, TextFormatAlign.CENTER, false);
            _arg_1.defaultTextFormat = _local_3;
            _arg_1.setTextFormat(_local_3);
            return (_local_3);
        }

        public static function petInfoLabel(_arg_1:UILabel, _arg_2:uint):void
        {
            var _local_3:TextFormat = createTextFormat(12, _arg_2, TextFormatAlign.CENTER, false);
            _arg_1.defaultTextFormat = _local_3;
            _arg_1.setTextFormat(_local_3);
        }

        public static function petSkinActionButton(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(14, 0xFFFFFF, TextFormatAlign.CENTER, false);
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function petStatLabelLeft(_arg_1:UILabel, _arg_2:uint):void
        {
            var _local_3:TextFormat = createTextFormat(12, _arg_2, TextFormatAlign.LEFT, false);
            _arg_1.defaultTextFormat = _local_3;
            _arg_1.setTextFormat(_local_3);
        }

        public static function petStatLabelRight(_arg_1:UILabel, _arg_2:uint, _arg_3:Boolean=false):void
        {
            var _local_4:TextFormat = createTextFormat(12, _arg_2, TextFormatAlign.RIGHT, _arg_3);
            _arg_1.defaultTextFormat = _local_4;
            _arg_1.setTextFormat(_local_4);
        }

        public static function fusionStrengthLabel(_arg_1:UILabel, _arg_2:uint, _arg_3:int):void
        {
            var _local_4:TextFormat = createTextFormat(14, 0xFFFFFF, TextFormatAlign.CENTER, true);
            var _local_5:TextFormat = createTextFormat(14, _arg_2, TextFormatAlign.CENTER, true);
            applyTextFromat(_local_4, _arg_1);
            if (_arg_3 != 0)
            {
                _arg_1.setTextFormat(_local_5, 0, _arg_3);
            }
        }

        public static function feedPowerInfo(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(12, 0xFFFFFF, TextFormatAlign.CENTER, true);
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function feedPetInfo(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(14, 0xFFFFFF, TextFormatAlign.CENTER, true);
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function wardrobeCollectionLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(12, 0xFFFFFF, TextFormatAlign.CENTER, true);
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function petYardRarity(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(12, 0xA2A2A2, TextFormatAlign.CENTER, true);
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function petYardUpgradeInfo(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(12, 0x8C8C8C, TextFormatAlign.CENTER, true);
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function petYardUpgradeRarityInfo(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(14, 0xFFFFFF, TextFormatAlign.CENTER, true);
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function newAbilityInfo(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(12, 0x999999, TextFormatAlign.CENTER, true);
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function newAbilityName(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(18, 8971493, TextFormatAlign.CENTER, true);
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function newSkinHatched(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(14, 0x939393, TextFormatAlign.CENTER, true);
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }

        public static function infoTooltipText(_arg_1:UILabel, _arg_2:uint):void
        {
            var _local_3:TextFormat = createTextFormat(14, _arg_2, TextFormatAlign.LEFT, false);
            _arg_1.defaultTextFormat = _local_3;
            _arg_1.setTextFormat(_local_3);
        }

        public static function newSkinLabel(_arg_1:UILabel):void
        {
            var _local_2:TextFormat = createTextFormat(9, 0, TextFormatAlign.CENTER, true);
            _arg_1.defaultTextFormat = _local_2;
            _arg_1.setTextFormat(_local_2);
        }


    }
}//package io.decagames.rotmg.ui.defaults

