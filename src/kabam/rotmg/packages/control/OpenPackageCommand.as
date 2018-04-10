// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//kabam.rotmg.packages.control.OpenPackageCommand

package kabam.rotmg.packages.control{
import robotlegs.bender.bundles.mvcs.Command;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.packages.services.PackageModel;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
import kabam.rotmg.packages.model.PackageInfo;
import io.decagames.rotmg.shop.packages.startupPackage.StartupPackage;

public class OpenPackageCommand extends Command {

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


    override public function execute():void{
        var _local_1:PackageInfo = this.packageModel.getPackageById(this.packageId);
        if (((_local_1) && (!(_local_1.popupImage == "")))){
            this.showPopupSignal.dispatch(new StartupPackage(_local_1));
        };
    }


}
}//package kabam.rotmg.packages.control

