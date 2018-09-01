﻿//kabam.rotmg.ui.view.SignalWaiter

package kabam.rotmg.ui.view
{
import com.adobe.utils.DictionaryUtil;

import flash.utils.Dictionary;

import org.osflash.signals.Signal;

public class SignalWaiter
{

	public var complete:Signal = new Signal();
	private var texts:Dictionary = new Dictionary();


	public function push(_arg_1:Signal):SignalWaiter
	{
		this.texts[_arg_1] = true;
		this.listenTo(_arg_1);
		return (this);
	}

	public function pushArgs(... _args):SignalWaiter
	{
		var _local_2:Signal;
		for each (_local_2 in _args)
		{
			this.push(_local_2);
		}
		return (this);
	}

	private function listenTo(value:Signal):void
	{
		var onTextChanged:Function;
		onTextChanged = function ():void
		{
			delete texts[value];
			checkEmpty();
		};
		value.addOnce(onTextChanged);
	}

	private function checkEmpty():void
	{
		if (this.isEmpty())
		{
			this.complete.dispatch();
		}
	}

	public function isEmpty():Boolean
	{
		return (DictionaryUtil.getKeys(this.texts).length == 0);
	}


}
}//package kabam.rotmg.ui.view

