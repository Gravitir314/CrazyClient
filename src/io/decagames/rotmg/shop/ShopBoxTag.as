// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.ShopBoxTag

package io.decagames.rotmg.shop
{
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.text.TextFieldAutoSize;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;

    public class ShopBoxTag extends Sprite 
    {

        public static const BLUE_TAG:String = "shop_blue_tag";
        public static const ORANGE_TAG:String = "shop_orange_tag";
        public static const GREEN_TAG:String = "shop_green_tag";
        public static const PURPLE_TAG:String = "shop_purple_tag";
        public static const RED_TAG:String = "shop_red_tag";

        private var background:SliceScalingBitmap;

        public function ShopBoxTag(_arg_1:String, _arg_2:String)
        {
            this.background = TextureParser.instance.getSliceScalingBitmap("UI", _arg_1);
            addChild(this.background);
            var _local_3:UILabel = new UILabel();
            _local_3.autoSize = TextFieldAutoSize.LEFT;
            _local_3.text = _arg_2;
            _local_3.x = 4;
            DefaultLabelFormat.shopTag(_local_3);
            addChild(_local_3);
            this.background.width = (_local_3.textWidth + 8);
        }

        public function dispose():void
        {
            this.background.dispose();
        }


    }
}//package io.decagames.rotmg.shop

