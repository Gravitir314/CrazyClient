// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.account.kabam.commands.KabamOpenAccountInfoCommand

package kabam.rotmg.account.kabam.commands
{
import kabam.rotmg.account.kabam.view.KabamAccountDetailDialog;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class KabamOpenAccountInfoCommand
    {

        [Inject]
        public var openDialog:OpenDialogSignal;


        public function execute():void
        {
            this.openDialog.dispatch(new KabamAccountDetailDialog());
        }


    }
}//package kabam.rotmg.account.kabam.commands

