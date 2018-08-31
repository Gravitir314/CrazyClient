//io.decagames.rotmg.shop.ShopBoxTag

package io.decagames.rotmg.shop
{
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class ShopBoxTag extends Sprite 
    {

        public static const BLUE_TAG:String = "shop_blue_tag";
        public static const ORANGE_TAG:String = "shop_orange_tag";
        public static const GREEN_TAG:String = "shop_green_tag";
        public static const PURPLE_TAG:String = "shop_purple_tag";
        public static const RED_TAG:String = "shop_red_tag";

        private var background:SliceScalingBitmap;

        public function ShopBoxTag(_arg_1:String, _arg_2:String, _arg_3:Boolean=false)
        {
            this.background = TextureParser.instance.getSliceScalingBitmap("UI", _arg_1);
            this.background.scaleType = SliceScalingBitmap.SCALE_TYPE_9;
            addChild(this.background);
            var _local_4:UILabel = new UILabel();
            _local_4.autoSize = TextFieldAutoSize.LEFT;
            _local_4.text = _arg_2;
            _local_4.x = 4;
            if (_arg_3)
            {
                DefaultLabelFormat.popupTag(_local_4);
            }
            else
            {
                DefaultLabelFormat.shopTag(_local_4);
            }
            addChild(_local_4);
            this.background.width = (_local_4.textWidth + 8);
            this.background.height = (_local_4.textHeight + 8);
        }

        public function dispose():void
        {
            this.background.dispose();
        }


    }
}//package io.decagames.rotmg.shop

