// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.texture.TextureParser

package io.decagames.rotmg.ui.texture
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import io.decagames.rotmg.ui.assets.UIAssets;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;

import kabam.lib.json.JsonParser;
import kabam.rotmg.core.StaticInjectorContext;

public class TextureParser
    {

        private static var _instance:TextureParser;

        private var textures:Dictionary;
        private var json:JsonParser;

        public function TextureParser()
        {
            this.textures = new Dictionary();
            this.json = StaticInjectorContext.getInjector().getInstance(JsonParser);
            this.registerTexture(new UIAssets.UI(), new UIAssets.UI_CONFIG(), new UIAssets.UI_SLICE_CONFIG(), "UI");
        }

        public static function get instance():TextureParser
        {
            if (_instance == null)
            {
                _instance = new (TextureParser)();
            }
            return (_instance);
        }


        public function registerTexture(_arg_1:Bitmap, _arg_2:String, _arg_3:String, _arg_4:String):void
        {
            this.textures[_arg_4] = {
                "texture":_arg_1,
                "configuration":this.json.parse(_arg_2),
                "sliceRectangles":this.json.parse(_arg_3)
            };
        }

        private function getConfiguration(_arg_1:String, _arg_2:String):Object
        {
            if (!this.textures[_arg_1])
            {
                throw (new Error(("Can't find set name " + _arg_1)));
            }
            if (!this.textures[_arg_1].configuration.frames[(_arg_2 + ".png")])
            {
                throw (new Error(("Can't find config for " + _arg_2)));
            }
            return (this.textures[_arg_1].configuration.frames[(_arg_2 + ".png")]);
        }

        private function getBitmapUsingConfig(_arg_1:String, _arg_2:Object):Bitmap
        {
            var _local_3:Bitmap = this.textures[_arg_1].texture;
            var _local_4:ByteArray = _local_3.bitmapData.getPixels(new Rectangle(_arg_2.frame.x, _arg_2.frame.y, _arg_2.frame.w, _arg_2.frame.h));
            _local_4.position = 0;
            var _local_5:BitmapData = new BitmapData(_arg_2.frame.w, _arg_2.frame.h);
            _local_5.setPixels(new Rectangle(0, 0, _arg_2.frame.w, _arg_2.frame.h), _local_4);
            return (new Bitmap(_local_5));
        }

        public function getTexture(_arg_1:String, _arg_2:String):Bitmap
        {
            var _local_3:Object = this.getConfiguration(_arg_1, _arg_2);
            return (this.getBitmapUsingConfig(_arg_1, _local_3));
        }

        public function getSliceScalingBitmap(_arg_1:String, _arg_2:String, _arg_3:int=0):SliceScalingBitmap
        {
            var _local_4:Bitmap = this.getTexture(_arg_1, _arg_2);
            var _local_5:Object = this.textures[_arg_1].sliceRectangles.slices[(_arg_2 + ".png")];
            var _local_6:Rectangle;
            var _local_7:String = SliceScalingBitmap.SCALE_TYPE_NONE;
            if (_local_5)
            {
                _local_6 = new Rectangle(_local_5.rectangle.x, _local_5.rectangle.y, _local_5.rectangle.w, _local_5.rectangle.h);
                _local_7 = _local_5.type;
            }
            var _local_8:SliceScalingBitmap = new SliceScalingBitmap(_local_4.bitmapData, _local_7, _local_6);
            _local_8.sourceBitmapName = _arg_2;
            if (_arg_3 != 0)
            {
                _local_8.width = _arg_3;
            }
            return (_local_8);
        }


    }
}//package io.decagames.rotmg.ui.texture

