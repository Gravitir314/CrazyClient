//com.greensock.easing.BounceOut

package com.greensock.easing
{
public final class BounceOut extends Ease
{

	public static var ease:BounceOut = new (BounceOut)();


	override public function getRatio(_arg_1:Number):Number
	{
		if (_arg_1 < (1 / 2.75))
		{
			return ((7.5625 * _arg_1) * _arg_1);
		}
		if (_arg_1 < (2 / 2.75))
		{
			return (((7.5625 * (_arg_1 = (_arg_1 - (1.5 / 2.75)))) * _arg_1) + 0.75);
		}
		if (_arg_1 < (2.5 / 2.75))
		{
			return (((7.5625 * (_arg_1 = (_arg_1 - (2.25 / 2.75)))) * _arg_1) + 0.9375);
		}
		return (((7.5625 * (_arg_1 = (_arg_1 - (2.625 / 2.75)))) * _arg_1) + 0.984375);
	}


}
}//package com.greensock.easing

