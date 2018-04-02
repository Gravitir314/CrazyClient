// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.account.core.commands.InternalOpenMoneyWindowCommand

package kabam.rotmg.account.core.commands
{
import kabam.rotmg.account.core.view.MoneyFrame;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class InternalOpenMoneyWindowCommand 
    {

        [Inject]
        public var openDialog:OpenDialogSignal;


        public function execute():void
        {
            this.openDialog.dispatch(new MoneyFrame());
        }


    }
}//package kabam.rotmg.account.core.commands

