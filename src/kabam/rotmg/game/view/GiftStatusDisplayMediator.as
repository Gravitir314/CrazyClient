//kabam.rotmg.game.view.GiftStatusDisplayMediator

package kabam.rotmg.game.view
{
import com.company.assembleegameclient.game.GiftStatusModel;
import com.company.assembleegameclient.game.events.DisplayAreaChangedSignal;

import kabam.rotmg.game.signals.UpdateGiftStatusDisplaySignal;

public class GiftStatusDisplayMediator
{

	[Inject]
	public var updateGiftStatusDisplay:UpdateGiftStatusDisplaySignal;
	[Inject]
	public var view:GiftStatusDisplay;
	[Inject]
	public var giftStatusModel:GiftStatusModel;
	[Inject]
	public var displayAreaChangedSignal:DisplayAreaChangedSignal;


	public function initialize():void
	{
		this.updateGiftStatusDisplay.add(this.onGiftChestUpdate);
		this.onGiftChestUpdate();
	}

	private function onGiftChestUpdate():void
	{
		if (this.giftStatusModel.hasGift)
		{
			this.view.drawAsOpen();
		}
		else
		{
			this.view.drawAsClosed();
		}
		this.displayAreaChangedSignal.dispatch();
	}


}
}//package kabam.rotmg.game.view

