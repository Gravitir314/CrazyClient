﻿//kabam.rotmg.util.graphics.ButtonLayoutHelper

package kabam.rotmg.util.graphics
{
import flash.display.DisplayObject;
import flash.errors.IllegalOperationError;
import flash.geom.Rectangle;

public class ButtonLayoutHelper
{


	public function layout(_arg_1:int, ... _args):void
	{
		var _local_3:int = _args.length;
		switch (_local_3)
		{
			case 1:
				this.centerButton(_arg_1, _args[0]);
				return;
			case 2:
				this.twoButtons(_arg_1, _args[0], _args[1]);
				return;
			default:
				throw (new IllegalOperationError("Currently unable to layout more than 2 buttons"));
		}
	}

	private function centerButton(_arg_1:int, _arg_2:DisplayObject):void
	{
		var _local_3:Rectangle = _arg_2.getRect(_arg_2);
		_arg_2.x = (((_arg_1 - _local_3.width) * 0.5) - _local_3.left);
	}

	private function twoButtons(_arg_1:int, _arg_2:DisplayObject, _arg_3:DisplayObject):void
	{
		var _local_4:Rectangle = _arg_2.getRect(_arg_2);
		var _local_5:Rectangle = _arg_3.getRect(_arg_3);
		_arg_2.x = int((((_arg_1 - (2 * _arg_2.width)) * 0.25) - _local_4.left));
		_arg_3.x = int(((((3 * _arg_1) - (2 * _arg_3.width)) * 0.25) - _local_5.left));
	}


}
}//package kabam.rotmg.util.graphics

