//com.greensock.easing.ExpoInOut

package com.greensock.easing
{
public final class ExpoInOut extends Ease
{

	public static var ease:ExpoInOut = new (ExpoInOut)();


	override public function getRatio(_arg_1:Number):Number
	{
		return (((_arg_1 = (_arg_1 * 2)) < 1) ? (0.5 * Math.pow(2, (10 * (_arg_1 - 1)))) : (0.5 * (2 - Math.pow(2, (-10 * (_arg_1 - 1))))));
	}


}
}//package com.greensock.easing

