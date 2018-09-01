//com.greensock.easing.BounceInOut

package com.greensock.easing
{
public final class BounceInOut extends Ease
{

	public static var ease:BounceInOut = new (BounceInOut)();


	override public function getRatio(_arg_1:Number):Number
	{
		var _local_2:Boolean;
		if (_arg_1 < 0.5)
		{
			_local_2 = true;
			_arg_1 = (1 - (_arg_1 * 2));
		}
		else
		{
			_arg_1 = ((_arg_1 * 2) - 1);
		}
		if (_arg_1 < (1 / 2.75))
		{
			_arg_1 = ((7.5625 * _arg_1) * _arg_1);
		}
		else
		{
			if (_arg_1 < (2 / 2.75))
			{
				_arg_1 = (((7.5625 * (_arg_1 = (_arg_1 - (1.5 / 2.75)))) * _arg_1) + 0.75);
			}
			else
			{
				if (_arg_1 < (2.5 / 2.75))
				{
					_arg_1 = (((7.5625 * (_arg_1 = (_arg_1 - (2.25 / 2.75)))) * _arg_1) + 0.9375);
				}
				else
				{
					_arg_1 = (((7.5625 * (_arg_1 = (_arg_1 - (2.625 / 2.75)))) * _arg_1) + 0.984375);
				}
			}
		}
		return ((_local_2) ? ((1 - _arg_1) * 0.5) : ((_arg_1 * 0.5) + 0.5));
	}


}
}//package com.greensock.easing

