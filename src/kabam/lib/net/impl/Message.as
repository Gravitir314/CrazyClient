﻿//kabam.lib.net.impl.Message

package kabam.lib.net.impl
{
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public class Message
{

	public var pool:MessagePool;
	public var prev:Message;
	public var next:Message;
	private var isCallback:Boolean;
	public var id:uint;
	public var callback:Function;

	public function Message(_arg_1:uint, _arg_2:Function = null)
	{
		this.id = _arg_1;
		this.isCallback = (!(_arg_2 == null));
		this.callback = _arg_2;
	}

	public function parseFromInput(_arg_1:IDataInput):void
	{
	}

	public function writeToOutput(_arg_1:IDataOutput):void
	{
	}

	public function toString():String
	{
		return (this.formatToString("MESSAGE", "id"));
	}

	protected function formatToString(_arg_1:String, ... _args):String
	{
		var _local_3:int;
		var _local_4:String = ("[" + _arg_1);
		while (_local_3 < _args.length)
		{
			_local_4 = (_local_4 + ((((" " + _args[_local_3]) + '="') + this[_args[_local_3]]) + '"'));
			_local_3++;
		}
		return (_local_4 + "]");
	}

	public function consume():void
	{
		((this.isCallback) && (this.callback(this)));
		this.prev = null;
		this.next = null;
		this.pool.append(this);
	}


}
}//package kabam.lib.net.impl

