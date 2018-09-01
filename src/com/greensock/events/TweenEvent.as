//com.greensock.events.TweenEvent

package com.greensock.events
{
import flash.events.Event;

public class TweenEvent extends Event
{

	public static const VERSION:Number = 12;
	public static const START:String = "start";
	public static const UPDATE:String = "change";
	public static const COMPLETE:String = "complete";
	public static const REVERSE_COMPLETE:String = "reverseComplete";
	public static const REPEAT:String = "repeat";

	public function TweenEvent(_arg_1:String, _arg_2:Boolean = false, _arg_3:Boolean = false)
	{
		super(_arg_1, _arg_2, _arg_3);
	}

	override public function clone():Event
	{
		return (new TweenEvent(this.type, this.bubbles, this.cancelable));
	}


}
}//package com.greensock.events

