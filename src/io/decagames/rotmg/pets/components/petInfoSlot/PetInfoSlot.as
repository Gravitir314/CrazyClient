//io.decagames.rotmg.pets.components.petInfoSlot.PetInfoSlot

package io.decagames.rotmg.pets.components.petInfoSlot
{
import flash.display.Sprite;

import io.decagames.rotmg.pets.components.petPortrait.PetPortrait;
import io.decagames.rotmg.pets.components.petStatsGrid.PetStatsGrid;
import io.decagames.rotmg.pets.data.vo.IPetVO;
import io.decagames.rotmg.ui.gird.UIGrid;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class PetInfoSlot extends Sprite
{

	public static const INFO_HEIGHT:int = 207;
	public static const STATS_WIDTH:int = 150;

	private var petPortrait:PetPortrait;
	private var _switchable:Boolean;
	private var _slotWidth:int;
	private var showStats:Boolean;
	private var _showCurrentPet:Boolean;
	private var animations:Boolean;
	private var isRarityLabelHidden:Boolean;
	private var showReleaseButton:Boolean;
	private var _petVO:IPetVO;
	private var _showFeedPower:Boolean;
	private var statsGrid:UIGrid;

	public function PetInfoSlot(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean = false, _arg_6:Boolean = false, _arg_7:Boolean = false, _arg_8:Boolean = false)
	{
		this._switchable = _arg_2;
		this._slotWidth = _arg_1;
		this._showFeedPower = _arg_8;
		this._showCurrentPet = _arg_4;
		this.showStats = _arg_3;
		this.animations = _arg_5;
		this.showReleaseButton = _arg_7;
		this.isRarityLabelHidden = _arg_6;
		var _local_9:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", _arg_1);
		addChild(_local_9);
		_local_9.height = INFO_HEIGHT;
		_local_9.x = 0;
		_local_9.y = 0;
	}

	public function showPetInfo(_arg_1:IPetVO, _arg_2:Boolean = true):void
	{
		this._petVO = _arg_1;
		if (!this.petPortrait)
		{
			this.petPortrait = new PetPortrait(this._slotWidth, _arg_1, this._switchable, this._showCurrentPet, this.showReleaseButton, this._showFeedPower);
			this.petPortrait.enableAnimation = this.animations;
			addChild(this.petPortrait);
		}
		else
		{
			this.petPortrait.petVO = _arg_1;
		}
		if (this.isRarityLabelHidden)
		{
			this.petPortrait.hideRarityLabel();
		}
		if (((this.showStats) && (_arg_2)))
		{
			this.statsGrid = new PetStatsGrid(STATS_WIDTH, _arg_1);
			addChild(this.statsGrid);
			this.statsGrid.y = 130;
			this.statsGrid.x = Math.round(((this._slotWidth - STATS_WIDTH) / 2));
		}
	}

	public function get slotWidth():int
	{
		return (this._slotWidth);
	}

	public function get showCurrentPet():Boolean
	{
		return (this._showCurrentPet);
	}

	public function get petVO():IPetVO
	{
		return (this._petVO);
	}


}
}//package io.decagames.rotmg.pets.components.petInfoSlot

