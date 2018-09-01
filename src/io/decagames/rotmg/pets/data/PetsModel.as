//io.decagames.rotmg.pets.data.PetsModel

package io.decagames.rotmg.pets.data
{
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.map.AbstractMap;
import com.company.assembleegameclient.objects.ObjectLibrary;

import flash.utils.Dictionary;

import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
import io.decagames.rotmg.pets.data.vo.PetVO;
import io.decagames.rotmg.pets.data.vo.SkinVO;
import io.decagames.rotmg.pets.data.yard.PetYardEnum;
import io.decagames.rotmg.pets.signals.NotifyActivePetUpdated;

import kabam.rotmg.core.model.PlayerModel;

public class PetsModel
{

	private static var petsDataXML:Class = PetsModel_petsDataXML;

	private var petsData:XMLList;
	[Inject]
	public var notifyActivePetUpdated:NotifyActivePetUpdated;
	[Inject]
	public var playerModel:PlayerModel;
	private var hash:Object = {};
	private var pets:Vector.<PetVO> = new Vector.<PetVO>();
	private var skins:Dictionary = new Dictionary();
	private var familySkins:Dictionary = new Dictionary();
	private var yardXmlData:XML;
	private var type:int;
	private var activePet:PetVO;
	private var _wardrobePet:PetVO;
	private var _totalPetsSkins:int = 0;
	private var ownedSkinsIDs:Vector.<int> = new Vector.<int>();
	private var _activeUIVO:PetVO;

	public function PetsModel():void
	{
	}

	public function destroy():void
	{
	}

	public function setPetYardType(_arg_1:int):void
	{
		this.type = _arg_1;
		this.yardXmlData = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(_arg_1));
	}

	public function getPetYardRarity():uint
	{
		return (PetYardEnum.selectByValue(this.yardXmlData.@id).rarity.ordinal);
	}

	public function getPetYardType():int
	{
		return ((this.yardXmlData) ? PetYardEnum.selectByValue(this.yardXmlData.@id).ordinal : 1);
	}

	public function isMapNameYardName(_arg_1:AbstractMap):Boolean
	{
		return ((_arg_1.name_) && (_arg_1.name_.substr(0, 8) == "Pet Yard"));
	}

	public function getPetYardUpgradeFamePrice():int
	{
		return (int(this.yardXmlData.Fame));
	}

	public function getPetYardUpgradeGoldPrice():int
	{
		return (int(this.yardXmlData.Price));
	}

	public function getPetYardObjectID():int
	{
		return (this.type);
	}

	public function deletePet(_arg_1:int):void
	{
		var _local_2:int = this.getPetIndex(_arg_1);
		if (_local_2 >= 0)
		{
			this.pets.splice(this.getPetIndex(_arg_1), 1);
			if (((this._activeUIVO) && (this._activeUIVO.getID() == _arg_1)))
			{
				this._activeUIVO = null;
			}
			if (((this.activePet) && (this.activePet.getID() == _arg_1)))
			{
				this.removeActivePet();
			}
		}
	}

	public function clearPets():void
	{
		this.hash = {};
		this.pets = new Vector.<PetVO>();
		this.petsData = null;
		this.skins = new Dictionary();
		this.familySkins = new Dictionary();
		this._totalPetsSkins = 0;
		this.ownedSkinsIDs = new Vector.<int>();
		this.removeActivePet();
	}

	public function parsePetsData():void
	{
		var _local_1:uint;
		var _local_2:int;
		var _local_3:XML;
		var _local_4:SkinVO;
		if (this.petsData == null)
		{
			this.petsData = XML(new petsDataXML()).Object;
			_local_1 = this.petsData.length();
			_local_2 = 0;
			while (_local_2 < _local_1)
			{
				_local_3 = this.petsData[_local_2];
				if (_local_3.hasOwnProperty("PetSkin"))
				{
					if (_local_3.@type != "0x8090")
					{
						_local_4 = SkinVO.parseFromXML(_local_3);
						_local_4.isOwned = (this.ownedSkinsIDs.indexOf(_local_4.skinType) >= 0);
						this.skins[_local_4.skinType] = _local_4;
						this._totalPetsSkins++;
						if (!this.familySkins[_local_4.family])
						{
							this.familySkins[_local_4.family] = new Vector.<SkinVO>();
						}
						this.familySkins[_local_4.family].push(_local_4);
					}
				}
				_local_2++;
			}
		}
	}

	public function unlockSkin(_arg_1:int):void
	{
		this.skins[_arg_1].isNew = true;
		this.skins[_arg_1].isOwned = true;
		if (this.ownedSkinsIDs.indexOf(_arg_1) == -1)
		{
			this.ownedSkinsIDs.push(_arg_1);
		}
	}

	public function getSkinVOById(_arg_1:int):SkinVO
	{
		return (this.skins[_arg_1]);
	}

	public function hasSkin(_arg_1:int):Boolean
	{
		return (!(this.ownedSkinsIDs.indexOf(_arg_1) == -1));
	}

	public function parseOwnedSkins(_arg_1:XML):void
	{
		if (_arg_1.toString() != "")
		{
			this.ownedSkinsIDs = Vector.<int>(_arg_1.toString().split(","));
		}
	}

	public function getPetVO(_arg_1:int):PetVO
	{
		var _local_2:PetVO;
		if (this.hash[_arg_1] != null)
		{
			return (this.hash[_arg_1]);
		}
		_local_2 = new PetVO(_arg_1);
		this.pets.push(_local_2);
		this.hash[_arg_1] = _local_2;
		return (_local_2);
	}

	public function get totalPetsSkins():int
	{
		return (this._totalPetsSkins);
	}

	public function get totalOwnedPetsSkins():int
	{
		return (this.ownedSkinsIDs.length);
	}

	public function getPetsSkinsFromFamily(_arg_1:String):Vector.<SkinVO>
	{
		return (this.familySkins[_arg_1]);
	}

	private function petNodeIsSkin(_arg_1:XML):Boolean
	{
		return (_arg_1.hasOwnProperty("PetSkin"));
	}

	public function getCachedVOOnly(_arg_1:int):PetVO
	{
		return (this.hash[_arg_1]);
	}

	public function getAllPets(family:String = "", rarity:PetRarityEnum = null):Vector.<PetVO>
	{
		var petsList:Vector.<PetVO> = this.pets;
		if (family != "")
		{
			petsList = petsList.filter(function (_arg_1:PetVO, _arg_2:int, _arg_3:Vector.<PetVO>):Boolean
			{
				return (_arg_1.family == family);
			});
		}
		if (rarity != null)
		{
			petsList = petsList.filter(function (_arg_1:PetVO, _arg_2:int, _arg_3:Vector.<PetVO>):Boolean
			{
				return (_arg_1.rarity == rarity);
			});
		}
		return (petsList);
	}

	public function addPet(_arg_1:PetVO):void
	{
		this.pets.push(_arg_1);
	}

	public function setActivePet(_arg_1:PetVO):void
	{
		this.activePet = _arg_1;
		var _local_2:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
		if (_local_2)
		{
			_local_2.setPetVO(this.activePet);
		}
		this.notifyActivePetUpdated.dispatch();
	}

	public function getActivePet():PetVO
	{
		return (this.activePet);
	}

	public function removeActivePet():void
	{
		if (this.activePet == null)
		{
			return;
		}
		var _local_1:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
		if (_local_1)
		{
			_local_1.setPetVO(null);
		}
		this.activePet = null;
		this.notifyActivePetUpdated.dispatch();
	}

	public function getPet(_arg_1:int):PetVO
	{
		var _local_2:int = this.getPetIndex(_arg_1);
		if (_local_2 == -1)
		{
			return (null);
		}
		return (this.pets[_local_2]);
	}

	private function getPetIndex(_arg_1:int):int
	{
		var _local_2:PetVO;
		var _local_3:uint;
		while (_local_3 < this.pets.length)
		{
			_local_2 = this.pets[_local_3];
			if (_local_2.getID() == _arg_1)
			{
				return (_local_3);
			}
			_local_3++;
		}
		return (-1);
	}

	private function selectPetInWardrobe(_arg_1:PetVO):void
	{
		this._wardrobePet = _arg_1;
	}

	public function get activeUIVO():PetVO
	{
		return (this._activeUIVO);
	}

	public function set activeUIVO(_arg_1:PetVO):void
	{
		this._activeUIVO = _arg_1;
	}


}
}//package io.decagames.rotmg.pets.data

