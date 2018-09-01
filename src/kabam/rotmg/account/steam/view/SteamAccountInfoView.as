﻿//kabam.rotmg.account.steam.view.SteamAccountInfoView

package kabam.rotmg.account.steam.view
{
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.core.view.AccountInfoView;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class SteamAccountInfoView extends Sprite implements AccountInfoView
{

	private static const FONT_SIZE:int = 18;

	private var accountText:TextFieldDisplayConcrete;
	private var userName:String = "";
	private var isRegistered:Boolean;

	public function SteamAccountInfoView()
	{
		this.makeAccountText();
	}

	private function makeAccountText():void
	{
		this.accountText = new TextFieldDisplayConcrete().setSize(FONT_SIZE).setColor(0xB3B3B3);
		this.accountText.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4)];
		this.accountText.setAutoSize(TextFieldAutoSize.RIGHT);
		addChild(this.accountText);
	}

	public function setInfo(_arg_1:String, _arg_2:Boolean):void
	{
		this.userName = _arg_1;
		this.isRegistered = _arg_2;
		this.accountText.setStringBuilder(new LineBuilder().setParams(TextKey.LOGGED_IN_TEXT, {"userName": _arg_1}));
	}


}
}//package kabam.rotmg.account.steam.view

