﻿//kabam.rotmg.account.core.view.PurchaseConfirmationDialog

package kabam.rotmg.account.core.view
{
import com.company.assembleegameclient.ui.dialogs.Dialog;

public class PurchaseConfirmationDialog extends Dialog
{

	public var confirmedHandler:Function;

	public function PurchaseConfirmationDialog(_arg_1:Function):void
	{
		super("Purchase confirmation", "Continue with purchase?", "Yes", "No");
		this.confirmedHandler = _arg_1;
	}

}
}//package kabam.rotmg.account.core.view

