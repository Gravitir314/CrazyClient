// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.pets.view.dialogs.PetPickerDialogMediator

package kabam.rotmg.pets.view.dialogs
{
import kabam.rotmg.dialogs.control.OpenDialogNoModalSignal;
import kabam.rotmg.pets.data.PetSlotsState;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PetPickerDialogMediator extends Mediator 
    {

        [Inject]
        public var view:PetPickerDialog;
        [Inject]
        public var openDialog:OpenDialogNoModalSignal;
        [Inject]
        public var petSlotsState:PetSlotsState;


        override public function initialize():void
        {
            this.view.closeButton.clicked.addOnce(this.onClosed);
        }

        private function onClosed():void
        {
            this.openDialog.dispatch(new this.petSlotsState.caller());
        }


    }
}//package kabam.rotmg.pets.view.dialogs

