//io.decagames.rotmg.pets.panels.YardUpgraderPanel

package io.decagames.rotmg.pets.panels
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.DeprecatedTextButton;
import com.company.assembleegameclient.ui.panels.Panel;

import flash.display.Bitmap;

import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class YardUpgraderPanel extends Panel
{

	private const titleText:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xFFFFFF, 16, true);

	private var icon:Bitmap;
	public var infoButton:DeprecatedTextButton;
	public var upgradeYardButton:DeprecatedTextButton;
	public var petsButton:DeprecatedTextButton;
	private var title:String = "Pets.caretakerPanelTitle";
	private var infoButtonString:String = "Pets.caretakerPanelButtonInfo";
	private var upgradeYardButtonString:String = "Pets.caretakerPanelButtonUpgrade";
	private var petsButtonString:String = "Pets";
	public var type:uint;

	public function YardUpgraderPanel(_arg_1:GameSprite, _arg_2:uint)
	{
		this.type = _arg_2;
		super(_arg_1);
	}

	private function handleInfoButton():void
	{
		this.infoButton = new DeprecatedTextButton(16, this.infoButtonString);
		this.infoButton.textChanged.addOnce(this.alignButton);
		addChild(this.infoButton);
	}

	private function handlePetsButton():void
	{
		this.petsButton = new DeprecatedTextButton(16, this.petsButtonString);
		this.petsButton.textChanged.addOnce(this.alignButton);
		addChild(this.petsButton);
	}

	private function handleTitleText():void
	{
		this.icon.x = -25;
		this.icon.y = -36;
		this.titleText.setStringBuilder(new LineBuilder().setParams(this.title));
		this.titleText.x = 48;
		this.titleText.y = 28;
		addChild(this.titleText);
	}

	private function handleUpgradeYardButton():void
	{
		this.upgradeYardButton = new DeprecatedTextButton(16, this.upgradeYardButtonString);
		this.upgradeYardButton.textChanged.addOnce(this.alignButton);
		addChild(this.upgradeYardButton);
	}

	public function init(_arg_1:Boolean):void
	{
		this.handleIcon();
		this.handleTitleText();
		this.handleInfoButton();
		this.handlePetsButton();
		if (_arg_1)
		{
			this.handleUpgradeYardButton();
		}
	}

	private function handleIcon():void
	{
		this.icon = PetsViewAssetFactory.returnCaretakerBitmap(this.type);
		addChild(this.icon);
		this.icon.x = 5;
	}

	private function alignButton():void
	{
		if (((this.upgradeYardButton) && (contains(this.upgradeYardButton))))
		{
			this.upgradeYardButton.x = (((WIDTH / 4) * 3) - (this.upgradeYardButton.width / 2));
			this.upgradeYardButton.y = ((HEIGHT - this.upgradeYardButton.height) - 4);
			this.infoButton.x = (((WIDTH / 4) * 1) - (this.infoButton.width / 2));
			this.infoButton.y = ((HEIGHT - this.infoButton.height) - 4);
		}
		else
		{
			this.infoButton.x = (((WIDTH / 4) * 1.25) - (this.infoButton.width / 2));
			this.infoButton.y = ((HEIGHT - this.infoButton.height) - 4);
			if (this.petsButton)
			{
				this.petsButton.x = (((WIDTH / 4) * 2.75) - (this.petsButton.width / 2));
				this.petsButton.y = ((HEIGHT - this.petsButton.height) - 4);
			}
		}
	}


}
}//package io.decagames.rotmg.pets.panels

