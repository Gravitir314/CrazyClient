﻿//io.decagames.rotmg.ui.tabs.UITabs

package io.decagames.rotmg.ui.tabs
{
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

import io.decagames.rotmg.social.signals.TabSelectedSignal;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;

import org.osflash.signals.Signal;

public class UITabs extends Sprite
{

	public var buttonsRenderedSignal:Signal = new Signal();
	public var tabSelectedSignal:TabSelectedSignal = new TabSelectedSignal();
	private var tabsXSpace:int = 3;
	private var tabsButtonMargin:int = 14;
	private var content:Vector.<UITab>;
	private var buttons:Vector.<TabButton>;
	private var tabsWidth:int;
	private var background:TabContentBackground;
	private var currentContent:UITab;
	private var defaultSelectedIndex:int = 0;
	private var borderlessMode:Boolean;
	private var _currentTabLabel:String;

	public function UITabs(_arg_1:int, _arg_2:Boolean = false)
	{
		this.tabsWidth = _arg_1;
		this.borderlessMode = _arg_2;
		this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedHandler);
		this.content = new Vector.<UITab>(0);
		this.buttons = new Vector.<TabButton>(0);
		if (!_arg_2)
		{
			this.background = new TabContentBackground();
			this.background.addMargin(0, 3);
			this.background.width = _arg_1;
			this.background.height = 405;
			this.background.x = 0;
			this.background.y = 41;
			addChild(this.background);
		}
		else
		{
			this.tabsButtonMargin = 3;
		}
	}

	public function addTab(_arg_1:UITab, _arg_2:Boolean = false):void
	{
		this.content.push(_arg_1);
		_arg_1.y = ((this.borderlessMode) ? 34 : 56);
		if (_arg_2)
		{
			this.defaultSelectedIndex = (this.content.length - 1);
			this.currentContent = _arg_1;
			this._currentTabLabel = _arg_1.tabName;
			addChild(_arg_1);
		}
		if (this._currentTabLabel == "")
		{
			this._currentTabLabel = _arg_1.tabName;
		}
	}

	private function createTabButtons():void
	{
		var _local_1:int;
		var _local_2:int;
		var _local_3:String;
		var _local_4:TabButton;
		var _local_5:UITab;
		var _local_6:TabButton;
		_local_1 = 1;
		_local_2 = int((((this.tabsWidth - ((this.content.length - 1) * this.tabsXSpace)) - (this.tabsButtonMargin * 2)) / this.content.length));
		for each (_local_5 in this.content)
		{
			if (_local_1 == 1)
			{
				_local_3 = TabButton.LEFT;
			}
			else
			{
				if (_local_1 == this.content.length)
				{
					_local_3 = TabButton.RIGHT;
				}
				else
				{
					_local_3 = TabButton.CENTER;
				}
			}
			_local_6 = this.createTabButton(_local_5.tabName, _local_3);
			_local_6.width = _local_2;
			_local_6.selected = (this.defaultSelectedIndex == (_local_1 - 1));
			if (_local_6.selected)
			{
				_local_4 = _local_6;
			}
			_local_6.y = 3;
			_local_6.x = ((this.tabsButtonMargin + (_local_2 * (_local_1 - 1))) + (this.tabsXSpace * (_local_1 - 1)));
			addChild(_local_6);
			_local_6.clickSignal.add(this.onButtonSelected);
			this.buttons.push(_local_6);
			_local_1++;
		}
		if (this.background)
		{
			this.background.addDecor((_local_4.x - 4), ((_local_4.x + _local_4.width) - 12), this.defaultSelectedIndex, this.buttons.length);
		}
		this.onButtonSelected(_local_4);
		this.buttonsRenderedSignal.dispatch();
	}

	private function onButtonSelected(_arg_1:TabButton):void
	{
		var _local_3:TabButton;
		var _local_2:int = this.buttons.indexOf(_arg_1);
		_arg_1.y = 0;
		this._currentTabLabel = _arg_1.label.text;
		this.tabSelectedSignal.dispatch(_arg_1.label.text);
		for each (_local_3 in this.buttons)
		{
			if (_local_3 != _arg_1)
			{
				_local_3.selected = false;
				_local_3.y = 3;
				this.updateTabButtonGraphicState(_local_3, _local_2);
			}
			else
			{
				_local_3.selected = true;
			}
		}
		if (this.currentContent)
		{
			this.currentContent.displaySignal.dispatch(false);
			this.currentContent.alpha = 0;
			this.currentContent.mouseChildren = false;
			this.currentContent.mouseEnabled = false;
		}
		this.currentContent = this.content[_local_2];
		if (this.background)
		{
			this.background.addDecor((_arg_1.x - 5), ((_arg_1.x + _arg_1.width) - 12), _local_2, this.buttons.length);
		}
		addChild(this.currentContent);
		this.currentContent.displaySignal.dispatch(true);
		this.currentContent.alpha = 1;
		this.currentContent.mouseChildren = true;
		this.currentContent.mouseEnabled = true;
	}

	private function updateTabButtonGraphicState(_arg_1:TabButton, _arg_2:int):void
	{
		var _local_3:int = this.buttons.indexOf(_arg_1);
		if (Math.abs((_local_3 - _arg_2)) <= 1)
		{
			if (this.borderlessMode)
			{
				_arg_1.changeBitmap("tab_button_borderless_idle", new Point(0, ((this.borderlessMode) ? 0 : TabButton.SELECTED_MARGIN)));
				_arg_1.bitmap.alpha = 0;
			}
			else
			{
				if (_local_3 > _arg_2)
				{
					_arg_1.changeBitmap("tab_button_right_idle", new Point(0, ((this.borderlessMode) ? 0 : TabButton.SELECTED_MARGIN)));
				}
				else
				{
					_arg_1.changeBitmap("tab_button_left_idle", new Point(0, ((this.borderlessMode) ? 0 : TabButton.SELECTED_MARGIN)));
				}
			}
		}
	}

	public function getTabButtonByLabel(_arg_1:String):TabButton
	{
		var _local_2:TabButton;
		for each (_local_2 in this.buttons)
		{
			if (_local_2.label.text == _arg_1)
			{
				return (_local_2);
			}
		}
		return (null);
	}

	private function createTabButton(_arg_1:String, _arg_2:String):TabButton
	{
		var _local_3:TabButton = new TabButton(((this.borderlessMode) ? TabButton.BORDERLESS : _arg_2));
		_local_3.setLabel(_arg_1, DefaultLabelFormat.defaultInactiveTab);
		return (_local_3);
	}

	private function onAddedHandler(_arg_1:Event):void
	{
		this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedHandler);
		this.createTabButtons();
	}

	public function dispose():void
	{
		var _local_1:TabButton;
		var _local_2:UITab;
		if (this.background)
		{
			this.background.dispose();
		}
		for each (_local_1 in this.buttons)
		{
			_local_1.dispose();
		}
		for each (_local_2 in this.content)
		{
			_local_2.dispose();
		}
		this.currentContent.dispose();
		this.content = null;
		this.buttons = null;
	}

	public function get currentTabLabel():String
	{
		return (this._currentTabLabel);
	}


}
}//package io.decagames.rotmg.ui.tabs

