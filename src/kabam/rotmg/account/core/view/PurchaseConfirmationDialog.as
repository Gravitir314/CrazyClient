// Decompiled by AS3 Sorcerer 5.64
// www.as3sorcerer.com

//kabam.rotmg.account.core.view.PurchaseConfirmationDialog

package kabam.rotmg.account.core.view{
import com.company.assembleegameclient.ui.dialogs.Dialog;

public class PurchaseConfirmationDialog extends Dialog {

        public var confirmedHandler:Function;

        public function PurchaseConfirmationDialog(_arg_1:Function):void{
            super("Purchase confirmation", "Continue with purchase?", "Yes", "No", null);
            this.confirmedHandler = _arg_1;
        }

    }
}//package kabam.rotmg.account.core.view

