﻿//kabam.rotmg.messaging.impl.PetUpdater

package kabam.rotmg.messaging.impl
{
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.objects.Pet;
import com.company.assembleegameclient.util.ConditionEffect;

import io.decagames.rotmg.pets.data.PetsModel;
import io.decagames.rotmg.pets.data.vo.AbilityVO;
import io.decagames.rotmg.pets.data.vo.PetVO;

import kabam.rotmg.messaging.impl.data.StatData;

public class PetUpdater
{

	[Inject]
	public var petsModel:PetsModel;
	[Inject]
	public var gameSprite:AGameSprite;


	public function updatePetVOs(_arg_1:Pet, _arg_2:Vector.<StatData>):void
	{
		var _local_3:StatData;
		var _local_4:AbilityVO;
		var _local_5:*;
		var _local_6:PetVO = ((_arg_1.vo) || (this.createPetVO(_arg_1, _arg_2)));
		if (_local_6 == null)
		{
			return;
		}
		for each (_local_3 in _arg_2)
		{
			_local_5 = _local_3.statValue_;
			if (_local_3.statType_ == StatData.TEXTURE_STAT)
			{
				_local_6.setSkin(_local_5);
			}
			switch (_local_3.statType_)
			{
				case StatData.PET_INSTANCEID_STAT:
					_local_6.setID(_local_5);
					break;
				case StatData.PET_NAME_STAT:
					_local_6.setName(_local_3.strStatValue_);
					break;
				case StatData.PET_TYPE_STAT:
					_local_6.setType(_local_5);
					break;
				case StatData.PET_RARITY_STAT:
					_local_6.setRarity(_local_5);
					break;
				case StatData.PET_MAXABILITYPOWER_STAT:
					_local_6.setMaxAbilityPower(_local_5);
					break;
				case StatData.PET_FAMILY_STAT:
					break;
				case StatData.PET_FIRSTABILITY_POINT_STAT:
					_local_4 = _local_6.abilityList[0];
					_local_4.points = _local_5;
					break;
				case StatData.PET_SECONDABILITY_POINT_STAT:
					_local_4 = _local_6.abilityList[1];
					_local_4.points = _local_5;
					break;
				case StatData.PET_THIRDABILITY_POINT_STAT:
					_local_4 = _local_6.abilityList[2];
					_local_4.points = _local_5;
					break;
				case StatData.PET_FIRSTABILITY_POWER_STAT:
					_local_4 = _local_6.abilityList[0];
					_local_4.level = _local_5;
					break;
				case StatData.PET_SECONDABILITY_POWER_STAT:
					_local_4 = _local_6.abilityList[1];
					_local_4.level = _local_5;
					break;
				case StatData.PET_THIRDABILITY_POWER_STAT:
					_local_4 = _local_6.abilityList[2];
					_local_4.level = _local_5;
					break;
				case StatData.PET_FIRSTABILITY_TYPE_STAT:
					_local_4 = _local_6.abilityList[0];
					_local_4.type = _local_5;
					break;
				case StatData.PET_SECONDABILITY_TYPE_STAT:
					_local_4 = _local_6.abilityList[1];
					_local_4.type = _local_5;
					break;
				case StatData.PET_THIRDABILITY_TYPE_STAT:
					_local_4 = _local_6.abilityList[2];
					_local_4.type = _local_5;
					break;
			}
			if (_local_4)
			{
				_local_4.updated.dispatch(_local_4);
			}
		}
	}

	private function createPetVO(_arg_1:Pet, _arg_2:Vector.<StatData>):PetVO
	{
		var _local_3:StatData;
		var _local_4:PetVO;
		for each (_local_3 in _arg_2)
		{
			if (_local_3.statType_ == StatData.PET_INSTANCEID_STAT)
			{
				_local_4 = this.petsModel.getCachedVOOnly(_local_3.statValue_);
				_arg_1.vo = ((_local_4) ? _local_4 : ((this.gameSprite.map.isPetYard) ? this.petsModel.getPetVO(_local_3.statValue_) : new PetVO(_local_3.statValue_)));
				return (_arg_1.vo);
			}
		}
		return (null);
	}

	public function updatePet(_arg_1:Pet, _arg_2:Vector.<StatData>):void
	{
		var _local_3:StatData;
		var _local_4:*;
		for each (_local_3 in _arg_2)
		{
			_local_4 = _local_3.statValue_;
			if (_local_3.statType_ == StatData.TEXTURE_STAT)
			{
				_arg_1.setSkin(_local_4);
			}
			if (_local_3.statType_ == StatData.SIZE_STAT)
			{
				_arg_1.size_ = _local_4;
			}
			if (_local_3.statType_ == StatData.CONDITION_STAT)
			{
				_arg_1.condition_[ConditionEffect.CE_FIRST_BATCH] = _local_4;
			}
		}
	}


}
}//package kabam.rotmg.messaging.impl

