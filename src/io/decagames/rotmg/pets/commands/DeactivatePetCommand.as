﻿//io.decagames.rotmg.pets.commands.DeactivatePetCommand

package io.decagames.rotmg.pets.commands
{
import io.decagames.rotmg.pets.data.PetsModel;
import io.decagames.rotmg.pets.utils.PetsConstants;

import kabam.lib.net.api.MessageProvider;
import kabam.lib.net.impl.SocketServer;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.messaging.impl.outgoing.ActivePetUpdateRequest;

import robotlegs.bender.bundles.mvcs.Command;

public class DeactivatePetCommand extends Command
{

	[Inject]
	public var instanceID:uint;
	[Inject]
	public var messages:MessageProvider;
	[Inject]
	public var server:SocketServer;
	[Inject]
	public var model:PetsModel;


	override public function execute():void
	{
		var _local_1:ActivePetUpdateRequest = (this.messages.require(GameServerConnection.ACTIVE_PET_UPDATE_REQUEST) as ActivePetUpdateRequest);
		_local_1.instanceid = this.instanceID;
		_local_1.commandtype = PetsConstants.FOLLOWING;
		this.server.sendMessage(_local_1);
	}


}
}//package io.decagames.rotmg.pets.commands

