//io.decagames.rotmg.pets.components.tooltip.PetTooltip

package io.decagames.rotmg.pets.components.tooltip
{
import com.company.assembleegameclient.ui.LineBreakDesign;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Bitmap;
import flash.display.Sprite;

import io.decagames.rotmg.pets.components.petStatsGrid.PetStatsGrid;
import io.decagames.rotmg.pets.data.family.PetFamilyColors;
import io.decagames.rotmg.pets.data.family.PetFamilyKeys;
import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
import io.decagames.rotmg.pets.data.vo.AbilityVO;
import io.decagames.rotmg.pets.data.vo.IPetVO;
import io.decagames.rotmg.pets.utils.PetsConstants;
import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
import io.decagames.rotmg.ui.gird.UIGrid;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.model.TabStripModel;

public class PetTooltip extends ToolTip
{

	private const petsContent:Sprite = new Sprite();
	private const titleTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xFFFFFF, 16, true);
	private const petRarityTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 12, false);
	private const petFamilyTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 12, false);
	private const lineBreak:LineBreakDesign = PetsViewAssetFactory.returnTooltipLineBreak();

	private var petBitmap:Bitmap;
	private var petVO:IPetVO;

	public function PetTooltip(_arg_1:IPetVO)
	{
		this.petVO = _arg_1;
		super(0x363636, 1, 0xFFFFFF, 1, true);
		this.petsContent.name = TabStripModel.PETS;
	}

	public function init():void
	{
		this.petBitmap = this.petVO.getSkinBitmap();
		this.addChildren();
		if (this.hasAbilities)
		{
			this.addAbilities();
		}
		this.positionChildren();
		this.updateTextFields();
	}

	private function updateTextFields():void
	{
		this.titleTextField.setColor(this.petVO.rarity.color);
		this.titleTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.name));
		this.petRarityTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.rarity.rarityKey));
		this.petFamilyTextField.setStringBuilder(new LineBuilder().setParams(PetFamilyKeys.getTranslationKey(this.petVO.family))).setColor(PetFamilyColors.getColorByFamilyKey(this.petVO.family));
	}

	private function addChildren():void
	{
		this.clearChildren();
		this.petsContent.graphics.beginFill(0, 0);
		this.petsContent.graphics.drawRect(0, 0, PetsConstants.TOOLTIP_WIDTH, ((this.hasAbilities) ? PetsConstants.TOOLTIP_HEIGHT : PetsConstants.TOOLTIP_HEIGHT_NO_ABILITIES));
		this.petsContent.addChild(this.petBitmap);
		this.petsContent.addChild(this.titleTextField);
		this.petsContent.addChild(this.petRarityTextField);
		this.petsContent.addChild(this.petFamilyTextField);
		if (this.hasAbilities)
		{
			this.petsContent.addChild(this.lineBreak);
		}
		if (!contains(this.petsContent))
		{
			addChild(this.petsContent);
		}
	}

	private function clearChildren():void
	{
		this.petsContent.graphics.clear();
		while (this.petsContent.numChildren > 0)
		{
			this.petsContent.removeChildAt(0);
		}
	}

	private function get hasAbilities():Boolean
	{
		var _local_1:AbilityVO;
		for each (_local_1 in this.petVO.abilityList)
		{
			if (_local_1.getUnlocked() && _local_1.level > 0)
			{
				return (true);
			}
		}
		return (false);
	}

	private function addAbilities():void
	{
		var _local_1:UIGrid;
		_local_1 = new PetStatsGrid(178, this.petVO);
		this.petsContent.addChild(_local_1);
		_local_1.y = 76;
		_local_1.x = 2;
	}

	private function getNumAbilities():uint
	{
		var _local_1:Boolean = ((this.petVO.rarity.rarityKey == PetRarityEnum.DIVINE.rarityKey) || (this.petVO.rarity.rarityKey == PetRarityEnum.LEGENDARY.rarityKey));
		if (_local_1)
		{
			return (2);
		}
		return (3);
	}

	private function positionChildren():void
	{
		this.titleTextField.x = 55;
		this.titleTextField.y = 21;
		this.petRarityTextField.x = 55;
		this.petRarityTextField.y = 35;
		this.petFamilyTextField.x = 55;
		this.petFamilyTextField.y = 48;
	}


}
}//package io.decagames.rotmg.pets.components.tooltip

