//com.greensock.plugins.TransformAroundCenterPlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;

import flash.geom.Point;
import flash.geom.Rectangle;

public class TransformAroundCenterPlugin extends TransformAroundPointPlugin
{

	public static const API:Number = 2;

	public function TransformAroundCenterPlugin()
	{
		_propName = "transformAroundCenter";
	}

	override public function _onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
	{
		var _local_4:Rectangle = _arg_1.getBounds(_arg_1);
		_arg_2.point = new Point((_local_4.x + (_local_4.width / 2)), (_local_4.y + (_local_4.height / 2)));
		_arg_2.pointIsLocal = true;
		return (super._onInitTween(_arg_1, _arg_2, _arg_3));
	}

}
}//package com.greensock.plugins

