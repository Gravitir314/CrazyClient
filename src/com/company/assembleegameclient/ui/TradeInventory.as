//com.company.assembleegameclient.ui.TradeInventory

package com.company.assembleegameclient.ui
{
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.ui.BaseSimpleText;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.messaging.impl.data.TradeItem;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class TradeInventory extends Sprite
{

	private static const NO_CUT:Array = [0, 0, 0, 0];
	private static const cuts:Array = [[1, 0, 0, 1], NO_CUT, NO_CUT, [0, 1, 1, 0], [1, 0, 0, 0], NO_CUT, NO_CUT, [0, 1, 0, 0], [0, 0, 0, 1], NO_CUT, NO_CUT, [0, 0, 1, 0]];
	public static const CLICKITEMS_MESSAGE:int = 0;
	public static const NOTENOUGHSPACE_MESSAGE:int = 1;
	public static const TRADEACCEPTED_MESSAGE:int = 2;
	public static const TRADEWAITING_MESSAGE:int = 3;

	public var gs_:AGameSprite;
	public var playerName_:String;
	private var message_:int;
	private var nameText_:BaseSimpleText;
	private var taglineText_:TextFieldDisplayConcrete;
	public var slots_:Vector.<TradeSlot> = new Vector.<TradeSlot>();

	public function TradeInventory(_arg_1:AGameSprite, _arg_2:String, _arg_3:Vector.<TradeItem>, _arg_4:Boolean)
	{
		var _local_5:TradeItem;
		var _local_6:TradeSlot;
		var _local_7:int;
		super();
		this.gs_ = _arg_1;
		this.playerName_ = _arg_2;
		this.nameText_ = new BaseSimpleText(20, 0xB3B3B3, false, 0, 0);
		this.nameText_.setBold(true);
		this.nameText_.x = 0;
		this.nameText_.y = 4;
		this.nameText_.text = this.playerName_;
		this.nameText_.updateMetrics();
		this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
		addChild(this.nameText_);
		this.taglineText_ = new TextFieldDisplayConcrete().setSize(12).setColor(0xB3B3B3);
		this.taglineText_.x = 0;
		this.taglineText_.y = 26;
		this.taglineText_.filters = [new DropShadowFilter(0, 0, 0)];
		addChild(this.taglineText_);
		while (_local_7 < (GeneralConstants.NUM_EQUIPMENT_SLOTS + GeneralConstants.NUM_INVENTORY_SLOTS))
		{
			_local_5 = _arg_3[_local_7];
			_local_6 = new TradeSlot(_local_5.item_, _local_5.tradeable_, _local_5.included_, _local_5.slotType_, (_local_7 - 3), cuts[_local_7], _local_7);
			_local_6.setPlayer(this.gs_.map.player_);
			_local_6.x = (int((_local_7 % 4)) * (Slot.WIDTH + 4));
			_local_6.y = ((int((_local_7 / 4)) * (Slot.HEIGHT + 4)) + 46);
			if (((_arg_4) && (_local_5.tradeable_)))
			{
				_local_6.addEventListener(MouseEvent.MOUSE_DOWN, this.onSlotClick);
				_local_6.addEventListener(MouseEvent.RIGHT_CLICK, this.selectAll);
			}
			this.slots_.push(_local_6);
			addChild(_local_6);
			_local_7++;
		}
	}

	private function onSlotClick(_arg_1:MouseEvent):void
	{
		var _local_2:TradeSlot = (_arg_1.currentTarget as TradeSlot);
		_local_2.setIncluded((!(_local_2.included_)));
		dispatchEvent(new Event(Event.CHANGE));
	}

	private function selectAll(_arg_1:MouseEvent):void
	{
		var _local_2:Vector.<Boolean>;
		if (Parameters.data_.instaSelect)
		{
			this.selectAllInstantly();
		}
		else
		{
			_local_2 = new <Boolean>[false, false, false, false, false, false, false, false, false, false, false, false];
			this.gs_.map.player_.select_ = (_arg_1.currentTarget as TradeSlot).item_;
		}
	}

	private function selectAllInstantly():void
	{
		var _local_1:int;
		var _local_2:XML;
		var _local_3:Vector.<Boolean> = new <Boolean>[false, false, false, false, false, false, false, false, false, false, false, false];
		var _local_4:Player = this.gs_.map.player_;
		_local_1 = 4;
		while (_local_1 < 12)
		{
			if (_local_4.equipment_[_local_1] != -1)
			{
				_local_2 = ObjectLibrary.xmlLibrary_[_local_4.equipment_[_local_1]];
				if (!_local_2.hasOwnProperty("Soulbound"))
				{
					_local_3[_local_1] = true;
					this.slots_[_local_1].setIncluded((!(this.slots_[_local_1].included_)));
				}
			}
			_local_1++;
		}
		this.gs_.gsc_.changeTrade(_local_3);
	}

	public function getOffer():Vector.<Boolean>
	{
		var _local_1:int;
		var _local_2:Vector.<Boolean> = new Vector.<Boolean>();
		while (_local_1 < this.slots_.length)
		{
			_local_2.push(this.slots_[_local_1].included_);
			_local_1++;
		}
		return (_local_2);
	}

	public function setOffer(_arg_1:Vector.<Boolean>):void
	{
		var _local_2:int;
		while (_local_2 < this.slots_.length)
		{
			this.slots_[_local_2].setIncluded(_arg_1[_local_2]);
			_local_2++;
		}
	}

	public function isOffer(_arg_1:Vector.<Boolean>):Boolean
	{
		var _local_2:int;
		while (_local_2 < this.slots_.length)
		{
			if (_arg_1[_local_2] != this.slots_[_local_2].included_)
			{
				return (false);
			}
			_local_2++;
		}
		return (true);
	}

	public function numIncluded():int
	{
		var _local_1:int;
		var _local_2:int;
		while (_local_2 < this.slots_.length)
		{
			if (this.slots_[_local_2].included_)
			{
				_local_1++;
			}
			_local_2++;
		}
		return (_local_1);
	}

	public function numEmpty():int
	{
		var _local_1:int;
		var _local_2:int = 4;
		while (_local_2 < this.slots_.length)
		{
			if (this.slots_[_local_2].isEmpty())
			{
				_local_1++;
			}
			_local_2++;
		}
		return (_local_1);
	}

	public function setMessage(_arg_1:int):void
	{
		var _local_2:* = "";
		switch (_arg_1)
		{
			case CLICKITEMS_MESSAGE:
				this.nameText_.setColor(0xB3B3B3);
				this.taglineText_.setColor(0xB3B3B3);
				_local_2 = TextKey.TRADEINVENTORY_CLICKITEMSTOTRADE;
				break;
			case NOTENOUGHSPACE_MESSAGE:
				this.nameText_.setColor(0xFF0000);
				this.taglineText_.setColor(0xFF0000);
				_local_2 = TextKey.TRADEINVENTORY_NOTENOUGHSPACE;
				break;
			case TRADEACCEPTED_MESSAGE:
				this.nameText_.setColor(9022300);
				this.taglineText_.setColor(9022300);
				_local_2 = TextKey.TRADEINVENTORY_TRADEACCEPTED;
				break;
			case TRADEWAITING_MESSAGE:
				this.nameText_.setColor(0xB3B3B3);
				this.taglineText_.setColor(0xB3B3B3);
				_local_2 = TextKey.TRADEINVENTORY_PLAYERISSELECTINGITEMS;
				break;
		}
		this.taglineText_.setStringBuilder(new LineBuilder().setParams(_local_2));
	}


}
}//package com.company.assembleegameclient.ui

