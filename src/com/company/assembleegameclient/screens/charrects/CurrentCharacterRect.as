//com.company.assembleegameclient.screens.charrects.CurrentCharacterRect

package com.company.assembleegameclient.screens.charrects
{
import com.company.assembleegameclient.appengine.CharacterStats;
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.screens.events.DeleteCharacterEvent;
import com.company.assembleegameclient.ui.tooltip.MyPlayerToolTip;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.util.FameUtil;
import com.company.rotmg.graphics.DeleteXGraphic;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import io.decagames.rotmg.fame.FameContentPopup;
import io.decagames.rotmg.pets.data.vo.PetVO;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.assets.services.IconFactory;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;
import org.swiftsuspenders.Injector;

public class CurrentCharacterRect extends CharacterRect
{
	// TODO add inventory viewer + stats viewer

	private static var toolTip_:MyPlayerToolTip = null;
	private static var fameToolTip:TextToolTip = null;
	public static var charnames:Vector.<String> = new Vector.<String>(0);
	public static var charids:Vector.<int> = new Vector.<int>(0);

	public const selected:Signal = new Signal();
	public const deleteCharacter:Signal = new Signal();
	public const showToolTip:Signal = new Signal(Sprite);
	public const hideTooltip:Signal = new Signal();

	public var charName:String;
	public var charStats:CharacterStats;
	public var char:SavedCharacter;
	public var myPlayerToolTipFactory:MyPlayerToolTipFactory = new MyPlayerToolTipFactory();
	private var charType:CharacterClass;
	private var deleteButton:Sprite;
	private var icon:DisplayObject;
	private var petIcon:Bitmap;
	private var fameBitmap:Bitmap;
	private var fameBitmapContainer:Sprite;
	protected var statsMaxedText:TextFieldDisplayConcrete;

	public function CurrentCharacterRect(_arg_1:String, _arg_2:CharacterClass, _arg_3:SavedCharacter, _arg_4:CharacterStats)
	{
		this.charName = _arg_1;
		this.charType = _arg_2;
		this.char = _arg_3;
		this.charStats = _arg_4;
		var _local_5:String = _arg_2.name;
		var _local_6:int = _arg_3.charXML_.Level;
		super.className = new LineBuilder().setParams(TextKey.CURRENT_CHARACTER_DESCRIPTION, {
			"className": _local_5,
			"level": _local_6
		});
		this.setCharCon(_local_5.toLowerCase(), this.char.charId());
		super.color = 0x5C5C5C;
		super.overColor = 0x7F7F7F;
		super.init();
		this.makeTagline();
		this.makeDeleteButton();
		this.makePetIcon();
		this.makeStatsMaxedText();
		this.makeFameUIIcon();
		this.addEventListeners();
	}

	private function addEventListeners():void
	{
		addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
		selectContainer.addEventListener(MouseEvent.CLICK, this.onSelect);
		selectContainer.addEventListener(MouseEvent.RIGHT_CLICK, this.onSelectVault);
		selectContainer.addEventListener(MouseEvent.MIDDLE_CLICK, this.onDelete);
		this.fameBitmapContainer.addEventListener(MouseEvent.CLICK, this.onFameClick);
		this.deleteButton.addEventListener(MouseEvent.CLICK, this.onDelete);
	}

	private function onSelect(_arg_1:MouseEvent):void
	{
		this.selected.dispatch(this.char);
	}

	private function onSelectVault(_arg_1:MouseEvent):void
	{
		Parameters.data_.vaultSelection = true;
		this.selected.dispatch(this.char);
	}

	private function onFameClick(_arg_1:MouseEvent):void
	{
		var _local_2:Injector = StaticInjectorContext.getInjector();
		var _local_3:ShowPopupSignal = _local_2.getInstance(ShowPopupSignal);
		_local_3.dispatch(new FameContentPopup(this.char.charId()));
	}

	private function onDelete(_arg_1:MouseEvent):void
	{
		this.deleteCharacter.dispatch(this.char);
	}

	public function setIcon(_arg_1:DisplayObject):void
	{
		((this.icon) && (selectContainer.removeChild(this.icon)));
		this.icon = _arg_1;
		this.icon.x = CharacterRectConstants.ICON_POS_X;
		this.icon.y = CharacterRectConstants.ICON_POS_Y;
		((this.icon) && (selectContainer.addChild(this.icon)));
	}

	private function setCharCon(_arg_1:String, _arg_2:int):void
	{
		var _local_3:int;
		while (_local_3 < charnames.length)
		{
			if (charnames[_local_3] == _arg_1)
			{
				if (charids[_local_3] < _arg_2)
				{
					_arg_1 = (_arg_1 + "2");
					charnames.push(_arg_1);
					charids.push(_arg_2);
				}
				else
				{
					_arg_1 = (_arg_1 + "2");
					charnames.push(_arg_1);
					charids.push(charids[_local_3]);
					charids[_local_3] = _arg_2;
				}
				return;
			}
			_local_3++;
		}
		charnames.push(_arg_1);
		charids.push(_arg_2);
	}

	private function makePetIcon():void
	{
		var _local_1:PetVO = this.char.getPetVO();
		if (_local_1)
		{
			this.petIcon = _local_1.getSkinBitmap();
			if (this.petIcon == null)
			{
				return;
			}
			this.petIcon.x = CharacterRectConstants.PET_ICON_POS_X;
			this.petIcon.y = CharacterRectConstants.PET_ICON_POS_Y;
			selectContainer.addChild(this.petIcon);
		}
	}

	private function makeTagline():void
	{
		if (this.getNextStarFame() > 0)
		{
			super.makeTaglineIcon();
			super.makeTaglineText(new LineBuilder().setParams(TextKey.CURRENT_CHARACTER_TAGLINE, {
				"fame":this.char.fame(),
				"nextStarFame":this.getNextStarFame()
			}));
			taglineText.x = (taglineText.x + taglineIcon.width);
		}
		else
		{
			super.makeTaglineIcon();
			super.makeTaglineText(new LineBuilder().setParams(TextKey.CURRENT_CHARACTER_TAGLINE_NOQUEST, {"fame":this.char.fame()}));
			taglineText.x = (taglineText.x + taglineIcon.width);
		}
	}

	private function getNextStarFame():int
	{
		return (FameUtil.nextStarFame(((this.charStats == null) ? 0 : this.charStats.bestFame()), this.char.fame()));
	}

	private function makeDeleteButton():void
	{
		this.deleteButton = new DeleteXGraphic();
		this.deleteButton.addEventListener(MouseEvent.MOUSE_DOWN, this.onDeleteDown);
		this.deleteButton.x = (WIDTH - 30);
		this.deleteButton.y = ((HEIGHT - this.deleteButton.height) * 0.5);
		addChild(this.deleteButton);
	}

	private function makeStatsMaxedText():void
	{
		var _local_1:int = this.getMaxedStats();
		var _local_2:uint = 0xB3B3B3;
		if (_local_1 >= 8)
		{
			_local_2 = 0xFCDF00;
		}
		this.statsMaxedText = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF);
		this.statsMaxedText.setBold(true);
		this.statsMaxedText.setColor(_local_2);
		this.statsMaxedText.setStringBuilder(new StaticStringBuilder((_local_1 + "/8")));
		this.statsMaxedText.filters = makeDropShadowFilter();
		this.statsMaxedText.x = CharacterRectConstants.STATS_MAXED_POS_X;
		this.statsMaxedText.y = CharacterRectConstants.STATS_MAXED_POS_Y;
		selectContainer.addChild(this.statsMaxedText);
	}

	private function makeFameUIIcon():void
	{
		var _local_1:BitmapData = IconFactory.makeFame();
		this.fameBitmap = new Bitmap(_local_1);
		this.fameBitmapContainer = new Sprite();
		this.fameBitmapContainer.name = "fame_ui";
		this.fameBitmapContainer.addChild(this.fameBitmap);
		this.fameBitmapContainer.x = CharacterRectConstants.FAME_UI_POS_X;
		this.fameBitmapContainer.y = CharacterRectConstants.FAME_UI_POS_Y;
		addChild(this.fameBitmapContainer);
	}

	private function getMaxedStats():int
	{
		var _local_1:int;
		if (this.char.hp() == this.charType.hp.max)
		{
			_local_1++;
		}
		if (this.char.mp() == this.charType.mp.max)
		{
			_local_1++;
		}
		if (this.char.att() == this.charType.attack.max)
		{
			_local_1++;
		}
		if (this.char.def() == this.charType.defense.max)
		{
			_local_1++;
		}
		if (this.char.spd() == this.charType.speed.max)
		{
			_local_1++;
		}
		if (this.char.dex() == this.charType.dexterity.max)
		{
			_local_1++;
		}
		if (this.char.vit() == this.charType.hpRegeneration.max)
		{
			_local_1++;
		}
		if (this.char.wis() == this.charType.mpRegeneration.max)
		{
			_local_1++;
		}
		return (_local_1);
	}

	override protected function onMouseOver(_arg_1:MouseEvent):void
	{
		super.onMouseOver(_arg_1);
		this.removeToolTip();
		if (_arg_1.target.name == "fame_ui")
		{
			fameToolTip = new TextToolTip(0x363636, 0x9B9B9B, "Fame", "Click to get an Overview!", 225);
			this.showToolTip.dispatch(fameToolTip);
		}
		else
		{
			toolTip_ = this.myPlayerToolTipFactory.create(this.charName, this.char.charXML_, this.charStats);
			toolTip_.createUI();
			this.showToolTip.dispatch(toolTip_);
		}
	}

	override protected function onRollOut(_arg_1:MouseEvent):void
	{
		super.onRollOut(_arg_1);
		this.removeToolTip();
	}

	private function onRemovedFromStage(_arg_1:Event):void
	{
		this.removeToolTip();
		selectContainer.removeEventListener(MouseEvent.CLICK, this.onSelect);
		selectContainer.removeEventListener(MouseEvent.RIGHT_CLICK, this.onSelectVault);
		selectContainer.removeEventListener(MouseEvent.MIDDLE_CLICK, this.onDelete);
		this.fameBitmapContainer.removeEventListener(MouseEvent.CLICK, this.onFameClick);
		this.deleteButton.removeEventListener(MouseEvent.CLICK, this.onDelete);
	}

	private function removeToolTip():void
	{
		this.hideTooltip.dispatch();
	}

	private function onDeleteDown(_arg_1:MouseEvent):void
	{
		_arg_1.stopImmediatePropagation();
		dispatchEvent(new DeleteCharacterEvent(this.char));
	}


}
}//package com.company.assembleegameclient.screens.charrects

