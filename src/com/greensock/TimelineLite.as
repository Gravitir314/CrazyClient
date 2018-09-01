//com.greensock.TimelineLite

package com.greensock
{
import com.greensock.core.Animation;
import com.greensock.core.SimpleTimeline;

public class TimelineLite extends SimpleTimeline
{

	public static const version:String = "12.1.6";

	protected var _forcingPlayhead:Boolean;
	protected var _labels:Object;

	public function TimelineLite(_arg_1:Object = null)
	{
		var _local_2:Object;
		var _local_3:String;
		super(_arg_1);
		_labels = {};
		autoRemoveChildren = (this.vars.autoRemoveChildren == true);
		smoothChildTiming = (this.vars.smoothChildTiming == true);
		_sortChildren = true;
		_onUpdate = this.vars.onUpdate;
		for (_local_3 in this.vars)
		{
			_local_2 = this.vars[_local_3];
			if ((_local_2 is Array))
			{
				if (_local_2.join("").indexOf("{self}") !== -1)
				{
					this.vars[_local_3] = _swapSelfInParams((_local_2 as Array));
				}
			}
		}
		if ((this.vars.tweens is Array))
		{
			this.add(this.vars.tweens, 0, ((this.vars.align) || ("normal")), ((this.vars.stagger) || (0)));
		}
	}

	protected static function _copy(_arg_1:Object):Object
	{
		var _local_3:String;
		var _local_2:Object = {};
		for (_local_3 in _arg_1)
		{
			_local_2[_local_3] = _arg_1[_local_3];
		}
		return (_local_2);
	}

	protected static function _prepVars(_arg_1:Object):Object
	{
		return ((_arg_1._isGSVars) ? _arg_1.vars : _arg_1);
	}

	public static function exportRoot(_arg_1:Object = null, _arg_2:Boolean = true):TimelineLite
	{
		var _local_6:Animation;
		_arg_1 = ((_arg_1) || ({}));
		if (!("smoothChildTiming" in _arg_1))
		{
			_arg_1.smoothChildTiming = true;
		}
		var _local_3:TimelineLite = new TimelineLite(_arg_1);
		var _local_4:SimpleTimeline = _local_3._timeline;
		_local_4._remove(_local_3, true);
		_local_3._startTime = 0;
		_local_3._rawPrevTime = (_local_3._time = (_local_3._totalTime = _local_4._time));
		var _local_5:Animation = _local_4._first;
		while (_local_5)
		{
			_local_6 = _local_5._next;
			if (((!(_arg_2)) || (!((_local_5 is TweenLite) && (TweenLite(_local_5).target == _local_5.vars.onComplete)))))
			{
				_local_3.add(_local_5, (_local_5._startTime - _local_5._delay));
			}
			_local_5 = _local_6;
		}
		_local_4.add(_local_3, 0);
		return (_local_3);
	}


	public function stop():*
	{
		return (paused(true));
	}

	public function remove(_arg_1:*):*
	{
		var _local_2:Number;
		if ((_arg_1 is Animation))
		{
			return (_remove(_arg_1, false));
		}
		if ((_arg_1 is Array))
		{
			_local_2 = _arg_1.length;
			while (--_local_2 > -1)
			{
				remove(_arg_1[_local_2]);
			}
			return (this);
		}
		if (typeof(_arg_1) == "string")
		{
			return (removeLabel(String(_arg_1)));
		}
		return (kill(null, _arg_1));
	}

	public function fromTo(_arg_1:Object, _arg_2:Number, _arg_3:Object, _arg_4:Object, _arg_5:* = "+=0"):*
	{
		return ((_arg_2) ? add(TweenLite.fromTo(_arg_1, _arg_2, _arg_3, _arg_4), _arg_5) : this.set(_arg_1, _arg_4, _arg_5));
	}

	public function staggerTo(_arg_1:Array, _arg_2:Number, _arg_3:Object, _arg_4:Number, _arg_5:* = "+=0", _arg_6:Function = null, _arg_7:Array = null):*
	{
		var _local_8:TimelineLite = new TimelineLite({
			"onComplete": _arg_6, "onCompleteParams": _arg_7, "smoothChildTiming": this.smoothChildTiming
		});
		var _local_9:int;
		while (_local_9 < _arg_1.length)
		{
			if (_arg_3.startAt != null)
			{
				_arg_3.startAt = _copy(_arg_3.startAt);
			}
			_local_8.to(_arg_1[_local_9], _arg_2, _copy(_arg_3), (_local_9 * _arg_4));
			_local_9++;
		}
		return (add(_local_8, _arg_5));
	}

	override public function _enabled(_arg_1:Boolean, _arg_2:Boolean = false):Boolean
	{
		var _local_3:Animation;
		if (_arg_1 == _gc)
		{
			_local_3 = _first;
			while (_local_3)
			{
				_local_3._enabled(_arg_1, true);
				_local_3 = _local_3._next;
			}
		}
		return (super._enabled(_arg_1, _arg_2));
	}

	public function appendMultiple(_arg_1:Array, _arg_2:* = 0, _arg_3:String = "normal", _arg_4:Number = 0):*
	{
		return (add(_arg_1, _parseTimeOrLabel(null, _arg_2, true, _arg_1), _arg_3, _arg_4));
	}

	public function _hasPausedChild():Boolean
	{
		var _local_1:Animation = _first;
		while (_local_1)
		{
			if (((_local_1._paused) || ((_local_1 is TimelineLite) && (TimelineLite(_local_1)._hasPausedChild()))))
			{
				return (true);
			}
			_local_1 = _local_1._next;
		}
		return (false);
	}

	public function clear(_arg_1:Boolean = true):*
	{
		var _local_2:Array;
		var _local_3:int;
		_local_2 = getChildren(false, true, true);
		_local_3 = _local_2.length;
		_time = (_totalTime = 0);
		while (--_local_3 > -1)
		{
			_local_2[_local_3]._enabled(false, false);
		}
		if (_arg_1)
		{
			_labels = {};
		}
		return (_uncache(true));
	}

	public function gotoAndPlay(_arg_1:*, _arg_2:Boolean = true):*
	{
		return (play(_arg_1, _arg_2));
	}

	public function removeLabel(_arg_1:String):*
	{
		delete _labels[_arg_1];
		return (this);
	}

	public function staggerFromTo(_arg_1:Array, _arg_2:Number, _arg_3:Object, _arg_4:Object, _arg_5:Number = 0, _arg_6:* = "+=0", _arg_7:Function = null, _arg_8:Array = null):*
	{
		_arg_4 = _prepVars(_arg_4);
		_arg_3 = _prepVars(_arg_3);
		_arg_4.startAt = _arg_3;
		_arg_4.immediateRender = ((!(_arg_4.immediateRender == false)) && (!(_arg_3.immediateRender == false)));
		return (staggerTo(_arg_1, _arg_2, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8));
	}

	public function addLabel(_arg_1:String, _arg_2:* = "+=0"):*
	{
		_labels[_arg_1] = _parseTimeOrLabel(_arg_2);
		return (this);
	}

	override public function duration(_arg_1:Number = NaN):*
	{
		if (!arguments.length)
		{
			if (_dirty)
			{
				totalDuration();
			}
			return (_duration);
		}
		if (duration() !== 0)
		{
			if (_arg_1 !== 0)
			{
				timeScale((_duration / _arg_1));
			}
		}
		return (this);
	}

	public function addPause(_arg_1:* = "+=0", _arg_2:Function = null, _arg_3:Array = null):*
	{
		return (call(_pauseCallback, ["{self}", _arg_2, _arg_3], _arg_1));
	}

	public function gotoAndStop(_arg_1:*, _arg_2:Boolean = true):*
	{
		return (pause(_arg_1, _arg_2));
	}

	public function usesFrames():Boolean
	{
		var _local_1:SimpleTimeline = _timeline;
		while (_local_1._timeline)
		{
			_local_1 = _local_1._timeline;
		}
		return (_local_1 == _rootFramesTimeline);
	}

	public function append(_arg_1:*, _arg_2:* = 0):*
	{
		return (add(_arg_1, _parseTimeOrLabel(null, _arg_2, true, _arg_1)));
	}

	protected function _pauseCallback(_arg_1:TweenLite, _arg_2:Function = null, _arg_3:Array = null):void
	{
		var _local_4:Number = _arg_1._timeline._totalTime;
		if (((!(_arg_2 == null)) || (!(_forcingPlayhead))))
		{
			_arg_1._timeline.pause(_arg_1._startTime);
			if ((_arg_2 is Function))
			{
				_arg_2.apply(null, _arg_3);
			}
			if (_forcingPlayhead)
			{
				_arg_1._timeline.seek(_local_4);
			}
		}
	}

	override public function add(_arg_1:*, _arg_2:* = "+=0", _arg_3:String = "normal", _arg_4:Number = 0):*
	{
		var _local_5:int;
		var _local_6:Number;
		var _local_7:Number;
		var _local_8:*;
		var _local_9:SimpleTimeline;
		var _local_10:Boolean;
		if (typeof(_arg_2) !== "number")
		{
			_arg_2 = _parseTimeOrLabel(_arg_2, 0, true, _arg_1);
		}
		if (!(_arg_1 is Animation))
		{
			if ((_arg_1 is Array))
			{
				_local_6 = Number(_arg_2);
				_local_7 = _arg_1.length;
				_local_5 = 0;
				while (_local_5 < _local_7)
				{
					_local_8 = _arg_1[_local_5];
					if ((_local_8 is Array))
					{
						_local_8 = new TimelineLite({"tweens": _local_8});
					}
					add(_local_8, _local_6);
					if (!((typeof(_local_8) === "string") || (typeof(_local_8) === "function")))
					{
						if (_arg_3 === "sequence")
						{
							_local_6 = (_local_8._startTime + (_local_8.totalDuration() / _local_8._timeScale));
						}
						else
						{
							if (_arg_3 === "start")
							{
								_local_8._startTime = (_local_8._startTime - _local_8.delay());
							}
						}
					}
					_local_6 = (_local_6 + _arg_4);
					_local_5++;
				}
				return (_uncache(true));
			}
			if (typeof(_arg_1) === "string")
			{
				return (addLabel(String(_arg_1), _arg_2));
			}
			if (typeof(_arg_1) === "function")
			{
				_arg_1 = TweenLite.delayedCall(0, _arg_1);
			}
			else
			{
				trace((("Cannot add " + _arg_1) + " into the TimelineLite/Max: it is not a tween, timeline, function, or string."));
				return (this);
			}
		}
		super.add(_arg_1, _arg_2);
		if (((_gc) || (_time === _duration)))
		{
			if (!_paused)
			{
				if (_duration < duration())
				{
					_local_9 = this;
					_local_10 = (_local_9.rawTime() > _arg_1._startTime);
					while (_local_9._timeline)
					{
						if (((_local_10) && (_local_9._timeline.smoothChildTiming)))
						{
							_local_9.totalTime(_local_9._totalTime, true);
						}
						else
						{
							if (_local_9._gc)
							{
								_local_9._enabled(true, false);
							}
						}
						_local_9 = _local_9._timeline;
					}
				}
			}
		}
		return (this);
	}

	public function set(_arg_1:Object, _arg_2:Object, _arg_3:* = "+=0"):*
	{
		_arg_3 = _parseTimeOrLabel(_arg_3, 0, true);
		_arg_2 = _prepVars(_arg_2);
		if (_arg_2.immediateRender == null)
		{
			_arg_2.immediateRender = ((_arg_3 === _time) && (!(_paused)));
		}
		return (add(new TweenLite(_arg_1, 0, _arg_2), _arg_3));
	}

	override public function _remove(_arg_1:Animation, _arg_2:Boolean = false):*
	{
		super._remove(_arg_1, _arg_2);
		if (_last == null)
		{
			_time = (_totalTime = (_duration = (_totalDuration = 0)));
		}
		else
		{
			if (_time > (_last._startTime + (_last._totalDuration / _last._timeScale)))
			{
				_time = duration();
				_totalTime = _totalDuration;
			}
		}
		return (this);
	}

	public function getTweensOf(_arg_1:Object, _arg_2:Boolean = true):Array
	{
		var _local_6:Array;
		var _local_7:int;
		var _local_3:Boolean = this._gc;
		var _local_4:Array = [];
		var _local_5:int;
		if (_local_3)
		{
			_enabled(true, true);
		}
		_local_6 = TweenLite.getTweensOf(_arg_1);
		_local_7 = _local_6.length;
		while (--_local_7 > -1)
		{
			if (((_local_6[_local_7].timeline === this) || ((_arg_2) && (_contains(_local_6[_local_7])))))
			{
				var _local_8:* = _local_5++;
				_local_4[_local_8] = _local_6[_local_7];
			}
		}
		if (_local_3)
		{
			_enabled(false, true);
		}
		return (_local_4);
	}

	public function call(_arg_1:Function, _arg_2:Array = null, _arg_3:* = "+=0"):*
	{
		return (add(TweenLite.delayedCall(0, _arg_1, _arg_2), _arg_3));
	}

	public function shiftChildren(_arg_1:Number, _arg_2:Boolean = false, _arg_3:Number = 0):*
	{
		var _local_5:String;
		var _local_4:Animation = _first;
		while (_local_4)
		{
			if (_local_4._startTime >= _arg_3)
			{
				_local_4._startTime = (_local_4._startTime + _arg_1);
			}
			_local_4 = _local_4._next;
		}
		if (_arg_2)
		{
			for (_local_5 in _labels)
			{
				if (_labels[_local_5] >= _arg_3)
				{
					_labels[_local_5] = (_labels[_local_5] + _arg_1);
				}
			}
		}
		_uncache(true);
		return (this);
	}

	public function insertMultiple(_arg_1:Array, _arg_2:* = 0, _arg_3:String = "normal", _arg_4:Number = 0):*
	{
		return (add(_arg_1, ((_arg_2) || (0)), _arg_3, _arg_4));
	}

	public function from(_arg_1:Object, _arg_2:Number, _arg_3:Object, _arg_4:* = "+=0"):*
	{
		return (add(TweenLite.from(_arg_1, _arg_2, _arg_3), _arg_4));
	}

	public function getLabelTime(_arg_1:String):Number
	{
		return ((_arg_1 in _labels) ? Number(_labels[_arg_1]) : -1);
	}

	override public function rawTime():Number
	{
		return ((_paused) ? _totalTime : ((_timeline.rawTime() - _startTime) * _timeScale));
	}

	override public function render(_arg_1:Number, _arg_2:Boolean = false, _arg_3:Boolean = false):void
	{
		var _local_9:Animation;
		var _local_10:Boolean;
		var _local_11:Animation;
		var _local_12:String;
		var _local_13:Boolean;
		if (_gc)
		{
			_enabled(true, false);
		}
		var _local_4:Number = ((_dirty) ? totalDuration() : _totalDuration);
		var _local_5:Number = _time;
		var _local_6:Number = _startTime;
		var _local_7:Number = _timeScale;
		var _local_8:Boolean = _paused;
		if (_arg_1 >= _local_4)
		{
			_totalTime = (_time = _local_4);
			if (!_reversed)
			{
				if (!_hasPausedChild())
				{
					_local_10 = true;
					_local_12 = "onComplete";
					if (_duration === 0)
					{
						if ((((_arg_1 === 0) || (_rawPrevTime < 0)) || (_rawPrevTime === _tinyNum)))
						{
							if (((!(_rawPrevTime === _arg_1)) && (!(_first == null))))
							{
								_local_13 = true;
								if (_rawPrevTime > _tinyNum)
								{
									_local_12 = "onReverseComplete";
								}
							}
						}
					}
				}
			}
			_rawPrevTime = (((((!(_duration === 0)) || (!(_arg_2))) || (!(_arg_1 === 0))) || (_rawPrevTime === _arg_1)) ? _arg_1 : _tinyNum);
			_arg_1 = (_local_4 + 0.0001);
		}
		else
		{
			if (_arg_1 < 1E-7)
			{
				_totalTime = (_time = 0);
				if (((!(_local_5 === 0)) || (((_duration === 0) && (!(_rawPrevTime === _tinyNum))) && ((_rawPrevTime > 0) || ((_arg_1 < 0) && (_rawPrevTime >= 0))))))
				{
					_local_12 = "onReverseComplete";
					_local_10 = _reversed;
				}
				if (_arg_1 < 0)
				{
					_active = false;
					if (((_rawPrevTime >= 0) && (!(_first == null))))
					{
						_local_13 = true;
					}
					_rawPrevTime = _arg_1;
				}
				else
				{
					_rawPrevTime = (((((_duration) || (!(_arg_2))) || (!(_arg_1 === 0))) || (_rawPrevTime === _arg_1)) ? _arg_1 : _tinyNum);
					_arg_1 = 0;
					if (!_initted)
					{
						_local_13 = true;
					}
				}
			}
			else
			{
				_totalTime = (_time = (_rawPrevTime = _arg_1));
			}
		}
		if (((((_time == _local_5) || (!(_first))) && (!(_arg_3))) && (!(_local_13))))
		{
			return;
		}
		if (!_initted)
		{
			_initted = true;
		}
		if (!_active)
		{
			if ((((!(_paused)) && (!(_time === _local_5))) && (_arg_1 > 0)))
			{
				_active = true;
			}
		}
		if (_local_5 == 0)
		{
			if (vars.onStart)
			{
				if (_time != 0)
				{
					if (!_arg_2)
					{
						vars.onStart.apply(null, vars.onStartParams);
					}
				}
			}
		}
		if (_time >= _local_5)
		{
			_local_9 = _first;
			while (_local_9)
			{
				_local_11 = _local_9._next;
				if (((_paused) && (!(_local_8)))) break;
				if (((_local_9._active) || (((_local_9._startTime <= _time) && (!(_local_9._paused))) && (!(_local_9._gc)))))
				{
					if (!_local_9._reversed)
					{
						_local_9.render(((_arg_1 - _local_9._startTime) * _local_9._timeScale), _arg_2, _arg_3);
					}
					else
					{
						_local_9.render((((_local_9._dirty) ? _local_9.totalDuration() : _local_9._totalDuration) - ((_arg_1 - _local_9._startTime) * _local_9._timeScale)), _arg_2, _arg_3);
					}
				}
				_local_9 = _local_11;
			}
		}
		else
		{
			_local_9 = _last;
			while (_local_9)
			{
				_local_11 = _local_9._prev;
				if (((_paused) && (!(_local_8)))) break;
				if (((_local_9._active) || (((_local_9._startTime <= _local_5) && (!(_local_9._paused))) && (!(_local_9._gc)))))
				{
					if (!_local_9._reversed)
					{
						_local_9.render(((_arg_1 - _local_9._startTime) * _local_9._timeScale), _arg_2, _arg_3);
					}
					else
					{
						_local_9.render((((_local_9._dirty) ? _local_9.totalDuration() : _local_9._totalDuration) - ((_arg_1 - _local_9._startTime) * _local_9._timeScale)), _arg_2, _arg_3);
					}
				}
				_local_9 = _local_11;
			}
		}
		if (_onUpdate != null)
		{
			if (!_arg_2)
			{
				_onUpdate.apply(null, vars.onUpdateParams);
			}
		}
		if (_local_12)
		{
			if (!_gc)
			{
				if (((_local_6 == _startTime) || (!(_local_7 == _timeScale))))
				{
					if (((_time == 0) || (_local_4 >= totalDuration())))
					{
						if (_local_10)
						{
							if (_timeline.autoRemoveChildren)
							{
								_enabled(false, false);
							}
							_active = false;
						}
						if (!_arg_2)
						{
							if (vars[_local_12])
							{
								vars[_local_12].apply(null, vars[(_local_12 + "Params")]);
							}
						}
					}
				}
			}
		}
	}

	protected function _parseTimeOrLabel(_arg_1:*, _arg_2:* = 0, _arg_3:Boolean = false, _arg_4:Object = null):Number
	{
		var _local_5:int;
		if (((_arg_4 is Animation) && (_arg_4.timeline === this)))
		{
			remove(_arg_4);
		}
		else
		{
			if ((_arg_4 is Array))
			{
				_local_5 = _arg_4.length;
				while (--_local_5 > -1)
				{
					if (((_arg_4[_local_5] is Animation) && (_arg_4[_local_5].timeline === this)))
					{
						remove(_arg_4[_local_5]);
					}
				}
			}
		}
		if (typeof(_arg_2) === "string")
		{
			return (_parseTimeOrLabel(_arg_2, ((((_arg_3) && (typeof(_arg_1) === "number")) && (!(_arg_2 in _labels))) ? (_arg_1 - duration()) : 0), _arg_3));
		}
		_arg_2 = ((_arg_2) || (0));
		if (((typeof(_arg_1) === "string") && ((isNaN(_arg_1)) || (_arg_1 in _labels))))
		{
			_local_5 = _arg_1.indexOf("=");
			if (_local_5 === -1)
			{
				if (!(_arg_1 in _labels))
				{
					return ((_arg_3) ? _labels[_arg_1] = (duration() + _arg_2) : _arg_2);
				}
				return (_labels[_arg_1] + _arg_2);
			}
			_arg_2 = (parseInt((_arg_1.charAt((_local_5 - 1)) + "1"), 10) * Number(_arg_1.substr((_local_5 + 1))));
			_arg_1 = ((_local_5 > 1) ? _parseTimeOrLabel(_arg_1.substr(0, (_local_5 - 1)), 0, _arg_3) : duration());
		}
		else
		{
			if (_arg_1 == null)
			{
				_arg_1 = duration();
			}
		}
		return (Number(_arg_1) + _arg_2);
	}

	override public function totalTime(_arg_1:Number = NaN, _arg_2:Boolean = false, _arg_3:Boolean = false):*
	{
		_forcingPlayhead = true;
		var _local_5:* = super.totalTime.apply(this, arguments);
		_forcingPlayhead = false;
		return (_local_5);
	}

	override public function invalidate():*
	{
		var _local_1:Animation = _first;
		while (_local_1)
		{
			_local_1.invalidate();
			_local_1 = _local_1._next;
		}
		return (this);
	}

	public function getChildren(_arg_1:Boolean = true, _arg_2:Boolean = true, _arg_3:Boolean = true, _arg_4:Number = -9999999999):Array
	{
		var _local_5:Array = [];
		var _local_6:Animation = _first;
		var _local_7:int;
		while (_local_6)
		{
			if (_local_6._startTime >= _arg_4)
			{
				if ((_local_6 is TweenLite))
				{
					if (_arg_2)
					{
						var _local_8:* = _local_7++;
						_local_5[_local_8] = _local_6;
					}
				}
				else
				{
					if (_arg_3)
					{
						_local_8 = _local_7++;
						_local_5[_local_8] = _local_6;
					}
					if (_arg_1)
					{
						_local_5 = _local_5.concat(TimelineLite(_local_6).getChildren(true, _arg_2, _arg_3));
						_local_7 = _local_5.length;
					}
				}
			}
			_local_6 = _local_6._next;
		}
		return (_local_5);
	}

	public function staggerFrom(_arg_1:Array, _arg_2:Number, _arg_3:Object, _arg_4:Number = 0, _arg_5:* = "+=0", _arg_6:Function = null, _arg_7:Array = null):*
	{
		_arg_3 = _prepVars(_arg_3);
		if (!("immediateRender" in _arg_3))
		{
			_arg_3.immediateRender = true;
		}
		_arg_3.runBackwards = true;
		return (staggerTo(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7));
	}

	override public function seek(_arg_1:*, _arg_2:Boolean = true):*
	{
		return (totalTime(((typeof(_arg_1) === "number") ? Number(_arg_1) : _parseTimeOrLabel(_arg_1)), _arg_2));
	}

	override public function insert(_arg_1:*, _arg_2:* = 0):*
	{
		return (add(_arg_1, ((_arg_2) || (0))));
	}

	public function to(_arg_1:Object, _arg_2:Number, _arg_3:Object, _arg_4:* = "+=0"):*
	{
		return ((_arg_2) ? add(new TweenLite(_arg_1, _arg_2, _arg_3), _arg_4) : this.set(_arg_1, _arg_3, _arg_4));
	}

	override public function _kill(_arg_1:Object = null, _arg_2:Object = null):Boolean
	{
		if (_arg_1 == null)
		{
			if (_arg_2 == null)
			{
				return (_enabled(false, false));
			}
		}
		var _local_3:Array = ((_arg_2 == null) ? getChildren(true, true, false) : getTweensOf(_arg_2));
		var _local_4:int = _local_3.length;
		var _local_5:Boolean;
		while (--_local_4 > -1)
		{
			if (_local_3[_local_4]._kill(_arg_1, _arg_2))
			{
				_local_5 = true;
			}
		}
		return (_local_5);
	}

	private function _contains(_arg_1:Animation):Boolean
	{
		var _local_2:SimpleTimeline = _arg_1.timeline;
		while (_local_2)
		{
			if (_local_2 == this)
			{
				return (true);
			}
			_local_2 = _local_2.timeline;
		}
		return (false);
	}

	override public function totalDuration(_arg_1:Number = NaN):*
	{
		var _local_3:Number;
		var _local_4:Animation;
		var _local_5:Number;
		var _local_6:Animation;
		var _local_7:Number;
		if (!arguments.length)
		{
			if (_dirty)
			{
				_local_3 = 0;
				_local_4 = _last;
				_local_5 = Infinity;
				while (_local_4)
				{
					_local_6 = _local_4._prev;
					if (_local_4._dirty)
					{
						_local_4.totalDuration();
					}
					if ((((_local_4._startTime > _local_5) && (_sortChildren)) && (!(_local_4._paused))))
					{
						add(_local_4, (_local_4._startTime - _local_4._delay));
					}
					else
					{
						_local_5 = _local_4._startTime;
					}
					if (((_local_4._startTime < 0) && (!(_local_4._paused))))
					{
						_local_3 = (_local_3 - _local_4._startTime);
						if (_timeline.smoothChildTiming)
						{
							_startTime = (_startTime + (_local_4._startTime / _timeScale));
						}
						shiftChildren(-(_local_4._startTime), false, -9999999999);
						_local_5 = 0;
					}
					_local_7 = (_local_4._startTime + (_local_4._totalDuration / _local_4._timeScale));
					if (_local_7 > _local_3)
					{
						_local_3 = _local_7;
					}
					_local_4 = _local_6;
				}
				_duration = (_totalDuration = _local_3);
				_dirty = false;
			}
			return (_totalDuration);
		}
		if (totalDuration() != 0)
		{
			if (_arg_1 != 0)
			{
				timeScale((_totalDuration / _arg_1));
			}
		}
		return (this);
	}


}
}//package com.greensock

