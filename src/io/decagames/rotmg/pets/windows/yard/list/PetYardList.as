//io.decagames.rotmg.pets.windows.yard.list.PetYardList

package io.decagames.rotmg.pets.windows.yard.list
{
import flash.display.Sprite;

import io.decagames.rotmg.pets.components.petItem.PetItem;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.gird.UIGrid;
import io.decagames.rotmg.ui.gird.UIGridElement;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.scroll.UIScrollbar;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;
import io.decagames.rotmg.utils.colors.Tint;

public class PetYardList extends Sprite
{

	public static var YARD_WIDTH:int = 275;
	public static const YARD_HEIGHT:int = 425;

	private var yardContainer:Sprite;
	private var contentInset:SliceScalingBitmap;
	private var contentTitle:SliceScalingBitmap;
	private var title:UILabel;
	private var contentGrid:UIGrid;
	private var contentElement:UIGridElement;
	private var petGrid:UIGrid;
	private var _upgradeButton:SliceScalingButton;

	public function PetYardList()
	{
		this.contentGrid = new UIGrid((YARD_WIDTH - 55), 1, 15);
		this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", YARD_WIDTH);
		addChild(this.contentInset);
		this.contentInset.height = YARD_HEIGHT;
		this.contentInset.x = 0;
		this.contentInset.y = 0;
		this.contentTitle = TextureParser.instance.getSliceScalingBitmap("UI", "content_title_decoration", YARD_WIDTH);
		addChild(this.contentTitle);
		this.contentTitle.x = 0;
		this.contentTitle.y = 0;
		this.title = new UILabel();
		this.title.text = "Pet Yard";
		DefaultLabelFormat.petNameLabel(this.title, 0xFFFFFF);
		this.title.width = YARD_WIDTH;
		this.title.wordWrap = true;
		this.title.y = 3;
		this.title.x = 0;
		addChild(this.title);
		this.createScrollview();
		this.createPetsGrid();
	}

	public function showPetYardRarity(_arg_1:String, _arg_2:Boolean):void
	{
		var _local_3:SliceScalingBitmap;
		var _local_4:UILabel;
		_local_3 = TextureParser.instance.getSliceScalingBitmap("UI", "content_divider_smalltitle_white", 180);
		Tint.add(_local_3, 0x333333, 1);
		addChild(_local_3);
		_local_3.x = Math.round(((YARD_WIDTH - _local_3.width) / 2));
		_local_3.y = 23;
		_local_4 = new UILabel();
		DefaultLabelFormat.petYardRarity(_local_4);
		_local_4.text = _arg_1;
		_local_4.width = _local_3.width;
		_local_4.wordWrap = true;
		_local_4.y = (_local_3.y + 2);
		_local_4.x = _local_3.x;
		addChild(_local_4);
		if (_arg_2)
		{
			this._upgradeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "upgrade_button"));
			this._upgradeButton.x = (((_local_3.x + _local_3.width) - this._upgradeButton.width) + 8);
			this._upgradeButton.y = ((_local_3.y - (this._upgradeButton.height / 2)) + 8);
			addChild(this._upgradeButton);
		}
	}

	private function createScrollview():void
	{
		var _local_1:Sprite = new Sprite();
		this.yardContainer = new Sprite();
		this.yardContainer.x = this.contentInset.x;
		this.yardContainer.y = 2;
		this.yardContainer.addChild(this.contentGrid);
		_local_1.addChild(this.yardContainer);
		var _local_2:UIScrollbar = new UIScrollbar((YARD_HEIGHT - 60));
		_local_2.mouseRollSpeedFactor = 1;
		_local_2.scrollObject = this;
		_local_2.content = this.yardContainer;
		_local_1.addChild(_local_2);
		_local_2.x = ((this.contentInset.x + this.contentInset.width) - 25);
		_local_2.y = 7;
		var _local_3:Sprite = new Sprite();
		_local_3.graphics.beginFill(0);
		_local_3.graphics.drawRect(0, 0, YARD_WIDTH, 380);
		_local_3.x = this.yardContainer.x;
		_local_3.y = this.yardContainer.y;
		this.yardContainer.mask = _local_3;
		_local_1.addChild(_local_3);
		addChild(_local_1);
		_local_1.y = 45;
	}

	public function addPet(_arg_1:PetItem):void
	{
		var _local_2:UIGridElement = new UIGridElement();
		_local_2.addChild(_arg_1);
		this.petGrid.addGridElement(_local_2);
	}

	public function clearPetsList():void
	{
		this.petGrid.clearGrid();
	}

	private function createPetsGrid():void
	{
		this.contentElement = new UIGridElement();
		this.petGrid = new UIGrid((YARD_WIDTH - 55), 5, 5);
		this.petGrid.x = 18;
		this.petGrid.y = 8;
		this.contentElement.addChild(this.petGrid);
		this.contentGrid.addGridElement(this.contentElement);
	}

	public function get upgradeButton():BaseButton
	{
		return (this._upgradeButton);
	}


}
}//package io.decagames.rotmg.pets.windows.yard.list

