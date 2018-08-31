//kabam.rotmg.packages.control.OpenPackageCommand

package kabam.rotmg.packages.control
{
import io.decagames.rotmg.shop.packages.startupPackage.StartupPackage;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.packages.model.PackageInfo;
import kabam.rotmg.packages.services.PackageModel;

import robotlegs.bender.bundles.mvcs.Command;

public class OpenPackageCommand extends Command 
    {

        [Inject]
        public var openDialogSignal:OpenDialogSignal;
        [Inject]
        public var packageModel:PackageModel;
        [Inject]
        public var packageId:int;
        [Inject]
        public var alreadyBoughtPackage:AlreadyBoughtPackageSignal;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;


        override public function execute():void
        {
            var _local_1:PackageInfo = this.packageModel.getPackageById(this.packageId);
            if (((_local_1) && (!(_local_1.popupImage == ""))))
            {
                this.showPopupSignal.dispatch(new StartupPackage(_local_1));
            }
        }


    }
}//package kabam.rotmg.packages.control

