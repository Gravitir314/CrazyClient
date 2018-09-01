//com.greensock.plugins.GlowFilterPlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;

import flash.filters.GlowFilter;

public class GlowFilterPlugin extends FilterPlugin
{

	public static const API:Number = 2;
	private static var _propNames:Array = ["color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout"];

	public function GlowFilterPlugin()
	{
		super("glowFilter");
	}

	override public function _onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
	{
		return (_initFilter(_arg_1, _arg_2, _arg_3, GlowFilter, new GlowFilter(0xFFFFFF, 0, 0, 0, ((_arg_2.strength) || (1)), ((_arg_2.quality) || (2)), _arg_2.inner, _arg_2.knockout), _propNames));
	}


}
}//package com.greensock.plugins

