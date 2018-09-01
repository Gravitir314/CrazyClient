//com.greensock.plugins.VisiblePlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;

public class VisiblePlugin extends TweenPlugin
{

	public static const API:Number = 2;

	protected var _progress:int;
	protected var _target:Object;
	protected var _initVal:Boolean;
	protected var _visible:Boolean;
	protected var _tween:TweenLite;

	public function VisiblePlugin()
	{
		super("visible");
	}

	override public function setRatio(_arg_1:Number):void
	{
		_target.visible = (((_arg_1 == 1) && (((_tween._time / _tween._duration) == _progress) || (_tween._duration == 0))) ? _visible : _initVal);
	}

	override public function _onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
	{
		_target = _arg_1;
		_tween = _arg_3;
		_progress = ((_tween.vars.runBackwards) ? 0 : 1);
		_initVal = _target.visible;
		_visible = Boolean(_arg_2);
		return (true);
	}


}
}//package com.greensock.plugins

