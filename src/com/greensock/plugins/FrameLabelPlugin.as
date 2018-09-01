//com.greensock.plugins.FrameLabelPlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;

import flash.display.MovieClip;

public class FrameLabelPlugin extends FramePlugin
{

	public static const API:Number = 2;

	public function FrameLabelPlugin()
	{
		_propName = "frameLabel";
	}

	override public function _onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
	{
		if (((!(_arg_3.target)) is MovieClip))
		{
			return (false);
		}
		_target = (_arg_1 as MovieClip);
		this.frame = _target.currentFrame;
		var _local_4:Array = _target.currentLabels;
		var _local_5:String = _arg_2;
		var _local_6:int = _target.currentFrame;
		var _local_7:int = _local_4.length;
		while (--_local_7 > -1)
		{
			if (_local_4[_local_7].name == _local_5)
			{
				_local_6 = _local_4[_local_7].frame;
				break;
			}
		}
		if (this.frame != _local_6)
		{
			_addTween(this, "frame", this.frame, _local_6, "frame", true);
		}
		return (true);
	}


}
}//package com.greensock.plugins

