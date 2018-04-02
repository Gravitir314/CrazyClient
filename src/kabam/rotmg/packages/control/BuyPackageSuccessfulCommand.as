// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.packages.control.BuyPackageSuccessfulCommand

package kabam.rotmg.packages.control
{
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.packages.view.PackageInfoDialog;
import kabam.rotmg.text.model.TextKey;

public class BuyPackageSuccessfulCommand
    {

        [Inject]
        public var openDialog:OpenDialogSignal;


        public function execute():void
        {
            this.openDialog.dispatch(this.makeDialog());
        }

        private function makeDialog():PackageInfoDialog
        {
            return (new PackageInfoDialog().setTitle(TextKey.PACKAGE_PURCHASED_TITLE).setBody(TextKey.PACKAGE_PURCHASED_MESSAGE, TextKey.PACKAGE_PURCHASED_BODY));
        }


    }
}//package kabam.rotmg.packages.control

