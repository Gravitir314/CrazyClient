//io.decagames.rotmg.pets.windows.yard.feed.FeedTabMediator

package io.decagames.rotmg.pets.windows.yard.feed
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InventoryTile;
import com.company.assembleegameclient.util.Currency;

import io.decagames.rotmg.pets.data.PetsModel;
import io.decagames.rotmg.pets.data.vo.PetVO;
import io.decagames.rotmg.pets.data.vo.requests.FeedPetRequestVO;
import io.decagames.rotmg.pets.signals.SelectFeedItemSignal;
import io.decagames.rotmg.pets.signals.SelectPetSignal;
import io.decagames.rotmg.pets.signals.SimulateFeedSignal;
import io.decagames.rotmg.pets.signals.UpgradePetSignal;
import io.decagames.rotmg.pets.utils.FeedFuseCostModel;
import io.decagames.rotmg.pets.windows.yard.feed.items.FeedItem;
import io.decagames.rotmg.shop.NotEnoughResources;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
import io.decagames.rotmg.ui.popups.signals.RemoveLockFade;
import io.decagames.rotmg.ui.popups.signals.ShowLockFade;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.game.view.components.InventoryTabContent;
import kabam.rotmg.messaging.impl.PetUpgradeRequest;
import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class FeedTabMediator extends Mediator
    {

        [Inject]
        public var view:FeedTab;
        [Inject]
        public var hud:HUDModel;
        [Inject]
        public var model:PetsModel;
        [Inject]
        public var selectFeedItemSignal:SelectFeedItemSignal;
        [Inject]
        public var selectPetSignal:SelectPetSignal;
        [Inject]
        public var gameModel:GameModel;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var showPopup:ShowPopupSignal;
        [Inject]
        public var upgradePet:UpgradePetSignal;
        [Inject]
        public var showFade:ShowLockFade;
        [Inject]
        public var removeFade:RemoveLockFade;
        [Inject]
        public var simulateFeed:SimulateFeedSignal;
        private var currentPet:PetVO;
        private var items:Vector.<FeedItem>;


        override public function initialize():void
        {
            this.currentPet = ((this.model.activeUIVO) ? this.model.activeUIVO : this.model.getActivePet());
            this.selectPetSignal.add(this.onPetSelected);
            this.items = new Vector.<FeedItem>();
            this.selectFeedItemSignal.add(this.refreshFeedPower);
            this.view.feedGoldButton.clickSignal.add(this.purchaseGold);
            this.view.feedFameButton.clickSignal.add(this.purchaseFame);
            this.view.displaySignal.add(this.showHideSignal);
            this.renderItems();
            this.refreshFeedPower();
        }

        override public function destroy():void
        {
            this.items = new Vector.<FeedItem>();
            this.selectFeedItemSignal.remove(this.refreshFeedPower);
            this.selectPetSignal.remove(this.onPetSelected);
            this.view.feedGoldButton.clickSignal.remove(this.purchaseGold);
            this.view.feedFameButton.clickSignal.remove(this.purchaseFame);
            this.view.displaySignal.remove(this.showHideSignal);
        }

        private function showHideSignal(_arg_1:Boolean):void
        {
            var _local_2:FeedItem;
            if (!_arg_1)
            {
                for each (_local_2 in this.items)
                {
                    _local_2.selected = false;
                }
                this.refreshFeedPower();
            }
        }

        private function renderItems():void
        {
            var _local_3:InventoryTile;
            var _local_4:int;
            var _local_5:FeedItem;
            this.view.clearGrid();
            this.items = new Vector.<FeedItem>();
            var _local_1:InventoryTabContent = this.hud.gameSprite.hudView.tabStrip.getTabView(InventoryTabContent);
            var _local_2:Vector.<InventoryTile> = new Vector.<InventoryTile>();
            if (_local_1)
            {
                _local_2 = _local_2.concat(_local_1.storage.tiles);
            }
            for each (_local_3 in _local_2)
            {
                _local_4 = _local_3.getItemId();
                if (((!(_local_4 == -1)) && (this.hasFeedPower(_local_4))))
                {
                    _local_5 = new FeedItem(_local_3);
                    this.items.push(_local_5);
                    this.view.addItem(_local_5);
                }
            }
        }

        private function refreshFeedPower():void
        {
            var _local_3:FeedItem;
            var _local_1:int;
            var _local_2:int;
            for each (_local_3 in this.items)
            {
                if (_local_3.selected)
                {
                    _local_1 = (_local_1 + _local_3.feedPower);
                    _local_2++;
                }
            }
            if (this.currentPet)
            {
                this.view.feedGoldButton.price = (FeedFuseCostModel.getFeedGoldCost(this.currentPet.rarity) * _local_2);
                this.view.feedFameButton.price = (FeedFuseCostModel.getFeedFameCost(this.currentPet.rarity) * _local_2);
                this.view.updateFeedPower(_local_1, this.currentPet.maxedAvailableAbilities());
            }
            else
            {
                this.view.feedGoldButton.price = 0;
                this.view.feedFameButton.price = 0;
                this.view.updateFeedPower(0, false);
            }
            this.simulateFeed.dispatch(_local_1);
        }

        private function get currentGold():int
        {
            var _local_1:Player = this.gameModel.player;
            if (_local_1 != null)
            {
                return (_local_1.credits_);
            }
            if (this.playerModel != null)
            {
                return (this.playerModel.getCredits());
            }
            return (0);
        }

        private function get currentFame():int
        {
            var _local_1:Player = this.gameModel.player;
            if (_local_1 != null)
            {
                return (_local_1.fame_);
            }
            if (this.playerModel != null)
            {
                return (this.playerModel.getFame());
            }
            return (0);
        }

        private function hasFeedPower(_arg_1:int):Boolean
        {
            var _local_2:XML = ObjectLibrary.xmlLibrary_[_arg_1];
            return (_local_2.hasOwnProperty("feedPower"));
        }

        private function purchaseFame(_arg_1:BaseButton):void
        {
            this.purchase(PetUpgradeRequest.FAME_PAYMENT_TYPE, this.view.feedFameButton.price);
        }

        private function purchaseGold(_arg_1:BaseButton):void
        {
            this.purchase(PetUpgradeRequest.GOLD_PAYMENT_TYPE, this.view.feedGoldButton.price);
        }

        private function purchase(_arg_1:int, _arg_2:int):void
        {
            var _local_4:FeedItem;
            var _local_5:FeedPetRequestVO;
            var _local_6:SlotObjectData;
            if (!this.checkYardType())
            {
                return;
            }
            if (((_arg_1 == PetUpgradeRequest.GOLD_PAYMENT_TYPE) && (this.currentGold < _arg_2)))
            {
                this.showPopup.dispatch(new NotEnoughResources(300, Currency.GOLD));
                return;
            }
            if (((_arg_1 == PetUpgradeRequest.FAME_PAYMENT_TYPE) && (this.currentFame < _arg_2)))
            {
                this.showPopup.dispatch(new NotEnoughResources(300, Currency.FAME));
                return;
            }
            var _local_3:Vector.<SlotObjectData> = new Vector.<SlotObjectData>();
            for each (_local_4 in this.items)
            {
                if (_local_4.selected)
                {
                    _local_6 = new SlotObjectData();
                    _local_6.objectId_ = _local_4.item.ownerGrid.owner.objectId_;
                    _local_6.objectType_ = _local_4.item.getItemId();
                    _local_6.slotId_ = _local_4.item.tileId;
                    _local_3.push(_local_6);
                }
            }
            this.currentPet.abilityUpdated.addOnce(this.abilityUpdated);
            this.showFade.dispatch();
            _local_5 = new FeedPetRequestVO(this.currentPet.getID(), _local_3, _arg_1);
            this.upgradePet.dispatch(_local_5);
        }

        private function abilityUpdated():void
        {
            var _local_1:FeedItem;
            this.removeFade.dispatch();
            this.renderItems();
            for each (_local_1 in this.items)
            {
                _local_1.selected = false;
            }
            this.refreshFeedPower();
        }

        private function onPetSelected(_arg_1:PetVO):void
        {
            var _local_2:FeedItem;
            this.currentPet = _arg_1;
            for each (_local_2 in this.items)
            {
                _local_2.selected = false;
            }
            this.refreshFeedPower();
        }

        private function checkYardType():Boolean
        {
            if (this.currentPet.rarity.ordinal >= this.model.getPetYardType())
            {
                this.showPopup.dispatch(new ErrorModal(350, "Feed Pets", LineBuilder.getLocalizedStringFromKey("server.upgrade_petyard_first")));
                return (false);
            }
            return (true);
        }


    }
}//package io.decagames.rotmg.pets.windows.yard.feed

