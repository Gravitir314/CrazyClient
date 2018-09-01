﻿//com.company.assembleegameclient.objects.Wall

package com.company.assembleegameclient.objects
{
import com.company.assembleegameclient.engine3d.Face3D;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.options.Options;
import com.company.util.BitmapUtil;

import flash.display.BitmapData;
import flash.display.IGraphicsData;

public class Wall extends GameObject
{

	private static const UVT:Vector.<Number> = new <Number>[0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0];
	private static const sqX:Vector.<int> = new <int>[0, 1, 0, -1];
	private static const sqY:Vector.<int> = new <int>[-1, 0, 1, 0];

	public var faces_:Vector.<Face3D> = new Vector.<Face3D>();
	private var topFace_:Face3D = null;
	private var topTexture_:BitmapData = null;

	public function Wall(_arg_1:XML)
	{
		super(_arg_1);
		hasShadow_ = false;
		var _local_2:TextureData = ObjectLibrary.typeToTopTextureData_[objectType_];
		this.topTexture_ = _local_2.getTexture(0);
	}

	override public function setObjectId(_arg_1:int):void
	{
		super.setObjectId(_arg_1);
		var _local_2:TextureData = ObjectLibrary.typeToTopTextureData_[objectType_];
		this.topTexture_ = _local_2.getTexture(_arg_1);
	}

	override public function getColor():uint
	{
		return (BitmapUtil.mostCommonColor(this.topTexture_));
	}

	override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void
	{
		var _local_4:BitmapData;
		var _local_5:Face3D;
		var _local_6:Square;
		var _local_7:int;
		if (!Options.hidden && Parameters.lowCPUMode)
		{
			return;
		}
		if (texture_ == null)
		{
			return;
		}
		if (this.faces_.length == 0)
		{
			this.rebuild3D();
		}
		var _local_8:BitmapData = texture_;
		if (animations_ != null)
		{
			_local_4 = animations_.getTexture(_arg_3);
			if (_local_4 != null)
			{
				_local_8 = _local_4;
			}
		}
		while (_local_7 < this.faces_.length)
		{
			_local_5 = this.faces_[_local_7];
			_local_6 = map_.lookupSquare((x_ + sqX[_local_7]), (y_ + sqY[_local_7]));
			if ((((_local_6 == null) || (_local_6.texture_ == null)) || (((!(_local_6 == null)) && (_local_6.obj_ is Wall)) && (!(_local_6.obj_.dead_)))))
			{
				_local_5.blackOut_ = true;
			}
			else
			{
				_local_5.blackOut_ = false;
				if (animations_ != null)
				{
					_local_5.setTexture(_local_8);
				}
			}
			_local_5.draw(_arg_1, _arg_2);
			_local_7++;
		}
		this.topFace_.draw(_arg_1, _arg_2);
	}

	public function rebuild3D():void
	{
		this.faces_.length = 0;
		var _local_1:int = x_;
		var _local_2:int = y_;
		var _local_3:Vector.<Number> = new <Number>[_local_1, _local_2, 1, (_local_1 + 1), _local_2, 1, (_local_1 + 1), (_local_2 + 1), 1, _local_1, (_local_2 + 1), 1];
		this.topFace_ = new Face3D(this.topTexture_, _local_3, UVT, false, true);
		this.topFace_.bitmapFill_.repeat = true;
		this.addWall(_local_1, _local_2, 1, (_local_1 + 1), _local_2, 1);
		this.addWall((_local_1 + 1), _local_2, 1, (_local_1 + 1), (_local_2 + 1), 1);
		this.addWall((_local_1 + 1), (_local_2 + 1), 1, _local_1, (_local_2 + 1), 1);
		this.addWall(_local_1, (_local_2 + 1), 1, _local_1, _local_2, 1);
	}

	private function addWall(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number):void
	{
		var _local_7:Vector.<Number> = new <Number>[_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_4, _arg_5, (_arg_6 - 1), _arg_1, _arg_2, (_arg_3 - 1)];
		var _local_8:Face3D = new Face3D(texture_, _local_7, UVT, true, true);
		_local_8.bitmapFill_.repeat = true;
		this.faces_.push(_local_8);
	}


}
}//package com.company.assembleegameclient.objects

