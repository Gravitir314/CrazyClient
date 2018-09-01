﻿//kabam.rotmg.chat.model.ChatModel

package kabam.rotmg.chat.model
{
import flash.geom.Rectangle;

public class ChatModel
{

	public var bounds:Rectangle;
	public var lineHeight:int;
	public var visibleItemCount:int;
	public var storedItemCount:int;
	public var chatMessages:Vector.<ChatMessage> = new Vector.<ChatMessage>();

	public function ChatModel()
	{
		this.bounds = new Rectangle(0, 0, 600, 300);
		this.lineHeight = 20;
		this.visibleItemCount = 5;
		this.storedItemCount = 150;
	}

	public function pushMessage(_arg_1:ChatMessage):void
	{
		this.chatMessages.push(_arg_1);
		if (this.chatMessages.length > this.storedItemCount)
		{
			this.chatMessages.shift();
		}
	}


}
}//package kabam.rotmg.chat.model

