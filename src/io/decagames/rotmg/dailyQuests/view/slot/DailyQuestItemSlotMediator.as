// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlotMediator

package io.decagames.rotmg.dailyQuests.view.slot
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import io.decagames.rotmg.dailyQuests.data.DailyQuestItemSlotType;
    import com.company.assembleegameclient.constants.InventoryOwnerTypes;
    import flash.events.MouseEvent;

    public class DailyQuestItemSlotMediator extends Mediator 
    {

        [Inject]
        public var view:DailyQuestItemSlot;
        [Inject]
        public var hud:HUDModel;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        private var tooltip:EquipmentToolTip;


        override public function initialize():void
        {
            var _local_1:Player = (((this.hud.gameSprite) && (this.hud.gameSprite.map)) ? this.hud.gameSprite.map.player_ : null);
            var _local_2:int = ObjectLibrary.idToType_[this.view.itemID];
            this.tooltip = new EquipmentToolTip(this.view.itemID, ((this.view.type == DailyQuestItemSlotType.REQUIREMENT) ? null : _local_1), _local_2, InventoryOwnerTypes.CURRENT_PLAYER);
            this.view.addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandler);
        }

        private function onRollOverHandler(_arg_1:MouseEvent):void
        {
            this.tooltip.attachToTarget(this.view);
            this.showTooltipSignal.dispatch(this.tooltip);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.slot

