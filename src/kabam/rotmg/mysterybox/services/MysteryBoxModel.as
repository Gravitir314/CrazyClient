//kabam.rotmg.mysterybox.services.MysteryBoxModel

package kabam.rotmg.mysterybox.services
{
import kabam.rotmg.mysterybox.model.MysteryBoxInfo;

import org.osflash.signals.Signal;

public class MysteryBoxModel
{
	public const updateSignal:Signal = new Signal();

	private var models:Object;
	private var initialized:Boolean = false;
	private var _isNew:Boolean = false;
	private var maxSlots:int = 18;


	public function getBoxesOrderByWeight():Object
	{
		return (this.models);
	}

	public function getBoxesForGrid():Vector.<MysteryBoxInfo>
	{
		var _local_2:MysteryBoxInfo;
		var _local_1:Vector.<MysteryBoxInfo> = new Vector.<MysteryBoxInfo>(this.maxSlots);
		for each (_local_2 in this.models)
		{
			if (_local_2.slot != 0)
			{
				_local_1[(_local_2.slot - 1)] = _local_2;
			}
		}
		return (_local_1);
	}

	public function getBoxById(_arg_1:String):MysteryBoxInfo
	{
		var _local_2:MysteryBoxInfo;
		for each (_local_2 in this.models)
		{
			if (_local_2.id == _arg_1)
			{
				return (_local_2);
			}
		}
		return (null);
	}

	public function setMysetryBoxes(_arg_1:Array):void
	{
		var _local_2:MysteryBoxInfo;
		this.models = {};
		for each (_local_2 in _arg_1)
		{
			this.models[_local_2.id] = _local_2;
		}
		this.updateSignal.dispatch();
		this.initialized = true;
	}

	public function isInitialized():Boolean
	{
		return (this.initialized);
	}

	public function setInitialized(_arg_1:Boolean):void
	{
		this.initialized = _arg_1;
	}

	public function get isNew():Boolean
	{
		return (this._isNew);
	}

	public function set isNew(_arg_1:Boolean):void
	{
		this._isNew = _arg_1;
	}


}
}//package kabam.rotmg.mysterybox.services

