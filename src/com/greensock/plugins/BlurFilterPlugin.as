//com.greensock.plugins.BlurFilterPlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;

import flash.filters.BlurFilter;

public class BlurFilterPlugin extends FilterPlugin
{

	public static const API:Number = 2;
	private static var _propNames:Array = ["blurX", "blurY", "quality"];

	public function BlurFilterPlugin()
	{
		super("blurFilter");
	}

	override public function _onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
	{
		return (_initFilter(_arg_1, _arg_2, _arg_3, BlurFilter, new BlurFilter(0, 0, ((_arg_2.quality) || (2))), _propNames));
	}


}
}//package com.greensock.plugins

