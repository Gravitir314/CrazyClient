﻿//com.company.assembleegameclient.map.partyoverlay.QuestArrow

package com.company.assembleegameclient.map.partyoverlay
{
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.Quest;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.tooltip.PortraitToolTip;
import com.company.assembleegameclient.ui.tooltip.QuestToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.greensock.TweenMax;

import flash.events.MouseEvent;

public class QuestArrow extends GameObjectArrow
{

	public var map_:Map;
	private var questArrowTween:TweenMax;

	public function QuestArrow(_arg_1:Map)
	{
		super(16352321, 12919330, true);
		this.map_ = _arg_1;
	}

	public function refreshToolTip():void
	{
		if (TweenMax.isTweening(this))
		{
			TweenMax.killTweensOf(this);
			this.questArrowTween.pause(0);
		}
		setToolTip(this.getToolTip(go_, 0));
	}

	override protected function onMouseOver(_arg_1:MouseEvent):void
	{
		super.onMouseOver(_arg_1);
		this.refreshToolTip();
	}

	override protected function onMouseOut(_arg_1:MouseEvent):void
	{
		super.onMouseOut(_arg_1);
		this.refreshToolTip();
	}

	private function getToolTip(_arg_1:GameObject, _arg_2:int):ToolTip
	{
		if (((_arg_1 == null) || (_arg_1.texture_ == null)))
		{
			return (null);
		}
		if (this.shouldShowFullQuest(_arg_2))
		{
			return (new QuestToolTip(go_));
		}
		if (Parameters.data_.showQuestPortraits)
		{
			return (new PortraitToolTip(_arg_1));
		}
		return (null);
	}

	private function shouldShowFullQuest(_arg_1:int):Boolean
	{
		var _local_2:Quest = this.map_.quest_;
		return ((mouseOver_) || (_local_2.isNew(_arg_1)));
	}

	override public function draw(_arg_1:int, _arg_2:Camera):void
	{
		var _local_3:Boolean;
		var _local_4:Boolean;
		var _local_5:GameObject = this.map_.quest_.getObject(_arg_1);
		if (_local_5 != go_)
		{
			setGameObject(_local_5);
			setToolTip(this.getToolTip(_local_5, _arg_1));
			if (!this.questArrowTween)
			{
				this.questArrowTween = TweenMax.to(this, 0.5, {
					"scaleX": 2, "scaleY": 2, "yoyo": true, "repeat": 1
				});
			}
			else
			{
				this.questArrowTween.play(0);
			}
		}
		else
		{
			if (go_ != null)
			{
				_local_3 = (tooltip_ is QuestToolTip);
				_local_4 = this.shouldShowFullQuest(_arg_1);
				if (_local_3 != _local_4)
				{
					setToolTip(this.getToolTip(_local_5, _arg_1));
				}
			}
		}
		super.draw(_arg_1, _arg_2);
	}


}
}//package com.company.assembleegameclient.map.partyoverlay

