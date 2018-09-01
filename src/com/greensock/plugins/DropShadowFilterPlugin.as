//com.greensock.plugins.DropShadowFilterPlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;

import flash.filters.DropShadowFilter;

public class DropShadowFilterPlugin extends FilterPlugin
{

	public static const API:Number = 2;
	private static var _propNames:Array = ["distance", "angle", "color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout", "hideObject"];

	public function DropShadowFilterPlugin()
	{
		super("dropShadowFilter");
	}

	override public function _onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
	{
		return (_initFilter(_arg_1, _arg_2, _arg_3, DropShadowFilter, new DropShadowFilter(0, 45, 0, 0, 0, 0, 1, ((_arg_2.quality) || (2)), _arg_2.inner, _arg_2.knockout, _arg_2.hideObject), _propNames));
	}


}
}//package com.greensock.plugins

