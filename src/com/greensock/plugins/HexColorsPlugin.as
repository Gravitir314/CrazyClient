//com.greensock.plugins.HexColorsPlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;

public class HexColorsPlugin extends TweenPlugin
{

	public static const API:Number = 2;

	protected var _colors:Array;

	public function HexColorsPlugin()
	{
		super("hexColors");
		_overwriteProps = [];
		_colors = [];
	}

	public function _initColor(_arg_1:Object, _arg_2:String, _arg_3:uint):void
	{
		var _local_6:uint;
		var _local_7:uint;
		var _local_8:uint;
		var _local_4:* = (typeof(_arg_1[_arg_2]) == "function");
		var _local_5:uint = ((_local_4) ? _arg_1[(((_arg_2.indexOf("set")) || (!(("get" + _arg_2.substr(3)) in _arg_1))) ? _arg_2 : ("get" + _arg_2.substr(3)))]() : _arg_1[_arg_2]);
		if (_local_5 != _arg_3)
		{
			_local_6 = (_local_5 >> 16);
			_local_7 = ((_local_5 >> 8) & 0xFF);
			_local_8 = (_local_5 & 0xFF);
			_colors[_colors.length] = new ColorProp(_arg_1, _arg_2, _local_4, _local_6, ((_arg_3 >> 16) - _local_6), _local_7, (((_arg_3 >> 8) & 0xFF) - _local_7), _local_8, ((_arg_3 & 0xFF) - _local_8));
			_overwriteProps[_overwriteProps.length] = _arg_2;
		}
	}

	override public function setRatio(_arg_1:Number):void
	{
		var _local_3:ColorProp;
		var _local_4:Number;
		var _local_2:int = _colors.length;
		while (--_local_2 > -1)
		{
			_local_3 = _colors[_local_2];
			_local_4 = ((((_local_3.rs + (_arg_1 * _local_3.rc)) << 16) | ((_local_3.gs + (_arg_1 * _local_3.gc)) << 8)) | (_local_3.bs + (_arg_1 * _local_3.bc)));
			if (_local_3.f)
			{
				var _local_5:* = _local_3.t;
				(_local_5[_local_3.p](_local_4));
			}
			else
			{
				_local_3.t[_local_3.p] = _local_4;
			}
		}
	}

	override public function _onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
	{
		var _local_4:String;
		for (_local_4 in _arg_2)
		{
			_initColor(_arg_1, _local_4, uint(_arg_2[_local_4]));
		}
		return (true);
	}

	override public function _kill(_arg_1:Object):Boolean
	{
		var _local_2:int = _colors.length;
		while (_local_2--)
		{
			if (_arg_1[_colors[_local_2].p] != null)
			{
				_colors.splice(_local_2, 1);
			}
		}
		return (super._kill(_arg_1));
	}


}
}//package com.greensock.plugins

class ColorProp
{

	public var rs:int;
	public var f:Boolean;
	public var gs:int;
	public var p:String;
	public var rc:int;
	public var t:Object;
	public var bc:int;
	public var gc:int;
	public var bs:int;

	public function ColorProp(_arg_1:Object, _arg_2:String, _arg_3:Boolean, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:int)
	{
		this.t = _arg_1;
		this.p = _arg_2;
		this.f = _arg_3;
		this.rs = _arg_4;
		this.rc = _arg_5;
		this.gs = _arg_6;
		this.gc = _arg_7;
		this.bs = _arg_8;
		this.bc = _arg_9;
	}

}


