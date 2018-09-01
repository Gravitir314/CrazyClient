//io.decagames.rotmg.pets.data.skin.PetSkinRenderer

package io.decagames.rotmg.pets.data.skin
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;

import flash.display.Bitmap;
import flash.display.BitmapData;

public class PetSkinRenderer
{

	protected var _skinType:int;
	protected var skin:AnimatedChar;


	public function getSkinBitmap():Bitmap
	{
		this.makeSkin();
		if (this.skin == null)
		{
			return (null);
		}
		var _local_1:MaskedImage = this.skin.imageFromAngle(0, AnimatedChar.STAND, 0);
		var _local_2:int = ((this.skin.getHeight() == 16) ? 40 : 80);
		var _local_3:BitmapData = TextureRedrawer.resize(_local_1.image_, _local_1.mask_, _local_2, true, 0, 0);
		_local_3 = GlowRedrawer.outlineGlow(_local_3, 0);
		return (new Bitmap(_local_3));
	}

	protected function makeSkin():void
	{
		var _local_1:XML = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(this._skinType));
		if (_local_1 == null)
		{
			return;
		}
		var _local_2:String = _local_1.AnimatedTexture.File;
		var _local_3:int = _local_1.AnimatedTexture.Index;
		this.skin = AnimatedChars.getAnimatedChar(_local_2, _local_3);
	}

	public function getSkinMaskedImage():MaskedImage
	{
		this.makeSkin();
		return ((this.skin) ? this.skin.imageFromAngle(0, AnimatedChar.STAND, 0) : null);
	}


}
}//package io.decagames.rotmg.pets.data.skin

