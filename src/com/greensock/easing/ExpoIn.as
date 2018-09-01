//com.greensock.easing.ExpoIn

package com.greensock.easing
{
public final class ExpoIn extends Ease
{

	public static var ease:ExpoIn = new (ExpoIn)();


	override public function getRatio(_arg_1:Number):Number
	{
		return (Math.pow(2, (10 * (_arg_1 - 1))) - 0.001);
	}


}
}//package com.greensock.easing

