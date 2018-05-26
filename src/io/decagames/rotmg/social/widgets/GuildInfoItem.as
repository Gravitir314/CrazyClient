// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.social.widgets.GuildInfoItem

package io.decagames.rotmg.social.widgets{
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;

public class GuildInfoItem extends BaseInfoItem {

        private var _gName:String;
        private var _gFame:int;

        public function GuildInfoItem(_arg_1:String, _arg_2:int){
            super(332, 70);
            this._gName = _arg_1;
            this._gFame = _arg_2;
            this.init();
        }

        private function init():void{
            this.createGuildName();
            this.createGuildFame();
        }

        private function createGuildName():void{
            var _local_1:UILabel;
            _local_1 = new UILabel();
            _local_1.text = this._gName;
            DefaultLabelFormat.guildInfoLabel(_local_1, 24);
            _local_1.x = ((_width - _local_1.width) / 2);
            _local_1.y = 12;
            addChild(_local_1);
        }

        private function createGuildFame():void{
            var _local_1:Sprite;
            var _local_3:Bitmap;
            var _local_4:UILabel;
            _local_1 = new Sprite();
            addChild(_local_1);
            var _local_2:BitmapData = AssetLibrary.getImageFromSet("lofiObj3", 226);
            _local_2 = TextureRedrawer.redraw(_local_2, 40, true, 0);
            _local_3 = new Bitmap(_local_2);
            _local_3.y = -6;
            _local_1.addChild(_local_3);
            _local_4 = new UILabel();
            _local_4.text = this._gFame.toString();
            DefaultLabelFormat.guildInfoLabel(_local_4);
            _local_4.x = _local_3.width;
            _local_4.y = 5;
            _local_1.addChild(_local_4);
            _local_1.x = ((_width - _local_1.width) / 2);
            _local_1.y = 36;
        }


    }
}//package io.decagames.rotmg.social.widgets

