//io.decagames.rotmg.pets.windows.yard.list.PetYardListMediator

package io.decagames.rotmg.pets.windows.yard.list
{
import com.company.assembleegameclient.ui.tooltip.TextToolTip;

import flash.events.MouseEvent;

import io.decagames.rotmg.pets.components.petItem.PetItem;
import io.decagames.rotmg.pets.data.PetsModel;
import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
import io.decagames.rotmg.pets.data.vo.PetVO;
import io.decagames.rotmg.pets.popup.upgradeYard.PetYardUpgradeDialog;
import io.decagames.rotmg.pets.signals.ActivatePet;
import io.decagames.rotmg.pets.signals.EvolvePetSignal;
import io.decagames.rotmg.pets.signals.NewAbilitySignal;
import io.decagames.rotmg.pets.signals.ReleasePetSignal;
import io.decagames.rotmg.pets.signals.SelectPetSignal;
import io.decagames.rotmg.pets.utils.PetItemFactory;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.messaging.impl.EvolvePetInfo;
import kabam.rotmg.tooltips.HoverTooltipDelegate;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PetYardListMediator extends Mediator
    {

        [Inject]
        public var view:PetYardList;
        [Inject]
        public var selectPetSignal:SelectPetSignal;
        [Inject]
        public var activatePet:ActivatePet;
        [Inject]
        public var petIconFactory:PetItemFactory;
        [Inject]
        public var model:PetsModel;
        [Inject]
        public var newAbilityUnlocked:NewAbilitySignal;
        [Inject]
        public var evolvePetSignal:EvolvePetSignal;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        [Inject]
        public var showDialog:ShowPopupSignal;
        [Inject]
        public var account:Account;
        [Inject]
        public var release:ReleasePetSignal;
        private var toolTip:TextToolTip = null;
        private var hoverTooltipDelegate:HoverTooltipDelegate;
        private var petsList:Vector.<PetItem>;


        override public function initialize():void
        {
            this.model.activeUIVO = null;
            this.refreshPetsList();
            this.selectPetVO(this.model.getActivePet());
            this.newAbilityUnlocked.add(this.abilityUnlocked);
            this.evolvePetSignal.add(this.evolvePetHandler);
            var _local_1:PetRarityEnum = PetRarityEnum.selectByOrdinal((this.model.getPetYardType() - 1));
            var _local_2:PetRarityEnum = PetRarityEnum.selectByOrdinal(this.model.getPetYardType());
            this.view.showPetYardRarity(_local_1.rarityName, ((_local_1.ordinal < PetRarityEnum.DIVINE.ordinal) && (this.account.isRegistered())));
            if (this.view.upgradeButton)
            {
                this.view.upgradeButton.clickSignal.add(this.upgradeYard);
                this.toolTip = new TextToolTip(0x363636, 0x9B9B9B, "Upgrade Pet Yard", ("Upgrading your yard allows you to fuse pets up to " + _local_2.rarityName), 180);
                this.hoverTooltipDelegate = new HoverTooltipDelegate();
                this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
                this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
                this.hoverTooltipDelegate.setDisplayObject(this.view.upgradeButton);
                this.hoverTooltipDelegate.tooltip = this.toolTip;
            }
            this.release.add(this.onRelease);
        }

        override public function destroy():void
        {
            this.clearList();
            this.newAbilityUnlocked.remove(this.abilityUnlocked);
            this.evolvePetSignal.remove(this.evolvePetHandler);
            if (this.view.upgradeButton)
            {
                this.view.upgradeButton.clickSignal.add(this.upgradeYard);
            }
            this.release.remove(this.onRelease);
        }

        private function upgradeYard(_arg_1:BaseButton):void
        {
            this.showDialog.dispatch(new PetYardUpgradeDialog(PetRarityEnum.selectByOrdinal(this.model.getPetYardType()), this.model.getPetYardUpgradeGoldPrice(), this.model.getPetYardUpgradeFamePrice()));
        }

        private function selectPetVO(_arg_1:PetVO):void
        {
            var _local_2:PetItem;
            this.model.activeUIVO = _arg_1;
            for each (_local_2 in this.petsList)
            {
                _local_2.selected = (_local_2.getPetVO() == _arg_1);
            }
        }

        private function onPetSelected(_arg_1:MouseEvent):void
        {
            var _local_2:PetItem = PetItem(_arg_1.currentTarget);
            this.selectPetSignal.dispatch(_local_2.getPetVO());
            this.selectPetVO(_local_2.getPetVO());
        }

        private function clearList():void
        {
            var _local_1:PetItem;
            for each (_local_1 in this.petsList)
            {
                _local_1.removeEventListener(MouseEvent.CLICK, this.onPetSelected);
            }
            this.petsList = new Vector.<PetItem>();
        }

        private function refreshPetsList():void
        {
            var _local_2:PetVO;
            var _local_3:PetItem;
            this.clearList();
            this.view.clearPetsList();
            this.petsList = new Vector.<PetItem>();
            var _local_1:Vector.<PetVO> = this.model.getAllPets();
            _local_1 = _local_1.sort(this.sortByFamily);
            for each (_local_2 in _local_1)
            {
                _local_3 = this.petIconFactory.create(_local_2, 40, 0x545454, 1);
                _local_3.addEventListener(MouseEvent.CLICK, this.onPetSelected);
                this.petsList.push(_local_3);
                this.view.addPet(_local_3);
            }
        }

        private function sortByPower(_arg_1:PetVO, _arg_2:PetVO):int
        {
            if (_arg_1.totalAbilitiesLevel() < _arg_2.totalAbilitiesLevel())
            {
                return (1);
            }
            return (-1);
        }

        private function sortByFamily(_arg_1:PetVO, _arg_2:PetVO):int
        {
            if (_arg_1.family == _arg_2.family)
            {
                return (this.sortByPower(_arg_1, _arg_2));
            }
            if (_arg_1.family > _arg_2.family)
            {
                return (1);
            }
            return (-1);
        }

        private function abilityUnlocked(_arg_1:int):void
        {
            this.refreshPetsList();
            this.selectPetVO(((this.model.activeUIVO) ? this.model.activeUIVO : this.model.getActivePet()));
        }

        private function evolvePetHandler(_arg_1:EvolvePetInfo):void
        {
            this.refreshPetsList();
            this.selectPetVO(((this.model.activeUIVO) ? this.model.activeUIVO : this.model.getActivePet()));
        }

        private function onRelease(_arg_1:int):void
        {
            this.model.deletePet(_arg_1);
            this.refreshPetsList();
        }


    }
}//package io.decagames.rotmg.pets.windows.yard.list

