//com.greensock.easing.SineIn

package com.greensock.easing
{
public final class SineIn extends Ease
{

	private static const _HALF_PI:Number = (Math.PI / 2);//1.5707963267949
	public static var ease:SineIn = new (SineIn)();


	override public function getRatio(_arg_1:Number):Number
	{
		return (-(Math.cos((_arg_1 * _HALF_PI))) + 1);
	}


}
}//package com.greensock.easing

