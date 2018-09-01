//com.greensock.plugins.ShortRotationPlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;

public class ShortRotationPlugin extends TweenPlugin
{

	public static const API:Number = 2;

	public function ShortRotationPlugin()
	{
		super("shortRotation");
		_overwriteProps.pop();
	}

	public function _initRotation(_arg_1:Object, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Boolean = false):void
	{
		var _local_6:Number = ((_arg_5) ? (Math.PI * 2) : 360);
		var _local_7:Number = ((_arg_4 - _arg_3) % _local_6);
		if (_local_7 != (_local_7 % (_local_6 / 2)))
		{
			_local_7 = ((_local_7 < 0) ? (_local_7 + _local_6) : (_local_7 - _local_6));
		}
		_addTween(_arg_1, _arg_2, _arg_3, (_arg_3 + _local_7), _arg_2);
		_overwriteProps[_overwriteProps.length] = _arg_2;
	}

	override public function _onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
	{
		var _local_5:Number;
		var _local_6:String;
		if (typeof(_arg_2) == "number")
		{
			return (false);
		}
		var _local_4:Boolean = Boolean((_arg_2.useRadians == true));
		for (_local_6 in _arg_2)
		{
			if (_local_6 != "useRadians")
			{
				_local_5 = ((_arg_1[_local_6] is Function) ? _arg_1[(((_local_6.indexOf("set")) || (!(("get" + _local_6.substr(3)) in _arg_1))) ? _local_6 : ("get" + _local_6.substr(3)))]() : _arg_1[_local_6]);
				_initRotation(_arg_1, _local_6, _local_5, ((typeof(_arg_2[_local_6]) == "number") ? Number(_arg_2[_local_6]) : (_local_5 + Number(_arg_2[_local_6].split("=").join("")))), _local_4);
			}
		}
		return (true);
	}


}
}//package com.greensock.plugins

