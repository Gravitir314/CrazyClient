﻿//kabam.rotmg.dailyLogin.config.CalendarSettings

package kabam.rotmg.dailyLogin.config
{
import flash.geom.ColorTransform;
import flash.geom.Rectangle;

public class CalendarSettings
{

	public static const NUMBER_OF_COLUMNS:int = 7;
	public static const BOX_WIDTH:int = 70;
	public static const BOX_HEIGHT:int = 70;
	public static const ITEM_SIZE:int = 100;
	public static const BOX_MARGIN:int = 10;
	public static const BOX_BORDER:int = 2;
	public static const CLAIM_WARNING_BEFORE_DAYS:int = 3;
	public static const DAILY_LOGIN_MODAL_PADDING:int = 20;
	public static const DAILY_LOGIN_TABS_PADDING:int = 10;
	public static const DAILY_LOGIN_MODAL_HEIGHT_MARGIN:int = 100;
	public static const TABS_HEIGHT:int = 30;
	public static const TABS_FONT_SIZE:int = 16;
	public static const TABS_WIDTH:int = 200;
	public static const TABS_Y_POSITION:int = 70;
	public static const GREEN_COLOR_TRANSFORM:ColorTransform = new ColorTransform(0, (198 / 0xFF), (6 / 0xFF));


	public static function getCalendarModalRectangle(_arg_1:int, _arg_2:Boolean):Rectangle
	{
		var _local_3:int = int(Math.ceil((_arg_1 / NUMBER_OF_COLUMNS)));
		return (new Rectangle(0, 0, ((((2 * DAILY_LOGIN_MODAL_PADDING) + (2 * DAILY_LOGIN_TABS_PADDING)) + (BOX_WIDTH * NUMBER_OF_COLUMNS)) + ((NUMBER_OF_COLUMNS - 1) * BOX_MARGIN)), ((((((TABS_HEIGHT + (2 * DAILY_LOGIN_TABS_PADDING)) + (2 * DAILY_LOGIN_MODAL_PADDING)) + (BOX_HEIGHT * _local_3)) + ((_local_3 - 1) * BOX_MARGIN)) + DAILY_LOGIN_MODAL_HEIGHT_MARGIN) + ((_arg_2) ? 20 : 0))));
	}

	public static function getTabsRectangle(_arg_1:int):Rectangle
	{
		var _local_2:int = int(Math.ceil((_arg_1 / NUMBER_OF_COLUMNS)));
		return (new Rectangle(0, 0, (((BOX_WIDTH * NUMBER_OF_COLUMNS) + ((NUMBER_OF_COLUMNS - 1) * BOX_MARGIN)) + (2 * DAILY_LOGIN_TABS_PADDING)), (((BOX_HEIGHT * _local_2) + ((_local_2 - 1) * BOX_MARGIN)) + (2 * DAILY_LOGIN_TABS_PADDING))));
	}


}
}//package kabam.rotmg.dailyLogin.config

