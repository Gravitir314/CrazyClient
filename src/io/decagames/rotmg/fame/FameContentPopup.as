// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.fame.FameContentPopup

package io.decagames.rotmg.fame
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.text.TextFormat;

import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.popups.header.PopupHeader;
import io.decagames.rotmg.ui.popups.modal.ModalPopup;
import io.decagames.rotmg.ui.scroll.UIScrollbar;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.assets.services.IconFactory;

public class FameContentPopup extends ModalPopup
    {

        private var characterDecorationBG:SliceScalingBitmap;
        private var contentInset:SliceScalingBitmap;
        private var popupIndent:int = 80;
        private var fameBitmap:Bitmap;
        private var fameOnDeathLabel:UILabel;
        private var statsLinesPosition:int = 0;
        private var statsContainer:Sprite;
        private var totalFame:UILabel;
        private var characterInfoLabel:UILabel;
        private var characterDateLabel:UILabel;
        public var infoButton:SliceScalingButton;
        public var characterId:int;

        public function FameContentPopup(_arg_1:int=-1)
        {
            var _local_3:UIScrollbar;
            var _local_4:Sprite;
            super(420, 400, "Fame Overview", DefaultLabelFormat.defaultSmallPopupTitle, new Rectangle(0, 0, 420, 457));
            this.characterId = _arg_1;
            this.infoButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "info_button"));
            _header.addButton(this.infoButton, PopupHeader.LEFT_BUTTON);
            this.characterInfoLabel = new UILabel();
            this.characterDateLabel = new UILabel();
            DefaultLabelFormat.characterFameInfoLabel(this.characterInfoLabel);
            DefaultLabelFormat.mysteryBoxContentInfo(this.characterDateLabel);
            this.characterInfoLabel.x = this.popupIndent;
            this.characterInfoLabel.y = 10;
            this.characterDateLabel.x = this.popupIndent;
            this.characterDateLabel.y = 25;
            addChild(this.characterInfoLabel);
            addChild(this.characterDateLabel);
            this.totalFame = new UILabel();
            DefaultLabelFormat.currentFameLabel(this.totalFame);
            this.totalFame.y = 14;
            addChild(this.totalFame);
            var _local_2:BitmapData = IconFactory.makeFame();
            this.fameBitmap = new Bitmap(_local_2);
            addChild(this.fameBitmap);
            this.characterDecorationBG = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_decoration", 69);
            addChild(this.characterDecorationBG);
            this.characterDecorationBG.height = 275;
            this.characterDecorationBG.x = 0;
            this.characterDecorationBG.y = 5;
            this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", 340);
            addChild(this.contentInset);
            this.contentInset.height = 330;
            this.contentInset.x = this.popupIndent;
            this.contentInset.y = 45;
            this.statsContainer = new Sprite();
            this.statsContainer.x = this.contentInset.x;
            this.statsContainer.y = (this.contentInset.y + 5);
            addChild(this.statsContainer);
            _local_3 = new UIScrollbar(320);
            _local_3.mouseRollSpeedFactor = 1;
            _local_3.scrollObject = this;
            _local_3.content = this.statsContainer;
            addChild(_local_3);
            _local_3.x = ((this.contentInset.x + this.contentInset.width) - 25);
            _local_3.y = (this.contentInset.y + 3);
            _local_4 = new Sprite();
            _local_4.graphics.beginFill(0);
            _local_4.graphics.drawRect(0, 0, 340, 320);
            _local_4.x = this.statsContainer.x;
            _local_4.y = this.statsContainer.y;
            this.statsContainer.mask = _local_4;
            addChild(_local_4);
            this.fameOnDeathLabel = new UILabel();
            DefaultLabelFormat.defaultBoldLabel(this.fameOnDeathLabel);
            this.fameOnDeathLabel.x = this.popupIndent;
            this.fameOnDeathLabel.y = 380;
            addChild(this.fameOnDeathLabel);
        }

        public function set fameOnDeath(_arg_1:int):void
        {
            this.fameOnDeathLabel.text = ("Total Fame on Death: " + _arg_1);
            var _local_2:TextFormat = this.fameOnDeathLabel.defaultTextFormat;
            _local_2.color = 0xFFC800;
            this.fameOnDeathLabel.setTextFormat(_local_2, (this.fameOnDeathLabel.text.length - _arg_1.toString().length), this.fameOnDeathLabel.text.length);
            this.fameBitmap.x = (this.fameOnDeathLabel.x + this.fameOnDeathLabel.textWidth);
            this.fameBitmap.y = this.fameOnDeathLabel.y;
        }

        public function setCharacterData(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:String, _arg_5:String, _arg_6:BitmapData):void
        {
            var _local_7:Bitmap;
            this.totalFame.text = _arg_1.toString();
            this.totalFame.x = (410 - this.totalFame.textWidth);
            this.characterInfoLabel.text = ((((_arg_2 + ", Level ") + _arg_3) + ", ") + _arg_4);
            this.characterDateLabel.text = ("Created on " + _arg_5);
            _local_7 = new Bitmap(_arg_6);
            _local_7.x = Math.round((this.characterDecorationBG.x + ((68 - _local_7.width) / 2)));
            _local_7.y = Math.round((this.characterDecorationBG.y + ((80 - _local_7.height) / 2)));
            addChild(_local_7);
        }

        public function addStatLine(_arg_1:FameStatsLine):void
        {
            _arg_1.x = 6;
            _arg_1.y = (this.statsLinesPosition * 22);
            this.statsContainer.addChild(_arg_1);
            if ((this.statsLinesPosition % 2) == 0)
            {
                _arg_1.drawBrightBackground();
            }
            this.statsLinesPosition++;
        }


    }
}//package io.decagames.rotmg.fame

