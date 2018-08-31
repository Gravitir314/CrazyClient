//io.decagames.rotmg.pets.commands.OpenCaretakerQueryDialogCommand

package io.decagames.rotmg.pets.commands
{
import io.decagames.rotmg.pets.components.caretaker.CaretakerQueryDialog;

import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class OpenCaretakerQueryDialogCommand
    {

        [Inject]
        public var openDialog:OpenDialogSignal;


        public function execute():void
        {
            var _local_1:CaretakerQueryDialog = new CaretakerQueryDialog();
            this.openDialog.dispatch(_local_1);
        }


    }
}//package io.decagames.rotmg.pets.commands

