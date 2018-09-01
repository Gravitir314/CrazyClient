﻿//io.decagames.rotmg.shop.mysteryBox.contentPopup.UIItemContainerMediator

package io.decagames.rotmg.shop.mysteryBox.contentPopup
{
import com.company.assembleegameclient.constants.InventoryOwnerTypes;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;

import flash.events.MouseEvent;

import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class UIItemContainerMediator extends Mediator
{

	[Inject]
	public var view:UIItemContainer;
	[Inject]
	public var hud:HUDModel;
	[Inject]
	public var showTooltipSignal:ShowTooltipSignal;
	private var tooltip:EquipmentToolTip;


	override public function initialize():void
	{
		var _local_1:Player = (((this.hud.gameSprite) && (this.hud.gameSprite.map)) ? this.hud.gameSprite.map.player_ : null);
		var _local_2:int = ObjectLibrary.idToType_[int(this.view.itemId)];
		this.tooltip = new EquipmentToolTip(int(this.view.itemId), _local_1, _local_2, InventoryOwnerTypes.CURRENT_PLAYER);
		this.view.addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
	}

	private function onRollOverHandler(_arg_1:MouseEvent):void
	{
		if (this.view.showTooltip)
		{
			this.tooltip.attachToTarget(this.view);
			this.showTooltipSignal.dispatch(this.tooltip);
		}
	}

	override public function destroy():void
	{
		this.view.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
		this.tooltip.detachFromTarget();
	}


}
}//package io.decagames.rotmg.shop.mysteryBox.contentPopup

