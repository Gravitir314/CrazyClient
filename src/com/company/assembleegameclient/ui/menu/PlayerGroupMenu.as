//com.company.assembleegameclient.ui.menu.PlayerGroupMenu

package com.company.assembleegameclient.ui.menu
{
import com.company.assembleegameclient.map.AbstractMap;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.GameObjectListItem;
import com.company.assembleegameclient.ui.LineBreakDesign;

import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

public class PlayerGroupMenu extends Menu
{

	private var playerPanels_:Vector.<GameObjectListItem> = new Vector.<GameObjectListItem>();
	private var posY:uint = 4;
	public var map_:AbstractMap;
	public var players_:Vector.<Player>;
	public var teleportOption_:MenuOption;
	public var lineBreakDesign_:LineBreakDesign;
	public var unableToTeleport:Signal = new Signal();

	public function PlayerGroupMenu(_arg_1:AbstractMap, _arg_2:Vector.<Player>)
	{
		super(0x363636, 0xFFFFFF);
		this.map_ = _arg_1;
		this.players_ = _arg_2.concat();
		this.createHeader();
		this.createPlayerList();
	}

	private function createPlayerList():void
	{
		var _local_1:GameObjectListItem;
		var _local_2:Player;
		_local_1 = null;
		for each (_local_2 in this.players_)
		{
			_local_1 = new GameObjectListItem(0xB3B3B3, true, _local_2);
			_local_1.x = 0;
			_local_1.y = this.posY;
			addChild(_local_1);
			this.playerPanels_.push(_local_1);
			_local_1.textReady.addOnce(this.onTextChanged);
			this.posY = (this.posY + 32);
		}
	}

	private function onTextChanged():void
	{
		var _local_1:GameObjectListItem;
		draw();
		for each (_local_1 in this.playerPanels_)
		{
			_local_1.textReady.remove(this.onTextChanged);
		}
	}

	private function createHeader():void
	{
		if (this.map_.allowPlayerTeleport())
		{
			this.teleportOption_ = new TeleportMenuOption(this.map_.player_);
			this.teleportOption_.x = 8;
			this.teleportOption_.y = 8;
			this.teleportOption_.addEventListener(MouseEvent.CLICK, this.onTeleport);
			addChild(this.teleportOption_);
			this.lineBreakDesign_ = new LineBreakDesign(150, 0x1C1C1C);
			this.lineBreakDesign_.x = 6;
			this.lineBreakDesign_.y = 40;
			addChild(this.lineBreakDesign_);
			this.posY = 52;
		}
	}

	private function onTeleport(_arg_1:Event):void
	{
		var _local_2:Player;
		var _local_4:Player;
		var _local_3:Player = this.map_.player_;
		for each (_local_2 in this.players_)
		{
			if (_local_3.isTeleportEligible(_local_2))
			{
				_local_4 = _local_2;
				if (_local_3.msUtilTeleport() > Player.MS_BETWEEN_TELEPORT)
				{
					if (_local_2.isFellowGuild_) break;
				}
				else
				{
					break;
				}
			}
		}
		if (_local_4 != null)
		{
			_local_3.teleportTo(_local_4);
		}
		else
		{
			this.unableToTeleport.dispatch();
		}
		remove();
	}


}
}//package com.company.assembleegameclient.ui.menu

