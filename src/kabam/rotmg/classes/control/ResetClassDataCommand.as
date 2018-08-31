﻿//kabam.rotmg.classes.control.ResetClassDataCommand

package kabam.rotmg.classes.control
{
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.CharacterSkinState;
import kabam.rotmg.classes.model.ClassesModel;

public class ResetClassDataCommand
{

	[Inject]
	public var classes:ClassesModel;


	public function execute():void
	{
		var _local_1:int;
		var _local_2:int = this.classes.getCount();
		while (_local_1 < _local_2)
		{
			this.resetClass(this.classes.getClassAtIndex(_local_1));
			_local_1++;
		}
	}

	private function resetClass(_arg_1:CharacterClass):void
	{
		_arg_1.setIsSelected((_arg_1.id == ClassesModel.WIZARD_ID));
		this.resetClassSkins(_arg_1);
	}

	private function resetClassSkins(_arg_1:CharacterClass):void
	{
		var _local_2:CharacterSkin;
		var _local_3:int;
		var _local_4:CharacterSkin = _arg_1.skins.getDefaultSkin();
		var _local_5:int = _arg_1.skins.getCount();
		while (_local_3 < _local_5)
		{
			_local_2 = _arg_1.skins.getSkinAt(_local_3);
			if (_local_2 != _local_4)
			{
				this.resetSkin(_arg_1.skins.getSkinAt(_local_3));
			}
			_local_3++;
		}
	}

	private function resetSkin(_arg_1:CharacterSkin):void
	{
		_arg_1.setState(CharacterSkinState.LOCKED);
	}


}
}//package kabam.rotmg.classes.control

