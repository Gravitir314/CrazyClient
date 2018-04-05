// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.tabs.TabContentBackground

package io.decagames.rotmg.ui.tabs
{
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class TabContentBackground extends SliceScalingBitmap 
    {

        private var decorBitmapData:BitmapData;
        private var decorSliceRectangle:Rectangle;

        public function TabContentBackground()
        {
            super(TextureParser.instance.getTexture("UI", "tab_cointainer_background").bitmapData, SliceScalingBitmap.SCALE_TYPE_9, new Rectangle(15, 15, 1, 1));
        }

        override public function dispose():void
        {
            this.decorBitmapData.dispose();
            super.dispose();
        }

        public function addDecor(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            this.render();
            if (_arg_3 == 0)
            {
                this.decorBitmapData = TextureParser.instance.getTexture("UI", "tab_open_decor_left").bitmapData;
                this.decorSliceRectangle = new Rectangle(21, 0, 1, 14);
                _arg_1 = (_arg_1 - 7);
                _arg_2 = (_arg_2 - 4);
            }
            else
            {
                if (_arg_3 == (_arg_4 - 1))
                {
                    this.decorBitmapData = TextureParser.instance.getTexture("UI", "tab_open_decor_right").bitmapData;
                    this.decorSliceRectangle = new Rectangle(18, 0, 1, 14);
                }
                else
                {
                    this.decorBitmapData = TextureParser.instance.getTexture("UI", "tab_open_decor_center").bitmapData;
                    this.decorSliceRectangle = new Rectangle(18, 0, 1, 14);
                }
            }
            this.bitmapData.copyPixels(this.decorBitmapData, new Rectangle(0, 0, this.decorSliceRectangle.x, this.decorBitmapData.height), new Point(_arg_1, 0));
            var _local_5:int = _arg_1;
            while (_local_5 < _arg_2)
            {
                this.bitmapData.copyPixels(this.decorBitmapData, new Rectangle(this.decorSliceRectangle.x, 0, this.decorSliceRectangle.width, this.decorBitmapData.height), new Point((this.decorSliceRectangle.x + _local_5), 0));
                _local_5++;
            }
            this.bitmapData.copyPixels(this.decorBitmapData, new Rectangle((this.decorSliceRectangle.x + this.decorSliceRectangle.width), 0, (this.decorBitmapData.width - (this.decorSliceRectangle.x + this.decorSliceRectangle.width)), this.decorBitmapData.height), new Point(_arg_2, 0));
        }


    }
}//package io.decagames.rotmg.ui.tabs

