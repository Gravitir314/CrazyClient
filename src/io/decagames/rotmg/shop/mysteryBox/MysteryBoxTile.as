//io.decagames.rotmg.shop.mysteryBox.MysteryBoxTile

package io.decagames.rotmg.shop.mysteryBox
{
import flash.geom.Point;

import io.decagames.rotmg.shop.genericBox.GenericBoxTile;
import io.decagames.rotmg.shop.mysteryBox.contentPopup.UIItemContainer;
import io.decagames.rotmg.ui.gird.UIGrid;

import kabam.rotmg.mysterybox.model.MysteryBoxInfo;

public class MysteryBoxTile extends GenericBoxTile
{

	private var displayedItemsGrid:UIGrid;
	private var maxResultHeight:int = 75;
	private var maxResultWidth:int;
	private var resultElementWidth:int;
	private var gridConfig:Point;

	public function MysteryBoxTile(_arg_1:MysteryBoxInfo)
	{
		buyButtonBitmapBackground = "shop_box_button_background";
		super(_arg_1);
	}

	private function prepareResultGrid(_arg_1:int):void
	{
		this.maxResultWidth = 160;
		this.gridConfig = this.calculateGrid(_arg_1);
		this.resultElementWidth = this.calculateElementSize(this.gridConfig);
		this.displayedItemsGrid = new UIGrid((this.resultElementWidth * this.gridConfig.x), this.gridConfig.x, 0);
		this.displayedItemsGrid.x = (20 + Math.round(((this.maxResultWidth - (this.resultElementWidth * this.gridConfig.x)) / 2)));
		this.displayedItemsGrid.y = Math.round((42 + ((this.maxResultHeight - (this.resultElementWidth * this.gridConfig.y)) / 2)));
		this.displayedItemsGrid.centerLastRow = true;
		addChild(this.displayedItemsGrid);
	}

	private function calculateGrid(_arg_1:int):Point
	{
		var _local_5:int;
		var _local_6:int;
		var _local_2:Point = new Point(11, 4);
		var _local_3:int = int.MIN_VALUE;
		if (_arg_1 >= (_local_2.x * _local_2.y))
		{
			return (_local_2);
		}
		var _local_4:int = 11;
		while (_local_4 >= 1)
		{
			_local_5 = 4;
			while (_local_5 >= 1)
			{
				if ((((_local_4 * _local_5) >= _arg_1) && (((_local_4 - 1) * (_local_5 - 1)) < _arg_1)))
				{
					_local_6 = this.calculateElementSize(new Point(_local_4, _local_5));
					if (_local_6 != -1)
					{
						if (_local_6 > _local_3)
						{
							_local_3 = _local_6;
							_local_2 = new Point(_local_4, _local_5);
						}
						else
						{
							if (_local_6 == _local_3)
							{
								if (((_local_2.x * _local_2.y) - _arg_1) > ((_local_4 * _local_5) - _arg_1))
								{
									_local_3 = _local_6;
									_local_2 = new Point(_local_4, _local_5);
								}
							}
						}
					}
				}
				_local_5--;
			}
			_local_4--;
		}
		return (_local_2);
	}

	private function calculateElementSize(_arg_1:Point):int
	{
		var _local_2:int = int(Math.floor((this.maxResultHeight / _arg_1.y)));
		if ((_local_2 * _arg_1.x) > this.maxResultWidth)
		{
			_local_2 = int(Math.floor((this.maxResultWidth / _arg_1.x)));
		}
		if ((_local_2 * _arg_1.y) > this.maxResultHeight)
		{
			return (-1);
		}
		return (_local_2);
	}

	override protected function createBoxBackground():void
	{
		var _local_2:int;
		var _local_4:UIItemContainer;
		var _local_1:Array = MysteryBoxInfo(_boxInfo).displayedItems.split(",");
		if (((_local_1.length == 0) || (MysteryBoxInfo(_boxInfo).displayedItems == "")))
		{
			return;
		}
		if (_infoButton)
		{
			_infoButton.alpha = 0;
		}
		switch (_local_1.length)
		{
			case 1:
				break;
			case 2:
				_local_2 = 50;
				break;
			case 3:
				break;
		}
		this.prepareResultGrid(_local_1.length);
		var _local_3:int;
		while (_local_3 < _local_1.length)
		{
			_local_4 = new UIItemContainer(_local_1[_local_3], 0, 0, this.resultElementWidth);
			this.displayedItemsGrid.addGridElement(_local_4);
			_local_3++;
		}
	}

	override public function resize(_arg_1:int, _arg_2:int = -1):void
	{
		background.width = _arg_1;
		backgroundTitle.width = _arg_1;
		backgroundButton.width = _arg_1;
		background.height = 184;
		backgroundTitle.y = 2;
		titleLabel.x = Math.round(((_arg_1 - titleLabel.textWidth) / 2));
		titleLabel.y = 6;
		backgroundButton.y = 133;
		_buyButton.y = (backgroundButton.y + 4);
		_buyButton.x = (_arg_1 - 110);
		_infoButton.x = 130;
		_infoButton.y = 45;
		if (this.displayedItemsGrid)
		{
			this.displayedItemsGrid.x = (10 + Math.round(((this.maxResultWidth - (this.resultElementWidth * this.gridConfig.x)) / 2)));
		}
		updateSaleLabel();
		updateClickMask(_arg_1);
		updateTimeEndString(_arg_1);
		updateStartTimeString(_arg_1);
	}

	override public function dispose():void
	{
		if (this.displayedItemsGrid)
		{
			this.displayedItemsGrid.dispose();
		}
		super.dispose();
	}


}
}//package io.decagames.rotmg.shop.mysteryBox

