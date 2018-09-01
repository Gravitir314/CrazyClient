//com.greensock.TweenMax

package com.greensock
{
import com.greensock.core.Animation;
import com.greensock.core.PropTween;
import com.greensock.core.SimpleTimeline;
import com.greensock.events.TweenEvent;
import com.greensock.plugins.AutoAlphaPlugin;
import com.greensock.plugins.BevelFilterPlugin;
import com.greensock.plugins.BezierPlugin;
import com.greensock.plugins.BezierThroughPlugin;
import com.greensock.plugins.BlurFilterPlugin;
import com.greensock.plugins.ColorMatrixFilterPlugin;
import com.greensock.plugins.ColorTransformPlugin;
import com.greensock.plugins.DropShadowFilterPlugin;
import com.greensock.plugins.EndArrayPlugin;
import com.greensock.plugins.FrameLabelPlugin;
import com.greensock.plugins.FramePlugin;
import com.greensock.plugins.GlowFilterPlugin;
import com.greensock.plugins.HexColorsPlugin;
import com.greensock.plugins.RemoveTintPlugin;
import com.greensock.plugins.RoundPropsPlugin;
import com.greensock.plugins.ShortRotationPlugin;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;
import com.greensock.plugins.VisiblePlugin;
import com.greensock.plugins.VolumePlugin;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.utils.getTimer;

public class TweenMax extends TweenLite implements IEventDispatcher
{

	public static const version:String = "12.1.5";
	protected static var _listenerLookup:Object = {
		"onCompleteListener": TweenEvent.COMPLETE,
		"onUpdateListener": TweenEvent.UPDATE,
		"onStartListener": TweenEvent.START,
		"onRepeatListener": TweenEvent.REPEAT,
		"onReverseCompleteListener": TweenEvent.REVERSE_COMPLETE
	};
	public static var ticker:Shape = Animation.ticker;
	public static var allTo:Function = staggerTo;
	public static var allFrom:Function = staggerFrom;
	public static var allFromTo:Function = staggerFromTo;

	protected var _dispatcher:EventDispatcher;
	public var _yoyo:Boolean;
	protected var _hasUpdateListener:Boolean;
	protected var _cycle:int = 0;
	protected var _repeatDelay:Number = 0;
	protected var _repeat:int = 0;

	{
		TweenPlugin.activate([AutoAlphaPlugin, EndArrayPlugin, FramePlugin, RemoveTintPlugin, TintPlugin, VisiblePlugin, VolumePlugin, BevelFilterPlugin, BezierPlugin, BezierThroughPlugin, BlurFilterPlugin, ColorMatrixFilterPlugin, ColorTransformPlugin, DropShadowFilterPlugin, FrameLabelPlugin, GlowFilterPlugin, HexColorsPlugin, RoundPropsPlugin, ShortRotationPlugin]);
	}

	public function TweenMax(_arg_1:Object, _arg_2:Number, _arg_3:Object)
	{
		super(_arg_1, _arg_2, _arg_3);
		_yoyo = (this.vars.yoyo == true);
		_repeat = int(this.vars.repeat);
		_repeatDelay = ((this.vars.repeatDelay) || (0));
		_dirty = true;
		if ((((((this.vars.onCompleteListener) || (this.vars.onUpdateListener)) || (this.vars.onStartListener)) || (this.vars.onRepeatListener)) || (this.vars.onReverseCompleteListener)))
		{
			_initDispatcher();
			if (_duration == 0)
			{
				if (_delay == 0)
				{
					if (this.vars.immediateRender)
					{
						_dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
						_dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
					}
				}
			}
		}
	}

	public static function resumeAll(_arg_1:Boolean = true, _arg_2:Boolean = true, _arg_3:Boolean = true):void
	{
		_changePause(false, _arg_1, _arg_2, _arg_3);
	}

	public static function fromTo(_arg_1:Object, _arg_2:Number, _arg_3:Object, _arg_4:Object):TweenMax
	{
		_arg_4 = _prepVars(_arg_4, false);
		_arg_3 = _prepVars(_arg_3, false);
		_arg_4.startAt = _arg_3;
		_arg_4.immediateRender = ((!(_arg_4.immediateRender == false)) && (!(_arg_3.immediateRender == false)));
		return (new TweenMax(_arg_1, _arg_2, _arg_4));
	}

	public static function staggerTo(targets:Array, duration:Number, vars:Object, stagger:Number = 0, onCompleteAll:Function = null, onCompleteAllParams:Array = null):Array
	{
		var copy:Object;
		var i:int;
		var p:String;
		vars = _prepVars(vars, false);
		var a:Array = [];
		var l:int = targets.length;
		var delay:Number = ((vars.delay) || (0));
		i = 0;
		while (i < l)
		{
			copy = {};
			for (p in vars)
			{
				copy[p] = vars[p];
			}
			copy.delay = delay;
			if (i == (l - 1))
			{
				if (onCompleteAll != null)
				{
					copy.onComplete = function ():void
					{
						if (internal::vars.onComplete)
						{
							internal::vars.onComplete.apply(null, arguments);
						}
						onCompleteAll.apply(null, onCompleteAllParams);
					};
				}
			}
			a[i] = new TweenMax(targets[i], duration, copy);
			delay = (delay + stagger);
			i = (i + 1);
		}
		return (a);
	}

	public static function pauseAll(_arg_1:Boolean = true, _arg_2:Boolean = true, _arg_3:Boolean = true):void
	{
		_changePause(true, _arg_1, _arg_2, _arg_3);
	}

	public static function staggerFromTo(_arg_1:Array, _arg_2:Number, _arg_3:Object, _arg_4:Object, _arg_5:Number = 0, _arg_6:Function = null, _arg_7:Array = null):Array
	{
		_arg_4 = _prepVars(_arg_4, false);
		_arg_3 = _prepVars(_arg_3, false);
		_arg_4.startAt = _arg_3;
		_arg_4.immediateRender = ((!(_arg_4.immediateRender == false)) && (!(_arg_3.immediateRender == false)));
		return (staggerTo(_arg_1, _arg_2, _arg_4, _arg_5, _arg_6, _arg_7));
	}

	public static function getTweensOf(_arg_1:*, _arg_2:Boolean = false):Array
	{
		return (TweenLite.getTweensOf(_arg_1, _arg_2));
	}

	public static function killTweensOf(_arg_1:*, _arg_2:* = false, _arg_3:Object = null):void
	{
		TweenLite.killTweensOf(_arg_1, _arg_2, _arg_3);
	}

	public static function delayedCall(_arg_1:Number, _arg_2:Function, _arg_3:Array = null, _arg_4:Boolean = false):TweenMax
	{
		return (new TweenMax(_arg_2, 0, {
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

	public static function isTweening(_arg_1:Object):Boolean
	{
		return (TweenLite.getTweensOf(_arg_1, true).length > 0);
	}

	public static function killAll(_arg_1:Boolean = false, _arg_2:Boolean = true, _arg_3:Boolean = true, _arg_4:Boolean = true):void
	{
		var _local_7:Boolean;
		var _local_9:Animation;
		var _local_10:int;
		var _local_5:Array = getAllTweens(_arg_4);
		var _local_6:int = _local_5.length;
		var _local_8:Boolean = (((_arg_2) && (_arg_3)) && (_arg_4));
		_local_10 = 0;
		while (_local_10 < _local_6)
		{
			_local_9 = _local_5[_local_10];
			if (((((_local_8) || (_local_9 is SimpleTimeline)) || ((_local_7 == (TweenLite(_local_9).target == TweenLite(_local_9).vars.onComplete)) && (_arg_3))) || ((_arg_2) && (!(_local_7)))))
			{
				if (_arg_1)
				{
					_local_9.totalTime(((_local_9._reversed) ? 0 : _local_9.totalDuration()));
				}
				else
				{
					_local_9._enabled(false, false);
				}
			}
			_local_10++;
		}
	}

	public static function killChildTweensOf(_arg_1:DisplayObjectContainer, _arg_2:Boolean = false):void
	{
		var _local_5:int;
		var _local_3:Array = getAllTweens(false);
		var _local_4:int = _local_3.length;
		_local_5 = 0;
		while (_local_5 < _local_4)
		{
			if (_containsChildOf(_arg_1, _local_3[_local_5].target))
			{
				if (_arg_2)
				{
					_local_3[_local_5].totalTime(_local_3[_local_5].totalDuration());
				}
				else
				{
					_local_3[_local_5]._enabled(false, false);
				}
			}
			_local_5++;
		}
	}

	private static function _changePause(_arg_1:Boolean, _arg_2:Boolean = true, _arg_3:Boolean = false, _arg_4:Boolean = true):void
	{
		var _local_6:Boolean;
		var _local_7:Animation;
		var _local_5:Array = getAllTweens(_arg_4);
		var _local_8:Boolean = (((_arg_2) && (_arg_3)) && (_arg_4));
		var _local_9:int = _local_5.length;
		while (--_local_9 > -1)
		{
			_local_7 = _local_5[_local_9];
			_local_6 = ((_local_7 is TweenLite) && (TweenLite(_local_7).target == _local_7.vars.onComplete));
			if (((((_local_8) || (_local_7 is SimpleTimeline)) || ((_local_6) && (_arg_3))) || ((_arg_2) && (!(_local_6)))))
			{
				_local_7.paused(_arg_1);
			}
		}
	}

	public static function set(_arg_1:Object, _arg_2:Object):TweenMax
	{
		return (new TweenMax(_arg_1, 0, _arg_2));
	}

	public static function from(_arg_1:Object, _arg_2:Number, _arg_3:Object):TweenMax
	{
		_arg_3 = _prepVars(_arg_3, true);
		_arg_3.runBackwards = true;
		return (new TweenMax(_arg_1, _arg_2, _arg_3));
	}

	public static function killDelayedCallsTo(_arg_1:Function):void
	{
		TweenLite.killTweensOf(_arg_1);
	}

	public static function globalTimeScale(_arg_1:Number = NaN):Number
	{
		if (!arguments.length)
		{
			return ((_rootTimeline == null) ? 1 : _rootTimeline._timeScale);
		}
		_arg_1 = ((_arg_1) || (0.0001));
		if (_rootTimeline == null)
		{
			TweenLite.to({}, 0, {});
		}
		var _local_3:SimpleTimeline = _rootTimeline;
		var _local_4:Number = (getTimer() / 1000);
		_local_3._startTime = (_local_4 - (((_local_4 - _local_3._startTime) * _local_3._timeScale) / _arg_1));
		_local_3 = _rootFramesTimeline;
		_local_4 = _rootFrame;
		_local_3._startTime = (_local_4 - (((_local_4 - _local_3._startTime) * _local_3._timeScale) / _arg_1));
		_rootFramesTimeline._timeScale = (_rootTimeline._timeScale = _arg_1);
		return (_arg_1);
	}

	public static function getAllTweens(_arg_1:Boolean = false):Array
	{
		var _local_2:Array = _getChildrenOf(_rootTimeline, _arg_1);
		return (_local_2.concat(_getChildrenOf(_rootFramesTimeline, _arg_1)));
	}

	protected static function _getChildrenOf(_arg_1:SimpleTimeline, _arg_2:Boolean):Array
	{
		if (_arg_1 == null)
		{
			return ([]);
		}
		var _local_3:Array = [];
		var _local_4:int;
		var _local_5:Animation = _arg_1._first;
		while (_local_5)
		{
			if ((_local_5 is TweenLite))
			{
				var _local_6:* = _local_4++;
				_local_3[_local_6] = _local_5;
			}
			else
			{
				if (_arg_2)
				{
					_local_6 = _local_4++;
					_local_3[_local_6] = _local_5;
				}
				_local_3 = _local_3.concat(_getChildrenOf(SimpleTimeline(_local_5), _arg_2));
				_local_4 = _local_3.length;
			}
			_local_5 = _local_5._next;
		}
		return (_local_3);
	}

	private static function _containsChildOf(_arg_1:DisplayObjectContainer, _arg_2:Object):Boolean
	{
		var _local_3:int;
		var _local_4:DisplayObjectContainer;
		if ((_arg_2 is Array))
		{
			_local_3 = _arg_2.length;
			while (--_local_3 > -1)
			{
				if (_containsChildOf(_arg_1, _arg_2[_local_3]))
				{
					return (true);
				}
			}
		}
		else
		{
			if ((_arg_2 is DisplayObject))
			{
				_local_4 = _arg_2.parent;
				while (_local_4)
				{
					if (_local_4 == _arg_1)
					{
						return (true);
					}
					_local_4 = _local_4.parent;
				}
			}
		}
		return (false);
	}

	public static function staggerFrom(_arg_1:Array, _arg_2:Number, _arg_3:Object, _arg_4:Number = 0, _arg_5:Function = null, _arg_6:Array = null):Array
	{
		_arg_3 = _prepVars(_arg_3, true);
		_arg_3.runBackwards = true;
		if (_arg_3.immediateRender != false)
		{
			_arg_3.immediateRender = true;
		}
		return (staggerTo(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6));
	}

	public static function to(_arg_1:Object, _arg_2:Number, _arg_3:Object):TweenMax
	{
		return (new TweenMax(_arg_1, _arg_2, _arg_3));
	}


	public function dispatchEvent(_arg_1:Event):Boolean
	{
		return ((_dispatcher == null) ? false : _dispatcher.dispatchEvent(_arg_1));
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

	public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean = false):void
	{
		if (_dispatcher)
		{
			_dispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
		}
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

	public function willTrigger(_arg_1:String):Boolean
	{
		return ((_dispatcher == null) ? false : _dispatcher.willTrigger(_arg_1));
	}

	override public function duration(_arg_1:Number = NaN):*
	{
		if (!arguments.length)
		{
			return (this._duration);
		}
		return (super.duration(_arg_1));
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

	override public function render(_arg_1:Number, _arg_2:Boolean = false, _arg_3:Boolean = false):void
	{
		var _local_8:Boolean;
		var _local_9:String;
		var _local_10:PropTween;
		var _local_11:Number;
		var _local_12:Number;
		var _local_13:Number;
		var _local_14:int;
		var _local_15:int;
		if (!_initted)
		{
			if (((_duration === 0) && (public::vars.repeat)))
			{
				invalidate();
			}
		}
		var _local_4:Number = ((_dirty) ? totalDuration() : _totalDuration);
		var _local_5:Number = _time;
		var _local_6:Number = _totalTime;
		var _local_7:Number = _cycle;
		if (_arg_1 >= _local_4)
		{
			_totalTime = _local_4;
			_cycle = _repeat;
			if (((_yoyo) && (!((_cycle & 0x01) == 0))))
			{
				_time = 0;
				ratio = ((_ease._calcEnd) ? _ease.getRatio(0) : 0);
			}
			else
			{
				_time = _duration;
				ratio = ((_ease._calcEnd) ? _ease.getRatio(1) : 1);
			}
			if (!_reversed)
			{
				_local_8 = true;
				_local_9 = "onComplete";
			}
			if (_duration == 0)
			{
				_local_11 = _rawPrevTime;
				if (_startTime === _timeline._duration)
				{
					_arg_1 = 0;
				}
				if ((((_arg_1 === 0) || (_local_11 < 0)) || (_local_11 === _tinyNum)))
				{
					if (_local_11 !== _arg_1)
					{
						_arg_3 = true;
						if (_local_11 > _tinyNum)
						{
							_local_9 = "onReverseComplete";
						}
					}
				}
				_rawPrevTime = (_local_11 = ((((!(_arg_2)) || (!(_arg_1 === 0))) || (_rawPrevTime === _arg_1)) ? _arg_1 : _tinyNum));
			}
		}
		else
		{
			if (_arg_1 < 1E-7)
			{
				_totalTime = (_time = (_cycle = 0));
				ratio = ((_ease._calcEnd) ? _ease.getRatio(0) : 0);
				if (((!(_local_6 === 0)) || (((_duration === 0) && (_rawPrevTime > 0)) && (!(_rawPrevTime === _tinyNum)))))
				{
					_local_9 = "onReverseComplete";
					_local_8 = _reversed;
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
						_rawPrevTime = (_local_11 = ((((!(_arg_2)) || (!(_arg_1 === 0))) || (_rawPrevTime === _arg_1)) ? _arg_1 : _tinyNum));
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
				if (_repeat != 0)
				{
					_local_12 = (_duration + _repeatDelay);
					_cycle = ((_totalTime / _local_12) >> 0);
					if (_cycle !== 0)
					{
						if (_cycle === (_totalTime / _local_12))
						{
							_cycle--;
						}
					}
					_time = (_totalTime - (_cycle * _local_12));
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
					}
					else
					{
						if (_time < 0)
						{
							_time = 0;
						}
					}
				}
				if (_easeType)
				{
					_local_13 = (_time / _duration);
					_local_14 = _easeType;
					_local_15 = _easePower;
					if (((_local_14 == 1) || ((_local_14 == 3) && (_local_13 >= 0.5))))
					{
						_local_13 = (1 - _local_13);
					}
					if (_local_14 == 3)
					{
						_local_13 = (_local_13 * 2);
					}
					if (_local_15 == 1)
					{
						_local_13 = (_local_13 * _local_13);
					}
					else
					{
						if (_local_15 == 2)
						{
							_local_13 = (_local_13 * (_local_13 * _local_13));
						}
						else
						{
							if (_local_15 == 3)
							{
								_local_13 = (_local_13 * ((_local_13 * _local_13) * _local_13));
							}
							else
							{
								if (_local_15 == 4)
								{
									_local_13 = (_local_13 * (((_local_13 * _local_13) * _local_13) * _local_13));
								}
							}
						}
					}
					if (_local_14 == 1)
					{
						ratio = (1 - _local_13);
					}
					else
					{
						if (_local_14 == 2)
						{
							ratio = _local_13;
						}
						else
						{
							if ((_time / _duration) < 0.5)
							{
								ratio = (_local_13 / 2);
							}
							else
							{
								ratio = (1 - (_local_13 / 2));
							}
						}
					}
				}
				else
				{
					ratio = _ease.getRatio((_time / _duration));
				}
			}
		}
		if ((((_local_5 == _time) && (!(_arg_3))) && (_cycle === _local_7)))
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
			_init();
			if (((!(_initted)) || (_gc)))
			{
				return;
			}
			if (((_time) && (!(_local_8))))
			{
				ratio = _ease.getRatio((_time / _duration));
			}
			else
			{
				if (((_local_8) && (_ease._calcEnd)))
				{
					ratio = _ease.getRatio(((_time === 0) ? 0 : 1));
				}
			}
		}
		if (!_active)
		{
			if ((((!(_paused)) && (!(_time === _local_5))) && (_arg_1 >= 0)))
			{
				_active = true;
			}
		}
		if (_local_6 == 0)
		{
			if (_startAt != null)
			{
				if (_arg_1 >= 0)
				{
					_startAt.render(_arg_1, _arg_2, _arg_3);
				}
				else
				{
					if (!_local_9)
					{
						_local_9 = "_dummyGS";
					}
				}
			}
			if (((!(_totalTime == 0)) || (_duration == 0)))
			{
				if (!_arg_2)
				{
					if (public::vars.onStart)
					{
						public::vars.onStart.apply(null, public::vars.onStartParams);
					}
					if (_dispatcher)
					{
						_dispatcher.dispatchEvent(new TweenEvent(TweenEvent.START));
					}
				}
			}
		}
		_local_10 = _firstPT;
		while (_local_10)
		{
			if (_local_10.f)
			{
				var _local_16:* = _local_10.t;
				(_local_16[_local_10.p](((_local_10.c * ratio) + _local_10.s)));
			}
			else
			{
				_local_10.t[_local_10.p] = ((_local_10.c * ratio) + _local_10.s);
			}
			_local_10 = _local_10._next;
		}
		if (_onUpdate != null)
		{
			if ((((_arg_1 < 0) && (!(_startAt == null))) && (!(_startTime == 0))))
			{
				_startAt.render(_arg_1, _arg_2, _arg_3);
			}
			if (!_arg_2)
			{
				if (((!(_totalTime === _local_6)) || (_local_8)))
				{
					_onUpdate.apply(null, public::vars.onUpdateParams);
				}
			}
		}
		if (_hasUpdateListener)
		{
			if (((((_arg_1 < 0) && (!(_startAt == null))) && (_onUpdate == null)) && (!(_startTime == 0))))
			{
				_startAt.render(_arg_1, _arg_2, _arg_3);
			}
			if (!_arg_2)
			{
				_dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
			}
		}
		if (_cycle != _local_7)
		{
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
		}
		if (_local_9)
		{
			if (!_gc)
			{
				if ((((((_arg_1 < 0) && (!(_startAt == null))) && (_onUpdate == null)) && (!(_hasUpdateListener))) && (!(_startTime == 0))))
				{
					_startAt.render(_arg_1, _arg_2, true);
				}
				if (_local_8)
				{
					if (_timeline.autoRemoveChildren)
					{
						_enabled(false, false);
					}
					_active = false;
				}
				if (!_arg_2)
				{
					if (public::vars[_local_9])
					{
						public::vars[_local_9].apply(null, public::vars[(_local_9 + "Params")]);
					}
					if (_dispatcher)
					{
						_dispatcher.dispatchEvent(new TweenEvent(((_local_9 == "onComplete") ? TweenEvent.COMPLETE : TweenEvent.REVERSE_COMPLETE)));
					}
				}
				if ((((_duration === 0) && (_rawPrevTime === _tinyNum)) && (!(_local_11 === _tinyNum))))
				{
					_rawPrevTime = 0;
				}
			}
		}
	}

	override public function totalProgress(_arg_1:Number = NaN, _arg_2:Boolean = false):*
	{
		return ((arguments.length) ? totalTime((totalDuration() * _arg_1), _arg_2) : (_totalTime / totalDuration()));
	}

	public function repeat(_arg_1:int = 0):*
	{
		if (!arguments.length)
		{
			return (_repeat);
		}
		_repeat = _arg_1;
		return (_uncache(true));
	}

	public function updateTo(_arg_1:Object, _arg_2:Boolean = false):*
	{
		var _local_4:String;
		var _local_5:Number;
		var _local_6:Number;
		var _local_7:PropTween;
		var _local_8:Number;
		var _local_3:Number = ratio;
		if (_arg_2)
		{
			if (_startTime < _timeline._time)
			{
				_startTime = _timeline._time;
				_uncache(false);
				if (_gc)
				{
					_enabled(true, false);
				}
				else
				{
					_timeline.insert(this, (_startTime - _delay));
				}
			}
		}
		for (_local_4 in _arg_1)
		{
			this.vars[_local_4] = _arg_1[_local_4];
		}
		if (_initted)
		{
			if (_arg_2)
			{
				_initted = false;
			}
			else
			{
				if (_gc)
				{
					_enabled(true, false);
				}
				if (_notifyPluginsOfEnabled)
				{
					if (_firstPT != null)
					{
						_onPluginEvent("_onDisable", this);
					}
				}
				if ((_time / _duration) > 0.998)
				{
					_local_5 = _time;
					render(0, true, false);
					_initted = false;
					render(_local_5, true, false);
				}
				else
				{
					if (_time > 0)
					{
						_initted = false;
						_init();
						_local_6 = (1 / (1 - _local_3));
						_local_7 = _firstPT;
						while (_local_7)
						{
							_local_8 = (_local_7.s + _local_7.c);
							_local_7.c = (_local_7.c * _local_6);
							_local_7.s = (_local_8 - _local_7.c);
							_local_7 = _local_7._next;
						}
					}
				}
			}
		}
		return (this);
	}

	public function repeatDelay(_arg_1:Number = NaN):*
	{
		if (!arguments.length)
		{
			return (_repeatDelay);
		}
		_repeatDelay = _arg_1;
		return (_uncache(true));
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
		return ((arguments.length) ? totalTime(((duration() * (((_yoyo) && (!((_cycle & 0x01) === 0))) ? (1 - _arg_1) : _arg_1)) + (_cycle * (_duration + _repeatDelay))), _arg_2) : (_time / duration()));
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

	override public function totalDuration(_arg_1:Number = NaN):*
	{
		if (!arguments.length)
		{
			if (_dirty)
			{
				_totalDuration = ((_repeat == -1) ? 999999999999 : ((_duration * (_repeat + 1)) + (_repeatDelay * _repeat)));
				_dirty = false;
			}
			return (_totalDuration);
		}
		return ((_repeat == -1) ? this : duration(((_arg_1 - (_repeat * _repeatDelay)) / (_repeat + 1))));
	}

	public function hasEventListener(_arg_1:String):Boolean
	{
		return ((_dispatcher == null) ? false : _dispatcher.hasEventListener(_arg_1));
	}


}
}//package com.greensock

