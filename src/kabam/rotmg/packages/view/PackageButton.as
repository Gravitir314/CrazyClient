//kabam.rotmg.packages.view.PackageButton

package kabam.rotmg.packages.view
{
import com.company.assembleegameclient.util.TimeUtil;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.ui.UIUtils;

import org.osflash.signals.Signal;

public class PackageButton extends BasePackageButton
{

	private const SHOW_DURATION:String = "showDuration";
	private const SHOW_QUANTITY:String = "showQuantity";

	public var clicked:Signal = new Signal();
	private var _state:String = "showDuration";
	private var _icon:DisplayObject;
	public var durationText:TextFieldDisplayConcrete = makeText();
	public var quantityText:TextFieldDisplayConcrete = makeText();
	public var quantityStringBuilder:StaticStringBuilder = new StaticStringBuilder("");
	public var durationStringBuilder:LineBuilder = new LineBuilder();


	private static function makeText():TextFieldDisplayConcrete
	{
		var _local_1:TextFieldDisplayConcrete;
		_local_1 = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF);
		_local_1.filters = [new DropShadowFilter(0, 0, 0)];
		return (_local_1);
	}


	public function init():void
	{
		addChild(UIUtils.makeStaticHUDBackground());
		addChild(this.durationText);
		addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
		this.setIcon(makeIcon());
	}

	private function setState(_arg_1:String):void
	{
		if (this._state == _arg_1)
		{
			return;
		}
		if (_arg_1 == this.SHOW_DURATION)
		{
			removeChild(this.quantityText);
			addChild(this.durationText);
		}
		else
		{
			if (_arg_1 == this.SHOW_QUANTITY)
			{
				removeChild(this.durationText);
				addChild(this.quantityText);
			}
			else
			{
				throw (new Error(("PackageButton.setState: Unexpected state " + _arg_1)));
			}
		}
		this._state = _arg_1;
	}

	public function setQuantity(_arg_1:int):void
	{
		this.quantityText.textChanged.addOnce(this.layout);
		this.quantityStringBuilder.setString(_arg_1.toString());
		this.quantityText.setStringBuilder(this.quantityStringBuilder);
	}

	public function setDuration(_arg_1:int):void
	{
		var _local_3:String;
		var _local_2:int = int(Math.ceil((_arg_1 / TimeUtil.DAY_IN_MS)));
		if (_local_2 > 1)
		{
			_local_3 = TextKey.PACKAGE_BUTTON_DAYS;
		}
		else
		{
			_local_3 = TextKey.PACKAGE_BUTTON_DAY;
		}
		this.durationText.textChanged.addOnce(this.layout);
		this.durationStringBuilder.setParams(_local_3, {"number": _local_2});
		this.durationText.setStringBuilder(this.durationStringBuilder);
	}

	private function layout():void
	{
		positionText(this._icon, this.durationText);
		positionText(this._icon, this.quantityText);
	}

	public function setIcon(_arg_1:DisplayObject):void
	{
		this._icon = _arg_1;
		addChild(_arg_1);
	}

	public function getIcon():DisplayObject
	{
		return (this._icon);
	}

	private function onMouseUp(_arg_1:Event):void
	{
		this.clicked.dispatch();
	}


}
}//package kabam.rotmg.packages.view

