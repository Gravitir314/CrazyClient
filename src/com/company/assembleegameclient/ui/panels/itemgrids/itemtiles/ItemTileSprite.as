﻿//com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTileSprite

package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.PointUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix;

import kabam.rotmg.constants.ItemConstants;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.ui.view.components.PotionSlotView;

public class ItemTileSprite extends Sprite
{

	protected static const DIM_FILTER:Array = [new ColorMatrixFilter([0.4, 0, 0, 0, 0, 0, 0.4, 0, 0, 0, 0, 0, 0.4, 0, 0, 0, 0, 0, 1, 0])];
	private static const IDENTITY_MATRIX:Matrix = new Matrix();
	private static const DOSE_MATRIX:Matrix = (function ():Matrix
	{
		var _local_1:* = new Matrix();
		_local_1.translate(8, 7);
		return (_local_1);
	})();

	public var itemId:int;
	public var itemBitmap:Bitmap;
	private var bitmapFactory:BitmapTextFactory;

	public function ItemTileSprite()
	{
		this.itemBitmap = new Bitmap();
		addChild(this.itemBitmap);
		this.itemId = -1;
	}

	public function setDim(_arg_1:Boolean):void
	{
		filters = ((_arg_1) ? DIM_FILTER : null);
	}

	public function setType(_arg_1:int):void
	{
		this.itemId = _arg_1;
		this.drawTile();
	}

	public function drawTile():void
	{
		var _local_2:BitmapData;
		var _local_3:XML;
		var _local_4:BitmapData;
		var _local_5:BitmapData;
		var _local_1:int = this.itemId;
		if (_local_1 != ItemConstants.NO_ITEM)
		{
			if (((_local_1 >= 0x9000) && (_local_1 < 0xF000)))
			{
				_local_1 = 36863;
			}
			_local_2 = ObjectLibrary.getRedrawnTextureFromType(_local_1, 80, true);
			_local_3 = ObjectLibrary.xmlLibrary_[_local_1];
			if ((((_local_3) && (_local_3.hasOwnProperty("Doses"))) && (this.bitmapFactory)))
			{
				_local_2 = _local_2.clone();
				_local_4 = this.bitmapFactory.make(new StaticStringBuilder(String(_local_3.Doses)), 12, 0xFFFFFF, false, IDENTITY_MATRIX, false);
				_local_4.applyFilter(_local_4, _local_4.rect, PointUtil.ORIGIN, PotionSlotView.READABILITY_SHADOW_2);
				_local_2.draw(_local_4, DOSE_MATRIX);
			}
			if ((((_local_3) && (_local_3.hasOwnProperty("Quantity"))) && (this.bitmapFactory)))
			{
				_local_2 = _local_2.clone();
				_local_5 = this.bitmapFactory.make(new StaticStringBuilder(String(_local_3.Quantity)), 12, 0xFFFFFF, false, IDENTITY_MATRIX, false);
				_local_5.applyFilter(_local_5, _local_5.rect, PointUtil.ORIGIN, PotionSlotView.READABILITY_SHADOW_2);
				_local_2.draw(_local_5, DOSE_MATRIX);
			}
			this.itemBitmap.bitmapData = _local_2;
			this.itemBitmap.x = (-(_local_2.width) / 2);
			this.itemBitmap.y = (-(_local_2.height) / 2);
			visible = true;
		}
		else
		{
			visible = false;
		}
	}

	public function setBitmapFactory(_arg_1:BitmapTextFactory):void
	{
		this.bitmapFactory = _arg_1;
	}


}
}//package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles

