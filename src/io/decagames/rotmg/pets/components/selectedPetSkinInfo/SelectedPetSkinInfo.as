//io.decagames.rotmg.pets.components.selectedPetSkinInfo.SelectedPetSkinInfo

package io.decagames.rotmg.pets.components.selectedPetSkinInfo
{
import com.company.assembleegameclient.util.Currency;

import io.decagames.rotmg.pets.components.petInfoSlot.PetInfoSlot;
import io.decagames.rotmg.pets.config.PetsPricing;
import io.decagames.rotmg.pets.data.skin.SelectedPetButtonType;
import io.decagames.rotmg.shop.ShopBuyButton;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;

public class SelectedPetSkinInfo extends PetInfoSlot
{

	private var _goldActionButton:SliceScalingButton;
	private var _fameActionButton:SliceScalingButton;
	private var _actionButtonType:int;
	private var _actionLabel:UILabel;
	private var actionButtonMargin:int = 8;

	public function SelectedPetSkinInfo(_arg_1:int, _arg_2:Boolean)
	{
		super(_arg_1, false, false, false, false, _arg_2);
		this._actionLabel = new UILabel();
		this._actionLabel.y = 140;
		DefaultLabelFormat.petInfoLabel(this._actionLabel, 0xFFFFFF);
	}

	private function updateButton():void
	{
		var _local_1:int;
		if (this._goldActionButton)
		{
			removeChild(this._goldActionButton);
			this._goldActionButton = null;
		}
		if (this._fameActionButton)
		{
			removeChild(this._fameActionButton);
			this._fameActionButton = null;
		}
		if (this._actionLabel.parent)
		{
			removeChild(this._actionLabel);
		}
		switch (this._actionButtonType)
		{
			case SelectedPetButtonType.SKIN:
				this._fameActionButton = new ShopBuyButton(PetsPricing.CHANGE_SKIN_FAME_FEE, Currency.FAME);
				this._goldActionButton = new ShopBuyButton(PetsPricing.CHANGE_SKIN_GOLD_FEE);
				this._actionLabel.text = "Change Skin";
				break;
			case SelectedPetButtonType.FAMILY:
				this._actionLabel.text = "Change Family";
				this._goldActionButton = new ShopBuyButton(PetsPricing.CHANGE_FAMILY_GOLD_FEE);
				this._fameActionButton = new ShopBuyButton(PetsPricing.CHANGE_FAMILY_FAME_FEE, Currency.FAME);
				break;
		}
		if (this._actionButtonType != SelectedPetButtonType.NONE)
		{
			this._actionLabel.x = Math.round(((slotWidth / 2) - (this._actionLabel.textWidth / 2)));
			this._goldActionButton.width = 90;
			this._fameActionButton.width = 90;
			this._goldActionButton.y = (this._fameActionButton.y = 155);
			_local_1 = int(((slotWidth - ((this._goldActionButton.width + this._fameActionButton.width) + this.actionButtonMargin)) / 2));
			this._goldActionButton.x = _local_1;
			this._fameActionButton.x = ((this._goldActionButton.x + this._goldActionButton.width) + this.actionButtonMargin);
			addChild(this._goldActionButton);
			addChild(this._fameActionButton);
			addChild(this._actionLabel);
		}
	}

	public function set actionButtonType(_arg_1:int):void
	{
		this._actionButtonType = _arg_1;
		this.updateButton();
	}

	public function get goldActionButton():SliceScalingButton
	{
		return (this._goldActionButton);
	}

	public function get actionButtonType():int
	{
		return (this._actionButtonType);
	}

	public function get fameActionButton():SliceScalingButton
	{
		return (this._fameActionButton);
	}


}
}//package io.decagames.rotmg.pets.components.selectedPetSkinInfo

