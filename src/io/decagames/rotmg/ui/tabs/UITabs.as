// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.tabs.UITabs

package io.decagames.rotmg.ui.tabs
{
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;

public class UITabs extends Sprite
    {

        private var tabsXSpace:int = 3;
        private var tabsButtonMargin:int = 14;
        private var content:Vector.<UITab>;
        private var buttons:Vector.<TabButton>;
        private var tabsWidth:int;
        private var background:TabContentBackground;
        private var currentContent:UITab;
        private var defaultSelectedIndex:int;

        public function UITabs(_arg_1:int)
        {
            this.tabsWidth = _arg_1;
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedHandler);
            this.content = new Vector.<UITab>(0);
            this.buttons = new Vector.<TabButton>(0);
            this.background = new TabContentBackground();
            this.background.addMargin(0, 3);
            this.background.width = _arg_1;
            this.background.height = 405;
            this.background.x = 0;
            this.background.y = 41;
            addChild(this.background);
        }

        public function addTab(_arg_1:UITab, _arg_2:Boolean=false):void
        {
            this.content.push(_arg_1);
            _arg_1.y = 56;
            if (_arg_2)
            {
                this.defaultSelectedIndex = (this.content.length - 1);
                this.currentContent = _arg_1;
                addChild(_arg_1);
            };
        }

        private function createTabButtons():void
        {
            var _local_1:int;
            var _local_2:String;
            var _local_3:TabButton;
            var _local_4:UITab;
            var _local_5:TabButton;
            _local_1 = 1;
            var _local_6:int = int((((this.tabsWidth - ((this.content.length - 1) * this.tabsXSpace)) - (this.tabsButtonMargin * 2)) / this.content.length));
            for each (_local_4 in this.content)
            {
                if (_local_1 == 1)
                {
                    _local_2 = TabButton.LEFT;
                }
                else
                {
                    if (_local_1 == this.content.length)
                    {
                        _local_2 = TabButton.RIGHT;
                    }
                    else
                    {
                        _local_2 = TabButton.CENTER;
                    };
                };
                _local_5 = this.createTabButton(_local_4.tabName, _local_2);
                _local_5.width = _local_6;
                _local_5.selected = (this.defaultSelectedIndex == (_local_1 - 1));
                if (_local_5.selected)
                {
                    _local_3 = _local_5;
                };
                _local_5.y = 3;
                _local_5.x = ((this.tabsButtonMargin + (_local_6 * (_local_1 - 1))) + (this.tabsXSpace * (_local_1 - 1)));
                addChild(_local_5);
                _local_5.clickSignal.add(this.onButtonSelected);
                this.buttons.push(_local_5);
                _local_1++;
            };
            this.background.addDecor((_local_3.x - 4), ((_local_3.x + _local_3.width) - 12), this.defaultSelectedIndex, this.buttons.length);
        }

        private function onButtonSelected(_arg_1:TabButton):void
        {
            var _local_2:TabButton;
            var _local_3:int;
            var _local_4:int;
            _arg_1.y = 0;
            for each (_local_2 in this.buttons)
            {
                if (_local_2 != _arg_1)
                {
                    _local_2.selected = false;
                    _local_2.y = 3;
                };
            };
            _local_3 = this.buttons.indexOf(_arg_1);
            for each (_local_2 in this.buttons)
            {
                if (!_local_2.selected)
                {
                    _local_4 = this.buttons.indexOf(_local_2);
                    if (Math.abs((_local_4 - _local_3)) <= 1)
                    {
                        if (_local_4 > _local_3)
                        {
                            _local_2.changeBitmap("tab_button_right_idle", new Point(0, TabButton.SELECTED_MARGIN));
                        }
                        else
                        {
                            _local_2.changeBitmap("tab_button_left_idle", new Point(0, TabButton.SELECTED_MARGIN));
                        };
                    };
                };
            };
            if (this.currentContent)
            {
                removeChild(this.currentContent);
            };
            this.currentContent = this.content[_local_3];
            this.background.addDecor((_arg_1.x - 5), ((_arg_1.x + _arg_1.width) - 12), _local_3, this.buttons.length);
            addChild(this.currentContent);
        }

        private function createTabButton(_arg_1:String, _arg_2:String):TabButton
        {
            var _local_3:TabButton = new TabButton(_arg_2);
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
            this.background.dispose();
            for each (_local_1 in this.buttons)
            {
                _local_1.dispose();
            };
            for each (_local_2 in this.content)
            {
                _local_2.dispose();
            };
            this.currentContent.dispose();
            this.content = null;
            this.buttons = null;
        }


    }
}//package io.decagames.rotmg.ui.tabs

