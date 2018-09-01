//com.company.assembleegameclient.util.FilterUtil

package com.company.assembleegameclient.util
{
import com.company.util.MoreColorUtil;

import flash.filters.ColorMatrixFilter;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;

public class FilterUtil
{

	private static const STANDARD_DROP_SHADOW_FILTER:Array = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
	private static const STANDARD_OUTLINE_FILTER:Array = [new GlowFilter(0, 1, 2, 2, 10, 1)];
	private static const GREY_COLOR_FILTER:Array = [new ColorMatrixFilter(MoreColorUtil.singleColorFilterMatrix(0x363636))];
	private static const DARK_GREY_COLOR_FILTER:Array = [new ColorMatrixFilter(MoreColorUtil.singleColorFilterMatrix(0x1C1C1C))];


	public static function getStandardDropShadowFilter():Array
	{
		return (STANDARD_DROP_SHADOW_FILTER);
	}

	public static function getTextOutlineFilter():Array
	{
		return (STANDARD_OUTLINE_FILTER);
	}

	public static function getGreyColorFilter():Array
	{
		return (GREY_COLOR_FILTER);
	}

	public static function getDarkGreyColorFilter():Array
	{
		return (DARK_GREY_COLOR_FILTER);
	}
}
}//package com.company.assembleegameclient.util

