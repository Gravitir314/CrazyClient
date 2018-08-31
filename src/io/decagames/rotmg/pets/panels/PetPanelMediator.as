//io.decagames.rotmg.pets.panels.PetPanelMediator

package io.decagames.rotmg.pets.panels
{
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.assembleegameclient.util.StageProxy;

import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import io.decagames.rotmg.pets.data.PetsModel;
import io.decagames.rotmg.pets.data.vo.PetVO;
import io.decagames.rotmg.pets.popup.releasePet.ReleasePetDialog;
import io.decagames.rotmg.pets.signals.ActivatePet;
import io.decagames.rotmg.pets.signals.DeactivatePet;
import io.decagames.rotmg.pets.signals.NotifyActivePetUpdated;
import io.decagames.rotmg.pets.signals.ShowPetTooltip;
import io.decagames.rotmg.pets.utils.PetsConstants;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

import org.swiftsuspenders.Injector;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PetPanelMediator extends Mediator
    {

        [Inject]
        public var view:PetPanel;
        [Inject]
        public var petModel:PetsModel;
        [Inject]
        public var showPetTooltip:ShowPetTooltip;
        [Inject]
        public var showToolTip:ShowTooltipSignal;
        [Inject]
        public var deactivatePet:DeactivatePet;
        [Inject]
        public var activatePet:ActivatePet;
        [Inject]
        public var notifyActivePetUpdated:NotifyActivePetUpdated;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var injector:Injector;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        private var stageProxy:StageProxy;


        override public function initialize():void
        {
            this.view.setState(this.returnButtonState());
            this.view.addToolTip.add(this.onAddToolTip);
            this.stageProxy = new StageProxy(this.view);
            this.setEventListeners();
            this.notifyActivePetUpdated.add(this.onNotifyActivePetUpdated);
        }

        private function setEventListeners():void
        {
            this.view.followButton.addEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.view.releaseButton.addEventListener(MouseEvent.CLICK, this.onReleaseClick);
            this.view.unFollowButton.addEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.stageProxy.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        }

        override public function destroy():void
        {
            this.view.followButton.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.view.releaseButton.removeEventListener(MouseEvent.CLICK, this.onReleaseClick);
            this.view.unFollowButton.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.stageProxy.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        }

        private function onReleaseClick(_arg_1:MouseEvent):void
        {
            this.injector.map(PetVO).toValue(this.view.petVO);
            this.showPopupSignal.dispatch(new ReleasePetDialog(this.view.petVO.getID()));
        }

        private function onNotifyActivePetUpdated():void
        {
            var _local_1:PetVO = this.petModel.getActivePet();
            this.view.toggleButtons((!(_local_1)));
        }

        private function returnButtonState():uint
        {
            if (this.isPanelPetSameAsActivePet())
            {
                return (PetsConstants.FOLLOWING);
            }
            return (PetsConstants.INTERACTING);
        }

        private function onKeyDown(_arg_1:KeyboardEvent):void
        {
            if (((_arg_1.keyCode == Parameters.data_.interact) && (this.view.stage.focus == null)))
            {
                this.followPet();
            }
        }

        protected function onButtonClick(_arg_1:MouseEvent):void
        {
            this.followPet();
        }

        private function followPet():void
        {
            if (this.isPanelPetSameAsActivePet())
            {
                this.deactivatePet.dispatch(this.view.petVO.getID());
            }
            else
            {
                this.activatePet.dispatch(this.view.petVO.getID());
            }
        }

        private function onAddToolTip(_arg_1:ToolTip):void
        {
            this.showToolTip.dispatch(_arg_1);
        }

        private function isPanelPetSameAsActivePet():Boolean
        {
            return ((this.petModel.getActivePet()) ? (this.petModel.getActivePet().getID() == this.view.petVO.getID()) : false);
        }


    }
}//package io.decagames.rotmg.pets.panels

