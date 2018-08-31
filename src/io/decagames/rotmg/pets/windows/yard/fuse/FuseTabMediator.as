//io.decagames.rotmg.pets.windows.yard.fuse.FuseTabMediator

package io.decagames.rotmg.pets.windows.yard.fuse
{
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.util.Currency;

import flash.events.MouseEvent;

import io.decagames.rotmg.pets.components.petItem.PetItem;
import io.decagames.rotmg.pets.data.PetsModel;
import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
import io.decagames.rotmg.pets.data.vo.PetVO;
import io.decagames.rotmg.pets.data.vo.requests.FusePetRequestVO;
import io.decagames.rotmg.pets.signals.EvolvePetSignal;
import io.decagames.rotmg.pets.signals.NewAbilitySignal;
import io.decagames.rotmg.pets.signals.SelectFusePetSignal;
import io.decagames.rotmg.pets.signals.SelectPetSignal;
import io.decagames.rotmg.pets.signals.UpgradePetSignal;
import io.decagames.rotmg.pets.utils.FeedFuseCostModel;
import io.decagames.rotmg.pets.utils.FusionCalculator;
import io.decagames.rotmg.pets.utils.PetItemFactory;
import io.decagames.rotmg.shop.NotEnoughResources;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
import io.decagames.rotmg.ui.popups.signals.RemoveLockFade;
import io.decagames.rotmg.ui.popups.signals.ShowLockFade;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.messaging.impl.EvolvePetInfo;
import kabam.rotmg.messaging.impl.PetUpgradeRequest;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import robotlegs.bender.bundles.mvcs.Mediator;

public class FuseTabMediator extends Mediator
    {

        [Inject]
        public var view:FuseTab;
        [Inject]
        public var model:PetsModel;
        [Inject]
        public var petIconFactory:PetItemFactory;
        [Inject]
        public var selectPetSignal:SelectPetSignal;
        [Inject]
        public var selectFusePetSignal:SelectFusePetSignal;
        [Inject]
        public var upgradePet:UpgradePetSignal;
        [Inject]
        public var showFade:ShowLockFade;
        [Inject]
        public var removeFade:RemoveLockFade;
        [Inject]
        public var newAbilityUnlocked:NewAbilitySignal;
        [Inject]
        public var evolvePetSignal:EvolvePetSignal;
        [Inject]
        public var showPopup:ShowPopupSignal;
        [Inject]
        public var gameModel:GameModel;
        [Inject]
        public var playerModel:PlayerModel;
        private var petsList:Vector.<PetItem>;
        private var currentSelectedPet:PetVO;
        private var fusePet:PetVO;


        override public function initialize():void
        {
            this.petsList = new Vector.<PetItem>();
            this.renderFusePets(((this.model.activeUIVO) ? this.model.activeUIVO : this.model.getActivePet()));
            this.selectPetSignal.add(this.onPetSelected);
            this.toggleButtons(false);
            this.view.setStrengthPercentage(-1, ((this.currentSelectedPet) && (this.currentSelectedPet.rarity.ordinal == PetRarityEnum.DIVINE.ordinal)));
            this.view.fuseFameButton.clickSignal.add(this.purchaseFame);
            this.view.fuseGoldButton.clickSignal.add(this.purchaseGold);
            this.view.displaySignal.add(this.showHideSignal);
        }

        override public function destroy():void
        {
            this.clearGrid();
            this.view.fuseFameButton.clickSignal.remove(this.purchaseFame);
            this.view.fuseGoldButton.clickSignal.remove(this.purchaseGold);
            this.newAbilityUnlocked.remove(this.abilityUnlocked);
            this.evolvePetSignal.remove(this.evolvePetHandler);
            this.selectPetSignal.remove(this.onPetSelected);
            this.view.displaySignal.remove(this.showHideSignal);
        }

        private function showHideSignal(_arg_1:Boolean):void
        {
            var _local_2:PetItem;
            if (!_arg_1)
            {
                this.view.setStrengthPercentage(-1);
                this.toggleButtons(false);
                for each (_local_2 in this.petsList)
                {
                    _local_2.selected = false;
                }
            }
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

        private function evolvePetHandler(_arg_1:EvolvePetInfo):void
        {
            this.evolvePetSignal.remove(this.evolvePetHandler);
            this.removeFade.dispatch();
            this.onPetSelected(null);
        }

        private function abilityUnlocked(_arg_1:int):void
        {
            this.newAbilityUnlocked.remove(this.abilityUnlocked);
            this.removeFade.dispatch();
            this.onPetSelected(this.currentSelectedPet);
        }

        private function purchase(_arg_1:int, _arg_2:int):void
        {
            var _local_3:FusePetRequestVO;
            if (this.checkYardType())
            {
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
                this.newAbilityUnlocked.add(this.abilityUnlocked);
                this.evolvePetSignal.add(this.evolvePetHandler);
                _local_3 = new FusePetRequestVO(this.currentSelectedPet.getID(), this.fusePet.getID(), _arg_1);
                this.showFade.dispatch();
                this.upgradePet.dispatch(_local_3);
            }
        }

        private function purchaseFame(_arg_1:BaseButton):void
        {
            this.purchase(PetUpgradeRequest.FAME_PAYMENT_TYPE, this.view.fuseFameButton.price);
        }

        private function purchaseGold(_arg_1:BaseButton):void
        {
            this.purchase(PetUpgradeRequest.GOLD_PAYMENT_TYPE, this.view.fuseGoldButton.price);
        }

        private function checkYardType():Boolean
        {
            if ((this.currentSelectedPet.rarity.ordinal + 1) >= this.model.getPetYardType())
            {
                this.showPopup.dispatch(new ErrorModal(350, "Fuse Pets", LineBuilder.getLocalizedStringFromKey("server.upgrade_petyard_first")));
                return (false);
            }
            return (true);
        }

        private function onPetSelected(_arg_1:PetVO):void
        {
            this.clearGrid();
            this.renderFusePets(_arg_1);
            this.toggleButtons(false);
            this.view.setStrengthPercentage(-1, ((_arg_1) && (_arg_1.rarity.ordinal == PetRarityEnum.DIVINE.ordinal)));
        }

        private function clearGrid():void
        {
            var _local_1:PetItem;
            for each (_local_1 in this.petsList)
            {
                _local_1.removeEventListener(MouseEvent.CLICK, this.onFusePetSelected);
            }
            this.view.clearGrid();
        }

        private function renderFusePets(_arg_1:PetVO):void
        {
            var _local_2:PetVO;
            var _local_3:PetItem;
            if (_arg_1 == null)
            {
                return;
            }
            this.currentSelectedPet = _arg_1;
            if (_arg_1.rarity.ordinal == PetRarityEnum.DIVINE.ordinal)
            {
                this.view.setStrengthPercentage(-1, (_arg_1.rarity.ordinal == PetRarityEnum.DIVINE.ordinal));
                return;
            }
            for each (_local_2 in this.model.getAllPets(_arg_1.family, _arg_1.rarity))
            {
                if (_local_2 != _arg_1)
                {
                    _local_3 = this.petIconFactory.create(_local_2, 40, 0x545454, 1);
                    _local_3.addEventListener(MouseEvent.CLICK, this.onFusePetSelected);
                    this.petsList.push(_local_3);
                    this.view.addPet(_local_3);
                }
            }
        }

        private function onFusePetSelected(_arg_1:MouseEvent):void
        {
            var _local_2:PetItem = PetItem(_arg_1.currentTarget);
            this.selectFusePetSignal.dispatch(_local_2.getPetVO());
            this.selectPet(_local_2);
            this.fusePet = _local_2.getPetVO();
            this.toggleButtons(true);
            this.view.fuseFameButton.price = FeedFuseCostModel.getFuseFameCost(this.currentSelectedPet.rarity);
            this.view.fuseGoldButton.price = FeedFuseCostModel.getFuseGoldCost(this.currentSelectedPet.rarity);
            this.view.setStrengthPercentage(FusionCalculator.getStrengthPercentage(this.currentSelectedPet, _local_2.getPetVO()), ((this.currentSelectedPet) && (this.currentSelectedPet.rarity.ordinal == PetRarityEnum.DIVINE.ordinal)));
        }

        private function toggleButtons(_arg_1:Boolean):void
        {
            this.view.fuseGoldButton.disabled = (!(_arg_1));
            this.view.fuseFameButton.disabled = (!(_arg_1));
            this.view.fuseFameButton.alpha = ((_arg_1) ? 1 : 0);
            this.view.fuseGoldButton.alpha = ((_arg_1) ? 1 : 0);
        }

        private function selectPet(_arg_1:PetItem):void
        {
            var _local_2:PetItem;
            for each (_local_2 in this.petsList)
            {
                _local_2.selected = (_local_2 == _arg_1);
            }
        }


    }
}//package io.decagames.rotmg.pets.windows.yard.fuse

