//io.decagames.rotmg.pets.data.vo.PetVO

package io.decagames.rotmg.pets.data.vo
{
import com.company.assembleegameclient.objects.ObjectLibrary;

import io.decagames.rotmg.pets.data.PetsModel;
import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
import io.decagames.rotmg.pets.data.skin.PetSkinRenderer;

import kabam.rotmg.core.StaticInjectorContext;

import org.osflash.signals.Signal;

public class PetVO extends PetSkinRenderer implements IPetVO
{

	private var staticData:XML;
	private var id:int;
	private var type:int;
	private var _rarity:PetRarityEnum;
	private var _name:String;
	private var _maxAbilityPower:int;
	private var _abilityList:Array = [new AbilityVO(), new AbilityVO(), new AbilityVO()];
	private var _updated:Signal = new Signal();
	private var _abilityUpdated:Signal = new Signal();
	private var _ownedSkin:Boolean;
	private var _family:String = "";

	public function PetVO(_arg_1:int = undefined)
	{
		this.id = _arg_1;
		this.staticData = <data/>;this.listenToAbilities();
	}

	private static function getPetDataDescription(_arg_1:int):String
	{
		return (ObjectLibrary.getPetDataXMLByType(_arg_1).Description);
	}

	private static function getPetDataDisplayId(_arg_1:int):String
	{
		return (ObjectLibrary.getPetDataXMLByType(_arg_1).@id);
	}

	public static function clone(_arg_1:PetVO):PetVO
	{
		return (new PetVO(_arg_1.id));
	}


	public function get updated():Signal
	{
		return (this._updated);
	}

	private function listenToAbilities():void
	{
		var _local_1:AbilityVO;
		for each (_local_1 in this._abilityList)
		{
			_local_1.updated.add(this.onAbilityUpdate);
		}
	}

	public function maxedAvailableAbilities():Boolean
	{
		var _local_1:AbilityVO;
		for each (_local_1 in this._abilityList)
		{
			if (((_local_1.getUnlocked()) && (_local_1.level < this.maxAbilityPower)))
			{
				return (false);
			}
		}
		return (true);
	}

	public function totalAbilitiesLevel():int
	{
		var _local_2:AbilityVO;
		var _local_1:int;
		for each (_local_2 in this._abilityList)
		{
			if (((_local_2.getUnlocked()) && (_local_2.level)))
			{
				_local_1 = (_local_1 + _local_2.level);
			}
		}
		return (_local_1);
	}

	public function get totalMaxAbilitiesLevel():int
	{
		var _local_2:AbilityVO;
		var _local_1:int;
		for each (_local_2 in this._abilityList)
		{
			if (_local_2.getUnlocked())
			{
				_local_1 = (_local_1 + this._maxAbilityPower);
			}
		}
		return (_local_1);
	}

	public function maxedAllAbilities():Boolean
	{
		var _local_2:AbilityVO;
		var _local_1:int;
		for each (_local_2 in this._abilityList)
		{
			if (((_local_2.getUnlocked()) && (_local_2.level == this.maxAbilityPower)))
			{
				_local_1++;
			}
		}
		return (_local_1 == this._abilityList.length);
	}

	private function onAbilityUpdate(_arg_1:AbilityVO):void
	{
		this._updated.dispatch();
		this._abilityUpdated.dispatch();
	}

	public function apply(_arg_1:XML):void
	{
		this.extractBasicData(_arg_1);
		this.extractAbilityData(_arg_1);
	}

	private function extractBasicData(_arg_1:XML):void
	{
		((_arg_1.@instanceId) && (this.setID(_arg_1.@instanceId)));
		((_arg_1.@type) && (this.setType(_arg_1.@type)));
		((_arg_1.@skin) && (this.setSkin(_arg_1.@skin)));
		((_arg_1.@name) && (this.setName(_arg_1.@name)));
		((_arg_1.@rarity) && (this.setRarity(_arg_1.@rarity)));
		((_arg_1.@maxAbilityPower) && (this.setMaxAbilityPower(_arg_1.@maxAbilityPower)));
	}

	public function extractAbilityData(_arg_1:XML):void
	{
		var _local_2:uint;
		var _local_4:AbilityVO;
		var _local_5:int;
		var _local_3:uint = this._abilityList.length;
		_local_2 = 0;
		while (_local_2 < _local_3)
		{
			_local_4 = this._abilityList[_local_2];
			_local_5 = int(_arg_1.Abilities.Ability[_local_2].@type);
			_local_4.name = getPetDataDisplayId(_local_5);
			_local_4.description = getPetDataDescription(_local_5);
			_local_4.level = _arg_1.Abilities.Ability[_local_2].@power;
			_local_4.points = _arg_1.Abilities.Ability[_local_2].@points;
			_local_2++;
		}
	}

	public function get family():String
	{
		var _local_1:SkinVO = this.skinVO;
		if (_local_1)
		{
			return (_local_1.family);
		}
		return (this.staticData.Family);
	}

	public function setID(_arg_1:int):void
	{
		this.id = _arg_1;
	}

	public function getID():int
	{
		return (this.id);
	}

	public function setType(_arg_1:int):void
	{
		this.type = _arg_1;
		this.staticData = ObjectLibrary.xmlLibrary_[this.type];
	}

	public function getType():int
	{
		return (this.type);
	}

	public function setRarity(_arg_1:uint):void
	{
		this._rarity = PetRarityEnum.selectByOrdinal(_arg_1);
		this.unlockAbilitiesBasedOnPetRarity(_arg_1);
		this._updated.dispatch();
	}

	private function unlockAbilitiesBasedOnPetRarity(_arg_1:uint):void
	{
		this._abilityList[0].setUnlocked(true);
		this._abilityList[1].setUnlocked((_arg_1 >= PetRarityEnum.UNCOMMON.ordinal));
		this._abilityList[2].setUnlocked((_arg_1 >= PetRarityEnum.LEGENDARY.ordinal));
	}

	public function get rarity():PetRarityEnum
	{
		return (this._rarity);
	}

	public function get skinVO():SkinVO
	{
		return (StaticInjectorContext.getInjector().getInstance(PetsModel).getSkinVOById(_skinType));
	}

	public function setName(_arg_1:String):void
	{
		this._name = ObjectLibrary.typeToDisplayId_[_skinType];
		if (((this._name == null) || (this._name == "")))
		{
			this._name = ObjectLibrary.typeToDisplayId_[this.getType()];
		}
		this._updated.dispatch();
	}

	public function get name():String
	{
		return (this._name);
	}

	public function setMaxAbilityPower(_arg_1:int):void
	{
		this._maxAbilityPower = _arg_1;
		this._updated.dispatch();
	}

	public function get maxAbilityPower():int
	{
		return (this._maxAbilityPower);
	}

	public function setSkin(_arg_1:int):void
	{
		_skinType = _arg_1;
		this._updated.dispatch();
	}

	public function get skinType():int
	{
		return (_skinType);
	}

	public function get ownedSkin():Boolean
	{
		return (this._ownedSkin);
	}

	public function set ownedSkin(_arg_1:Boolean):void
	{
		this._ownedSkin = _arg_1;
	}

	public function setFamily(_arg_1:String):void
	{
		this._family = _arg_1;
	}

	public function get abilityList():Array
	{
		return (this._abilityList);
	}

	public function set abilityList(_arg_1:Array):void
	{
		this._abilityList = _arg_1;
	}

	public function get isOwned():Boolean
	{
		return (false);
	}

	public function get abilityUpdated():Signal
	{
		return (this._abilityUpdated);
	}

	public function get isNew():Boolean
	{
		return (false);
	}

	public function set isNew(_arg_1:Boolean):void
	{
	}


}
}//package io.decagames.rotmg.pets.data.vo

