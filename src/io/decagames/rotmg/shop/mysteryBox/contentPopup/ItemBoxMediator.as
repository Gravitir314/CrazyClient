// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.mysteryBox.contentPopup.ItemBoxMediator

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

public class ItemBoxMediator extends Mediator 
    {

        [Inject]
        public var view:ItemBox;
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
            this.view.itemBackground.addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        }

        private function onRollOverHandler(_arg_1:MouseEvent):void
        {
            this.tooltip.attachToTarget(this.view);
            this.showTooltipSignal.dispatch(this.tooltip);
        }

        override public function destroy():void
        {
            this.view.itemBackground.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
            this.tooltip.detachFromTarget();
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.contentPopup

