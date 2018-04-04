// Decompiled by AS3 Sorcerer 5.64
// www.as3sorcerer.com

//io.decagames.rotmg.ui.tabs.TabButton

package io.decagames.rotmg.ui.tabs{
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class TabButton extends SliceScalingButton {

    public static const SELECTED_MARGIN:int = 3;
    public static const LEFT:String = "left";
    public static const RIGHT:String = "right";
    public static const CENTER:String = "center";
    public static const BORDERLESS:String = "borderless";

    private var _selected:Boolean;
    private var selectedBitmap:String;
    private var defaultBitmap:String;
    private var buttonType:String;
    private var indicator:Sprite;

    public function TabButton(_arg_1:String){
        this.buttonType = _arg_1;
        switch (_arg_1){
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
                break;
            case BORDERLESS:
                this.defaultBitmap = "tab_button_borderless_idle";
                this.selectedBitmap = "tab_button_borderless";
        };
        this.defaultBitmap = this.defaultBitmap;
        this.selectedBitmap = this.selectedBitmap;
        var _local_2:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", this.defaultBitmap);
        super(_local_2);
        bitmap.name = "TabButton";
        _local_2.addMargin(0, ((this.buttonType == BORDERLESS) ? 0 : SELECTED_MARGIN));
        _interactionEffects = false;
    }

    public function get hasIndicator():Boolean{
        return ((this.indicator) && (this.indicator.parent));
    }

    public function set showIndicator(_arg_1:Boolean):void{
        if (_arg_1){
            if (!this.indicator){
                this.indicator = new Sprite();
            };
            this.indicator.graphics.clear();
            this.indicator.graphics.beginFill(823807);
            this.indicator.graphics.drawCircle(0, 0, 4);
            this.indicator.graphics.endFill();
            addChild(this.indicator);
            this.updateIndicatorPosition();
        } else {
            if (((this.indicator) && (this.indicator.parent))){
                removeChild(this.indicator);
            };
        };
    }

    private function updateIndicatorPosition():void{
        if (this.indicator){
            this.indicator.x = ((this.label.x + this.label.width) + 7);
            this.indicator.y = (this.label.y + 8);
        };
    }

    public function set selected(_arg_1:Boolean):void{
        this._selected = _arg_1;
        if (!this._selected){
            setLabelMargin(0, 0);
            DefaultLabelFormat.defaultInactiveTab(this.label);
            changeBitmap(this.defaultBitmap, new Point(0, ((this.buttonType == BORDERLESS) ? 0 : SELECTED_MARGIN)));
            bitmap.alpha = 0;
        } else {
            setLabelMargin(0, ((this.buttonType == BORDERLESS) ? 0 : 2));
            DefaultLabelFormat.defaultActiveTab(this.label);
            changeBitmap(this.selectedBitmap, new Point(0, ((this.buttonType == BORDERLESS) ? 0 : SELECTED_MARGIN)));
            bitmap.alpha = 1;
        };
        this.updateIndicatorPosition();
    }

    override protected function onClickHandler(_arg_1:MouseEvent):void{
        super.onClickHandler(_arg_1);
        if (!this._selected){
            this.selected = (!(this._selected));
        };
    }

    public function get selected():Boolean{
        return (this._selected);
    }


}
}//package io.decagames.rotmg.ui.tabs

