﻿//kabam.rotmg.messaging.impl.outgoing.CreateGuild

package kabam.rotmg.messaging.impl.outgoing
{
import flash.utils.IDataOutput;

public class CreateGuild extends OutgoingMessage
{

	public var name_:String;

	public function CreateGuild(_arg_1:uint, _arg_2:Function)
	{
		super(_arg_1, _arg_2);
	}

	override public function writeToOutput(_arg_1:IDataOutput):void
	{
		_arg_1.writeUTF(this.name_);
	}

	override public function toString():String
	{
		return (formatToString("CREATEGUILD", "name_"));
	}


}
}//package kabam.rotmg.messaging.impl.outgoing

