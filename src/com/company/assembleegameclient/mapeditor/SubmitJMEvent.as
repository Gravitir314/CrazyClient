//com.company.assembleegameclient.mapeditor.SubmitJMEvent

package com.company.assembleegameclient.mapeditor
{
import flash.events.Event;

public class SubmitJMEvent extends Event
{

	public static const SUBMIT_JM_EVENT:String = "SUBMIT_JM_EVENT";

	public var mapJSON_:String;
	public var mapInfo_:Object;

	public function SubmitJMEvent(_arg_1:String, _arg_2:Object)
	{
		super(SUBMIT_JM_EVENT);
		this.mapJSON_ = _arg_1;
		this.mapInfo_ = _arg_2;
	}

}
}//package com.company.assembleegameclient.mapeditor

