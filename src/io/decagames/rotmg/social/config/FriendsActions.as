﻿//io.decagames.rotmg.social.config.FriendsActions

package io.decagames.rotmg.social.config
{
public class FriendsActions
{

	public static const FRIEND_LIST:String = "/getList";
	public static const INVITE_LIST:String = "/getRequests";
	public static const INVITE:String = "/requestFriend";
	public static const ACCEPT:String = "/acceptRequest";
	public static const REJECT:String = "/rejectRequest";
	public static const REMOVE:String = "/removeFriend";
	public static const BLOCK:String = "/blockRequest";
	public static const SEARCH:String = "searchFriend";
	public static const FRIEND_TAB:String = "Friends";
	public static const INVITE_TAB:String = "Invitations";
	public static const WHISPER:String = "Whisper";
	public static const JUMP:String = "JumpServer";


	public static function getURL(_arg_1:String):String
	{
		return ("/friends" + _arg_1);
	}


}
}//package io.decagames.rotmg.social.config

