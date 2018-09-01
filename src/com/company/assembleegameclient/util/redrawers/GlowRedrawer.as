﻿//com.company.assembleegameclient.util.redrawers.GlowRedrawer

package com.company.assembleegameclient.util.redrawers
{
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.PointUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.GradientType;
import flash.display.Shape;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import flash.utils.Dictionary;

public class GlowRedrawer
{

	private static const GRADIENT_MAX_SUB:uint = 0x282828;
	private static const GLOW_FILTER:GlowFilter = new GlowFilter(0, 0.3, 12, 12, 2, BitmapFilterQuality.LOW, false, false);
	private static const GLOW_FILTER_ALT:GlowFilter = new GlowFilter(0, 0.5, 16, 16, 3, BitmapFilterQuality.LOW, false, false);
	private static var tempMatrix_:Matrix = new Matrix();
	private static var gradient_:Shape = getGradient();
	private static var glowHashes:Dictionary = new Dictionary();


	public static function outlineGlow(_arg_1:BitmapData, _arg_2:uint, _arg_3:Number = 1.4, _arg_4:Boolean = false, _arg_5:int = 0):BitmapData
	{
		var _local_6:String = getHash(_arg_2, _arg_3, _arg_5);
		if (((_arg_4) && (isCached(_arg_1, _local_6))))
		{
			return (glowHashes[_arg_1][_local_6]);
		}
		var _local_7:BitmapData = _arg_1.clone();
		tempMatrix_.identity();
		tempMatrix_.scale((_arg_1.width / 0x0100), (_arg_1.height / 0x0100));
		_local_7.draw(gradient_, tempMatrix_, null, BlendMode.SUBTRACT);
		var _local_8:Bitmap = new Bitmap(_arg_1);
		_local_7.draw(_local_8, null, null, BlendMode.ALPHA);
		TextureRedrawer.OUTLINE_FILTER.blurX = _arg_3;
		TextureRedrawer.OUTLINE_FILTER.blurY = _arg_3;
		TextureRedrawer.OUTLINE_FILTER.color = _arg_5;
		_local_7.applyFilter(_local_7, _local_7.rect, PointUtil.ORIGIN, TextureRedrawer.OUTLINE_FILTER);
		if (_arg_2 != 0xFFFFFFFF)
		{
			if (((Parameters.isGpuRender()) && (!(_arg_2 == 0))))
			{
				GLOW_FILTER_ALT.color = _arg_2;
				_local_7.applyFilter(_local_7, _local_7.rect, PointUtil.ORIGIN, GLOW_FILTER_ALT);
			}
			else
			{
				GLOW_FILTER.color = _arg_2;
				_local_7.applyFilter(_local_7, _local_7.rect, PointUtil.ORIGIN, GLOW_FILTER);
			}
		}
		if (_arg_4)
		{
			cache(_arg_1, _arg_2, _arg_3, _local_7, _arg_5);
		}
		return (_local_7);
	}

	private static function cache(_arg_1:BitmapData, _arg_2:uint, _arg_3:Number, _arg_4:BitmapData, _arg_5:int):void
	{
		var _local_7:Object;
		var _local_6:String = getHash(_arg_2, _arg_3, _arg_5);
		if ((_arg_1 in glowHashes))
		{
			glowHashes[_arg_1][_local_6] = _arg_4;
		}
		else
		{
			_local_7 = {};
			_local_7[_local_6] = _arg_4;
			glowHashes[_arg_1] = _local_7;
		}
	}

	private static function isCached(_arg_1:BitmapData, _arg_2:String):Boolean
	{
		var _local_3:Object;
		if ((_arg_1 in glowHashes))
		{
			_local_3 = glowHashes[_arg_1];
			if ((_arg_2 in _local_3))
			{
				return (true);
			}
		}
		return (false);
	}

	private static function getHash(_arg_1:uint, _arg_2:Number, _arg_3:int):String
	{
		return ((int((_arg_2 * 10)).toString() + _arg_1) + _arg_3);
	}

	private static function getGradient():Shape
	{
		var _local_1:Shape = new Shape();
		var _local_2:Matrix = new Matrix();
		_local_2.createGradientBox(0x0100, 0x0100, (Math.PI / 2), 0, 0);
		_local_1.graphics.beginGradientFill(GradientType.LINEAR, [0, GRADIENT_MAX_SUB], [1, 1], [127, 0xFF], _local_2);
		_local_1.graphics.drawRect(0, 0, 0x0100, 0x0100);
		_local_1.graphics.endFill();
		return (_local_1);
	}


}
}//package com.company.assembleegameclient.util.redrawers

