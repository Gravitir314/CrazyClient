//com.greensock.plugins.BezierPlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;

import flash.geom.Point;

public class BezierPlugin extends TweenPlugin
{

	public static const API:Number = 2;
	protected static const _RAD2DEG:Number = (180 / Math.PI);//57.2957795130823
	protected static var _r1:Array = [];
	protected static var _r2:Array = [];
	protected static var _r3:Array = [];
	protected static var _corProps:Object = {};

	protected var _startRatio:int;
	protected var _beziers:Object;
	protected var _length:Number;
	protected var _autoRotate:Array;
	protected var _s2:Number;
	protected var _lengths:Array;
	protected var _round:Object;
	protected var _curSeg:Array;
	protected var _prec:Number;
	protected var _segCount:int;
	protected var _timeRes:int;
	protected var _li:Number;
	protected var _func:Object;
	protected var _l1:Number;
	protected var _l2:Number;
	protected var _target:Object;
	protected var _props:Array;
	protected var _si:Number;
	protected var _initialRotations:Array;
	protected var _s1:Number;
	protected var _segments:Array;

	public function BezierPlugin()
	{
		super("bezier");
		this._overwriteProps.pop();
		this._func = {};
		this._round = {};
	}

	protected static function _parseLengthData(_arg_1:Object, _arg_2:uint = 6):Object
	{
		var _local_10:String;
		var _local_11:int;
		var _local_12:int;
		var _local_13:Number;
		var _local_3:Array = [];
		var _local_4:Array = [];
		var _local_5:Number = 0;
		var _local_6:Number = 0;
		var _local_7:int = (_arg_2 - 1);
		var _local_8:Array = [];
		var _local_9:Array = [];
		for (_local_10 in _arg_1)
		{
			_addCubicLengths(_arg_1[_local_10], _local_3, _arg_2);
		}
		_local_12 = _local_3.length;
		_local_11 = 0;
		while (_local_11 < _local_12)
		{
			_local_5 = (_local_5 + Math.sqrt(_local_3[_local_11]));
			_local_13 = (_local_11 % _arg_2);
			_local_9[_local_13] = _local_5;
			if (_local_13 == _local_7)
			{
				_local_6 = (_local_6 + _local_5);
				_local_13 = ((_local_11 / _arg_2) >> 0);
				_local_8[_local_13] = _local_9;
				_local_4[_local_13] = _local_6;
				_local_5 = 0;
				_local_9 = [];
			}
			_local_11++;
		}
		return ({
			"length": _local_6, "lengths": _local_4, "segments": _local_8
		});
	}

	public static function bezierThrough(_arg_1:Array, _arg_2:Number = 1, _arg_3:Boolean = false, _arg_4:Boolean = false, _arg_5:String = "x,y,z", _arg_6:Object = null):Object
	{
		var _local_9:Array;
		var _local_10:int;
		var _local_11:String;
		var _local_12:int;
		var _local_13:Array;
		var _local_14:int;
		var _local_15:Number;
		var _local_16:Boolean;
		var _local_17:Object;
		var _local_7:Object = {};
		var _local_8:Object = ((_arg_6) || (_arg_1[0]));
		_arg_5 = (("," + _arg_5) + ",");
		if ((_local_8 is Point))
		{
			_local_9 = ["x", "y"];
		}
		else
		{
			_local_9 = [];
			for (_local_11 in _local_8)
			{
				_local_9.push(_local_11);
			}
		}
		if (_arg_1.length > 1)
		{
			_local_17 = _arg_1[(_arg_1.length - 1)];
			_local_16 = true;
			_local_10 = _local_9.length;
			while (--_local_10 > -1)
			{
				_local_11 = _local_9[_local_10];
				if (Math.abs((_local_8[_local_11] - _local_17[_local_11])) > 0.05)
				{
					_local_16 = false;
					break;
				}
			}
			if (_local_16)
			{
				_arg_1 = _arg_1.concat();
				if (_arg_6)
				{
					_arg_1.unshift(_arg_6);
				}
				_arg_1.push(_arg_1[1]);
				_arg_6 = _arg_1[(_arg_1.length - 3)];
			}
		}
		_r1.length = (_r2.length = (_r3.length = 0));
		_local_10 = _local_9.length;
		while (--_local_10 > -1)
		{
			_local_11 = _local_9[_local_10];
			_corProps[_local_11] = (!(_arg_5.indexOf((("," + _local_11) + ",")) === -1));
			_local_7[_local_11] = _parseAnchors(_arg_1, _local_11, _corProps[_local_11], _arg_6);
		}
		_local_10 = _r1.length;
		while (--_local_10 > -1)
		{
			_r1[_local_10] = Math.sqrt(_r1[_local_10]);
			_r2[_local_10] = Math.sqrt(_r2[_local_10]);
		}
		if (!_arg_4)
		{
			_local_10 = _local_9.length;
			while (--_local_10 > -1)
			{
				if (_corProps[_local_11])
				{
					_local_13 = _local_7[_local_9[_local_10]];
					_local_14 = (_local_13.length - 1);
					_local_12 = 0;
					while (_local_12 < _local_14)
					{
						_local_15 = ((_local_13[(_local_12 + 1)].da / _r2[_local_12]) + (_local_13[_local_12].da / _r1[_local_12]));
						_r3[_local_12] = (((_r3[_local_12]) || (0)) + (_local_15 * _local_15));
						_local_12++;
					}
				}
			}
			_local_10 = _r3.length;
			while (--_local_10 > -1)
			{
				_r3[_local_10] = Math.sqrt(_r3[_local_10]);
			}
		}
		_local_10 = _local_9.length;
		_local_12 = ((_arg_3) ? 4 : 1);
		while (--_local_10 > -1)
		{
			_local_11 = _local_9[_local_10];
			_local_13 = _local_7[_local_11];
			_calculateControlPoints(_local_13, _arg_2, _arg_3, _arg_4, _corProps[_local_11]);
			if (_local_16)
			{
				_local_13.splice(0, _local_12);
				_local_13.splice((_local_13.length - _local_12), _local_12);
			}
		}
		return (_local_7);
	}

	private static function _addCubicLengths(_arg_1:Array, _arg_2:Array, _arg_3:uint = 6):void
	{
		var _local_6:Number;
		var _local_7:Number;
		var _local_8:Number;
		var _local_9:Number;
		var _local_10:Number;
		var _local_11:Number;
		var _local_12:Number;
		var _local_13:int;
		var _local_14:Number;
		var _local_15:Segment;
		var _local_16:int;
		var _local_4:Number = (1 / _arg_3);
		var _local_5:int = _arg_1.length;
		while (--_local_5 > -1)
		{
			_local_15 = _arg_1[_local_5];
			_local_8 = _local_15.a;
			_local_9 = (_local_15.d - _local_8);
			_local_10 = (_local_15.c - _local_8);
			_local_11 = (_local_15.b - _local_8);
			_local_6 = (_local_7 = 0);
			_local_13 = 1;
			while (_local_13 <= _arg_3)
			{
				_local_12 = (_local_4 * _local_13);
				_local_14 = (1 - _local_12);
				_local_6 = (_local_7 - (_local_7 = ((((_local_12 * _local_12) * _local_9) + ((3 * _local_14) * ((_local_12 * _local_10) + (_local_14 * _local_11)))) * _local_12)));
				_local_16 = (((_local_5 * _arg_3) + _local_13) - 1);
				_arg_2[_local_16] = (((_arg_2[_local_16]) || (0)) + (_local_6 * _local_6));
				_local_13++;
			}
		}
	}

	protected static function _parseAnchors(_arg_1:Array, _arg_2:String, _arg_3:Boolean, _arg_4:Object):Array
	{
		var _local_6:int;
		var _local_7:int;
		var _local_8:Number;
		var _local_9:Number;
		var _local_10:Number;
		var _local_11:Object;
		var _local_5:Array = [];
		if (_arg_4)
		{
			_arg_1 = [_arg_4].concat(_arg_1);
			_local_7 = _arg_1.length;
			while (--_local_7 > -1)
			{
				if (typeof(_local_11 = _arg_1[_local_7][_arg_2]) === "string")
				{
					if (_local_11.charAt(1) === "=")
					{
						_arg_1[_local_7][_arg_2] = (_arg_4[_arg_2] + Number((_local_11.charAt(0) + _local_11.substr(2))));
					}
				}
			}
		}
		_local_6 = (_arg_1.length - 2);
		if (_local_6 < 0)
		{
			_local_5[0] = new Segment(_arg_1[0][_arg_2], 0, 0, _arg_1[((_local_6 < -1) ? 0 : 1)][_arg_2]);
			return (_local_5);
		}
		_local_7 = 0;
		while (_local_7 < _local_6)
		{
			_local_8 = _arg_1[_local_7][_arg_2];
			_local_9 = _arg_1[(_local_7 + 1)][_arg_2];
			_local_5[_local_7] = new Segment(_local_8, 0, 0, _local_9);
			if (_arg_3)
			{
				_local_10 = _arg_1[(_local_7 + 2)][_arg_2];
				_r1[_local_7] = (((_r1[_local_7]) || (0)) + ((_local_9 - _local_8) * (_local_9 - _local_8)));
				_r2[_local_7] = (((_r2[_local_7]) || (0)) + ((_local_10 - _local_9) * (_local_10 - _local_9)));
			}
			_local_7++;
		}
		_local_5[_local_7] = new Segment(_arg_1[_local_7][_arg_2], 0, 0, _arg_1[(_local_7 + 1)][_arg_2]);
		return (_local_5);
	}

	public static function cubicToQuadratic(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Array
	{
		var _local_5:Object = {"a": _arg_1};
		var _local_6:Object = {};
		var _local_7:Object = {};
		var _local_8:Object = {"c": _arg_4};
		var _local_9:Number = ((_arg_1 + _arg_2) / 2);
		var _local_10:Number = ((_arg_2 + _arg_3) / 2);
		var _local_11:Number = ((_arg_3 + _arg_4) / 2);
		var _local_12:Number = ((_local_9 + _local_10) / 2);
		var _local_13:Number = ((_local_10 + _local_11) / 2);
		var _local_14:Number = ((_local_13 - _local_12) / 8);
		_local_5.b = (_local_9 + ((_arg_1 - _local_9) / 4));
		_local_6.b = (_local_12 + _local_14);
		_local_5.c = (_local_6.a = ((_local_5.b + _local_6.b) / 2));
		_local_6.c = (_local_7.a = ((_local_12 + _local_13) / 2));
		_local_7.b = (_local_13 - _local_14);
		_local_8.b = (_local_11 + ((_arg_4 - _local_11) / 4));
		_local_7.c = (_local_8.a = ((_local_7.b + _local_8.b) / 2));
		return ([_local_5, _local_6, _local_7, _local_8]);
	}

	public static function quadraticToCubic(_arg_1:Number, _arg_2:Number, _arg_3:Number):Object
	{
		return (new Segment(_arg_1, (((2 * _arg_2) + _arg_1) / 3), (((2 * _arg_2) + _arg_3) / 3), _arg_3));
	}

	protected static function _calculateControlPoints(_arg_1:Array, _arg_2:Number = 1, _arg_3:Boolean = false, _arg_4:Boolean = false, _arg_5:Boolean = false):void
	{
		var _local_9:int;
		var _local_10:Number;
		var _local_11:Number;
		var _local_12:Number;
		var _local_13:Segment;
		var _local_14:Number;
		var _local_15:Number;
		var _local_16:Number;
		var _local_17:Number;
		var _local_18:Array;
		var _local_19:Number;
		var _local_20:Number;
		var _local_21:Number;
		var _local_6:int = (_arg_1.length - 1);
		var _local_7:int;
		var _local_8:Number = _arg_1[0].a;
		_local_9 = 0;
		while (_local_9 < _local_6)
		{
			_local_13 = _arg_1[_local_7];
			_local_10 = _local_13.a;
			_local_11 = _local_13.d;
			_local_12 = _arg_1[(_local_7 + 1)].d;
			if (_arg_5)
			{
				_local_19 = _r1[_local_9];
				_local_20 = _r2[_local_9];
				_local_21 = ((((_local_20 + _local_19) * _arg_2) * 0.25) / ((_arg_4) ? 0.5 : ((_r3[_local_9]) || (0.5))));
				_local_14 = (_local_11 - ((_local_11 - _local_10) * ((_arg_4) ? (_arg_2 * 0.5) : ((_local_19 !== 0) ? (_local_21 / _local_19) : 0))));
				_local_15 = (_local_11 + ((_local_12 - _local_11) * ((_arg_4) ? (_arg_2 * 0.5) : ((_local_20 !== 0) ? (_local_21 / _local_20) : 0))));
				_local_16 = (_local_11 - (_local_14 + ((((_local_15 - _local_14) * (((_local_19 * 3) / (_local_19 + _local_20)) + 0.5)) / 4) || (0))));
			}
			else
			{
				_local_14 = (_local_11 - (((_local_11 - _local_10) * _arg_2) * 0.5));
				_local_15 = (_local_11 + (((_local_12 - _local_11) * _arg_2) * 0.5));
				_local_16 = (_local_11 - ((_local_14 + _local_15) / 2));
			}
			_local_14 = (_local_14 + _local_16);
			_local_15 = (_local_15 + _local_16);
			_local_13.c = (_local_17 = _local_14);
			if (_local_9 != 0)
			{
				_local_13.b = _local_8;
			}
			else
			{
				_local_13.b = (_local_8 = (_local_13.a + ((_local_13.c - _local_13.a) * 0.6)));
			}
			_local_13.da = (_local_11 - _local_10);
			_local_13.ca = (_local_17 - _local_10);
			_local_13.ba = (_local_8 - _local_10);
			if (_arg_3)
			{
				_local_18 = cubicToQuadratic(_local_10, _local_8, _local_17, _local_11);
				_arg_1.splice(_local_7, 1, _local_18[0], _local_18[1], _local_18[2], _local_18[3]);
				_local_7 = (_local_7 + 4);
			}
			else
			{
				_local_7++;
			}
			_local_8 = _local_15;
			_local_9++;
		}
		_local_13 = _arg_1[_local_7];
		_local_13.b = _local_8;
		_local_13.c = (_local_8 + ((_local_13.d - _local_8) * 0.4));
		_local_13.da = (_local_13.d - _local_13.a);
		_local_13.ca = (_local_13.c - _local_13.a);
		_local_13.ba = (_local_8 - _local_13.a);
		if (_arg_3)
		{
			_local_18 = cubicToQuadratic(_local_13.a, _local_8, _local_13.c, _local_13.d);
			_arg_1.splice(_local_7, 1, _local_18[0], _local_18[1], _local_18[2], _local_18[3]);
		}
	}

	public static function _parseBezierData(_arg_1:Array, _arg_2:String, _arg_3:Object = null):Object
	{
		var _local_7:Number;
		var _local_8:Number;
		var _local_9:Number;
		var _local_10:Number;
		var _local_11:Array;
		var _local_12:Array;
		var _local_13:int;
		var _local_14:int;
		var _local_15:int;
		var _local_16:String;
		var _local_17:int;
		var _local_18:Object;
		_arg_2 = ((_arg_2) || ("soft"));
		var _local_4:Object = {};
		var _local_5:int = ((_arg_2 === "cubic") ? 3 : 2);
		var _local_6:* = (_arg_2 === "soft");
		if (((_local_6) && (_arg_3)))
		{
			_arg_1 = [_arg_3].concat(_arg_1);
		}
		if (((_arg_1 == null) || (_arg_1.length < (_local_5 + 1))))
		{
			throw (new Error("invalid Bezier data"));
		}
		if ((_arg_1[1] is Point))
		{
			_local_12 = ["x", "y"];
		}
		else
		{
			_local_12 = [];
			for (_local_16 in _arg_1[0])
			{
				_local_12.push(_local_16);
			}
		}
		_local_13 = _local_12.length;
		while (--_local_13 > -1)
		{
			_local_16 = _local_12[_local_13];
			_local_4[_local_16] = (_local_11 = []);
			_local_17 = 0;
			_local_15 = _arg_1.length;
			_local_14 = 0;
			while (_local_14 < _local_15)
			{
				_local_7 = ((_arg_3 == null) ? _arg_1[_local_14][_local_16] : (((typeof(_local_18 = _arg_1[_local_14][_local_16]) === "string") && (_local_18.charAt(1) === "=")) ? (_arg_3[_local_16] + Number((_local_18.charAt(0) + _local_18.substr(2)))) : Number(_local_18)));
				if (_local_6)
				{
					if (_local_14 > 1)
					{
						if (_local_14 < (_local_15 - 1))
						{
							var _local_19:* = _local_17++;
							_local_11[_local_19] = ((_local_7 + _local_11[(_local_17 - 2)]) / 2);
						}
					}
				}
				_local_19 = _local_17++;
				_local_11[_local_19] = _local_7;
				_local_14++;
			}
			_local_15 = ((_local_17 - _local_5) + 1);
			_local_17 = 0;
			_local_14 = 0;
			while (_local_14 < _local_15)
			{
				_local_7 = _local_11[_local_14];
				_local_8 = _local_11[(_local_14 + 1)];
				_local_9 = _local_11[(_local_14 + 2)];
				_local_10 = ((_local_5 === 2) ? 0 : _local_11[(_local_14 + 3)]);
				_local_19 = _local_17++;
				_local_11[_local_19] = ((_local_5 === 3) ? new Segment(_local_7, _local_8, _local_9, _local_10) : new Segment(_local_7, (((2 * _local_8) + _local_7) / 3), (((2 * _local_8) + _local_9) / 3), _local_9));
				_local_14 = (_local_14 + _local_5);
			}
			_local_11.length = _local_17;
		}
		return (_local_4);
	}


	override public function _kill(_arg_1:Object):Boolean
	{
		var _local_3:String;
		var _local_4:int;
		var _local_2:Array = this._props;
		for (_local_3 in _beziers)
		{
			if ((_local_3 in _arg_1))
			{
				delete _beziers[_local_3];
				delete _func[_local_3];
				_local_4 = _local_2.length;
				while (--_local_4 > -1)
				{
					if (_local_2[_local_4] === _local_3)
					{
						_local_2.splice(_local_4, 1);
					}
				}
			}
		}
		return (super._kill(_arg_1));
	}

	override public function setRatio(_arg_1:Number):void
	{
		var _local_6:int;
		var _local_7:Number;
		var _local_8:int;
		var _local_9:String;
		var _local_10:Segment;
		var _local_11:Number;
		var _local_12:Number;
		var _local_13:int;
		var _local_14:Array;
		var _local_15:Array;
		var _local_16:Array;
		var _local_17:Segment;
		var _local_18:Number;
		var _local_19:Number;
		var _local_20:Number;
		var _local_21:Number;
		var _local_22:Number;
		var _local_23:Number;
		var _local_2:int = this._segCount;
		var _local_3:Object = this._func;
		var _local_4:Object = this._target;
		var _local_5:* = (!(_arg_1 === this._startRatio));
		if (this._timeRes == 0)
		{
			_local_6 = ((_arg_1 < 0) ? 0 : ((_arg_1 >= 1) ? (_local_2 - 1) : ((_local_2 * _arg_1) >> 0)));
			_local_11 = ((_arg_1 - (_local_6 * (1 / _local_2))) * _local_2);
		}
		else
		{
			_local_14 = this._lengths;
			_local_15 = this._curSeg;
			_arg_1 = (_arg_1 * this._length);
			_local_8 = this._li;
			if (((_arg_1 > this._l2) && (_local_8 < (_local_2 - 1))))
			{
				_local_13 = (_local_2 - 1);
				do
				{
				} while (((_local_8 < _local_13) && ((this._l2 = _local_14[++_local_8]) <= _arg_1)));
				this._l1 = _local_14[(_local_8 - 1)];
				this._li = _local_8;
				this._curSeg = (_local_15 = this._segments[_local_8]);
				this._s2 = _local_15[(this._s1 = (this._si = 0))];
			}
			else
			{
				if (((_arg_1 < this._l1) && (_local_8 > 0)))
				{
					do
					{
					} while (((_local_8 > 0) && ((this._l1 = _local_14[--_local_8]) >= _arg_1)));
					if (((_local_8 === 0) && (_arg_1 < this._l1)))
					{
						this._l1 = 0;
					}
					else
					{
						_local_8++;
					}
					this._l2 = _local_14[_local_8];
					this._li = _local_8;
					this._curSeg = (_local_15 = this._segments[_local_8]);
					this._s1 = ((_local_15[((this._si = (_local_15.length - 1)) - 1)]) || (0));
					this._s2 = _local_15[this._si];
				}
			}
			_local_6 = _local_8;
			_arg_1 = (_arg_1 - this._l1);
			_local_8 = this._si;
			if (((_arg_1 > this._s2) && (_local_8 < (_local_15.length - 1))))
			{
				_local_13 = (_local_15.length - 1);
				do
				{
				} while (((_local_8 < _local_13) && ((this._s2 = _local_15[++_local_8]) <= _arg_1)));
				this._s1 = _local_15[(_local_8 - 1)];
				this._si = _local_8;
			}
			else
			{
				if (((_arg_1 < this._s1) && (_local_8 > 0)))
				{
					do
					{
					} while (((_local_8 > 0) && ((this._s1 = _local_15[--_local_8]) >= _arg_1)));
					if (((_local_8 === 0) && (_arg_1 < this._s1)))
					{
						this._s1 = 0;
					}
					else
					{
						_local_8++;
					}
					this._s2 = _local_15[_local_8];
					this._si = _local_8;
				}
			}
			_local_11 = ((_local_8 + ((_arg_1 - this._s1) / (this._s2 - this._s1))) * this._prec);
		}
		_local_7 = (1 - _local_11);
		_local_8 = this._props.length;
		while (--_local_8 > -1)
		{
			_local_9 = this._props[_local_8];
			_local_10 = this._beziers[_local_9][_local_6];
			_local_12 = (((((_local_11 * _local_11) * _local_10.da) + ((3 * _local_7) * ((_local_11 * _local_10.ca) + (_local_7 * _local_10.ba)))) * _local_11) + _local_10.a);
			if (this._round[_local_9])
			{
				_local_12 = ((_local_12 + ((_local_12 > 0) ? 0.5 : -0.5)) >> 0);
			}
			if (_local_3[_local_9])
			{
				var _local_24:* = _local_4;
				(_local_24[_local_9](_local_12));
			}
			else
			{
				_local_4[_local_9] = _local_12;
			}
		}
		if (this._autoRotate != null)
		{
			_local_16 = this._autoRotate;
			_local_8 = _local_16.length;
			while (--_local_8 > -1)
			{
				_local_9 = _local_16[_local_8][2];
				_local_22 = ((_local_16[_local_8][3]) || (0));
				_local_23 = ((_local_16[_local_8][4] == true) ? 1 : _RAD2DEG);
				_local_10 = this._beziers[_local_16[_local_8][0]][_local_6];
				_local_17 = this._beziers[_local_16[_local_8][1]][_local_6];
				_local_18 = (_local_10.a + ((_local_10.b - _local_10.a) * _local_11));
				_local_20 = (_local_10.b + ((_local_10.c - _local_10.b) * _local_11));
				_local_18 = (_local_18 + ((_local_20 - _local_18) * _local_11));
				_local_20 = (_local_20 + (((_local_10.c + ((_local_10.d - _local_10.c) * _local_11)) - _local_20) * _local_11));
				_local_19 = (_local_17.a + ((_local_17.b - _local_17.a) * _local_11));
				_local_21 = (_local_17.b + ((_local_17.c - _local_17.b) * _local_11));
				_local_19 = (_local_19 + ((_local_21 - _local_19) * _local_11));
				_local_21 = (_local_21 + (((_local_17.c + ((_local_17.d - _local_17.c) * _local_11)) - _local_21) * _local_11));
				_local_12 = ((_local_5) ? ((Math.atan2((_local_21 - _local_19), (_local_20 - _local_18)) * _local_23) + _local_22) : this._initialRotations[_local_8]);
				if (_local_3[_local_9])
				{
					_local_24 = _local_4;
					(_local_24[_local_9](_local_12));
				}
				else
				{
					_local_4[_local_9] = _local_12;
				}
			}
		}
	}

	override public function _onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
	{
		var _local_9:String;
		var _local_10:Boolean;
		var _local_11:int;
		var _local_12:int;
		var _local_13:Array;
		var _local_14:Object;
		var _local_15:Object;
		this._target = _arg_1;
		var _local_4:Object = ((_arg_2 is Array) ? {"values": _arg_2} : _arg_2);
		this._props = [];
		this._timeRes = ((_local_4.timeResolution == null) ? 6 : int(_local_4.timeResolution));
		var _local_5:Array = ((_local_4.values) || ([]));
		var _local_6:Object = {};
		var _local_7:Object = _local_5[0];
		var _local_8:Object = ((_local_4.autoRotate) || (_arg_3.vars.orientToBezier));
		this._autoRotate = ((_local_8) ? ((_local_8 is Array) ? (_local_8 as Array) : [["x", "y", "rotation", ((_local_8 === true) ? 0 : Number(_local_8))]]) : null);
		if ((_local_7 is Point))
		{
			this._props = ["x", "y"];
		}
		else
		{
			for (_local_9 in _local_7)
			{
				this._props.push(_local_9);
			}
		}
		_local_11 = this._props.length;
		while (--_local_11 > -1)
		{
			_local_9 = this._props[_local_11];
			this._overwriteProps.push(_local_9);
			_local_10 = (this._func[_local_9] = (_arg_1[_local_9] is Function));
			_local_6[_local_9] = ((_local_10) ? _arg_1[(((_local_9.indexOf("set")) || (!(("get" + _local_9.substr(3)) in _arg_1))) ? _local_9 : ("get" + _local_9.substr(3)))]() : _arg_1[_local_9]);
			if (!_local_14)
			{
				if (_local_6[_local_9] !== _local_5[0][_local_9])
				{
					_local_14 = _local_6;
				}
			}
		}
		this._beziers = ((((!(_local_4.type === "cubic")) && (!(_local_4.type === "quadratic"))) && (!(_local_4.type === "soft"))) ? bezierThrough(_local_5, ((isNaN(_local_4.curviness)) ? 1 : _local_4.curviness), false, (_local_4.type === "thruBasic"), ((_local_4.correlate) || ("x,y,z")), _local_14) : _parseBezierData(_local_5, _local_4.type, _local_6));
		this._segCount = this._beziers[_local_9].length;
		if (this._timeRes)
		{
			_local_15 = _parseLengthData(this._beziers, this._timeRes);
			this._length = _local_15.length;
			this._lengths = _local_15.lengths;
			this._segments = _local_15.segments;
			this._l1 = (this._li = (this._s1 = (this._si = 0)));
			this._l2 = this._lengths[0];
			this._curSeg = this._segments[0];
			this._s2 = this._curSeg[0];
			this._prec = (1 / this._curSeg.length);
		}
		if ((_local_13 == this._autoRotate))
		{
			this._initialRotations = [];
			if (!(_local_13[0] is Array))
			{
				this._autoRotate = (_local_13 = [_local_13]);
			}
			_local_11 = _local_13.length;
			while (--_local_11 > -1)
			{
				_local_12 = 0;
				while (_local_12 < 3)
				{
					_local_9 = _local_13[_local_11][_local_12];
					this._func[_local_9] = ((_arg_1[_local_9] is Function) ? _arg_1[(((_local_9.indexOf("set")) || (!(("get" + _local_9.substr(3)) in _arg_1))) ? _local_9 : ("get" + _local_9.substr(3)))] : false);
					_local_12++;
				}
				_local_9 = _local_13[_local_11][2];
				this._initialRotations[_local_11] = ((this._func[_local_9]) ? this._func[_local_9]() : this._target[_local_9]);
			}
		}
		_startRatio = ((_arg_3.vars.runBackwards) ? 1 : 0);
		return (true);
	}

	override public function _roundProps(_arg_1:Object, _arg_2:Boolean = true):void
	{
		var _local_3:Array = this._overwriteProps;
		var _local_4:int = _local_3.length;
		while (--_local_4 > -1)
		{
			if ((((_local_3[_local_4] in _arg_1) || ("bezier" in _arg_1)) || ("bezierThrough" in _arg_1)))
			{
				this._round[_local_3[_local_4]] = _arg_2;
			}
		}
	}


}
}//package com.greensock.plugins

class Segment
{

	public var a:Number;
	public var c:Number;
	public var b:Number;
	public var d:Number;
	public var da:Number;
	public var ca:Number;
	public var ba:Number;

	public function Segment(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number)
	{
		this.a = _arg_1;
		this.b = _arg_2;
		this.c = _arg_3;
		this.d = _arg_4;
		this.da = (_arg_4 - _arg_1);
		this.ca = (_arg_3 - _arg_1);
		this.ba = (_arg_2 - _arg_1);
	}

}


