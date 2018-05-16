// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlotMediator

package io.decagames.rotmg.dailyQuests.view.slot
{
import com.company.assembleegameclient.constants.InventoryOwnerTypes;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;

import flash.events.MouseEvent;

import io.decagames.rotmg.dailyQuests.data.DailyQuestItemSlotType;
import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
import io.decagames.rotmg.dailyQuests.signal.SelectedItemSlotsSignal;
import io.decagames.rotmg.dailyQuests.signal.UnselectAllSlotsSignal;

import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class DailyQuestItemSlotMediator extends Mediator 
    {

        [Inject]
        public var view:DailyQuestItemSlot;
        [Inject]
        public var hud:HUDModel;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var selectedItemSlotsSignal:SelectedItemSlotsSignal;
        [Inject]
        public var unselectAllSignal:UnselectAllSlotsSignal;
        [Inject]
        public var model:DailyQuestsModel;
        private var tooltip:EquipmentToolTip;


        override public function initialize():void
        {
            var _local_1:Player = (((this.hud.gameSprite) && (this.hud.gameSprite.map)) ? this.hud.gameSprite.map.player_ : null);
            var _local_2:int = ObjectLibrary.idToType_[this.view.itemID];
            this.tooltip = new EquipmentToolTip(this.view.itemID, ((this.view.type == DailyQuestItemSlotType.REQUIREMENT) ? null : _local_1), _local_2, InventoryOwnerTypes.CURRENT_PLAYER);
            this.view.addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
            if (this.view.isSlotsSelectable){
                this.unselectAllSignal.add(this.unselectHandler);
                this.view.addEventListener(MouseEvent.CLICK, this.onSlotSelected);
            }
        }

        private function unselectHandler(_arg_1:int):void{
            if (this.view.itemID != _arg_1){
                this.view.selected = false;
            }
        }

        override public function destroy():void{
            this.view.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
            if (this.view.isSlotsSelectable){
                this.unselectAllSignal.remove(this.unselectHandler);
                this.view.removeEventListener(MouseEvent.CLICK, this.onSlotSelected);
            }
            this.view.dispose();
        }

        private function onSlotSelected(_arg_1:MouseEvent):void{
            this.view.selected = (!(this.view.selected));
            this.unselectAllSignal.dispatch(this.view.itemID);
            if (this.view.selected){
                this.model.selectedItem = this.view.itemID;
            } else {
                this.model.selectedItem = -1;
            }
            this.selectedItemSlotsSignal.dispatch(this.model.selectedItem);
        }

        private function onRollOverHandler(_arg_1:MouseEvent):void
        {
            this.tooltip.attachToTarget(this.view);
            this.showTooltipSignal.dispatch(this.tooltip);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.slot

