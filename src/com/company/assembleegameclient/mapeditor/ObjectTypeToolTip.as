//com.company.assembleegameclient.mapeditor.ObjectTypeToolTip

package com.company.assembleegameclient.mapeditor
{
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.ui.BaseSimpleText;

import flash.filters.DropShadowFilter;

public class ObjectTypeToolTip extends ToolTip
{

	private static const MAX_WIDTH:int = 180;

	private var titleText_:BaseSimpleText;
	private var descText_:BaseSimpleText;

	public function ObjectTypeToolTip(_arg_1:XML)
	{
		var _local_2:XML;
		super(0x363636, 1, 0x9B9B9B, 1, true);
		this.titleText_ = new BaseSimpleText(16, 0xFFFFFF, false, (MAX_WIDTH - 4), 0);
		this.titleText_.setBold(true);
		this.titleText_.wordWrap = true;
		this.titleText_.text = String(_arg_1.@id);
		this.titleText_.useTextDimensions();
		this.titleText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
		this.titleText_.x = 0;
		this.titleText_.y = 0;
		addChild(this.titleText_);
		var _local_3:* = "";
		if (_arg_1.hasOwnProperty("Group"))
		{
			_local_3 = (_local_3 + (("Group: " + _arg_1.Group) + "\n"));
		}
		if (_arg_1.hasOwnProperty("Static"))
		{
			_local_3 = (_local_3 + "Static\n");
		}
		if (_arg_1.hasOwnProperty("Enemy"))
		{
			_local_3 = (_local_3 + "Enemy\n");
			if (_arg_1.hasOwnProperty("MaxHitPoints"))
			{
				_local_3 = (_local_3 + (("MaxHitPoints: " + _arg_1.MaxHitPoints) + "\n"));
			}
			if (_arg_1.hasOwnProperty("Defense"))
			{
				_local_3 = (_local_3 + (("Defense: " + _arg_1.Defense) + "\n"));
			}
		}
		if (_arg_1.hasOwnProperty("God"))
		{
			_local_3 = (_local_3 + "God\n");
		}
		if (_arg_1.hasOwnProperty("Quest"))
		{
			_local_3 = (_local_3 + "Quest\n");
		}
		if (_arg_1.hasOwnProperty("Hero"))
		{
			_local_3 = (_local_3 + "Hero\n");
		}
		if (_arg_1.hasOwnProperty("Encounter"))
		{
			_local_3 = (_local_3 + "Encounter\n");
		}
		if (_arg_1.hasOwnProperty("Level"))
		{
			_local_3 = (_local_3 + (("Level: " + _arg_1.Level) + "\n"));
		}
		if (_arg_1.hasOwnProperty("Terrain"))
		{
			_local_3 = (_local_3 + (("Terrain: " + _arg_1.Terrain) + "\n"));
		}
		for each (_local_2 in _arg_1.Projectile)
		{
			_local_3 = (_local_3 + (((((((((("Projectile " + _local_2.@id) + ": ") + _local_2.ObjectId) + "\n") + "\tDamage: ") + _local_2.Damage) + "\n") + "\tSpeed: ") + _local_2.Speed) + "\n"));
			if (_local_2.hasOwnProperty("PassesCover"))
			{
				_local_3 = (_local_3 + "\tPassesCover\n");
			}
			if (_local_2.hasOwnProperty("MultiHit"))
			{
				_local_3 = (_local_3 + "\tMultiHit\n");
			}
			if (_local_2.hasOwnProperty("ConditionEffect"))
			{
				_local_3 = (_local_3 + (((("\t" + _local_2.ConditionEffect) + " for ") + _local_2.ConditionEffect.@duration) + " secs\n"));
			}
			if (_local_2.hasOwnProperty("Parametric"))
			{
				_local_3 = (_local_3 + "\tParametric\n");
			}
		}
		this.descText_ = new BaseSimpleText(14, 0xB3B3B3, false, MAX_WIDTH, 0);
		this.descText_.wordWrap = true;
		this.descText_.text = String(_local_3);
		this.descText_.useTextDimensions();
		this.descText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
		this.descText_.x = 0;
		this.descText_.y = (this.titleText_.height + 2);
		addChild(this.descText_);
	}

}
}//package com.company.assembleegameclient.mapeditor

