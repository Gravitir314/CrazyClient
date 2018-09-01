//com.greensock.plugins.VolumePlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;

import flash.media.SoundTransform;

public class VolumePlugin extends TweenPlugin
{

	public static const API:Number = 2;

	protected var _target:Object;
	protected var _st:SoundTransform;

	public function VolumePlugin()
	{
		super("volume");
	}

	override public function setRatio(_arg_1:Number):void
	{
		super.setRatio(_arg_1);
		_target.soundTransform = _st;
	}

	override public function _onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
	{
		if ((((isNaN(_arg_2)) || (_arg_1.hasOwnProperty("volume"))) || (!(_arg_1.hasOwnProperty("soundTransform")))))
		{
			return (false);
		}
		_target = _arg_1;
		_st = _target.soundTransform;
		_addTween(_st, "volume", _st.volume, _arg_2, "volume");
		return (true);
	}


}
}//package com.greensock.plugins

