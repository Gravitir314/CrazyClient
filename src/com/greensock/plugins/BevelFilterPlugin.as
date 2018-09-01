﻿//com.greensock.plugins.BevelFilterPlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;

import flash.filters.BevelFilter;

public class BevelFilterPlugin extends FilterPlugin
{

	public static const API:Number = 2;
	private static var _propNames:Array = ["distance", "angle", "highlightColor", "highlightAlpha", "shadowColor", "shadowAlpha", "blurX", "blurY", "strength", "quality"];

	public function BevelFilterPlugin()
	{
		super("bevelFilter");
	}

	override public function _onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
	{
		return (_initFilter(_arg_1, _arg_2, _arg_3, BevelFilter, new BevelFilter(0, 0, 0xFFFFFF, 0.5, 0, 0.5, 2, 2, 0, ((_arg_2.quality) || (2))), _propNames));
	}


}
}//package com.greensock.plugins

