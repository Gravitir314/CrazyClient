//io.decagames.rotmg.pets.popup.info.FeedTooltip

package io.decagames.rotmg.pets.popup.info
{
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Sprite;

import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class FeedTooltip extends ToolTip
{

	private var title:UILabel;
	private var topDesc:UILabel;
	private var feedIconContainer:Sprite;
	private var feedIcon:SliceScalingBitmap;
	private var midDesc:UILabel;
	private var progressIconContainer:Sprite;
	private var botDesc:UILabel;

	public function FeedTooltip()
	{
		super(0x363636, 1, 0x9B9B9B, 1);
		this.init();
	}

	private function init():void
	{
		this.createTitle();
		this.createFeedIcons();
		this.createMiddle();
		this.createProgressIcon();
		this.createBottom();
	}

	private function createTitle():void
	{
		this.title = new UILabel();
		DefaultLabelFormat.petNameLabel(this.title, 0xFFFFFF);
		addChild(this.title);
		this.title.text = "Feeding";
		this.title.y = 5;
		this.title.x = 0;
		this.topDesc = new UILabel();
		DefaultLabelFormat.infoTooltipText(this.topDesc, 0xAAAAAA);
		addChild(this.topDesc);
		this.topDesc.text = "Feed items from your inventory to your pets to make them stronger!";
		this.topDesc.width = 220;
		this.topDesc.wordWrap = true;
		this.topDesc.y = (this.title.y + this.title.height);
		this.topDesc.x = 0;
	}

	private function createFeedIcons():void
	{
		this.feedIconContainer = new Sprite();
		addChild(this.feedIconContainer);
		this.feedIcon = TextureParser.instance.getSliceScalingBitmap("UI", "FeedTooltip", 280);
		this.feedIconContainer.addChild(this.feedIcon);
		this.feedIcon.width = 196;
		this.feedIcon.height = 62;
		this.feedIcon.x = 0;
		this.feedIcon.y = 0;
		this.feedIconContainer.y = ((this.topDesc.y + this.topDesc.height) + 5);
		this.feedIconContainer.x = 10;
	}

	private function createMiddle():void
	{
		this.midDesc = new UILabel();
		DefaultLabelFormat.infoTooltipText(this.midDesc, 0xAAAAAA);
		addChild(this.midDesc);
		this.midDesc.text = "In the Pets menu, select the pet and up to 8 items you want to feed it to see how many levels its abilities will gain. Feed as many items as you need to get your pets’ ability levels to their max!";
		this.midDesc.width = 220;
		this.midDesc.wordWrap = true;
		this.midDesc.y = ((this.feedIconContainer.y + this.feedIconContainer.height) + 5);
		this.midDesc.x = 0;
	}

	private function createProgressIcon():void
	{
		var _local_3:UILabel;
		this.progressIconContainer = new Sprite();
		addChild(this.progressIconContainer);
		var _local_1:Sprite = new Sprite();
		_local_1.graphics.beginFill(6341728, 1);
		_local_1.graphics.drawRect(0, 0, 160, 4);
		_local_1.graphics.endFill();
		this.progressIconContainer.addChild(_local_1);
		var _local_2:Sprite = new Sprite();
		_local_2.graphics.beginFill(15305801, 1);
		_local_2.graphics.drawRect(0, 0, 120, 4);
		_local_2.graphics.endFill();
		this.progressIconContainer.addChild(_local_2);
		_local_3 = new UILabel();
		DefaultLabelFormat.petStatLabelLeft(_local_3, 6341728);
		_local_3.text = "MAX";
		_local_3.x = 165;
		_local_3.y = -5;
		this.progressIconContainer.addChild(_local_3);
		this.progressIconContainer.y = ((this.midDesc.y + this.midDesc.height) + 15);
		this.progressIconContainer.x = 15;
	}

	private function createBottom():void
	{
		this.botDesc = new UILabel();
		DefaultLabelFormat.infoTooltipText(this.botDesc, 0xAAAAAA);
		addChild(this.botDesc);
		this.botDesc.text = "Once two of your pets reach their max level at their current rarity, it will be time to fuse them!";
		this.botDesc.width = 220;
		this.botDesc.wordWrap = true;
		this.botDesc.y = ((this.progressIconContainer.y + this.progressIconContainer.height) + 5);
		this.botDesc.x = 0;
	}


}
}//package io.decagames.rotmg.pets.popup.info

