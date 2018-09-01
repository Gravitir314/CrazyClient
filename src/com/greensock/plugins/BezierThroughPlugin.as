//com.greensock.plugins.BezierThroughPlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;

public class BezierThroughPlugin extends BezierPlugin
{

	public static const API:Number = 2;

	public function BezierThroughPlugin()
	{
		_propName = "bezierThrough";
	}

	override public function _onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
	{
		if ((_arg_2 is Array))
		{
			_arg_2 = {"values": _arg_2};
		}
		_arg_2.type = "thru";
		return (super._onInitTween(_arg_1, _arg_2, _arg_3));
	}


}
}//package com.greensock.plugins

