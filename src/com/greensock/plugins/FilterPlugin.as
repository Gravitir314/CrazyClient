//com.greensock.plugins.FilterPlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;

import flash.filters.BitmapFilter;
import flash.filters.BlurFilter;

public class FilterPlugin extends TweenPlugin
{

	public static const API:Number = 2;

	protected var _remove:Boolean;
	private var _tween:TweenLite;
	protected var _target:Object;
	protected var _index:int;
	protected var _filter:BitmapFilter;
	protected var _type:Class;

	public function FilterPlugin(_arg_1:String = "", _arg_2:Number = 0)
	{
		super(_arg_1, _arg_2);
	}

	protected function _initFilter(_arg_1:*, _arg_2:Object, _arg_3:TweenLite, _arg_4:Class, _arg_5:BitmapFilter, _arg_6:Array):Boolean
	{
		var _local_8:String;
		var _local_9:int;
		var _local_10:HexColorsPlugin;
		_target = _arg_1;
		_tween = _arg_3;
		_type = _arg_4;
		var _local_7:Array = _target.filters;
		var _local_11:Object = ((_arg_2 is BitmapFilter) ? {} : _arg_2);
		if (_local_11.index != null)
		{
			_index = _local_11.index;
		}
		else
		{
			_index = _local_7.length;
			if (_local_11.addFilter != true)
			{
				do
				{
				} while (((--_index > -1) && (!(_local_7[_index] is _type))));
			}
		}
		if (((_index < 0) || (!(_local_7[_index] is _type))))
		{
			if (_index < 0)
			{
				_index = _local_7.length;
			}
			if (_index > _local_7.length)
			{
				_local_9 = (_local_7.length - 1);
				while (++_local_9 < _index)
				{
					_local_7[_local_9] = new BlurFilter(0, 0, 1);
				}
			}
			_local_7[_index] = _arg_5;
			_target.filters = _local_7;
		}
		_filter = _local_7[_index];
		_remove = (_local_11.remove == true);
		_local_9 = _arg_6.length;
		while (--_local_9 > -1)
		{
			_local_8 = _arg_6[_local_9];
			if (((_local_8 in _arg_2) && (!(_filter[_local_8] == _arg_2[_local_8]))))
			{
				if ((((_local_8 == "color") || (_local_8 == "highlightColor")) || (_local_8 == "shadowColor")))
				{
					_local_10 = new HexColorsPlugin();
					_local_10._initColor(_filter, _local_8, _arg_2[_local_8]);
					_addTween(_local_10, "setRatio", 0, 1, _propName);
				}
				else
				{
					if (((((_local_8 == "quality") || (_local_8 == "inner")) || (_local_8 == "knockout")) || (_local_8 == "hideObject")))
					{
						_filter[_local_8] = _arg_2[_local_8];
					}
					else
					{
						_addTween(_filter, _local_8, _filter[_local_8], _arg_2[_local_8], _propName);
					}
				}
			}
		}
		return (true);
	}

	override public function setRatio(_arg_1:Number):void
	{
		super.setRatio(_arg_1);
		var _local_2:Array = _target.filters;
		if (!(_local_2[_index] is _type))
		{
			_index = _local_2.length;
			do
			{
			} while (((--_index > -1) && (!(_local_2[_index] is _type))));
			if (_index == -1)
			{
				_index = _local_2.length;
			}
		}
		if (((((_arg_1 == 1) && (_remove)) && (_tween._time == _tween._duration)) && (!(_tween.data == "isFromStart"))))
		{
			if (_index < _local_2.length)
			{
				_local_2.splice(_index, 1);
			}
		}
		else
		{
			_local_2[_index] = _filter;
		}
		_target.filters = _local_2;
	}


}
}//package com.greensock.plugins

