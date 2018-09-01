//kabam.rotmg.dailyLogin.controller.CalendarViewMediator

package kabam.rotmg.dailyLogin.controller
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.dailyLogin.message.ClaimDailyRewardResponse;
import kabam.rotmg.dailyLogin.model.DailyLoginModel;
import kabam.rotmg.dailyLogin.signal.ClaimDailyRewardResponseSignal;
import kabam.rotmg.dailyLogin.view.CalendarView;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CalendarViewMediator extends Mediator
{

	[Inject]
	public var view:CalendarView;
	[Inject]
	public var model:DailyLoginModel;
	[Inject]
	public var addTextLine:AddTextLineSignal;
	[Inject]
	public var claimRewardSignal:ClaimDailyRewardResponseSignal;
	[Inject]
	public var hudModel:HUDModel;


	override public function initialize():void
	{
		this.view.init(this.model.getDaysConfig(this.model.currentDisplayedCaledar), this.model.getMaxDays(this.model.currentDisplayedCaledar), this.model.getCurrentDay(this.model.currentDisplayedCaledar));
		this.claimRewardSignal.add(this.onClaimReward);
	}

	override public function destroy():void
	{
		this.claimRewardSignal.remove(this.onClaimReward);
		super.destroy();
	}

	private function onClaimReward(_arg_1:ClaimDailyRewardResponse):void
	{
		var _local_2:* = "";
		if (_arg_1.gold > 0)
		{
			_local_2 = "gold";
			this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, (((((_arg_1.gold > 0) ? _arg_1.gold : _arg_1.quantity) + "x ") + _local_2) + " was claimed."), -1, -1, "", false));
			if (this.hudModel.gameSprite.map.player_ != null)
			{
				this.hudModel.gameSprite.map.player_.credits_ = (this.hudModel.gameSprite.map.player_.credits_ + _arg_1.gold);
			}
		}
		else
		{
			_local_2 = LineBuilder.getLocalizedStringFromKey(ObjectLibrary.typeToDisplayId_[_arg_1.itemId]);
			this.addTextLine.dispatch(ChatMessage.make(Parameters.SERVER_CHAT_NAME, (((((_arg_1.gold > 0) ? _arg_1.gold : _arg_1.quantity) + "x ") + _local_2) + " was claimed and will be sent to the gift chests in your vault."), -1, -1, "", false));
		}
	}


}
}//package kabam.rotmg.dailyLogin.controller

