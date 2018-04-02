// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.packages.view.BasePackageButton

package kabam.rotmg.packages.view
{
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Rectangle;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class BasePackageButton extends Sprite
    {

        public static const IMAGE_NAME:String = "redLootBag";
        public static const IMAGE_ID:int = 0;


        protected static function makeIcon():DisplayObject
        {
            var _local_1:DisplayObject;
            var _local_2:BitmapData = AssetLibrary.getImageFromSet(IMAGE_NAME, IMAGE_ID);
            _local_2 = TextureRedrawer.redraw(_local_2, 40, true, 0);
            _local_2 = BitmapUtil.cropToBitmapData(_local_2, 10, 10, (_local_2.width - 20), (_local_2.height - 20));
            _local_1 = new Bitmap(_local_2);
            _local_1.x = 3;
            _local_1.y = 3;
            return (_local_1);
        }


        protected function positionText(_arg_1:DisplayObject, _arg_2:TextFieldDisplayConcrete):void
        {
            var _local_3:Number;
            var _local_4:Rectangle = _arg_1.getBounds(this);
            _local_3 = (_local_4.top + (_local_4.height / 2));
            _arg_2.x = _local_4.right;
            _arg_2.y = (_local_3 - (_arg_2.height / 2));
        }


    }
}//package kabam.rotmg.packages.view

