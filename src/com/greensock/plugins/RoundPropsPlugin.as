//com.greensock.plugins.RoundPropsPlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;
import com.greensock.core.PropTween;

public class RoundPropsPlugin extends TweenPlugin
{

	public static const API:Number = 2;

	protected var _tween:TweenLite;

	public function RoundPropsPlugin()
	{
		super("roundProps", -1);
		_overwriteProps.length = 0;
	}

	public function _add(_arg_1:Object, _arg_2:String, _arg_3:Number, _arg_4:Number):void
	{
		_addTween(_arg_1, _arg_2, _arg_3, (_arg_3 + _arg_4), _arg_2, true);
		_overwriteProps[_overwriteProps.length] = _arg_2;
	}

	override public function _onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
	{
		_tween = _arg_3;
		return (true);
	}

	public function _onInitAllProps():Boolean
	{
		var _local_5:String;
		var _local_6:PropTween;
		var _local_7:PropTween;
		var _local_1:Array = ((_tween.vars.roundProps is Array) ? _tween.vars.roundProps : _tween.vars.roundProps.split(","));
		var _local_2:int = _local_1.length;
		var _local_3:Object = {};
		var _local_4:PropTween = _tween._propLookup.roundProps;
		while (--_local_2 > -1)
		{
			_local_3[_local_1[_local_2]] = 1;
		}
		_local_2 = _local_1.length;
		while (--_local_2 > -1)
		{
			_local_5 = _local_1[_local_2];
			_local_6 = _tween._firstPT;
			while (_local_6)
			{
				_local_7 = _local_6._next;
				if (_local_6.pg)
				{
					_local_6.t._roundProps(_local_3, true);
				}
				else
				{
					if (_local_6.n == _local_5)
					{
						_add(_local_6.t, _local_5, _local_6.s, _local_6.c);
						if (_local_7)
						{
							_local_7._prev = _local_6._prev;
						}
						if (_local_6._prev)
						{
							_local_6._prev._next = _local_7;
						}
						else
						{
							if (_tween._firstPT == _local_6)
							{
								_tween._firstPT = _local_7;
							}
						}
						_local_6._next = (_local_6._prev = null);
						_tween._propLookup[_local_5] = _local_4;
					}
				}
				_local_6 = _local_7;
			}
		}
		return (false);
	}


}
}//package com.greensock.plugins

