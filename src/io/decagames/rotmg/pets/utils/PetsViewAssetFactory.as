//io.decagames.rotmg.pets.utils.PetsViewAssetFactory

package io.decagames.rotmg.pets.utils
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.ui.LineBreakDesign;

import flash.display.Bitmap;
import flash.display.Shape;
import flash.filters.DropShadowFilter;

import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class PetsViewAssetFactory
{


	public static function returnPetSlotShape(_arg_1:uint, _arg_2:uint, _arg_3:int, _arg_4:Boolean, _arg_5:Boolean, _arg_6:int = 2):Shape
	{
		var _local_7:Shape = new Shape();
		((_arg_4) && (_local_7.graphics.beginFill(0x464646, 1)));
		((_arg_5) && (_local_7.graphics.lineStyle(_arg_6, _arg_2)));
		_local_7.graphics.drawRoundRect(0, _arg_3, _arg_1, _arg_1, 16, 16);
		_local_7.x = ((100 - _arg_1) * 0.5);
		return (_local_7);
	}

	public static function returnCloseButton(_arg_1:int):DialogCloseButton
	{
		var _local_2:DialogCloseButton;
		_local_2 = new DialogCloseButton();
		_local_2.y = 4;
		_local_2.x = ((_arg_1 - _local_2.width) - 5);
		return (_local_2);
	}

	public static function returnTooltipLineBreak():LineBreakDesign
	{
		var _local_1:LineBreakDesign = new LineBreakDesign(173, 0);
		_local_1.x = 5;
		_local_1.y = 64;
		return (_local_1);
	}

	public static function returnBitmap(_arg_1:uint, _arg_2:uint = 80):Bitmap
	{
		return (new Bitmap(ObjectLibrary.getRedrawnTextureFromType(_arg_1, _arg_2, true)));
	}

	public static function returnCaretakerBitmap(_arg_1:uint):Bitmap
	{
		return (new Bitmap(ObjectLibrary.getRedrawnTextureFromType(_arg_1, 80, true, true, 10)));
	}

	public static function returnTextfield(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean = false):TextFieldDisplayConcrete
	{
		var _local_5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
		_local_5.setSize(_arg_2).setColor(_arg_1).setBold(_arg_3);
		_local_5.setVerticalAlign(TextFieldDisplayConcrete.BOTTOM);
		_local_5.filters = ((_arg_4) ? [new DropShadowFilter(0, 0, 0)] : []);
		return (_local_5);
	}


}
}//package io.decagames.rotmg.pets.utils

