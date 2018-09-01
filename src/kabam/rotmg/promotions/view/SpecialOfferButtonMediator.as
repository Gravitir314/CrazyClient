//kabam.rotmg.promotions.view.SpecialOfferButtonMediator

package kabam.rotmg.promotions.view
{
import kabam.rotmg.promotions.model.BeginnersPackageModel;
import kabam.rotmg.promotions.signals.PackageStatusUpdateSignal;
import kabam.rotmg.promotions.signals.ShowBeginnersPackageSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class SpecialOfferButtonMediator extends Mediator
{

	[Inject]
	public var view:SpecialOfferButton;
	[Inject]
	public var beginnersPackageModel:BeginnersPackageModel;
	[Inject]
	public var showBeginnersPackage:ShowBeginnersPackageSignal;
	[Inject]
	public var packageStatusUpdateSignal:PackageStatusUpdateSignal;

	override public function initialize():void
	{
		this.updatePackageStatus();
		this.packageStatusUpdateSignal.add(this.updatePackageStatus);
		this.beginnersPackageModel.markedAsPurchased.addOnce(this.onMarkedAsPurchased);
		this.view.clicked.add(this.onButtonClick);
	}

	private function updatePackageStatus():void
	{
		this.view.isSpecialOfferAvailable = (this.beginnersPackageModel.status != BeginnersPackageModel.STATUS_CANNOT_BUY);
		if (!this.view.isSpecialOfferAvailable)
		{
			this.view.destroy();
		}
	}

	override public function destroy():void
	{
		this.beginnersPackageModel.markedAsPurchased.remove(this.onMarkedAsPurchased);
		this.view.clicked.remove(this.onButtonClick);
	}

	private function onButtonClick():void
	{
		this.showBeginnersPackage.dispatch();
	}

	private function onMarkedAsPurchased():void
	{
		this.view.destroy();
	}


}
}//package kabam.rotmg.promotions.view

