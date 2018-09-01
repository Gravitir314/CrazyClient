//io.decagames.rotmg.pets.popup.info.PetInfoDialog

package io.decagames.rotmg.pets.popup.info
{
import flash.display.Bitmap;

import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.gird.UIGrid;
import io.decagames.rotmg.ui.gird.UIGridElement;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.popups.modal.ModalPopup;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class PetInfoDialog extends ModalPopup
{

	private var icon:Bitmap;
	private var contentInset:SliceScalingBitmap;
	private var contentTabs:SliceScalingBitmap;
	private var infoTitle:UILabel;
	private var infoLabel:UILabel;
	private var infoGrid:UIGrid;

	public function PetInfoDialog()
	{
		super(280, 320, "Yard Caretaker");
		this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", 280);
		addChild(this.contentInset);
		this.contentInset.height = 320;
		this.contentInset.x = 0;
		this.contentInset.y = 0;
		this.contentTabs = TextureParser.instance.getSliceScalingBitmap("UI", "tab_inset_content_background", 280);
		addChild(this.contentTabs);
		this.contentTabs.height = 90;
		this.contentTabs.x = 0;
		this.contentTabs.y = 0;
		this.createInfo();
		this.createGrid();
	}

	private function createInfo():void
	{
		this.icon = PetsViewAssetFactory.returnCaretakerBitmap(6465);
		addChild(this.icon);
		this.icon.x = -10;
		this.icon.y = -20;
		this.infoTitle = new UILabel();
		DefaultLabelFormat.questNameListLabel(this.infoTitle, 0xFFFFFF);
		addChild(this.infoTitle);
		this.infoTitle.text = "Welcome to your Pet Yard!";
		this.infoTitle.width = 220;
		this.infoTitle.wordWrap = true;
		this.infoTitle.y = 10;
		this.infoTitle.x = 65;
		this.infoLabel = new UILabel();
		DefaultLabelFormat.petStatLabelLeft(this.infoLabel, 0xFFFFFF);
		addChild(this.infoLabel);
		this.infoLabel.text = "Here you can hatch new pet eggs, feed items to strengthen your pets, and fuse two of your pets to take them to the next stage in their evolution! Enjoy your stay!";
		this.infoLabel.width = 220;
		this.infoLabel.wordWrap = true;
		this.infoLabel.y = 25;
		this.infoLabel.x = 65;
	}

	public function addInfoItem(_arg_1:PetInfoItem):void
	{
		var _local_2:UIGridElement = new UIGridElement();
		_local_2.addChild(_arg_1);
		this.infoGrid.addGridElement(_local_2);
	}

	private function createGrid():void
	{
		this.infoGrid = new UIGrid(260, 1, 5);
		this.infoGrid.x = 10;
		this.infoGrid.y = 90;
		addChild(this.infoGrid);
	}


}
}//package io.decagames.rotmg.pets.popup.info

