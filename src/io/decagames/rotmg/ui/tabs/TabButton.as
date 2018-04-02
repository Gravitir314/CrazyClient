// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.tabs.TabButton

package io.decagames.rotmg.ui.tabs
{
import flash.events.MouseEvent;
import flash.geom.Point;

import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class TabButton extends SliceScalingButton
    {

        public static const SELECTED_MARGIN:int = 5;
        public static const LEFT:String = "left";
        public static const RIGHT:String = "right";
        public static const CENTER:String = "center";

        private var _selected:Boolean;
        private var selectedBitmap:String;
        private var defaultBitmap:String;
        private var buttonType:String;

        public function TabButton(_arg_1:String)
        {
            this.buttonType = _arg_1;
            switch (_arg_1)
            {
                case LEFT:
                    this.defaultBitmap = "tab_button_left_idle";
                    this.selectedBitmap = "tab_button_center_open";
                    break;
                case RIGHT:
                    this.defaultBitmap = "tab_button_right_idle";
                    this.selectedBitmap = "tab_button_right_open";
                    break;
                case CENTER:
                    this.defaultBitmap = "tab_button_center_idle";
                    this.selectedBitmap = "tab_button_center_open";
            };
            this.defaultBitmap = this.defaultBitmap;
            this.selectedBitmap = this.selectedBitmap;
            var _local_2:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", this.defaultBitmap);
            _local_2.addMargin(0, SELECTED_MARGIN);
            super(_local_2);
            _interactionEffects = false;
        }

        public function set selected(_arg_1:Boolean):void
        {
            this._selected = _arg_1;
            if (!this._selected)
            {
                DefaultLabelFormat.defaultInactiveTab(this.label);
            }
            else
            {
                DefaultLabelFormat.defaultActiveTab(this.label);
            };
            changeBitmap(((this._selected) ? this.selectedBitmap : this.defaultBitmap), ((this._selected) ? null : new Point(0, SELECTED_MARGIN)));
        }

        override protected function onClickHandler(_arg_1:MouseEvent):void
        {
            super.onClickHandler(_arg_1);
            this.selected = (!(this._selected));
        }

        public function get selected():Boolean
        {
            return (this._selected);
        }


    }
}//package io.decagames.rotmg.ui.tabs

