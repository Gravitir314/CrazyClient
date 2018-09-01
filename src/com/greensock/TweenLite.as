//com.greensock.TweenLite

package com.greensock
{
import com.greensock.core.Animation;
import com.greensock.core.PropTween;
import com.greensock.core.SimpleTimeline;
import com.greensock.easing.Ease;

import flash.display.Shape;
import flash.events.Event;
import flash.utils.Dictionary;

public class TweenLite extends Animation
{

	public static const version:String = "12.1.5";
	public static var defaultEase:Ease = new Ease(null, null, 1, 1);
	public static var defaultOverwrite:String = "auto";
	public static var ticker:Shape = Animation.ticker;
	public static var _plugins:Object = {};
	public static var _onPluginEvent:Function;
	protected static var _tweenLookup:Dictionary = new Dictionary(false);
	protected static var _reservedProps:Object = {
		"ease": 1,
		"delay": 1,
		"overwrite": 1,
		"onComplete": 1,
		"onCompleteParams": 1,
		"onCompleteScope": 1,
		"useFrames": 1,
		"runBackwards": 1,
		"startAt": 1,
		"onUpdate": 1,
		"onUpdateParams": 1,
		"onUpdateScope": 1,
		"onStart": 1,
		"onStartParams": 1,
		"onStartScope": 1,
		"onReverseComplete": 1,
		"onReverseCompleteParams": 1,
		"onReverseCompleteScope": 1,
		"onRepeat": 1,
		"onRepeatParams": 1,
		"onRepeatScope": 1,
		"easeParams": 1,
		"yoyo": 1,
		"onCompleteListener": 1,
		"onUpdateListener": 1,
		"onStartListener": 1,
		"onReverseCompleteListener": 1,
		"onRepeatListener": 1,
		"orientToBezier": 1,
		"immediateRender": 1,
		"repeat": 1,
		"repeatDelay": 1,
		"data": 1,
		"paused": 1,
		"reversed": 1
	};
	protected static var _overwriteLookup:Object;

	protected var _targets:Array;
	public var ratio:Number;
	protected var _overwrite:int;
	public var _ease:Ease;
	protected var _siblings:Array;
	public var target:Object;
	protected var _overwrittenProps:Object;
	public var _propLookup:Object;
	protected var _easeType:int;
	protected var _notifyPluginsOfEnabled:Boolean;
	public var _firstPT:PropTween;
	protected var _startAt:TweenLite;
	protected var _easePower:int;

	public function TweenLite(_arg_1:Object, _arg_2:Number, _arg_3:Object)
	{
		var _local_4:int;
		super(_arg_2, _arg_3);
		if (_arg_1 == null)
		{
			throw (new Error(((("Cannot tween a null object. Duration: " + _arg_2) + ", data: ") + this.data)));
		}
		if (!_overwriteLookup)
		{
			_overwriteLookup = {
				"none": 0,
				"all": 1,
				"auto": 2,
				"concurrent": 3,
				"allOnStart": 4,
				"preexisting": 5,
				"true": 1,
				"false": 0
			};
			ticker.addEventListener("enterFrame", _dumpGarbage, false, -1, true);
		}
		ratio = 0;
		this.target = _arg_1;
		_ease = defaultEase;
		_overwrite = (("overwrite" in this.vars) ? ((typeof(this.vars.overwrite) === "number") ? (this.vars.overwrite >> 0) : _overwriteLookup[this.vars.overwrite]) : _overwriteLookup[defaultOverwrite]);
		if (((this.target is Array) && (typeof(this.target[0]) === "object")))
		{
			_targets = this.target.concat();
			_propLookup = [];
			_siblings = [];
			_local_4 = _targets.length;
			while (--_local_4 > -1)
			{
				_siblings[_local_4] = _register(_targets[_local_4], this, false);
				if (_overwrite == 1)
				{
					if (_siblings[_local_4].length > 1)
					{
						_applyOverwrite(_targets[_local_4], this, null, 1, _siblings[_local_4]);
					}
				}
			}
		}
		else
		{
			_propLookup = {};
			_siblings = _tweenLookup[_arg_1];
			if (_siblings == null)
			{
				_siblings = (_tweenLookup[_arg_1] = [this]);
			}
			else
			{
				_siblings[_siblings.length] = this;
				if (_overwrite == 1)
				{
					_applyOverwrite(_arg_1, this, null, 1, _siblings);
				}
			}
		}
		if (((this.vars.immediateRender) || (((_arg_2 == 0) && (_delay == 0)) && (!(this.vars.immediateRender == false)))))
		{
			render(-(_delay), false, true);
		}
	}

	public static function fromTo(_arg_1:Object, _arg_2:Number, _arg_3:Object, _arg_4:Object):TweenLite
	{
		_arg_4 = _prepVars(_arg_4, true);
		_arg_3 = _prepVars(_arg_3);
		_arg_4.startAt = _arg_3;
		_arg_4.immediateRender = ((!(_arg_4.immediateRender == false)) && (!(_arg_3.immediateRender == false)));
		return (new TweenLite(_arg_1, _arg_2, _arg_4));
	}

	public static function getTweensOf(_arg_1:*, _arg_2:Boolean = false):Array
	{
		var _local_3:int;
		var _local_4:Array;
		var _local_5:int;
		var _local_6:TweenLite;
		if ((((_arg_1 is Array) && (!(typeof(_arg_1[0]) == "string"))) && (!(typeof(_arg_1[0]) == "number"))))
		{
			_local_3 = _arg_1.length;
			_local_4 = [];
			while (--_local_3 > -1)
			{
				_local_4 = _local_4.concat(getTweensOf(_arg_1[_local_3], _arg_2));
			}
			_local_3 = _local_4.length;
			while (--_local_3 > -1)
			{
				_local_6 = _local_4[_local_3];
				_local_5 = _local_3;
				while (--_local_5 > -1)
				{
					if (_local_6 === _local_4[_local_5])
					{
						_local_4.splice(_local_3, 1);
					}
				}
			}
		}
		else
		{
			_local_4 = _register(_arg_1).concat();
			_local_3 = _local_4.length;
			while (--_local_3 > -1)
			{
				if (((_local_4[_local_3]._gc) || ((_arg_2) && (!(_local_4[_local_3].isActive())))))
				{
					_local_4.splice(_local_3, 1);
				}
			}
		}
		return (_local_4);
	}

	protected static function _register(_arg_1:Object, _arg_2:TweenLite = null, _arg_3:Boolean = false):Array
	{
		var _local_5:int;
		var _local_4:Array = _tweenLookup[_arg_1];
		if (_local_4 == null)
		{
			_local_4 = (_tweenLookup[_arg_1] = []);
		}
		if (_arg_2)
		{
			_local_5 = _local_4.length;
			_local_4[_local_5] = _arg_2;
			if (_arg_3)
			{
				while (--_local_5 > -1)
				{
					if (_local_4[_local_5] === _arg_2)
					{
						_local_4.splice(_local_5, 1);
					}
				}
			}
		}
		return (_local_4);
	}

	protected static function _applyOverwrite(_arg_1:Object, _arg_2:TweenLite, _arg_3:Object, _arg_4:int, _arg_5:Array):Boolean
	{
		var _local_6:int;
		var _local_7:Boolean;
		var _local_8:TweenLite;
		var _local_13:Number;
		var _local_14:int;
		if (((_arg_4 == 1) || (_arg_4 >= 4)))
		{
			_local_14 = _arg_5.length;
			_local_6 = 0;
			while (_local_6 < _local_14)
			{
				_local_8 = _arg_5[_local_6];
				if (_local_8 != _arg_2)
				{
					if (!_local_8._gc)
					{
						if (_local_8._enabled(false, false))
						{
							_local_7 = true;
						}
					}
				}
				else
				{
					if (_arg_4 == 5) break;
				}
				_local_6++;
			}
			return (_local_7);
		}
		var _local_9:Number = (_arg_2._startTime + 1E-10);
		var _local_10:Array = [];
		var _local_11:int;
		var _local_12:* = (_arg_2._duration == 0);
		_local_6 = _arg_5.length;
		while (--_local_6 > -1)
		{
			_local_8 = _arg_5[_local_6];
			if (!(((_local_8 === _arg_2) || (_local_8._gc)) || (_local_8._paused)))
			{
				if (_local_8._timeline != _arg_2._timeline)
				{
					_local_13 = ((_local_13) || (_checkOverlap(_arg_2, 0, _local_12)));
					if (_checkOverlap(_local_8, _local_13, _local_12) === 0)
					{
						var _local_15:* = _local_11++;
						_local_10[_local_15] = _local_8;
					}
				}
				else
				{
					if (_local_8._startTime <= _local_9)
					{
						if ((_local_8._startTime + (_local_8.totalDuration() / _local_8._timeScale)) > _local_9)
						{
							if (!(((_local_12) || (!(_local_8._initted))) && ((_local_9 - _local_8._startTime) <= 2E-10)))
							{
								_local_15 = _local_11++;
								_local_10[_local_15] = _local_8;
							}
						}
					}
				}
			}
		}
		_local_6 = _local_11;
		while (--_local_6 > -1)
		{
			_local_8 = _local_10[_local_6];
			if (_arg_4 == 2)
			{
				if (_local_8._kill(_arg_3, _arg_1))
				{
					_local_7 = true;
				}
			}
			if (((!(_arg_4 === 2)) || ((!(_local_8._firstPT)) && (_local_8._initted))))
			{
				if (_local_8._enabled(false, false))
				{
					_local_7 = true;
				}
			}
		}
		return (_local_7);
	}

	public static function killTweensOf(_arg_1:*, _arg_2:* = false, _arg_3:Object = null):void
	{
		if (typeof(_arg_2) === "object")
		{
			_arg_3 = _arg_2;
			_arg_2 = false;
		}
		var _local_4:Array = TweenLite.getTweensOf(_arg_1, _arg_2);
		var _local_5:int = _local_4.length;
		while (--_local_5 > -1)
		{
			_local_4[_local_5]._kill(_arg_3, _arg_1);
		}
	}

	protected static function _prepVars(_arg_1:Object, _arg_2:Boolean = false):Object
	{
		if (_arg_1._isGSVars)
		{
			_arg_1 = _arg_1.vars;
		}
		if (((_arg_2) && (!("immediateRender" in _arg_1))))
		{
			_arg_1.immediateRender = true;
		}
		return (_arg_1);
	}

	public static function delayedCall(_arg_1:Number, _arg_2:Function, _arg_3:Array = null, _arg_4:Boolean = false):TweenLite
	{
		return (new TweenLite(_arg_2, 0, {
			"delay": _arg_1,
			"onComplete": _arg_2,
			"onCompleteParams": _arg_3,
			"onReverseComplete": _arg_2,
			"onReverseCompleteParams": _arg_3,
			"immediateRender": false,
			"useFrames": _arg_4,
			"overwrite": 0
		}));
	}

	public static function from(_arg_1:Object, _arg_2:Number, _arg_3:Object):TweenLite
	{
		_arg_3 = _prepVars(_arg_3, true);
		_arg_3.runBackwards = true;
		return (new TweenLite(_arg_1, _arg_2, _arg_3));
	}

	public static function killDelayedCallsTo(_arg_1:Function):void
	{
		killTweensOf(_arg_1);
	}

	public static function set(_arg_1:Object, _arg_2:Object):TweenLite
	{
		return (new TweenLite(_arg_1, 0, _arg_2));
	}

	private static function _dumpGarbage(_arg_1:Event):void
	{
		var _local_2:int;
		var _local_3:Array;
		var _local_4:Object;
		if (((_rootFrame / 60) >> 0) === (_rootFrame / 60))
		{
			for (_local_4 in _tweenLookup)
			{
				_local_3 = _tweenLookup[_local_4];
				_local_2 = _local_3.length;
				while (--_local_2 > -1)
				{
					if (_local_3[_local_2]._gc)
					{
						_local_3.splice(_local_2, 1);
					}
				}
				if (_local_3.length === 0)
				{
					delete _tweenLookup[_local_4];
				}
			}
		}
	}

	public static function to(_arg_1:Object, _arg_2:Number, _arg_3:Object):TweenLite
	{
		return (new TweenLite(_arg_1, _arg_2, _arg_3));
	}

	private static function _checkOverlap(_arg_1:Animation, _arg_2:Number, _arg_3:Boolean):Number
	{
		var _local_4:SimpleTimeline = _arg_1._timeline;
		var _local_5:Number = _local_4._timeScale;
		var _local_6:Number = _arg_1._startTime;
		var _local_7:Number = 1E-10;
		while (_local_4._timeline)
		{
			_local_6 = (_local_6 + _local_4._startTime);
			_local_5 = (_local_5 * _local_4._timeScale);
			if (_local_4._paused)
			{
				return (-100);
			}
			_local_4 = _local_4._timeline;
		}
		_local_6 = (_local_6 / _local_5);
		return ((_local_6 > _arg_2) ? (_local_6 - _arg_2) : ((((_arg_3) && (_local_6 == _arg_2)) || ((!(_arg_1._initted)) && ((_local_6 - _arg_2) < (2 * _local_7)))) ? _local_7 : (((_local_6 = (_local_6 + ((_arg_1.totalDuration() / _arg_1._timeScale) / _local_5))) > (_arg_2 + _local_7)) ? 0 : ((_local_6 - _arg_2) - _local_7))));
	}


	protected function _initProps(_arg_1:Object, _arg_2:Object, _arg_3:Array, _arg_4:Object):Boolean
	{
		var _local_6:String;
		var _local_7:int;
		var _local_8:Boolean;
		var _local_9:Object;
		var _local_10:Object;
		var _local_5:Object = this.vars;
		if (_arg_1 == null)
		{
			return (false);
		}
		for (_local_6 in _local_5)
		{
			_local_10 = _local_5[_local_6];
			if ((_local_6 in _reservedProps))
			{
				if ((_local_10 is Array))
				{
					if (_local_10.join("").indexOf("{self}") !== -1)
					{
						_local_5[_local_6] = _swapSelfInParams((_local_10 as Array));
					}
				}
			}
			else
			{
				if (((_local_6 in _plugins) && ((_local_9 = new (_plugins[_local_6])())._onInitTween(_arg_1, _local_10, this))))
				{
					_firstPT = new PropTween(_local_9, "setRatio", 0, 1, _local_6, true, _firstPT, _local_9._priority);
					_local_7 = _local_9._overwriteProps.length;
					while (--_local_7 > -1)
					{
						_arg_2[_local_9._overwriteProps[_local_7]] = _firstPT;
					}
					if (((_local_9._priority) || ("_onInitAllProps" in _local_9)))
					{
						_local_8 = true;
					}
					if ((("_onDisable" in _local_9) || ("_onEnable" in _local_9)))
					{
						_notifyPluginsOfEnabled = true;
					}
				}
				else
				{
					_firstPT = (_arg_2[_local_6] = new PropTween(_arg_1, _local_6, 0, 1, _local_6, false, _firstPT));
					_firstPT.s = ((_firstPT.f) ? _arg_1[(((_local_6.indexOf("set")) || (!(("get" + _local_6.substr(3)) in _arg_1))) ? _local_6 : ("get" + _local_6.substr(3)))]() : Number(_arg_1[_local_6]));
					_firstPT.c = ((typeof(_local_10) === "number") ? (Number(_local_10) - _firstPT.s) : (((typeof(_local_10) === "string") && (_local_10.charAt(1) === "=")) ? (int((_local_10.charAt(0) + "1")) * Number(_local_10.substr(2))) : ((Number(_local_10)) || (0))));
				}
			}
		}
		if (_arg_4)
		{
			if (_kill(_arg_4, _arg_1))
			{
				return (_initProps(_arg_1, _arg_2, _arg_3, _arg_4));
			}
		}
		if (_overwrite > 1)
		{
			if (_firstPT != null)
			{
				if (_arg_3.length > 1)
				{
					if (_applyOverwrite(_arg_1, this, _arg_2, _overwrite, _arg_3))
					{
						_kill(_arg_2, _arg_1);
						return (_initProps(_arg_1, _arg_2, _arg_3, _arg_4));
					}
				}
			}
		}
		return (_local_8);
	}

	override public function _enabled(_arg_1:Boolean, _arg_2:Boolean = false):Boolean
	{
		var _local_3:int;
		if (((_arg_1) && (_gc)))
		{
			if (_targets)
			{
				_local_3 = _targets.length;
				while (--_local_3 > -1)
				{
					_siblings[_local_3] = _register(_targets[_local_3], this, true);
				}
			}
			else
			{
				_siblings = _register(target, this, true);
			}
		}
		super._enabled(_arg_1, _arg_2);
		if (_notifyPluginsOfEnabled)
		{
			if (_firstPT != null)
			{
				return (_onPluginEvent(((_arg_1) ? "_onEnable" : "_onDisable"), this));
			}
		}
		return (false);
	}

	override public function render(_arg_1:Number, _arg_2:Boolean = false, _arg_3:Boolean = false):void
	{
		var _local_4:Boolean;
		var _local_5:String;
		var _local_6:PropTween;
		var _local_7:Number;
		var _local_9:Number;
		var _local_8:Number = _time;
		if (_arg_1 >= _duration)
		{
			_totalTime = (_time = _duration);
			ratio = ((_ease._calcEnd) ? _ease.getRatio(1) : 1);
			if (!_reversed)
			{
				_local_4 = true;
				_local_5 = "onComplete";
			}
			if (_duration == 0)
			{
				_local_7 = _rawPrevTime;
				if (_startTime === _timeline._duration)
				{
					_arg_1 = 0;
				}
				if ((((_arg_1 === 0) || (_local_7 < 0)) || (_local_7 === _tinyNum)))
				{
					if (_local_7 !== _arg_1)
					{
						_arg_3 = true;
						if (((_local_7 > 0) && (!(_local_7 === _tinyNum))))
						{
							_local_5 = "onReverseComplete";
						}
					}
				}
				_rawPrevTime = (_local_7 = ((((!(_arg_2)) || (!(_arg_1 === 0))) || (_rawPrevTime === _arg_1)) ? _arg_1 : _tinyNum));
			}
		}
		else
		{
			if (_arg_1 < 1E-7)
			{
				_totalTime = (_time = 0);
				ratio = ((_ease._calcEnd) ? _ease.getRatio(0) : 0);
				if (((!(_local_8 === 0)) || (((_duration === 0) && (_rawPrevTime > 0)) && (!(_rawPrevTime === _tinyNum)))))
				{
					_local_5 = "onReverseComplete";
					_local_4 = _reversed;
				}
				if (_arg_1 < 0)
				{
					_active = false;
					if (_duration == 0)
					{
						if (_rawPrevTime >= 0)
						{
							_arg_3 = true;
						}
						_rawPrevTime = (_local_7 = ((((!(_arg_2)) || (!(_arg_1 === 0))) || (_rawPrevTime === _arg_1)) ? _arg_1 : _tinyNum));
					}
				}
				else
				{
					if (!_initted)
					{
						_arg_3 = true;
					}
				}
			}
			else
			{
				_totalTime = (_time = _arg_1);
				if (_easeType)
				{
					_local_9 = (_arg_1 / _duration);
					if (((_easeType == 1) || ((_easeType == 3) && (_local_9 >= 0.5))))
					{
						_local_9 = (1 - _local_9);
					}
					if (_easeType == 3)
					{
						_local_9 = (_local_9 * 2);
					}
					if (_easePower == 1)
					{
						_local_9 = (_local_9 * _local_9);
					}
					else
					{
						if (_easePower == 2)
						{
							_local_9 = (_local_9 * (_local_9 * _local_9));
						}
						else
						{
							if (_easePower == 3)
							{
								_local_9 = (_local_9 * ((_local_9 * _local_9) * _local_9));
							}
							else
							{
								if (_easePower == 4)
								{
									_local_9 = (_local_9 * (((_local_9 * _local_9) * _local_9) * _local_9));
								}
							}
						}
					}
					if (_easeType == 1)
					{
						ratio = (1 - _local_9);
					}
					else
					{
						if (_easeType == 2)
						{
							ratio = _local_9;
						}
						else
						{
							if ((_arg_1 / _duration) < 0.5)
							{
								ratio = (_local_9 / 2);
							}
							else
							{
								ratio = (1 - (_local_9 / 2));
							}
						}
					}
				}
				else
				{
					ratio = _ease.getRatio((_arg_1 / _duration));
				}
			}
		}
		if (((_time == _local_8) && (!(_arg_3))))
		{
			return;
		}
		if (!_initted)
		{
			_init();
			if (((!(_initted)) || (_gc)))
			{
				return;
			}
			if (((_time) && (!(_local_4))))
			{
				ratio = _ease.getRatio((_time / _duration));
			}
			else
			{
				if (((_local_4) && (_ease._calcEnd)))
				{
					ratio = _ease.getRatio(((_time === 0) ? 0 : 1));
				}
			}
		}
		if (!_active)
		{
			if ((((!(_paused)) && (!(_time === _local_8))) && (_arg_1 >= 0)))
			{
				_active = true;
			}
		}
		if (_local_8 == 0)
		{
			if (_startAt != null)
			{
				if (_arg_1 >= 0)
				{
					_startAt.render(_arg_1, _arg_2, _arg_3);
				}
				else
				{
					if (!_local_5)
					{
						_local_5 = "_dummyGS";
					}
				}
			}
			if (vars.onStart)
			{
				if (((!(_time == 0)) || (_duration == 0)))
				{
					if (!_arg_2)
					{
						vars.onStart.apply(null, vars.onStartParams);
					}
				}
			}
		}
		_local_6 = _firstPT;
		while (_local_6)
		{
			if (_local_6.f)
			{
				var _local_10:* = _local_6.t;
				(_local_10[_local_6.p](((_local_6.c * ratio) + _local_6.s)));
			}
			else
			{
				_local_6.t[_local_6.p] = ((_local_6.c * ratio) + _local_6.s);
			}
			_local_6 = _local_6._next;
		}
		if (_onUpdate != null)
		{
			if ((((_arg_1 < 0) && (!(_startAt == null))) && (!(_startTime == 0))))
			{
				_startAt.render(_arg_1, _arg_2, _arg_3);
			}
			if (!_arg_2)
			{
				if (((!(_time === _local_8)) || (_local_4)))
				{
					_onUpdate.apply(null, vars.onUpdateParams);
				}
			}
		}
		if (_local_5)
		{
			if (!_gc)
			{
				if (((((_arg_1 < 0) && (!(_startAt == null))) && (_onUpdate == null)) && (!(_startTime == 0))))
				{
					_startAt.render(_arg_1, _arg_2, _arg_3);
				}
				if (_local_4)
				{
					if (_timeline.autoRemoveChildren)
					{
						_enabled(false, false);
					}
					_active = false;
				}
				if (!_arg_2)
				{
					if (vars[_local_5])
					{
						vars[_local_5].apply(null, vars[(_local_5 + "Params")]);
					}
				}
				if ((((_duration === 0) && (_rawPrevTime === _tinyNum)) && (!(_local_7 === _tinyNum))))
				{
					_rawPrevTime = 0;
				}
			}
		}
	}

	protected function _init():void
	{
		var _local_2:int;
		var _local_3:Boolean;
		var _local_4:PropTween;
		var _local_5:String;
		var _local_6:Object;
		var _local_1:Boolean = vars.immediateRender;
		if (vars.startAt)
		{
			if (_startAt != null)
			{
				_startAt.render(-1, true);
			}
			vars.startAt.overwrite = 0;
			vars.startAt.immediateRender = true;
			_startAt = new TweenLite(target, 0, vars.startAt);
			if (_local_1)
			{
				if (_time > 0)
				{
					_startAt = null;
				}
				else
				{
					if (_duration !== 0)
					{
						return;
					}
				}
			}
		}
		else
		{
			if (((vars.runBackwards) && (!(_duration === 0))))
			{
				if (_startAt != null)
				{
					_startAt.render(-1, true);
					_startAt = null;
				}
				else
				{
					_local_6 = {};
					for (_local_5 in vars)
					{
						if (!(_local_5 in _reservedProps))
						{
							_local_6[_local_5] = vars[_local_5];
						}
					}
					_local_6.overwrite = 0;
					_local_6.data = "isFromStart";
					_startAt = TweenLite.to(target, 0, _local_6);
					if (!_local_1)
					{
						_startAt.render(-1, true);
					}
					else
					{
						if (_time === 0)
						{
							return;
						}
					}
				}
			}
		}
		if ((vars.ease is Ease))
		{
			_ease = ((vars.easeParams is Array) ? vars.ease.config.apply(vars.ease, vars.easeParams) : vars.ease);
		}
		else
		{
			if (typeof(vars.ease) === "function")
			{
				_ease = new Ease(vars.ease, vars.easeParams);
			}
			else
			{
				_ease = defaultEase;
			}
		}
		_easeType = _ease._type;
		_easePower = _ease._power;
		_firstPT = null;
		if (_targets)
		{
			_local_2 = _targets.length;
			while (--_local_2 > -1)
			{
				if (_initProps(_targets[_local_2], (_propLookup[_local_2] = {}), _siblings[_local_2], ((_overwrittenProps) ? _overwrittenProps[_local_2] : null)))
				{
					_local_3 = true;
				}
			}
		}
		else
		{
			_local_3 = _initProps(target, _propLookup, _siblings, _overwrittenProps);
		}
		if (_local_3)
		{
			_onPluginEvent("_onInitAllProps", this);
		}
		if (_overwrittenProps)
		{
			if (_firstPT == null)
			{
				if (typeof(target) !== "function")
				{
					_enabled(false, false);
				}
			}
		}
		if (vars.runBackwards)
		{
			_local_4 = _firstPT;
			while (_local_4)
			{
				_local_4.s = (_local_4.s + _local_4.c);
				_local_4.c = -(_local_4.c);
				_local_4 = _local_4._next;
			}
		}
		_onUpdate = vars.onUpdate;
		_initted = true;
	}

	override public function invalidate():*
	{
		if (_notifyPluginsOfEnabled)
		{
			_onPluginEvent("_onDisable", this);
		}
		_firstPT = null;
		_overwrittenProps = null;
		_onUpdate = null;
		_startAt = null;
		_initted = (_active = (_notifyPluginsOfEnabled = false));
		_propLookup = ((_targets) ? {} : []);
		return (this);
	}

	override public function _kill(_arg_1:Object = null, _arg_2:Object = null):Boolean
	{
		var _local_3:int;
		var _local_4:Object;
		var _local_5:String;
		var _local_6:PropTween;
		var _local_7:Object;
		var _local_8:Boolean;
		var _local_9:Object;
		var _local_10:Boolean;
		if (_arg_1 === "all")
		{
			_arg_1 = null;
		}
		if (_arg_1 == null)
		{
			if (((_arg_2 == null) || (_arg_2 == this.target)))
			{
				return (_enabled(false, false));
			}
		}
		_arg_2 = (((_arg_2) || (_targets)) || (this.target));
		if (((_arg_2 is Array) && (typeof(_arg_2[0]) === "object")))
		{
			_local_3 = _arg_2.length;
			while (--_local_3 > -1)
			{
				if (_kill(_arg_1, _arg_2[_local_3]))
				{
					_local_8 = true;
				}
			}
		}
		else
		{
			if (_targets)
			{
				_local_3 = _targets.length;
				while (--_local_3 > -1)
				{
					if (_arg_2 === _targets[_local_3])
					{
						_local_7 = ((_propLookup[_local_3]) || ({}));
						_overwrittenProps = ((_overwrittenProps) || ([]));
						_local_4 = (_overwrittenProps[_local_3] = ((_arg_1) ? ((_overwrittenProps[_local_3]) || ({})) : "all"));
						break;
					}
				}
			}
			else
			{
				if (_arg_2 !== this.target)
				{
					return (false);
				}
				_local_7 = _propLookup;
				_local_4 = (_overwrittenProps = ((_arg_1) ? ((_overwrittenProps) || ({})) : "all"));
			}
			if (_local_7)
			{
				_local_9 = ((_arg_1) || (_local_7));
				_local_10 = ((((!(_arg_1 == _local_4)) && (!(_local_4 == "all"))) && (!(_arg_1 == _local_7))) && ((!(typeof(_arg_1) == "object")) || (!(_arg_1._tempKill == true))));
				for (_local_5 in _local_9)
				{
					_local_6 = _local_7[_local_5];
					if (_local_6 != null)
					{
						if (((_local_6.pg) && (_local_6.t._kill(_local_9))))
						{
							_local_8 = true;
						}
						if (((!(_local_6.pg)) || (_local_6.t._overwriteProps.length === 0)))
						{
							if (_local_6._prev)
							{
								_local_6._prev._next = _local_6._next;
							}
							else
							{
								if (_local_6 == _firstPT)
								{
									_firstPT = _local_6._next;
								}
							}
							if (_local_6._next)
							{
								_local_6._next._prev = _local_6._prev;
							}
							_local_6._next = (_local_6._prev = null);
						}
						delete _local_7[_local_5];
					}
					if (_local_10)
					{
						_local_4[_local_5] = 1;
					}
				}
				if (((_firstPT == null) && (_initted)))
				{
					_enabled(false, false);
				}
			}
		}
		return (_local_8);
	}


}
}//package com.greensock

