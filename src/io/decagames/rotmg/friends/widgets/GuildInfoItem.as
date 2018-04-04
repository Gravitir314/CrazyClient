// Decompiled by AS3 Sorcerer 5.64
// www.as3sorcerer.com

//io.decagames.rotmg.friends.widgets.GuildInfoItem

package io.decagames.rotmg.friends.widgets{
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.ui.model.HUDModel;

public class GuildInfoItem extends Sprite {

        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var player:PlayerModel;
        private var guildName:UILabel;
        private var guildBoard:UILabel;
        private var guildFame:UILabel;
        private var guildFameIcon:Bitmap;
        private var listBackground:SliceScalingBitmap;

        public function GuildInfoItem(_arg_1:String, _arg_2:String, _arg_3:Number){
            this.listBackground = TextureParser.instance.getSliceScalingBitmap("UI", "listitem_content_background");
            addChild(this.listBackground);
            this.listBackground.height = 90;
            this.listBackground.width = 310;
            this.guildName = new UILabel();
            this.guildName.text = _arg_1;
            DefaultLabelFormat.defaultSmallPopupTitle(this.guildName);
            this.guildBoard = new UILabel();
            this.guildBoard.text = _arg_2;
            DefaultLabelFormat.defaultSmallPopupTitle(this.guildBoard);
            this.guildFame = new UILabel();
            this.guildFame.text = _arg_3.toString();
            DefaultLabelFormat.defaultSmallPopupTitle(this.guildFame);
            var _local_4:BitmapData = AssetLibrary.getImageFromSet("lofiObj3", 226);
            _local_4 = TextureRedrawer.redraw(_local_4, 40, true, 0);
            this.guildFameIcon = new Bitmap(_local_4);
            addChild(this.guildFameIcon);
            this.guildFameIcon.x = 270;
            this.guildFameIcon.y = 0;
            this.positionLabels();
        }

        private function positionLabels():void{
            addChild(this.guildName);
            this.guildName.x = 10;
            this.guildName.y = 12;
            this.guildBoard.multiline = true;
            this.guildBoard.wordWrap = true;
            this.guildBoard.width = 300;
            addChild(this.guildBoard);
            this.guildBoard.x = 10;
            this.guildBoard.y = 27;
            addChild(this.guildFame);
            this.guildFame.x = 235;
            this.guildFame.y = 12;
        }


    }
}//package io.decagames.rotmg.friends.widgets

