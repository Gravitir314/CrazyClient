// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.social.widgets.BaseInfoItem

package io.decagames.rotmg.social.widgets{
import flash.display.Sprite;

import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class BaseInfoItem extends Sprite {

        protected var _width:int;
        protected var _height:int;

        public function BaseInfoItem(_arg_1:int, _arg_2:int){
            this._width = _arg_1;
            this._height = _arg_2;
            this.intit();
        }

        private function intit():void{
            this.createBackground();
        }

        private function createBackground():void{
            var _local_1:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "listitem_content_background");
            _local_1.height = this._height;
            _local_1.width = this._width;
            addChild(_local_1);
        }


    }
}//package io.decagames.rotmg.social.widgets

