//com.greensock.TimelineMax

package com.greensock
{
import com.greensock.core.Animation;
import com.greensock.easing.Ease;
import com.greensock.events.TweenEvent;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

public class TimelineMax extends TimelineLite implements IEventDispatcher
{

	public static const version:String = "12.1.5";
	protected static var _listenerLookup:Object = {
		"onCompleteListener": TweenEvent.COMPLETE,
		"onUpdateListener": TweenEvent.UPDATE,
		"onStartListener": TweenEvent.START,
		"onRepeatListener": TweenEvent.REPEAT,
		"onReverseCompleteListener": TweenEvent.REVERSE_COMPLETE
	};
	protected static var _easeNone:Ease = new Ease(null, null, 1, 0);

	protected var _dispatcher:EventDispatcher;
	protected var _yoyo:Boolean;
	protected var _hasUpdateListener:Boolean;
	protected var _cycle:int = 0;
	protected var _locked:Boolean;
	protected var _repeatDelay:Number;
	protected var _repeat:int;

	public function TimelineMax(_arg_1:Object = null)
	{
		super(_arg_1);
		_repeat = ((this.vars.repeat) || (0));
		_repeatDelay = ((this.vars.repeatDelay) || (0));
		_yoyo = (this.vars.yoyo == true);
		_dirty = true;
		if ((((((this.vars.onCompleteListener) || (this.vars.onUpdateListener)) || (this.vars.onStartListener)) || (this.vars.onRepeatListener)) || (this.vars.onReverseCompleteListener)))
		{
			_initDispatcher();
		}
	}

	protected static function _getGlobalPaused(_arg_1:Animation):Boolean
	{
		while (_arg_1)
		{
			if (_arg_1._paused)
			{
				return (true);
			}
			_arg_1 = _arg_1._timeline;
		}
		return (false);
	}


	public function dispatchEvent(_arg_1:Event):Boolean
	{
		return ((_dispatcher == null) ? false : _dispatcher.dispatchEvent(_arg_1));
	}

	public function currentLabel(_arg_1:String = null):*
	{
		if (!arguments.length)
		{
			return (getLabelBefore((_time + 1E-8)));
		}
		return (seek(_arg_1, true));
	}

	public function hasEventListener(_arg_1:String):Boolean
	{
		return ((_dispatcher == null) ? false : _dispatcher.hasEventListener(_arg_1));
	}

	public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean = false):void
	{
		if (_dispatcher != null)
		{
			_dispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
		}
	}

	public function addCallback(_arg_1:Function, _arg_2:*, _arg_3:Array = null):TimelineMax
	{
		return (add(TweenLite.delayedCall(0, _arg_1, _arg_3), _arg_2) as TimelineMax);
	}

	public function tweenFromTo(_arg_1:*, _arg_2:*, _arg_3:Object = null):TweenLite
	{
		_arg_3 = ((_arg_3) || ({}));
		_arg_1 = _parseTimeOrLabel(_arg_1);
		_arg_3.startAt = {
			"onComplete": seek, "onCompleteParams": [_arg_1]
		};
		_arg_3.immediateRender = (!(_arg_3.immediateRender === false));
		var _local_4:TweenLite = tweenTo(_arg_2, _arg_3);
		return (_local_4.public::duration(((Math.abs((_local_4.vars.time - _arg_1)) / _timeScale) || (0.001))) as TweenLite);
	}

	public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean = false, _arg_4:int = 0, _arg_5:Boolean = false):void
	{
		if (_dispatcher == null)
		{
			_dispatcher = new EventDispatcher(this);
		}
		if (_arg_1 == TweenEvent.UPDATE)
		{
			_hasUpdateListener = true;
		}
		_dispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
	}

	public function tweenTo(position:*, vars:Object = null):TweenLite
	{
		var p:String;
		var duration:Number;
		var t:TweenLite;
		vars = ((vars) || ({}));
		var copy:Object = {
			"ease": _easeNone, "overwrite": ((vars.delay) ? 2 : 1), "useFrames": usesFrames(), "immediateRender": false
		};
		for (p in vars)
		{
			copy[p] = vars[p];
		}
		copy.time = _parseTimeOrLabel(position);
		duration = ((Math.abs((Number(copy.time) - _time)) / _timeScale) || (0.001));
		t = new TweenLite(this, duration, copy);
		copy.onStart = function ():void
		{
			t.target.paused(true);
			if (((!(t.vars.time == t.target.time())) && (internal::duration === t.public::duration())))
			{
				t.public::duration((Math.abs((t.vars.time - t.target.time())) / t.target._timeScale));
			}
			if (internal::vars.onStart)
			{
				internal::vars.onStart.apply(null, internal::vars.onStartParams);
			}
		};
		return (t);
	}

	public function repeat(_arg_1:Number = 0):*
	{
		if (!arguments.length)
		{
			return (_repeat);
		}
		_repeat = _arg_1;
		return (_uncache(true));
	}

	public function getLabelBefore(_arg_1:Number = NaN):String
	{
		if (!_arg_1)
		{
			if (_arg_1 != 0)
			{
				_arg_1 = _time;
			}
		}
		var _local_2:Array = getLabelsArray();
		var _local_3:int = _local_2.length;
		while (--_local_3 > -1)
		{
			if (_local_2[_local_3].time < _arg_1)
			{
				return (_local_2[_local_3].name);
			}
		}
		return (null);
	}

	public function willTrigger(_arg_1:String):Boolean
	{
		return ((_dispatcher == null) ? false : _dispatcher.willTrigger(_arg_1));
	}

	override public function totalProgress(_arg_1:Number = NaN, _arg_2:Boolean = true):*
	{
		return ((arguments.length) ? totalTime((totalDuration() * _arg_1), _arg_2) : (_totalTime / totalDuration()));
	}

	public function getLabelsArray():Array
	{
		var _local_3:String;
		var _local_1:Array = [];
		var _local_2:int;
		for (_local_3 in _labels)
		{
			var _local_6:* = _local_2++;
			_local_1[_local_6] = {
				"time": _labels[_local_3], "name": _local_3
			};
		}
		_local_1.sortOn("time", Array.NUMERIC);
		return (_local_1);
	}

	override public function render(_arg_1:Number, _arg_2:Boolean = false, _arg_3:Boolean = false):void
	{
		var _local_12:Animation;
		var _local_13:Boolean;
		var _local_14:Animation;
		var _local_15:Number;
		var _local_16:String;
		var _local_17:Boolean;
		var _local_18:Number;
		var _local_19:Boolean;
		var _local_20:Boolean;
		var _local_21:Number;
		var _local_22:int;
		var _local_23:Number;
		var _local_24:Number;
		if (_gc)
		{
			_enabled(true, false);
		}
		var _local_4:Number = ((_dirty) ? totalDuration() : _totalDuration);
		var _local_5:Number = _time;
		var _local_6:Number = _totalTime;
		var _local_7:Number = _startTime;
		var _local_8:Number = _timeScale;
		var _local_9:Number = _rawPrevTime;
		var _local_10:Boolean = _paused;
		var _local_11:int = _cycle;
		if (_arg_1 >= _local_4)
		{
			if (!_locked)
			{
				_totalTime = _local_4;
				_cycle = _repeat;
			}
			if (!_reversed)
			{
				if (!_hasPausedChild())
				{
					_local_13 = true;
					_local_16 = "onComplete";
					if (_duration === 0)
					{
						if ((((_arg_1 === 0) || (_rawPrevTime < 0)) || (_rawPrevTime === _tinyNum)))
						{
							if (((!(_rawPrevTime === _arg_1)) && (!(_first == null))))
							{
								_local_17 = true;
								if (_rawPrevTime > _tinyNum)
								{
									_local_16 = "onReverseComplete";
								}
							}
						}
					}
				}
			}
			_rawPrevTime = (((((_duration) || (!(_arg_2))) || (!(_arg_1 === 0))) || (_rawPrevTime === _arg_1)) ? _arg_1 : _tinyNum);
			if (((_yoyo) && (!((_cycle & 0x01) == 0))))
			{
				_time = (_arg_1 = 0);
			}
			else
			{
				_time = _duration;
				_arg_1 = (_duration + 0.0001);
			}
		}
		else
		{
			if (_arg_1 < 1E-7)
			{
				if (!_locked)
				{
					_totalTime = (_cycle = 0);
				}
				_time = 0;
				if (((!(_local_5 === 0)) || ((((_duration === 0) && (!(_rawPrevTime === _tinyNum))) && ((_rawPrevTime > 0) || ((_arg_1 < 0) && (_rawPrevTime >= 0)))) && (!(_locked)))))
				{
					_local_16 = "onReverseComplete";
					_local_13 = _reversed;
				}
				if (_arg_1 < 0)
				{
					_active = false;
					if (((_rawPrevTime >= 0) && (_first)))
					{
						_local_17 = true;
					}
					_rawPrevTime = _arg_1;
				}
				else
				{
					_rawPrevTime = (((((_duration) || (!(_arg_2))) || (!(_arg_1 === 0))) || (_rawPrevTime === _arg_1)) ? _arg_1 : _tinyNum);
					_arg_1 = 0;
					if (!_initted)
					{
						_local_17 = true;
					}
				}
			}
			else
			{
				if (((_duration === 0) && (_rawPrevTime < 0)))
				{
					_local_17 = true;
				}
				_time = (_rawPrevTime = _arg_1);
				if (!_locked)
				{
					_totalTime = _arg_1;
					if (_repeat != 0)
					{
						_local_18 = (_duration + _repeatDelay);
						_cycle = ((_totalTime / _local_18) >> 0);
						if (_cycle !== 0)
						{
							if (_cycle === (_totalTime / _local_18))
							{
								_cycle--;
							}
						}
						_time = (_totalTime - (_cycle * _local_18));
						if (_yoyo)
						{
							if ((_cycle & 0x01) != 0)
							{
								_time = (_duration - _time);
							}
						}
						if (_time > _duration)
						{
							_time = _duration;
							_arg_1 = (_duration + 0.0001);
						}
						else
						{
							if (_time < 0)
							{
								_time = (_arg_1 = 0);
							}
							else
							{
								_arg_1 = _time;
							}
						}
					}
				}
			}
		}
		if (_cycle != _local_11)
		{
			if (!_locked)
			{
				_local_19 = ((_yoyo) && (!((_local_11 & 0x01) === 0)));
				_local_20 = (_local_19 == ((_yoyo) && (!((_cycle & 0x01) === 0))));
				_local_21 = _totalTime;
				_local_22 = _cycle;
				_local_23 = _rawPrevTime;
				_local_24 = _time;
				_totalTime = (_local_11 * _duration);
				if (_cycle < _local_11)
				{
					_local_19 = (!(_local_19));
				}
				else
				{
					_totalTime = (_totalTime + _duration);
				}
				_time = _local_5;
				_rawPrevTime = _local_9;
				_cycle = _local_11;
				_locked = true;
				_local_5 = ((_local_19) ? 0 : _duration);
				render(_local_5, _arg_2, false);
				if (!_arg_2)
				{
					if (!_gc)
					{
						if (public::vars.onRepeat)
						{
							public::vars.onRepeat.apply(null, public::vars.onRepeatParams);
						}
						if (_dispatcher)
						{
							_dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REPEAT));
						}
					}
				}
				if (_local_20)
				{
					_local_5 = ((_local_19) ? (_duration + 0.0001) : -0.0001);
					render(_local_5, true, false);
				}
				_locked = false;
				if (((_paused) && (!(_local_10))))
				{
					return;
				}
				_time = _local_24;
				_totalTime = _local_21;
				_cycle = _local_22;
				_rawPrevTime = _local_23;
			}
		}
		if (((((_time == _local_5) || (!(_first))) && (!(_arg_3))) && (!(_local_17))))
		{
			if (_local_6 !== _totalTime)
			{
				if (_onUpdate != null)
				{
					if (!_arg_2)
					{
						_onUpdate.apply(((public::vars.onUpdateScope) || (this)), public::vars.onUpdateParams);
					}
				}
			}
			return;
		}
		if (!_initted)
		{
			_initted = true;
		}
		if (!_active)
		{
			if ((((!(_paused)) && (!(_totalTime === _local_6))) && (_arg_1 > 0)))
			{
				_active = true;
			}
		}
		if (_local_6 == 0)
		{
			if (_totalTime != 0)
			{
				if (!_arg_2)
				{
					if (public::vars.onStart)
					{
						public::vars.onStart.apply(this, public::vars.onStartParams);
					}
					if (_dispatcher)
					{
						_dispatcher.dispatchEvent(new TweenEvent(TweenEvent.START));
					}
				}
			}
		}
		if (_time >= _local_5)
		{
			_local_12 = _first;
			while (_local_12)
			{
				_local_14 = _local_12._next;
				if (((_paused) && (!(_local_10)))) break;
				if (((_local_12._active) || (((_local_12._startTime <= _time) && (!(_local_12._paused))) && (!(_local_12._gc)))))
				{
					if (!_local_12._reversed)
					{
						_local_12.render(((_arg_1 - _local_12._startTime) * _local_12._timeScale), _arg_2, _arg_3);
					}
					else
					{
						_local_12.render((((_local_12._dirty) ? _local_12.totalDuration() : _local_12._totalDuration) - ((_arg_1 - _local_12._startTime) * _local_12._timeScale)), _arg_2, _arg_3);
					}
				}
				_local_12 = _local_14;
			}
		}
		else
		{
			_local_12 = _last;
			while (_local_12)
			{
				_local_14 = _local_12._prev;
				if (((_paused) && (!(_local_10)))) break;
				if (((_local_12._active) || (((_local_12._startTime <= _local_5) && (!(_local_12._paused))) && (!(_local_12._gc)))))
				{
					if (!_local_12._reversed)
					{
						_local_12.render(((_arg_1 - _local_12._startTime) * _local_12._timeScale), _arg_2, _arg_3);
					}
					else
					{
						_local_12.render((((_local_12._dirty) ? _local_12.totalDuration() : _local_12._totalDuration) - ((_arg_1 - _local_12._startTime) * _local_12._timeScale)), _arg_2, _arg_3);
					}
				}
				_local_12 = _local_14;
			}
		}
		if (_onUpdate != null)
		{
			if (!_arg_2)
			{
				_onUpdate.apply(null, public::vars.onUpdateParams);
			}
		}
		if (_hasUpdateListener)
		{
			if (!_arg_2)
			{
				_dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
			}
		}
		if (_local_16)
		{
			if (!_locked)
			{
				if (!_gc)
				{
					if (((_local_7 === _startTime) || (!(_local_8 === _timeScale))))
					{
						if (((_time === 0) || (_local_4 >= totalDuration())))
						{
							if (_local_13)
							{
								if (_timeline.autoRemoveChildren)
								{
									_enabled(false, false);
								}
								_active = false;
							}
							if (!_arg_2)
							{
								if (public::vars[_local_16])
								{
									public::vars[_local_16].apply(null, public::vars[(_local_16 + "Params")]);
								}
								if (_dispatcher)
								{
									_dispatcher.dispatchEvent(new TweenEvent(((_local_16 == "onComplete") ? TweenEvent.COMPLETE : TweenEvent.REVERSE_COMPLETE)));
								}
							}
						}
					}
				}
			}
		}
	}

	public function removeCallback(_arg_1:Function, _arg_2:* = null):TimelineMax
	{
		var _local_3:Array;
		var _local_4:int;
		var _local_5:Number;
		if (_arg_1 != null)
		{
			if (_arg_2 == null)
			{
				_kill(null, _arg_1);
			}
			else
			{
				_local_3 = getTweensOf(_arg_1, false);
				_local_4 = _local_3.length;
				_local_5 = _parseTimeOrLabel(_arg_2);
				while (--_local_4 > -1)
				{
					if (_local_3[_local_4]._startTime === _local_5)
					{
						_local_3[_local_4]._enabled(false, false);
					}
				}
			}
		}
		return (this);
	}

	public function yoyo(_arg_1:Boolean = false):*
	{
		if (!arguments.length)
		{
			return (_yoyo);
		}
		_yoyo = _arg_1;
		return (this);
	}

	override public function progress(_arg_1:Number = NaN, _arg_2:Boolean = false):*
	{
		return ((arguments.length) ? totalTime(((public::duration() * (((_yoyo) && (!((_cycle & 0x01) === 0))) ? (1 - _arg_1) : _arg_1)) + (_cycle * (_duration + _repeatDelay))), _arg_2) : (_time / public::duration()));
	}

	public function repeatDelay(_arg_1:Number = 0):*
	{
		if (!arguments.length)
		{
			return (_repeatDelay);
		}
		_repeatDelay = _arg_1;
		return (_uncache(true));
	}

	override public function time(_arg_1:Number = NaN, _arg_2:Boolean = false):*
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
		if (((_yoyo) && (!((_cycle & 0x01) === 0))))
		{
			_arg_1 = ((_duration - _arg_1) + (_cycle * (_duration + _repeatDelay)));
		}
		else
		{
			if (_repeat != 0)
			{
				_arg_1 = (_arg_1 + (_cycle * (_duration + _repeatDelay)));
			}
		}
		return (totalTime(_arg_1, _arg_2));
	}

	protected function _initDispatcher():Boolean
	{
		var _local_2:String;
		var _local_1:Boolean;
		for (_local_2 in _listenerLookup)
		{
			if ((_local_2 in public::vars))
			{
				if ((public::vars[_local_2] is Function))
				{
					if (_dispatcher == null)
					{
						_dispatcher = new EventDispatcher(this);
					}
					_dispatcher.addEventListener(_listenerLookup[_local_2], public::vars[_local_2], false, 0, true);
					_local_1 = true;
				}
			}
		}
		return (_local_1);
	}

	override public function invalidate():*
	{
		_yoyo = Boolean((this.vars.yoyo == true));
		_repeat = ((this.vars.repeat) || (0));
		_repeatDelay = ((this.vars.repeatDelay) || (0));
		_hasUpdateListener = false;
		_initDispatcher();
		_uncache(true);
		return (super.invalidate());
	}

	public function getActive(_arg_1:Boolean = true, _arg_2:Boolean = true, _arg_3:Boolean = false):Array
	{
		var _local_8:int;
		var _local_9:Animation;
		var _local_4:Array = [];
		var _local_5:Array = getChildren(_arg_1, _arg_2, _arg_3);
		var _local_6:int;
		var _local_7:int = _local_5.length;
		_local_8 = 0;
		while (_local_8 < _local_7)
		{
			_local_9 = _local_5[_local_8];
			if (!_local_9._paused)
			{
				if (_local_9._timeline._time >= _local_9._startTime)
				{
					if (_local_9._timeline._time < (_local_9._startTime + (_local_9._totalDuration / _local_9._timeScale)))
					{
						if (!_getGlobalPaused(_local_9._timeline))
						{
							var _local_10:* = _local_6++;
							_local_4[_local_10] = _local_9;
						}
					}
				}
			}
			_local_8++;
		}
		return (_local_4);
	}

	public function getLabelAfter(_arg_1:Number = NaN):String
	{
		var _local_4:int;
		if (!_arg_1)
		{
			if (_arg_1 != 0)
			{
				_arg_1 = _time;
			}
		}
		var _local_2:Array = getLabelsArray();
		var _local_3:int = _local_2.length;
		_local_4 = 0;
		while (_local_4 < _local_3)
		{
			if (_local_2[_local_4].time > _arg_1)
			{
				return (_local_2[_local_4].name);
			}
			_local_4++;
		}
		return (null);
	}

	override public function totalDuration(_arg_1:Number = NaN):*
	{
		if (!arguments.length)
		{
			if (_dirty)
			{
				super.totalDuration();
				_totalDuration = ((_repeat == -1) ? 999999999999 : ((_duration * (_repeat + 1)) + (_repeatDelay * _repeat)));
			}
			return (_totalDuration);
		}
		return ((_repeat == -1) ? this : public::duration(((_arg_1 - (_repeat * _repeatDelay)) / (_repeat + 1))));
	}


}
}//package com.greensock

