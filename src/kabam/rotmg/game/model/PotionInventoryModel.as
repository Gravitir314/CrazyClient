﻿//kabam.rotmg.game.model.PotionInventoryModel

package kabam.rotmg.game.model
{
import flash.utils.Dictionary;

import kabam.rotmg.ui.model.PotionModel;

import org.osflash.signals.Signal;

public class PotionInventoryModel
{

	public static const HEALTH_POTION_ID:int = 2594;
	public static const HEALTH_POTION_SLOT:int = 254;
	public static const MAGIC_POTION_ID:int = 2595;
	public static const MAGIC_POTION_SLOT:int = 0xFF;

	public var potionModels:Dictionary;
	public var updatePosition:Signal;

	public function PotionInventoryModel()
	{
		this.potionModels = new Dictionary();
		this.updatePosition = new Signal(int);
	}

	public static function getPotionSlot(_arg_1:int):int
	{
		switch (_arg_1)
		{
			case HEALTH_POTION_ID:
				return (HEALTH_POTION_SLOT);
			case MAGIC_POTION_ID:
				return (MAGIC_POTION_SLOT);
		}
		return (-1);
	}


	public function initializePotionModels(_arg_1:XML):void
	{
		var _local_2:int;
		var _local_3:PotionModel;
		var _local_4:int = _arg_1.PotionPurchaseCooldown;
		var _local_5:int = _arg_1.PotionPurchaseCostCooldown;
		var _local_6:int = _arg_1.MaxStackablePotions;
		var _local_7:Array = [];
		for each (_local_2 in _arg_1.PotionPurchaseCosts.cost)
		{
			_local_7.push(_local_2);
		}
		_local_3 = new PotionModel();
		_local_3.purchaseCooldownMillis = _local_4;
		_local_3.priceCooldownMillis = _local_5;
		_local_3.maxPotionCount = _local_6;
		_local_3.objectId = HEALTH_POTION_ID;
		_local_3.position = 0;
		_local_3.costs = _local_7;
		this.potionModels[_local_3.position] = _local_3;
		_local_3.update.add(this.update);
		_local_3 = new PotionModel();
		_local_3.purchaseCooldownMillis = _local_4;
		_local_3.priceCooldownMillis = _local_5;
		_local_3.maxPotionCount = _local_6;
		_local_3.objectId = MAGIC_POTION_ID;
		_local_3.position = 1;
		_local_3.costs = _local_7;
		this.potionModels[_local_3.position] = _local_3;
		_local_3.update.add(this.update);
	}

	public function getPotionModel(_arg_1:uint):PotionModel
	{
		var _local_2:String;
		for (_local_2 in this.potionModels)
		{
			if (this.potionModels[_local_2].objectId == _arg_1)
			{
				return (this.potionModels[_local_2]);
			}
		}
		return (null);
	}

	private function update(_arg_1:int):void
	{
		this.updatePosition.dispatch(_arg_1);
	}


}
}//package kabam.rotmg.game.model

