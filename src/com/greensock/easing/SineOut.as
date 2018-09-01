//com.greensock.easing.SineOut

package com.greensock.easing
{
public final class SineOut extends Ease
{

	private static const _HALF_PI:Number = (Math.PI / 2);//1.5707963267949
	public static var ease:SineOut = new (SineOut)();


	override public function getRatio(_arg_1:Number):Number
	{
		return (Math.sin((_arg_1 * _HALF_PI)));
	}


}
}//package com.greensock.easing

