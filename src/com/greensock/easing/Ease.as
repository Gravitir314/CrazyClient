//com.greensock.easing.Ease

package com.greensock.easing
{
public class Ease
{

	protected static var _baseParams:Array = [0, 0, 1, 1];

	protected var _p1:Number;
	protected var _p2:Number;
	protected var _func:Function;
	protected var _params:Array;
	protected var _p3:Number;
	public var _power:int;
	public var _calcEnd:Boolean;
	public var _type:int;

	public function Ease(_arg_1:Function = null, _arg_2:Array = null, _arg_3:Number = 0, _arg_4:Number = 0)
	{
		_func = _arg_1;
		_params = ((_arg_2) ? _baseParams.concat(_arg_2) : _baseParams);
		_type = _arg_3;
		_power = _arg_4;
	}

	public function getRatio(_arg_1:Number):Number
	{
		var _local_2:Number;
		if (_func != null)
		{
			_params[0] = _arg_1;
			return (_func.apply(null, _params));
		}
		_local_2 = ((_type == 1) ? (1 - _arg_1) : ((_type == 2) ? _arg_1 : ((_arg_1 < 0.5) ? (_arg_1 * 2) : ((1 - _arg_1) * 2))));
		if (_power == 1)
		{
			_local_2 = (_local_2 * _local_2);
		}
		else
		{
			if (_power == 2)
			{
				_local_2 = (_local_2 * (_local_2 * _local_2));
			}
			else
			{
				if (_power == 3)
				{
					_local_2 = (_local_2 * ((_local_2 * _local_2) * _local_2));
				}
				else
				{
					if (_power == 4)
					{
						_local_2 = (_local_2 * (((_local_2 * _local_2) * _local_2) * _local_2));
					}
				}
			}
		}
		return ((_type == 1) ? (1 - _local_2) : ((_type == 2) ? _local_2 : ((_arg_1 < 0.5) ? (_local_2 / 2) : (1 - (_local_2 / 2)))));
	}


}
}//package com.greensock.easing

