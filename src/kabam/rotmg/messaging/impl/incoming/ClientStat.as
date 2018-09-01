﻿//kabam.rotmg.messaging.impl.incoming.ClientStat

package kabam.rotmg.messaging.impl.incoming
{
import flash.utils.IDataInput;

public class ClientStat extends IncomingMessage
{

	public var name_:String;
	public var value_:int;

	public function ClientStat(_arg_1:uint, _arg_2:Function)
	{
		super(_arg_1, _arg_2);
	}

	override public function parseFromInput(_arg_1:IDataInput):void
	{
		this.name_ = _arg_1.readUTF();
		this.value_ = _arg_1.readInt();
	}

	override public function toString():String
	{
		return (formatToString("CLIENTSTAT", "name_", "value_"));
	}


}
}//package kabam.rotmg.messaging.impl.incoming

