﻿//kabam.rotmg.messaging.impl.outgoing.InvSwap

package kabam.rotmg.messaging.impl.outgoing
{
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.messaging.impl.data.WorldPosData;

public class InvSwap extends OutgoingMessage
{

	public var time_:int;
	public var position_:WorldPosData = new WorldPosData();
	public var slotObject1_:SlotObjectData = new SlotObjectData();
	public var slotObject2_:SlotObjectData = new SlotObjectData();

	public function InvSwap(_arg_1:uint, _arg_2:Function)
	{
		super(_arg_1, _arg_2);
	}

	override public function writeToOutput(_arg_1:IDataOutput):void
	{
		_arg_1.writeInt(this.time_);
		this.position_.writeToOutput(_arg_1);
		this.slotObject1_.writeToOutput(_arg_1);
		this.slotObject2_.writeToOutput(_arg_1);
	}

	override public function toString():String
	{
		return (formatToString("INVSWAP", "time_", "position_", "slotObject1_", "slotObject2_"));
	}


}
}//package kabam.rotmg.messaging.impl.outgoing

