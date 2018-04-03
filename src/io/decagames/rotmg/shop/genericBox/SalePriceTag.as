// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.genericBox.SalePriceTag

package io.decagames.rotmg.shop.genericBox
{
import flash.display.Sprite;
import flash.display.Bitmap;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.shop.ShopBuyButton;
import kabam.rotmg.assets.services.IconFactory;
import flash.display.BitmapData;

public class SalePriceTag extends Sprite
{

    private var coinBitmap:Bitmap;

    public function SalePriceTag(_arg_1:int, _arg_2:int)
    {
        var _local_4:Sprite;
        super();
        var _local_3:UILabel = new UILabel();
        DefaultLabelFormat.originalPriceButtonLabel(_local_3);
        _local_3.text = _arg_1.toString();
        _local_4 = new Sprite();
        var _local_5:BitmapData = ((_arg_2 == ShopBuyButton.CURRENCY_GOLD) ? IconFactory.makeCoin(35) : IconFactory.makeFame(35));
        this.coinBitmap = new Bitmap(_local_5);
        this.coinBitmap.y = 0;
        addChild(this.coinBitmap);
        addChild(_local_3);
        this.coinBitmap.x = (_local_3.textWidth + 5);
        addChild(_local_4);
        _local_4.graphics.lineStyle(2, 0xFF002A, 0.6);
        _local_4.graphics.lineTo(this.width, 0);
        _local_4.y = ((_local_3.textHeight + 2) / 2);
    }

    public function dispose():void
    {
        this.coinBitmap.bitmapData.dispose();
    }


}
}//package io.decagames.rotmg.shop.genericBox

