//io.decagames.rotmg.pets.commands.UpgradePetCommand

package io.decagames.rotmg.pets.commands
{
import io.decagames.rotmg.pets.data.vo.requests.FeedPetRequestVO;
import io.decagames.rotmg.pets.data.vo.requests.FusePetRequestVO;
import io.decagames.rotmg.pets.data.vo.requests.IUpgradePetRequestVO;
import io.decagames.rotmg.pets.data.vo.requests.UpgradePetYardRequestVO;

import kabam.lib.net.api.MessageProvider;
import kabam.lib.net.impl.SocketServer;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.view.RegisterPromptDialog;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.messaging.impl.PetUpgradeRequest;

import robotlegs.bender.bundles.mvcs.Command;

public class UpgradePetCommand extends Command
{

	private static const PET_YARD_REGISTER_STRING:String = "In order to upgradeYard your yard you must be a registered user.";

	[Inject]
	public var vo:IUpgradePetRequestVO;
	[Inject]
	public var messages:MessageProvider;
	[Inject]
	public var server:SocketServer;
	[Inject]
	public var account:Account;
	[Inject]
	public var openDialog:OpenDialogSignal;


	override public function execute():void
	{
		var _local_1:PetUpgradeRequest;
		if ((this.vo is UpgradePetYardRequestVO))
		{
			if (!this.account.isRegistered())
			{
				this.showPromptToRegister(PET_YARD_REGISTER_STRING);
			}
			_local_1 = (this.messages.require(GameServerConnection.PETUPGRADEREQUEST) as PetUpgradeRequest);
			_local_1.petTransType = 1;
			_local_1.objectId = UpgradePetYardRequestVO(this.vo).objectID;
			_local_1.paymentTransType = UpgradePetYardRequestVO(this.vo).paymentTransType;
		}
		if ((this.vo is FeedPetRequestVO))
		{
			_local_1 = (this.messages.require(GameServerConnection.PETUPGRADEREQUEST) as PetUpgradeRequest);
			_local_1.petTransType = 2;
			_local_1.PIDOne = FeedPetRequestVO(this.vo).petInstanceId;
			_local_1.slotsObject = FeedPetRequestVO(this.vo).slotObjects;
			_local_1.paymentTransType = FeedPetRequestVO(this.vo).paymentTransType;
		}
		if ((this.vo is FusePetRequestVO))
		{
			_local_1 = (this.messages.require(GameServerConnection.PETUPGRADEREQUEST) as PetUpgradeRequest);
			_local_1.petTransType = 3;
			_local_1.PIDOne = FusePetRequestVO(this.vo).petInstanceIdOne;
			_local_1.PIDTwo = FusePetRequestVO(this.vo).petInstanceIdTwo;
			_local_1.paymentTransType = FusePetRequestVO(this.vo).paymentTransType;
		}
		if (_local_1)
		{
			this.server.sendMessage(_local_1);
		}
	}

	private function showPromptToRegister(_arg_1:String):void
	{
		this.openDialog.dispatch(new RegisterPromptDialog(_arg_1));
	}


}
}//package io.decagames.rotmg.pets.commands

