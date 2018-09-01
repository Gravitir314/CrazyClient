//io.decagames.rotmg.pets.popup.info.UpgradeTooltip

package io.decagames.rotmg.pets.popup.info
{
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Sprite;

import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class UpgradeTooltip extends ToolTip
{

	private var title:UILabel;
	private var topDesc:UILabel;
	private var imageContainer:Sprite;
	private var upgradeIcon:SliceScalingBitmap;
	private var botDesc:UILabel;

	public function UpgradeTooltip()
	{
		super(0x363636, 1, 0x9B9B9B, 1);
		this.init();
	}

	private function init():void
	{
		this.createTitle();
		this.createImage();
		this.createBottom();
	}

	private function createTitle():void
	{
		this.title = new UILabel();
		DefaultLabelFormat.petNameLabel(this.title, 0xFFFFFF);
		addChild(this.title);
		this.title.text = "Upgrade";
		this.title.y = 5;
		this.title.x = 0;
		this.topDesc = new UILabel();
		DefaultLabelFormat.infoTooltipText(this.topDesc, 0xAAAAAA);
		addChild(this.topDesc);
		this.topDesc.text = "You must upgrade your Pet Yard to fuse higher level rarity pets.";
		this.topDesc.width = 220;
		this.topDesc.wordWrap = true;
		this.topDesc.y = (this.title.y + this.title.height);
		this.topDesc.x = 0;
	}

	private function createImage():void
	{
		this.imageContainer = new Sprite();
		addChild(this.imageContainer);
		this.upgradeIcon = TextureParser.instance.getSliceScalingBitmap("UI", "UpgradeTooltip", 280);
		this.imageContainer.addChild(this.upgradeIcon);
		this.upgradeIcon.width = 100;
		this.upgradeIcon.height = 100;
		this.upgradeIcon.x = 0;
		this.upgradeIcon.y = 0;
		this.imageContainer.y = ((this.topDesc.y + this.topDesc.height) + 5);
		this.imageContainer.x = 55;
	}

	private function createBottom():void
	{
		this.botDesc = new UILabel();
		DefaultLabelFormat.infoTooltipText(this.botDesc, 0xAAAAAA);
		addChild(this.botDesc);
		this.botDesc.text = "Click on the Upgrade Pet Yard Button in the Pets menu.";
		this.botDesc.width = 220;
		this.botDesc.wordWrap = true;
		this.botDesc.y = ((this.imageContainer.y + this.imageContainer.height) + 5);
		this.botDesc.x = 0;
	}


}
}//package io.decagames.rotmg.pets.popup.info

