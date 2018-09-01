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
	private var _color:String;
	private var _label:UILabel;

	public function ShopBoxTag(_arg_1:String, _arg_2:String, _arg_3:Boolean=false)
	{
		this._color = _arg_1;
		this.background = TextureParser.instance.getSliceScalingBitmap("UI", _arg_1);
		this.background.scaleType = SliceScalingBitmap.SCALE_TYPE_9;
		addChild(this.background);
		this._label = new UILabel();
		this._label.autoSize = TextFieldAutoSize.LEFT;
		this._label.text = _arg_2;
		this._label.x = 4;
		if (_arg_3)
		{
			DefaultLabelFormat.popupTag(this._label);
		}
		else
		{
			DefaultLabelFormat.shopTag(this._label);
		}
		addChild(this._label);
		this.background.width = (this._label.textWidth + 8);
		this.background.height = (this._label.textHeight + 8);
	}

	public function updateLabel(_arg_1:String):void
	{
		this._label.text = _arg_1;
		this.background.width = (this._label.textWidth + 8);
		this.background.height = (this._label.textHeight + 8);
	}

	public function dispose():void
	{
		this.background.dispose();
	}

	public function get color():String
	{
		return (this._color);
	}


}
}//package io.decagames.rotmg.shop