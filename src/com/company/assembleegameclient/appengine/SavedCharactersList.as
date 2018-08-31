//com.company.assembleegameclient.appengine.SavedCharactersList

package com.company.assembleegameclient.appengine
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;

import flash.events.Event;

import io.decagames.rotmg.tos.popups.ToSPopup;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.promotions.model.BeginnersPackageModel;
import kabam.rotmg.servers.api.LatLong;

import org.swiftsuspenders.Injector;

public class SavedCharactersList extends Event
{

	public static const SAVED_CHARS_LIST:String = "SAVED_CHARS_LIST";
	public static const AVAILABLE:String = "available";
	public static const UNAVAILABLE:String = "unavailable";
	public static const UNRESTRICTED:String = "unrestricted";
	private static const DEFAULT_LATLONG:LatLong = new LatLong(37.4436, -122.412);
	private static const DEFAULT_SALESFORCE:String = "unavailable";

	private var origData_:String;
	private var charsXML_:XML;
	public var accountId_:String;
	public var nextCharId_:int;
	public var maxNumChars_:int;
	public var numChars_:int = 0;
	public var savedChars_:Vector.<SavedCharacter> = new Vector.<SavedCharacter>();
	public var charStats_:Object = {};
	public var totalFame_:int = 0;
	public var bestCharFame_:int = 0;
	public var fame_:int = 0;
	public var credits_:int = 0;
	public var tokens_:int = 0;
	public var numStars_:int = 0;
	public var nextCharSlotPrice_:int;
	public var guildName_:String;
	public var guildRank_:int;
	public var name_:String = null;
	public var nameChosen_:Boolean;
	public var converted_:Boolean;
	public var isAdmin_:Boolean;
	public var canMapEdit_:Boolean;
	public var news_:Vector.<SavedNewsItem> = new Vector.<SavedNewsItem>();
	public var myPos_:LatLong;
	public var salesForceData_:String = "unavailable";
	public var hasPlayerDied:Boolean = false;
	public var classAvailability:Object;
	public var isAgeVerified:Boolean;
	private var account:Account;

	public function SavedCharactersList(_arg_1:String)
	{
		var _local_2:*;
		var _local_3:Account;
		super(SAVED_CHARS_LIST);
		this.origData_ = _arg_1;
		this.charsXML_ = new XML(this.origData_);
		var _local_4:XML = XML(this.charsXML_.Account);
		this.parseUserData(_local_4);
		this.parseBeginnersPackageData(_local_4);
		this.parseGuildData(_local_4);
		this.parseCharacterData();
		this.parseCharacterStatsData();
		this.parseNewsData();
		this.parseGeoPositioningData();
		this.parseSalesForceData();
		this.parseTOSPopup();
		this.reportUnlocked();
		var _local_5:Injector = StaticInjectorContext.getInjector();
		if (_local_5)
		{
			_local_3 = _local_5.getInstance(Account);
			_local_3.reportIntStat("BestLevel", this.bestOverallLevel());
			_local_3.reportIntStat("BestFame", this.bestOverallFame());
			_local_3.reportIntStat("NumStars", this.numStars_);
			_local_3.verify(_local_4.hasOwnProperty("VerifiedEmail"));
		}
		this.classAvailability = {};
		for each (_local_2 in this.charsXML_.ClassAvailabilityList.ClassAvailability)
		{
			this.classAvailability[_local_2.@id.toString()] = _local_2.toString();
		}
	}

	public function getCharById(_arg_1:int):SavedCharacter
	{
		var _local_2:SavedCharacter;
		for each (_local_2 in this.savedChars_)
		{
			if (_local_2.charId() == _arg_1)
			{
				return (_local_2);
			}
		}
		return (null);
	}

	private function parseUserData(_arg_1:XML):void
	{
		this.accountId_ = _arg_1.AccountId;
		this.name_ = _arg_1.Name;
		this.nameChosen_ = _arg_1.hasOwnProperty("NameChosen");
		this.converted_ = _arg_1.hasOwnProperty("Converted");
		this.isAdmin_ = _arg_1.hasOwnProperty("Admin");
		Player.isAdmin = this.isAdmin_;
		Player.isMod = _arg_1.hasOwnProperty("Mod");
		this.canMapEdit_ = _arg_1.hasOwnProperty("MapEditor");
		this.totalFame_ = int(_arg_1.Stats.TotalFame);
		this.bestCharFame_ = int(_arg_1.Stats.BestCharFame);
		this.fame_ = int(_arg_1.Stats.Fame);
		this.credits_ = int(_arg_1.Credits);
		this.tokens_ = int(_arg_1.FortuneToken);
		this.nextCharSlotPrice_ = int(_arg_1.NextCharSlotPrice);
		this.isAgeVerified = ((!(this.accountId_ == "")) && (_arg_1.IsAgeVerified == 1));
		this.hasPlayerDied = true;
	}

	private function parseBeginnersPackageData(_arg_1:XML):void
	{
		var _local_2:int;
		var _local_3:BeginnersPackageModel;
		if (_arg_1.hasOwnProperty("BeginnerPackageStatus"))
		{
			_local_2 = _arg_1.BeginnerPackageStatus;
			_local_3 = this.getBeginnerModel();
			_local_3.status = _local_2;
		}
	}

	private function getBeginnerModel():BeginnersPackageModel
	{
		var _local_1:Injector = StaticInjectorContext.getInjector();
		return (_local_1.getInstance(BeginnersPackageModel));
	}

	private function parseGuildData(_arg_1:XML):void
	{
		var _local_2:XML;
		if (_arg_1.hasOwnProperty("Guild"))
		{
			_local_2 = XML(_arg_1.Guild);
			this.guildName_ = _local_2.Name;
			this.guildRank_ = int(_local_2.Rank);
		}
	}

	private function parseCharacterData():void
	{
		var _local_1:XML;
		this.nextCharId_ = int(this.charsXML_.@nextCharId);
		this.maxNumChars_ = int(this.charsXML_.@maxNumChars);
		for each (_local_1 in this.charsXML_.Char)
		{
			this.savedChars_.push(new SavedCharacter(_local_1, this.name_));
			this.numChars_++;
		}
		this.savedChars_.sort(SavedCharacter.compare);
	}

	private function parseCharacterStatsData():void
	{
		var _local_1:XML;
		var _local_2:int;
		var _local_3:CharacterStats;
		var _local_4:XML = XML(this.charsXML_.Account.Stats);
		for each (_local_1 in _local_4.ClassStats)
		{
			_local_2 = int(_local_1.@objectType);
			_local_3 = new CharacterStats(_local_1);
			this.numStars_ = (this.numStars_ + _local_3.numStars());
			this.charStats_[_local_2] = _local_3;
		}
	}

	private function parseNewsData():void
	{
		var _local_1:XML;
		var _local_2:XML = XML(this.charsXML_.News);
		for each (_local_1 in _local_2.Item)
		{
			this.news_.push(new SavedNewsItem(_local_1.Icon, _local_1.Title, _local_1.TagLine, _local_1.Link, int(_local_1.Date)));
		}
	}

	private function parseGeoPositioningData():void
	{
		if (((this.charsXML_.hasOwnProperty("Lat")) && (this.charsXML_.hasOwnProperty("Long"))))
		{
			this.myPos_ = new LatLong(Number(this.charsXML_.Lat), Number(this.charsXML_.Long));
		}
		else
		{
			this.myPos_ = DEFAULT_LATLONG;
		}
	}

	private function parseSalesForceData():void
	{
		if (((this.charsXML_.hasOwnProperty("SalesForce")) && (this.charsXML_.hasOwnProperty("SalesForce"))))
		{
			this.salesForceData_ = String(this.charsXML_.SalesForce);
		}
	}

	private function parseTOSPopup():void
	{
		if (this.charsXML_.hasOwnProperty("TOSPopup"))
		{
			StaticInjectorContext.getInjector().getInstance(ShowPopupSignal).dispatch(new ToSPopup());
		}
	}

	public function isFirstTimeLogin():Boolean
	{
		return (!(this.charsXML_.hasOwnProperty("TOSPopup")));
	}

	public function bestLevel(_arg_1:int):int
	{
		var _local_2:CharacterStats = this.charStats_[_arg_1];
		return ((_local_2 == null) ? 0 : _local_2.bestLevel());
	}

	public function bestOverallLevel():int
	{
		var _local_1:CharacterStats;
		var _local_2:int;
		for each (_local_1 in this.charStats_)
		{
			if (_local_1.bestLevel() > _local_2)
			{
				_local_2 = _local_1.bestLevel();
			}
		}
		return (_local_2);
	}

	public function bestFame(_arg_1:int):int
	{
		var _local_2:CharacterStats = this.charStats_[_arg_1];
		return ((_local_2 == null) ? 0 : _local_2.bestFame());
	}

	public function bestOverallFame():int
	{
		var _local_1:CharacterStats;
		var _local_2:int;
		for each (_local_1 in this.charStats_)
		{
			if (_local_1.bestFame() > _local_2)
			{
				_local_2 = _local_1.bestFame();
			}
		}
		return (_local_2);
	}

	public function levelRequirementsMet(_arg_1:int):Boolean
	{
		var _local_2:XML;
		var _local_3:int;
		var _local_4:XML = ObjectLibrary.xmlLibrary_[_arg_1];
		for each (_local_2 in _local_4.UnlockLevel)
		{
			_local_3 = ObjectLibrary.idToType_[_local_2.toString()];
			if (this.bestLevel(_local_3) < int(_local_2.@level))
			{
				return (false);
			}
		}
		return (true);
	}

	public function availableCharSlots():int
	{
		return (this.maxNumChars_ - this.numChars_);
	}

	public function hasAvailableCharSlot():Boolean
	{
		return (this.numChars_ < this.maxNumChars_);
	}

	public function newUnlocks(_arg_1:int, _arg_2:int):Array
	{
		var _local_3:XML;
		var _local_4:int;
		var _local_5:Boolean;
		var _local_6:Boolean;
		var _local_7:XML;
		var _local_8:int;
		var _local_9:int;
		var _local_11:int;
		var _local_10:Array = [];
		while (_local_11 < ObjectLibrary.playerChars_.length)
		{
			_local_3 = ObjectLibrary.playerChars_[_local_11];
			_local_4 = int(_local_3.@type);
			if (!this.levelRequirementsMet(_local_4))
			{
				_local_5 = true;
				_local_6 = false;
				for each (_local_7 in _local_3.UnlockLevel)
				{
					_local_8 = ObjectLibrary.idToType_[_local_7.toString()];
					_local_9 = int(_local_7.@level);
					if (this.bestLevel(_local_8) < _local_9)
					{
						if (((!(_local_8 == _arg_1)) || (!(_local_9 == _arg_2))))
						{
							_local_5 = false;
							break;
						}
						_local_6 = true;
					}
				}
				if (((_local_5) && (_local_6)))
				{
					_local_10.push(_local_4);
				}
			}
			_local_11++;
		}
		return (_local_10);
	}

	override public function clone():Event
	{
		return (new SavedCharactersList(this.origData_));
	}

	override public function toString():String
	{
		return ((((("[" + " numChars: ") + this.numChars_) + " maxNumChars: ") + this.maxNumChars_) + " ]");
	}

	private function reportUnlocked():void
	{
		var _local_1:Injector = StaticInjectorContext.getInjector();
		if (_local_1)
		{
			this.account = _local_1.getInstance(Account);
			((this.account) && (this.updateAccount()));
		}
	}

	private function updateAccount():void
	{
		var _local_1:XML;
		var _local_2:int;
		var _local_3:int;
		var _local_4:int;
		while (_local_4 < ObjectLibrary.playerChars_.length)
		{
			_local_1 = ObjectLibrary.playerChars_[_local_4];
			_local_2 = int(_local_1.@type);
			if (this.levelRequirementsMet(_local_2))
			{
				this.account.reportIntStat((_local_1.@id + "Unlocked"), 1);
				_local_3++;
			}
			_local_4++;
		}
		this.account.reportIntStat("ClassesUnlocked", _local_3);
	}


}
}//package com.company.assembleegameclient.appengine

