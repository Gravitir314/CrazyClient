//com.greensock.core.SimpleTimeline

package com.greensock.core
{
public class SimpleTimeline extends Animation
{

	public var _first:Animation;
	public var autoRemoveChildren:Boolean;
	public var _last:Animation;
	public var smoothChildTiming:Boolean;
	public var _sortChildren:Boolean;

	public function SimpleTimeline(_arg_1:Object = null)
	{
		super(0, _arg_1);
		this.autoRemoveChildren = (this.smoothChildTiming = true);
	}

	public function add(_arg_1:*, _arg_2:* = "+=0", _arg_3:String = "normal", _arg_4:Number = 0):*
	{
		var _local_6:Number;
		_arg_1._startTime = (Number(((_arg_2) || (0))) + _arg_1._delay);
		if (_arg_1._paused)
		{
			if (this != _arg_1._timeline)
			{
				_arg_1._pauseTime = (_arg_1._startTime + ((rawTime() - _arg_1._startTime) / _arg_1._timeScale));
			}
		}
		if (_arg_1.timeline)
		{
			_arg_1.timeline._remove(_arg_1, true);
		}
		_arg_1.timeline = (_arg_1._timeline = this);
		if (_arg_1._gc)
		{
			_arg_1._enabled(true, true);
		}
		var _local_5:Animation = _last;
		if (_sortChildren)
		{
			_local_6 = _arg_1._startTime;
			while (((_local_5) && (_local_5._startTime > _local_6)))
			{
				_local_5 = _local_5._prev;
			}
		}
		if (_local_5)
		{
			_arg_1._next = _local_5._next;
			_local_5._next = Animation(_arg_1);
		}
		else
		{
			_arg_1._next = _first;
			_first = Animation(_arg_1);
		}
		if (_arg_1._next)
		{
			_arg_1._next._prev = _arg_1;
		}
		else
		{
			_last = Animation(_arg_1);
		}
		_arg_1._prev = _local_5;
		if (_timeline)
		{
			_uncache(true);
		}
		return (this);
	}

	public function _remove(_arg_1:Animation, _arg_2:Boolean = false):*
	{
		if (_arg_1.timeline == this)
		{
			if (!_arg_2)
			{
				_arg_1._enabled(false, true);
			}
			if (_arg_1._prev)
			{
				_arg_1._prev._next = _arg_1._next;
			}
			else
			{
				if (_first === _arg_1)
				{
					_first = _arg_1._next;
				}
			}
			if (_arg_1._next)
			{
				_arg_1._next._prev = _arg_1._prev;
			}
			else
			{
				if (_last === _arg_1)
				{
					_last = _arg_1._prev;
				}
			}
			_arg_1._next = (_arg_1._prev = (_arg_1.timeline = null));
			if (_timeline)
			{
				_uncache(true);
			}
		}
		return (this);
	}

	public function rawTime():Number
	{
		return (_totalTime);
	}

	override public function render(_arg_1:Number, _arg_2:Boolean = false, _arg_3:Boolean = false):void
	{
		var _local_5:Animation;
		var _local_4:Animation = _first;
		_totalTime = (_time = (_rawPrevTime = _arg_1));
		while (_local_4)
		{
			_local_5 = _local_4._next;
			if (((_local_4._active) || ((_arg_1 >= _local_4._startTime) && (!(_local_4._paused)))))
			{
				if (!_local_4._reversed)
				{
					_local_4.render(((_arg_1 - _local_4._startTime) * _local_4._timeScale), _arg_2, _arg_3);
				}
				else
				{
					_local_4.render((((_local_4._dirty) ? _local_4.totalDuration() : _local_4._totalDuration) - ((_arg_1 - _local_4._startTime) * _local_4._timeScale)), _arg_2, _arg_3);
				}
			}
			_local_4 = _local_5;
		}
	}

	public function insert(_arg_1:*, _arg_2:* = 0):*
	{
		return (add(_arg_1, ((_arg_2) || (0))));
	}


}
}//package com.greensock.core

