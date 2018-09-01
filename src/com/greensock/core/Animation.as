//com.greensock.core.Animation

package com.greensock.core
{
import flash.display.Shape;
import flash.events.Event;
import flash.utils.getTimer;

public class Animation
{

	public static const version:String = "12.1.1";
	public static var ticker:Shape = new Shape();
	public static var _rootTimeline:SimpleTimeline;
	public static var _rootFramesTimeline:SimpleTimeline;
	protected static var _rootFrame:Number = -1;
	protected static var _tickEvent:Event = new Event("tick");
	protected static var _tinyNum:Number = 1E-10;

	public var _delay:Number;
	public var _prev:Animation;
	public var _reversed:Boolean;
	public var _active:Boolean;
	public var _timeline:SimpleTimeline;
	public var _rawPrevTime:Number;
	public var data:*;
	public var vars:Object;
	public var _totalTime:Number;
	public var _time:Number;
	public var timeline:SimpleTimeline;
	public var _initted:Boolean;
	public var _paused:Boolean;
	public var _startTime:Number;
	public var _dirty:Boolean;
	public var _next:Animation;
	protected var _onUpdate:Function;
	public var _pauseTime:Number;
	public var _duration:Number;
	public var _totalDuration:Number;
	public var _gc:Boolean;
	public var _timeScale:Number;

	public function Animation(_arg_1:Number = 0, _arg_2:Object = null)
	{
		this.vars = ((_arg_2) || ({}));
		if (this.vars._isGSVars)
		{
			this.vars = this.vars.vars;
		}
		_duration = (_totalDuration = ((_arg_1) || (0)));
		_delay = ((Number(this.vars.delay)) || (0));
		_timeScale = 1;
		_totalTime = (_time = 0);
		data = this.vars.data;
		_rawPrevTime = -1;
		if (_rootTimeline == null)
		{
			if (_rootFrame == -1)
			{
				_rootFrame = 0;
				_rootFramesTimeline = new SimpleTimeline();
				_rootTimeline = new SimpleTimeline();
				_rootTimeline._startTime = (getTimer() / 1000);
				_rootFramesTimeline._startTime = 0;
				_rootTimeline._active = (_rootFramesTimeline._active = true);
				ticker.addEventListener("enterFrame", _updateRoot, false, 0, true);
			}
			else
			{
				return;
			}
		}
		var _local_3:SimpleTimeline = ((this.vars.useFrames) ? _rootFramesTimeline : _rootTimeline);
		_local_3.add(this, _local_3._time);
		_reversed = (this.vars.reversed == true);
		if (this.vars.paused)
		{
			paused(true);
		}
	}

	public static function _updateRoot(_arg_1:Event = null):void
	{
		_rootFrame++;
		_rootTimeline.render((((getTimer() / 1000) - _rootTimeline._startTime) * _rootTimeline._timeScale), false, false);
		_rootFramesTimeline.render(((_rootFrame - _rootFramesTimeline._startTime) * _rootFramesTimeline._timeScale), false, false);
		ticker.dispatchEvent(_tickEvent);
	}


	public function delay(_arg_1:Number = NaN):*
	{
		if (!arguments.length)
		{
			return (_delay);
		}
		if (_timeline.smoothChildTiming)
		{
			startTime(((_startTime + _arg_1) - _delay));
		}
		_delay = _arg_1;
		return (this);
	}

	public function totalDuration(_arg_1:Number = NaN):*
	{
		_dirty = false;
		return ((arguments.length) ? duration(_arg_1) : _totalDuration);
	}

	public function _enabled(_arg_1:Boolean, _arg_2:Boolean = false):Boolean
	{
		_gc = (!(_arg_1));
		_active = Boolean(((((_arg_1) && (!(_paused))) && (_totalTime > 0)) && (_totalTime < _totalDuration)));
		if (!_arg_2)
		{
			if (((_arg_1) && (timeline == null)))
			{
				_timeline.add(this, (_startTime - _delay));
			}
			else
			{
				if (((!(_arg_1)) && (!(timeline == null))))
				{
					_timeline._remove(this, true);
				}
			}
		}
		return (false);
	}

	public function timeScale(_arg_1:Number = NaN):*
	{
		var _local_3:Number;
		if (!arguments.length)
		{
			return (_timeScale);
		}
		_arg_1 = ((_arg_1) || (1E-6));
		if (((_timeline) && (_timeline.smoothChildTiming)))
		{
			_local_3 = (((_pauseTime) || (_pauseTime == 0)) ? _pauseTime : _timeline._totalTime);
			_startTime = (_local_3 - (((_local_3 - _startTime) * _timeScale) / _arg_1));
		}
		_timeScale = _arg_1;
		return (_uncache(false));
	}

	protected function _swapSelfInParams(_arg_1:Array):Array
	{
		var _local_2:int = _arg_1.length;
		var _local_3:Array = _arg_1.concat();
		while (--_local_2 > -1)
		{
			if (_arg_1[_local_2] === "{self}")
			{
				_local_3[_local_2] = this;
			}
		}
		return (_local_3);
	}

	public function totalProgress(_arg_1:Number = NaN, _arg_2:Boolean = false):*
	{
		return ((arguments.length) ? totalTime((duration() * _arg_1), _arg_2) : (_time / duration()));
	}

	public function duration(_arg_1:Number = NaN):*
	{
		if (!arguments.length)
		{
			_dirty = false;
			return (_duration);
		}
		_duration = (_totalDuration = _arg_1);
		_uncache(true);
		if (_timeline.smoothChildTiming)
		{
			if (_time > 0)
			{
				if (_time < _duration)
				{
					if (_arg_1 != 0)
					{
						totalTime((_totalTime * (_arg_1 / _duration)), true);
					}
				}
			}
		}
		return (this);
	}

	public function restart(_arg_1:Boolean = false, _arg_2:Boolean = true):*
	{
		reversed(false);
		paused(false);
		return (totalTime(((_arg_1) ? -(_delay) : 0), _arg_2, true));
	}

	public function render(_arg_1:Number, _arg_2:Boolean = false, _arg_3:Boolean = false):void
	{
	}

	public function resume(_arg_1:* = null, _arg_2:Boolean = true):*
	{
		if (_arg_1 != null)
		{
			seek(_arg_1, _arg_2);
		}
		return (paused(false));
	}

	public function paused(_arg_1:Boolean = false):*
	{
		var _local_3:Number;
		var _local_4:Number;
		if (!arguments.length)
		{
			return (_paused);
		}
		if (_arg_1 != _paused)
		{
			if (_timeline)
			{
				_local_3 = _timeline.rawTime();
				_local_4 = (_local_3 - _pauseTime);
				if (((!(_arg_1)) && (_timeline.smoothChildTiming)))
				{
					_startTime = (_startTime + _local_4);
					_uncache(false);
				}
				_pauseTime = ((_arg_1) ? _local_3 : NaN);
				_paused = _arg_1;
				_active = (((!(_arg_1)) && (_totalTime > 0)) && (_totalTime < _totalDuration));
				if (((((!(_arg_1)) && (!(_local_4 == 0))) && (_initted)) && (!(duration() === 0))))
				{
					render(((_timeline.smoothChildTiming) ? _totalTime : ((_local_3 - _startTime) / _timeScale)), true, true);
				}
			}
		}
		if (((_gc) && (!(_arg_1))))
		{
			_enabled(true, false);
		}
		return (this);
	}

	public function totalTime(_arg_1:Number = NaN, _arg_2:Boolean = false, _arg_3:Boolean = false):*
	{
		var _local_5:SimpleTimeline;
		if (!arguments.length)
		{
			return (_totalTime);
		}
		if (_timeline)
		{
			if (((_arg_1 < 0) && (!(_arg_3))))
			{
				_arg_1 = (_arg_1 + totalDuration());
			}
			if (_timeline.smoothChildTiming)
			{
				if (_dirty)
				{
					totalDuration();
				}
				if (((_arg_1 > _totalDuration) && (!(_arg_3))))
				{
					_arg_1 = _totalDuration;
				}
				_local_5 = _timeline;
				_startTime = (((_paused) ? _pauseTime : _local_5._time) - (((_reversed) ? (_totalDuration - _arg_1) : _arg_1) / _timeScale));
				if (!_timeline._dirty)
				{
					_uncache(false);
				}
				if (_local_5._timeline != null)
				{
					while (_local_5._timeline)
					{
						if (_local_5._timeline._time !== ((_local_5._startTime + _local_5._totalTime) / _local_5._timeScale))
						{
							_local_5.totalTime(_local_5._totalTime, true);
						}
						_local_5 = _local_5._timeline;
					}
				}
			}
			if (_gc)
			{
				_enabled(true, false);
			}
			if (((!(_totalTime == _arg_1)) || (_duration === 0)))
			{
				render(_arg_1, _arg_2, false);
			}
		}
		return (this);
	}

	public function play(_arg_1:* = null, _arg_2:Boolean = true):*
	{
		if (_arg_1 != null)
		{
			seek(_arg_1, _arg_2);
		}
		reversed(false);
		return (paused(false));
	}

	public function invalidate():*
	{
		return (this);
	}

	public function progress(_arg_1:Number = NaN, _arg_2:Boolean = false):*
	{
		return ((arguments.length) ? totalTime((duration() * _arg_1), _arg_2) : (_time / duration()));
	}

	public function _kill(_arg_1:Object = null, _arg_2:Object = null):Boolean
	{
		return (_enabled(false, false));
	}

	public function reversed(_arg_1:Boolean = false):*
	{
		if (!arguments.length)
		{
			return (_reversed);
		}
		if (_arg_1 != _reversed)
		{
			_reversed = _arg_1;
			totalTime((((_timeline) && (!(_timeline.smoothChildTiming))) ? (totalDuration() - _totalTime) : _totalTime), true);
		}
		return (this);
	}

	public function startTime(_arg_1:Number = NaN):*
	{
		if (!arguments.length)
		{
			return (_startTime);
		}
		if (_arg_1 != _startTime)
		{
			_startTime = _arg_1;
			if (timeline)
			{
				if (timeline._sortChildren)
				{
					timeline.add(this, (_arg_1 - _delay));
				}
			}
		}
		return (this);
	}

	protected function _uncache(_arg_1:Boolean):*
	{
		var _local_2:Animation = ((_arg_1) ? this : timeline);
		while (_local_2)
		{
			_local_2._dirty = true;
			_local_2 = _local_2.timeline;
		}
		return (this);
	}

	public function isActive():Boolean
	{
		var _local_2:Number;
		var _local_1:SimpleTimeline = _timeline;
		return ((_local_1 == null) || (((((!(_gc)) && (!(_paused))) && (_local_1.isActive())) && ((_local_2 = _local_1.rawTime()) >= _startTime)) && (_local_2 < (_startTime + (totalDuration() / _timeScale)))));
	}

	public function time(_arg_1:Number = NaN, _arg_2:Boolean = false):*
	{
		if (!arguments.length)
		{
			return (_time);
		}
		if (_dirty)
		{
			totalDuration();
		}
		if (_arg_1 > _duration)
		{
			_arg_1 = _duration;
		}
		return (totalTime(_arg_1, _arg_2));
	}

	public function kill(_arg_1:Object = null, _arg_2:Object = null):*
	{
		_kill(_arg_1, _arg_2);
		return (this);
	}

	public function reverse(_arg_1:* = null, _arg_2:Boolean = true):*
	{
		if (_arg_1 != null)
		{
			seek(((_arg_1) || (totalDuration())), _arg_2);
		}
		reversed(true);
		return (paused(false));
	}

	public function seek(_arg_1:*, _arg_2:Boolean = true):*
	{
		return (totalTime(Number(_arg_1), _arg_2));
	}

	public function pause(_arg_1:* = null, _arg_2:Boolean = true):*
	{
		if (_arg_1 != null)
		{
			seek(_arg_1, _arg_2);
		}
		return (paused(true));
	}

	public function eventCallback(_arg_1:String, _arg_2:Function = null, _arg_3:Array = null):*
	{
		if (_arg_1 == null)
		{
			return (null);
		}
		if (_arg_1.substr(0, 2) == "on")
		{
			if (arguments.length == 1)
			{
				return (vars[_arg_1]);
			}
			if (_arg_2 == null)
			{
				delete vars[_arg_1];
			}
			else
			{
				vars[_arg_1] = _arg_2;
				vars[(_arg_1 + "Params")] = (((_arg_3 is Array) && (!(_arg_3.join("").indexOf("{self}") === -1))) ? _swapSelfInParams(_arg_3) : _arg_3);
			}
			if (_arg_1 == "onUpdate")
			{
				_onUpdate = _arg_2;
			}
		}
		return (this);
	}


}
}//package com.greensock.core

