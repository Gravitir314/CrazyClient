// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.tabs.UITab

package io.decagames.rotmg.ui.tabs
{
import flash.display.Sprite;

public class UITab extends Sprite 
    {

        private var _tabName:String;

        public function UITab(_arg_1:String)
        {
            this._tabName = _arg_1;
        }

        public function addContent(_arg_1:Sprite):void
        {
            addChild(_arg_1);
        }

        public function get tabName():String
        {
            return (this._tabName);
        }

        public function set tabName(_arg_1:String):void
        {
            this._tabName = _arg_1;
        }

        public function dispose():void
        {
        }


    }
}//package io.decagames.rotmg.ui.tabs

