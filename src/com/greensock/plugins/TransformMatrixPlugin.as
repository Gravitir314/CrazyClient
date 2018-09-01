//com.greensock.plugins.TransformMatrixPlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;

import flash.geom.Matrix;
import flash.geom.Transform;

public class TransformMatrixPlugin extends TweenPlugin
{

	public static const API:Number = 2;
	private static const _DEG2RAD:Number = (Math.PI / 180);//0.0174532925199433

	protected var _dChange:Number;
	protected var _txStart:Number;
	protected var _cStart:Number;
	protected var _matrix:Matrix;
	protected var _tyStart:Number;
	protected var _aStart:Number;
	protected var _angleChange:Number = 0;
	protected var _transform:Transform;
	protected var _aChange:Number;
	protected var _bChange:Number;
	protected var _tyChange:Number;
	protected var _txChange:Number;
	protected var _cChange:Number;
	protected var _dStart:Number;
	protected var _bStart:Number;

	public function TransformMatrixPlugin()
	{
		super("transformMatrix,x,y,scaleX,scaleY,rotation,width,height,transformAroundPoint,transformAroundCenter");
	}

	override public function setRatio(_arg_1:Number):void
	{
		var _local_2:Number;
		var _local_3:Number;
		var _local_4:Number;
		var _local_5:Number;
		_matrix.a = (_aStart + (_arg_1 * _aChange));
		_matrix.b = (_bStart + (_arg_1 * _bChange));
		_matrix.c = (_cStart + (_arg_1 * _cChange));
		_matrix.d = (_dStart + (_arg_1 * _dChange));
		if (_angleChange)
		{
			_local_2 = Math.cos((_angleChange * _arg_1));
			_local_3 = Math.sin((_angleChange * _arg_1));
			_local_4 = _matrix.a;
			_local_5 = _matrix.c;
			_matrix.a = ((_local_4 * _local_2) - (_matrix.b * _local_3));
			_matrix.b = ((_local_4 * _local_3) + (_matrix.b * _local_2));
			_matrix.c = ((_local_5 * _local_2) - (_matrix.d * _local_3));
			_matrix.d = ((_local_5 * _local_3) + (_matrix.d * _local_2));
		}
		_matrix.tx = (_txStart + (_arg_1 * _txChange));
		_matrix.ty = (_tyStart + (_arg_1 * _tyChange));
		_transform.matrix = _matrix;
	}

	override public function _onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
	{
		var _local_5:Number;
		var _local_6:Number;
		var _local_7:Number;
		var _local_8:Number;
		var _local_9:Number;
		var _local_10:Number;
		var _local_11:Number;
		var _local_12:Number;
		var _local_13:Number;
		var _local_14:Number;
		_transform = (_arg_1.transform as Transform);
		_matrix = _transform.matrix;
		var _local_4:Matrix = _matrix.clone();
		_txStart = _local_4.tx;
		_tyStart = _local_4.ty;
		_aStart = _local_4.a;
		_bStart = _local_4.b;
		_cStart = _local_4.c;
		_dStart = _local_4.d;
		if (("x" in _arg_2))
		{
			_txChange = ((typeof(_arg_2.x) == "number") ? (_arg_2.x - _txStart) : Number(_arg_2.x.split("=").join("")));
		}
		else
		{
			if (("tx" in _arg_2))
			{
				_txChange = (_arg_2.tx - _txStart);
			}
			else
			{
				_txChange = 0;
			}
		}
		if (("y" in _arg_2))
		{
			_tyChange = ((typeof(_arg_2.y) == "number") ? (_arg_2.y - _tyStart) : Number(_arg_2.y.split("=").join("")));
		}
		else
		{
			if (("ty" in _arg_2))
			{
				_tyChange = (_arg_2.ty - _tyStart);
			}
			else
			{
				_tyChange = 0;
			}
		}
		_aChange = (("a" in _arg_2) ? (_arg_2.a - _aStart) : 0);
		_bChange = (("b" in _arg_2) ? (_arg_2.b - _bStart) : 0);
		_cChange = (("c" in _arg_2) ? (_arg_2.c - _cStart) : 0);
		_dChange = (("d" in _arg_2) ? (_arg_2.d - _dStart) : 0);
		if (((((((((("rotation" in _arg_2) || ("shortRotation" in _arg_2)) || (("scale" in _arg_2) && (!(_arg_2 is Matrix)))) || ("scaleX" in _arg_2)) || ("scaleY" in _arg_2)) || ("skewX" in _arg_2)) || ("skewY" in _arg_2)) || ("skewX2" in _arg_2)) || ("skewY2" in _arg_2)))
		{
			_local_7 = Math.sqrt(((_local_4.a * _local_4.a) + (_local_4.b * _local_4.b)));
			if (_local_7 == 0)
			{
				_local_4.a = (_local_7 = 0.0001);
			}
			else
			{
				if (((_local_4.a < 0) && (_local_4.d > 0)))
				{
					_local_7 = -(_local_7);
				}
			}
			_local_8 = Math.sqrt(((_local_4.c * _local_4.c) + (_local_4.d * _local_4.d)));
			if (_local_8 == 0)
			{
				_local_4.d = (_local_8 = 0.0001);
			}
			else
			{
				if (((_local_4.d < 0) && (_local_4.a > 0)))
				{
					_local_8 = -(_local_8);
				}
			}
			_local_9 = Math.atan2(_local_4.b, _local_4.a);
			if (((_local_4.a < 0) && (_local_4.d >= 0)))
			{
				_local_9 = (_local_9 + ((_local_9 <= 0) ? Math.PI : -(Math.PI)));
			}
			_local_10 = (Math.atan2(-(_matrix.c), _matrix.d) - _local_9);
			_local_11 = _local_9;
			if (("shortRotation" in _arg_2))
			{
				_local_13 = (((_arg_2.shortRotation * _DEG2RAD) - _local_9) % (Math.PI * 2));
				if (_local_13 > Math.PI)
				{
					_local_13 = (_local_13 - (Math.PI * 2));
				}
				else
				{
					if (_local_13 < -(Math.PI))
					{
						_local_13 = (_local_13 + (Math.PI * 2));
					}
				}
				_local_11 = (_local_11 + _local_13);
			}
			else
			{
				if (("rotation" in _arg_2))
				{
					_local_11 = ((typeof(_arg_2.rotation) == "number") ? (_arg_2.rotation * _DEG2RAD) : ((Number(_arg_2.rotation.split("=").join("")) * _DEG2RAD) + _local_9));
				}
			}
			_local_12 = (("skewX" in _arg_2) ? ((typeof(_arg_2.skewX) == "number") ? (Number(_arg_2.skewX) * _DEG2RAD) : ((Number(_arg_2.skewX.split("=").join("")) * _DEG2RAD) + _local_10)) : 0);
			if (("skewY" in _arg_2))
			{
				_local_14 = ((typeof(_arg_2.skewY) == "number") ? (_arg_2.skewY * _DEG2RAD) : ((Number(_arg_2.skewY.split("=").join("")) * _DEG2RAD) - _local_10));
				_local_11 = (_local_11 + (_local_14 + _local_10));
				_local_12 = (_local_12 - _local_14);
			}
			if (_local_11 != _local_9)
			{
				if ((("rotation" in _arg_2) || ("shortRotation" in _arg_2)))
				{
					_angleChange = (_local_11 - _local_9);
					_local_11 = _local_9;
				}
				else
				{
					_local_4.rotate((_local_11 - _local_9));
				}
			}
			if (("scale" in _arg_2))
			{
				_local_5 = (Number(_arg_2.scale) / _local_7);
				_local_6 = (Number(_arg_2.scale) / _local_8);
				if (typeof(_arg_2.scale) != "number")
				{
					_local_5 = (_local_5 + 1);
					_local_6 = (_local_6 + 1);
				}
			}
			else
			{
				if (("scaleX" in _arg_2))
				{
					_local_5 = (Number(_arg_2.scaleX) / _local_7);
					if (typeof(_arg_2.scaleX) != "number")
					{
						_local_5 = (_local_5 + 1);
					}
				}
				if (("scaleY" in _arg_2))
				{
					_local_6 = (Number(_arg_2.scaleY) / _local_8);
					if (typeof(_arg_2.scaleY) != "number")
					{
						_local_6 = (_local_6 + 1);
					}
				}
			}
			if (_local_12 != _local_10)
			{
				_local_4.c = (-(_local_8) * Math.sin((_local_12 + _local_11)));
				_local_4.d = (_local_8 * Math.cos((_local_12 + _local_11)));
			}
			if (("skewX2" in _arg_2))
			{
				if (typeof(_arg_2.skewX2) == "number")
				{
					_local_4.c = Math.tan((0 - (_arg_2.skewX2 * _DEG2RAD)));
				}
				else
				{
					_local_4.c = (_local_4.c + Math.tan((0 - (Number(_arg_2.skewX2) * _DEG2RAD))));
				}
			}
			if (("skewY2" in _arg_2))
			{
				if (typeof(_arg_2.skewY2) == "number")
				{
					_local_4.b = Math.tan((_arg_2.skewY2 * _DEG2RAD));
				}
				else
				{
					_local_4.b = (_local_4.b + Math.tan((Number(_arg_2.skewY2) * _DEG2RAD)));
				}
			}
			if (((_local_5) || (_local_5 == 0)))
			{
				_local_4.a = (_local_4.a * _local_5);
				_local_4.b = (_local_4.b * _local_5);
			}
			if (((_local_6) || (_local_6 == 0)))
			{
				_local_4.c = (_local_4.c * _local_6);
				_local_4.d = (_local_4.d * _local_6);
			}
			_aChange = (_local_4.a - _aStart);
			_bChange = (_local_4.b - _bStart);
			_cChange = (_local_4.c - _cStart);
			_dChange = (_local_4.d - _dStart);
		}
		return (true);
	}


}
}//package com.greensock.plugins

