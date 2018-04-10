// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfoMediator

package io.decagames.rotmg.dailyQuests.view.info
{
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InventoryTile;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;

import flash.events.MouseEvent;

import io.decagames.rotmg.dailyQuests.model.DailyQuest;
import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
import io.decagames.rotmg.dailyQuests.signal.LockQuestScreenSignal;
import io.decagames.rotmg.dailyQuests.signal.QuestRedeemCompleteSignal;
import io.decagames.rotmg.dailyQuests.signal.SelectedItemSlotsSignal;
import io.decagames.rotmg.dailyQuests.signal.ShowQuestInfoSignal;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.game.view.components.BackpackTabContent;
import kabam.rotmg.game.view.components.InventoryTabContent;
import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class DailyQuestInfoMediator extends Mediator 
    {

        [Inject]
        public var showInfoSignal:ShowQuestInfoSignal;
        [Inject]
        public var view:DailyQuestInfo;
        [Inject]
        public var model:DailyQuestsModel;
        [Inject]
        public var hud:HUDModel;
        [Inject]
        public var redeemCompleteSignal:QuestRedeemCompleteSignal;
        [Inject]
        public var lockScreen:LockQuestScreenSignal;
        [Inject]
        public var selectedItemSlotsSignal:SelectedItemSlotsSignal;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipsSignal:HideTooltipsSignal;
        private var tooltip:TextToolTip;
        private var hoverTooltipDelegate:HoverTooltipDelegate = new HoverTooltipDelegate();


        override public function initialize():void
        {
            this.showInfoSignal.add(this.showQuestInfo);
            var _local_1:DailyQuest = this.model.first;
            if (_local_1)
            {
                this.showQuestInfo(_local_1.id);
            }
            this.tooltip = new TextToolTip(0x363636, 0x9B9B9B, "", "You must select a reward first!", 190, null);
            this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipsSignal);
            this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.hoverTooltipDelegate.tooltip = this.tooltip;
            this.view.completeButton.addEventListener(MouseEvent.CLICK, this.onCompleteButtonClickHandler);
            this.selectedItemSlotsSignal.add(this.itemSelectedHandler);
        }

        private function itemSelectedHandler(_arg_1:int):void{
            this.view.completeButton.disabled = ((this.model.currentQuest.completed) ? true : ((this.model.selectedItem == -1) ? true : (!(DailyQuestInfo.hasAllItems(this.model.currentQuest.requirements, this.model.playerItemsFromInventory)))));
            if (this.model.selectedItem == -1){
                this.hoverTooltipDelegate.setDisplayObject(this.view.completeButton);
            } else {
                this.hoverTooltipDelegate.removeDisplayObject();
            }
        }


        override public function destroy():void
        {
            this.view.completeButton.removeEventListener(MouseEvent.CLICK, this.onCompleteButtonClickHandler);
            this.showInfoSignal.remove(this.showQuestInfo);
            this.selectedItemSlotsSignal.remove(this.itemSelectedHandler);
        }

        private function showQuestInfo(_arg_1:String):void
        {
            this.model.selectedItem = -1;
            this.view.clear();
            this.model.currentQuest = this.model.getQuestById(_arg_1);
            this.view.show(this.model.currentQuest, this.model.playerItemsFromInventory);
            if (((!(this.view.completeButton.completed)) && (this.model.currentQuest.itemOfChoice))){
                this.view.completeButton.disabled = true;
                this.hoverTooltipDelegate.setDisplayObject(this.view.completeButton);
            }
        }

        private function tileToSlot(_arg_1:InventoryTile):SlotObjectData
        {
            var _local_2:SlotObjectData = new SlotObjectData();
            _local_2.objectId_ = _arg_1.ownerGrid.owner.objectId_;
            _local_2.objectType_ = _arg_1.getItemId();
            _local_2.slotId_ = _arg_1.tileId;
            return (_local_2);
        }

        private function onCompleteButtonClickHandler(_arg_1:MouseEvent):void {
            var _local_2:Vector.<SlotObjectData>;
            var _local_3:BackpackTabContent;
            var _local_4:InventoryTabContent;
            var _local_5:Vector.<int>;
            var _local_6:Vector.<InventoryTile>;
            var _local_7:int;
            var _local_8:InventoryTile;
            if (((!(this.view.completeButton.disabled)) && (!(this.view.completeButton.completed)))) {
                {
                    _local_2 = new Vector.<SlotObjectData>();
                    _local_3 = this.hud.gameSprite.hudView.tabStrip.getTabView(BackpackTabContent);
                    _local_4 = this.hud.gameSprite.hudView.tabStrip.getTabView(InventoryTabContent);
                    _local_5 = this.model.currentQuest.requirements.concat();
                    _local_6 = new Vector.<InventoryTile>();
                    if (_local_3) {
                        _local_6 = _local_6.concat(_local_3.backpack.tiles);
                    }
                    if (_local_4) {
                        _local_6 = _local_6.concat(_local_4.storage.tiles);
                    }
                    for each (_local_7 in _local_5) {
                        for each (_local_8 in _local_6) {
                            if (_local_8.getItemId() == _local_7) {
                                _local_6.splice(_local_6.indexOf(_local_8), 1);
                                _local_2.push(this.tileToSlot(_local_8));
                                break;
                            }
                        }
                    }
                    this.lockScreen.dispatch();
                    this.hud.gameSprite.gsc_.questRedeem(this.model.currentQuest.id, _local_2, this.model.selectedItem);
                    this.model.currentQuest.completed = true;
                    this.view.completeButton.completed = true;
                    this.view.completeButton.disabled = true;
                }
            }
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.info

