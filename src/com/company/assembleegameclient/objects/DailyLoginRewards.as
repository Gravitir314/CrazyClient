﻿//com.company.assembleegameclient.objects.DailyLoginRewards

package com.company.assembleegameclient.objects
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.Panel;

import kabam.rotmg.dailyLogin.view.DailyLoginPanel;

public class DailyLoginRewards extends GameObject implements IInteractiveObject
{

	public function DailyLoginRewards(_arg_1:XML)
	{
		super(_arg_1);
		isInteractive_ = true;
	}

	public function getPanel(_arg_1:GameSprite):Panel
	{
		return (new DailyLoginPanel(_arg_1));
	}


}
}//package com.company.assembleegameclient.objects

