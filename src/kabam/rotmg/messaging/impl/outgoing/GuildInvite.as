﻿//kabam.rotmg.messaging.impl.outgoing.GuildInvite

package kabam.rotmg.messaging.impl.outgoing
{
import flash.utils.IDataOutput;

public class GuildInvite extends OutgoingMessage
{

	public var name_:String;

	public function GuildInvite(_arg_1:uint, _arg_2:Function)
	{
		super(_arg_1, _arg_2);
	}

	override public function writeToOutput(_arg_1:IDataOutput):void
	{
		_arg_1.writeUTF(this.name_);
	}

	override public function toString():String
	{
		return (formatToString("GUILDINVITE", "name_"));
	}


}
}//package kabam.rotmg.messaging.impl.outgoing

