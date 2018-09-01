//com.greensock.plugins.TransformAroundPointPlugin

package com.greensock.plugins
{
import com.greensock.TweenLite;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.getDefinitionByName;

public class TransformAroundPointPlugin extends TweenPlugin
{

	public static const API:Number = 2;
	private static var _classInitted:Boolean;
	private static var _isFlex:Boolean;

	protected var _yRound:Boolean;
	protected var _useAddElement:Boolean;
	protected var _local:Point;
	protected var _proxy:DisplayObject;
	protected var _target:DisplayObject;
	protected var _point:Point;
	protected var _xRound:Boolean;
	protected var _pointIsLocal:Boolean;
	protected var _proxySizeData:Object;
	protected var _shortRotation:ShortRotationPlugin;

	public function TransformAroundPointPlugin()
	{
		super("transformAroundPoint,transformAroundCenter,x,y", -1);
	}

	private static function _applyMatrix(_arg_1:Point, _arg_2:Matrix):Point
	{
		var _local_5:Number;
		var _local_3:Number = (((_arg_1.x * _arg_2.a) + (_arg_1.y * _arg_2.c)) + _arg_2.tx);
		var _local_4:Number = (((_arg_1.x * _arg_2.b) + (_arg_1.y * _arg_2.d)) + _arg_2.ty);
		_local_3 = ((_local_5 = (_local_3 - (_local_3 = (_local_3 | 0x00)))) ? (((_local_5 < 0.3) ? 0 : ((_local_5 < 0.7) ? 0.5 : 1)) + _local_3) : _local_3);
		_local_4 = ((_local_5 = (_local_4 - (_local_4 = (_local_4 | 0x00)))) ? (((_local_5 < 0.3) ? 0 : ((_local_5 < 0.7) ? 0.5 : 1)) + _local_4) : _local_4);
		return (new Point(_local_3, _local_4));
	}


	override public function _kill(_arg_1:Object):Boolean
	{
		if (_shortRotation != null)
		{
			_shortRotation._kill(_arg_1);
			if (_shortRotation._overwriteProps.length == 0)
			{
				_arg_1.shortRotation = true;
			}
		}
		return (super._kill(_arg_1));
	}

	override public function setRatio(_arg_1:Number):void
	{
		var _local_2:Point;
		var _local_3:Matrix;
		var _local_4:Number;
		var _local_5:Number;
		var _local_6:Number;
		var _local_7:Number;
		if (((!(_proxy == null)) && (!(_proxy.parent == null))))
		{
			if (_useAddElement)
			{
				Object(_proxy.parent).addElement(_target.parent);
			}
			else
			{
				_proxy.parent.addChild(_target.parent);
			}
		}
		if (_pointIsLocal)
		{
			_local_2 = _applyMatrix(_local, _target.transform.matrix);
			if (((Math.abs((_local_2.x - _point.x)) > 0.5) || (Math.abs((_local_2.y - _point.y)) > 0.5)))
			{
				_point = _local_2;
			}
		}
		super.setRatio(_arg_1);
		_local_3 = _target.transform.matrix;
		_local_4 = (((_local.x * _local_3.a) + (_local.y * _local_3.c)) + _local_3.tx);
		_local_5 = (((_local.x * _local_3.b) + (_local.y * _local_3.d)) + _local_3.ty);
		_target.x = ((_xRound) ? (((_local_6 = ((_target.x + _point.x) - _local_4)) > 0) ? ((_local_6 + 0.5) >> 0) : ((_local_6 - 0.5) >> 0)) : ((_target.x + _point.x) - _local_4));
		_target.y = ((_yRound) ? (((_local_6 = ((_target.y + _point.y) - _local_5)) > 0) ? ((_local_6 + 0.5) >> 0) : ((_local_6 - 0.5) >> 0)) : ((_target.y + _point.y) - _local_5));
		if (_proxy != null)
		{
			_local_7 = _target.rotation;
			_proxy.rotation = (_target.rotation = 0);
			if (_proxySizeData.width != null)
			{
				_proxy.width = (_target.width = _proxySizeData.width);
			}
			if (_proxySizeData.height != null)
			{
				_proxy.height = (_target.height = _proxySizeData.height);
			}
			_proxy.rotation = (_target.rotation = _local_7);
			_local_3 = _target.transform.matrix;
			_local_4 = (((_local.x * _local_3.a) + (_local.y * _local_3.c)) + _local_3.tx);
			_local_5 = (((_local.x * _local_3.b) + (_local.y * _local_3.d)) + _local_3.ty);
			_proxy.x = ((_xRound) ? (((_local_6 = ((_target.x + _point.x) - _local_4)) > 0) ? ((_local_6 + 0.5) >> 0) : ((_local_6 - 0.5) >> 0)) : ((_target.x + _point.x) - _local_4));
			_proxy.y = ((_yRound) ? (((_local_6 = ((_target.y + _point.y) - _local_5)) > 0) ? ((_local_6 + 0.5) >> 0) : ((_local_6 - 0.5) >> 0)) : ((_target.y + _point.y) - _local_5));
			if (_proxy.parent != null)
			{
				if (_useAddElement)
				{
					Object(_proxy.parent).removeElement(_target.parent);
				}
				else
				{
					_proxy.parent.removeChild(_target.parent);
				}
			}
		}
	}

	override public function _roundProps(_arg_1:Object, _arg_2:Boolean = true):void
	{
		if (("transformAroundPoint" in _arg_1))
		{
			_xRound = (_yRound = _arg_2);
		}
		else
		{
			if (("x" in _arg_1))
			{
				_xRound = _arg_2;
			}
			else
			{
				if (("y" in _arg_1))
				{
					_yRound = _arg_2;
				}
			}
		}
	}

	override public function _onInitTween(target:Object, value:*, tween:TweenLite):Boolean
	{
		var matrixCopy:Matrix;
		var p:String;
		var short:ShortRotationPlugin;
		var sp:String;
		var point:Point;
		var b:Rectangle;
		var s:Sprite;
		var container:Sprite;
		var enumerables:Object;
		var endX:Number;
		var endY:Number;
		if (!(value.point is Point))
		{
			return (false);
		}
		_target = (target as DisplayObject);
		var m:Matrix = _target.transform.matrix;
		if (value.pointIsLocal == true)
		{
			_pointIsLocal = true;
			_local = value.point.clone();
			_point = _applyMatrix(_local, m);
		}
		else
		{
			_point = value.point.clone();
			matrixCopy = m.clone();
			matrixCopy.invert();
			_local = _applyMatrix(_point, matrixCopy);
		}
		if (!_classInitted)
		{
			try
			{
				_isFlex = Boolean(getDefinitionByName("mx.managers.SystemManager"));
			}
			catch (e:Error)
			{
				_isFlex = false;
			}
			_classInitted = true;
		}
		if ((((!(isNaN(value.width))) || (!(isNaN(value.height)))) && (!(_target.parent == null))))
		{
			point = _target.parent.globalToLocal(_target.localToGlobal(new Point(100, 100)));
			_target.width = (_target.width * 2);
			if (point.x == _target.parent.globalToLocal(_target.localToGlobal(new Point(100, 100))).x)
			{
				_proxy = _target;
				_target.rotation = 0;
				_proxySizeData = {};
				if (!isNaN(value.width))
				{
					_addTween(_proxySizeData, "width", (_target.width / 2), value.width, "width");
				}
				if (!isNaN(value.height))
				{
					_addTween(_proxySizeData, "height", _target.height, value.height, "height");
				}
				b = _target.getBounds(_target);
				s = new Sprite();
				container = ((_isFlex) ? new (getDefinitionByName("mx.core.UIComponent"))() : new Sprite());
				container.addChild(s);
				container.visible = false;
				_useAddElement = Boolean(((_isFlex) && (_proxy.parent.hasOwnProperty("addElement"))));
				if (_useAddElement)
				{
					Object(_proxy.parent).addElement(container);
				}
				else
				{
					_proxy.parent.addChild(container);
				}
				_target = s;
				s.graphics.beginFill(0xFF, 0.4);
				s.graphics.drawRect(b.x, b.y, b.width, b.height);
				s.graphics.endFill();
				_proxy.width = (_proxy.width / 2);
				s.transform.matrix = (_target.transform.matrix = m);
			}
			else
			{
				_target.width = (_target.width / 2);
				_target.transform.matrix = m;
			}
		}
		for (p in value)
		{
			if (!((p == "point") || (p == "pointIsLocal")))
			{
				if (p == "shortRotation")
				{
					_shortRotation = new ShortRotationPlugin();
					_shortRotation._onInitTween(_target, value[p], tween);
					_addTween(_shortRotation, "setRatio", 0, 1, "shortRotation");
					for (sp in value[p])
					{
						_overwriteProps[_overwriteProps.length] = sp;
					}
				}
				else
				{
					if (((p == "x") || (p == "y")))
					{
						_addTween(_point, p, _point[p], value[p], p);
					}
					else
					{
						if (p == "scale")
						{
							_addTween(_target, "scaleX", _target.scaleX, value.scale, "scaleX");
							_addTween(_target, "scaleY", _target.scaleY, value.scale, "scaleY");
							_overwriteProps[_overwriteProps.length] = "scaleX";
							_overwriteProps[_overwriteProps.length] = "scaleY";
						}
						else
						{
							if (!(((p == "width") || (p == "height")) && (!(_proxy == null))))
							{
								_addTween(_target, p, _target[p], value[p], p);
								_overwriteProps[_overwriteProps.length] = p;
							}
						}
					}
				}
			}
		}
		if (tween != null)
		{
			enumerables = tween.vars;
			if ((("x" in enumerables) || ("y" in enumerables)))
			{
				if (("x" in enumerables))
				{
					endX = ((typeof(enumerables.x) == "number") ? enumerables.x : (_target.x + Number(enumerables.x.split("=").join(""))));
				}
				if (("y" in enumerables))
				{
					endY = ((typeof(enumerables.y) == "number") ? enumerables.y : (_target.y + Number(enumerables.y.split("=").join(""))));
				}
				tween._kill({
					"x": true, "y": true, "_tempKill": true
				}, _target);
				this.setRatio(1);
				if (!isNaN(endX))
				{
					_addTween(_point, "x", _point.x, (_point.x + (endX - _target.x)), "x");
				}
				if (!isNaN(endY))
				{
					_addTween(_point, "y", _point.y, (_point.y + (endY - _target.y)), "y");
				}
				this.setRatio(0);
			}
		}
		return (true);
	}


}
}//package com.greensock.plugins

