//com.greensock.easing.ExpoOut

package com.greensock.easing
{
public final class ExpoOut extends Ease
{

	public static var ease:ExpoOut = new (ExpoOut)();


	override public function getRatio(_arg_1:Number):Number
	{
		return (1 - Math.pow(2, (-10 * _arg_1)));
	}


}
}//package com.greensock.easing

