//io.decagames.rotmg.pets.popup.choosePet.ChoosePetPopupMediator

package io.decagames.rotmg.pets.popup.choosePet
{
import flash.events.MouseEvent;

import io.decagames.rotmg.pets.components.petItem.PetItem;
import io.decagames.rotmg.pets.data.PetsModel;
import io.decagames.rotmg.pets.data.vo.PetVO;
import io.decagames.rotmg.pets.signals.ActivatePet;
import io.decagames.rotmg.pets.signals.SelectPetSignal;
import io.decagames.rotmg.pets.utils.PetItemFactory;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.popups.header.PopupHeader;
import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
import io.decagames.rotmg.ui.texture.TextureParser;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ChoosePetPopupMediator extends Mediator
    {

        [Inject]
        public var view:ChoosePetPopup;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var petIconFactory:PetItemFactory;
        [Inject]
        public var model:PetsModel;
        [Inject]
        public var selectPetSignal:SelectPetSignal;
        [Inject]
        public var activatePet:ActivatePet;
        private var petsList:Vector.<PetItem>;
        private var closeButton:SliceScalingButton;


        override public function initialize():void
        {
            var _local_1:PetVO;
            var _local_2:PetItem;
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.petsList = new Vector.<PetItem>();
            for each (_local_1 in this.model.getAllPets())
            {
                _local_2 = this.petIconFactory.create(_local_1, 40, 0x545454, 1);
                _local_2.addEventListener(MouseEvent.CLICK, this.onPetSelected);
                this.petsList.push(_local_2);
                this.view.addPet(_local_2);
            }
        }

        private function onPetSelected(_arg_1:MouseEvent):void
        {
            var _local_2:PetItem = PetItem(_arg_1.currentTarget);
            this.activatePet.dispatch(_local_2.getPetVO().getID());
            this.selectPetSignal.dispatch(_local_2.getPetVO());
            this.closePopupSignal.dispatch(this.view);
        }

        override public function destroy():void
        {
            var _local_1:PetItem;
            this.closeButton.dispose();
            for each (_local_1 in this.petsList)
            {
                _local_1.removeEventListener(MouseEvent.CLICK, this.onPetSelected);
            }
            this.petsList = new Vector.<PetItem>();
        }

        private function onClose(_arg_1:BaseButton):void
        {
            this.closePopupSignal.dispatch(this.view);
        }


    }
}//package io.decagames.rotmg.pets.popup.choosePet

