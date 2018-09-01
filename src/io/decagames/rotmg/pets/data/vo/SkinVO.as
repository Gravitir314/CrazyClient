//io.decagames.rotmg.pets.data.vo.SkinVO

package io.decagames.rotmg.pets.data.vo
{
import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
import io.decagames.rotmg.pets.data.skin.PetSkinRenderer;

import org.osflash.signals.Signal;

public class SkinVO extends PetSkinRenderer implements IPetVO
{

	private var _family:String;
	private var _rarity:PetRarityEnum;
	private var _name:String;
	private var _isOwned:Boolean;
	private var _isNew:Boolean;


	public static function parseFromXML(_arg_1:XML):SkinVO
	{
		var _local_2:SkinVO = new (SkinVO)();
		_local_2.skinType = int(_arg_1.@type);
		_local_2.family = _arg_1.Family[0];
		_local_2.name = _arg_1.DisplayId[0];
		_local_2.rarity = PetRarityEnum.selectByRarityName(_arg_1.Rarity[0]);
		return (_local_2);
	}


	public function get updated():Signal
	{
		return (null);
	}

	public function get family():String
	{
		return (this._family);
	}

	public function set family(_arg_1:String):void
	{
		this._family = _arg_1;
	}

	public function get rarity():PetRarityEnum
	{
		return (this._rarity);
	}

	public function set rarity(_arg_1:PetRarityEnum):void
	{
		this._rarity = _arg_1;
	}

	public function get name():String
	{
		return (this._name);
	}

	public function set name(_arg_1:String):void
	{
		this._name = _arg_1;
	}

	public function get skinType():int
	{
		return (_skinType);
	}

	public function set skinType(_arg_1:int):void
	{
		_skinType = _arg_1;
	}

	public function get isOwned():Boolean
	{
		return (this._isOwned);
	}

	public function set isOwned(_arg_1:Boolean):void
	{
		this._isOwned = _arg_1;
	}

	public function get abilityList():Array
	{
		return ([new AbilityVO(), new AbilityVO(), new AbilityVO()]);
	}

	public function get maxAbilityPower():int
	{
		return (0);
	}

	public function getID():int
	{
		return (-1);
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
}//package io.decagames.rotmg.pets.data.vo

