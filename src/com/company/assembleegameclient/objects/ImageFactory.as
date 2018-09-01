﻿//com.company.assembleegameclient.objects.ImageFactory

package com.company.assembleegameclient.objects
{
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;

public class ImageFactory
{


	public function getImageFromSet(_arg_1:String, _arg_2:int):BitmapData
	{
		return (AssetLibrary.getImageFromSet(_arg_1, _arg_2));
	}

	public function getTexture(_arg_1:int, _arg_2:int):BitmapData
	{
		var _local_3:Number;
		var _local_4:BitmapData;
		var _local_5:BitmapData = ObjectLibrary.getBitmapData(_arg_1);
		if (_local_5)
		{
			_local_3 = ((_arg_2 - TextureRedrawer.minSize) / _local_5.width);
			return (ObjectLibrary.getRedrawnTextureFromType(_arg_1, 100, true, false, _local_3));
		}
		return (new BitmapDataSpy(_arg_2, _arg_2));
	}


}
}//package com.company.assembleegameclient.objects

