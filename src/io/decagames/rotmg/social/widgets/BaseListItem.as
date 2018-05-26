// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.social.widgets.BaseListItem

package io.decagames.rotmg.social.widgets{
import com.company.assembleegameclient.ui.icons.IconButton;
import com.company.assembleegameclient.ui.icons.IconButtonFactory;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import io.decagames.rotmg.social.data.SocialItemState;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;

public class BaseListItem extends Sprite implements TooltipAble {

        protected const LIST_ITEM_WIDTH:int = 310;
        protected const LIST_ITEM_HEIGHT:int = 40;
        protected const ONLINE_COLOR:uint = 3407650;
        protected const OFFLINE_COLOR:uint = 0xB3B3B3;

        protected var _characterContainer:Sprite;
        protected var hoverTooltipDelegate:HoverTooltipDelegate;
        protected var _state:int;
        protected var _iconButtonFactory:IconButtonFactory;
        protected var listBackground:SliceScalingBitmap;
        protected var listLabel:UILabel;
        protected var listPortrait:Bitmap;
        private var toolTip_:TextToolTip;

        public function BaseListItem(_arg_1:int){
            this._state = _arg_1;
        }

        public function getLabelText():String{
            return (this.listLabel.text);
        }

        public function setToolTipTitle(_arg_1:String, _arg_2:Object=null):void{
            if (_arg_1 != ""){
                if (this.toolTip_ == null){
                    this.toolTip_ = new TextToolTip(0x363636, 0x9B9B9B, "", "", 200);
                    this.hoverTooltipDelegate.setDisplayObject(this._characterContainer);
                    this.hoverTooltipDelegate.tooltip = this.toolTip_;
                }
                this.toolTip_.setTitle(new LineBuilder().setParams(_arg_1, _arg_2));
            }
        }

        public function setToolTipText(_arg_1:String, _arg_2:Object=null):void{
            if (_arg_1 != ""){
                if (this.toolTip_ == null){
                    this.toolTip_ = new TextToolTip(0x363636, 0x9B9B9B, "", "", 200);
                    this.hoverTooltipDelegate.setDisplayObject(this._characterContainer);
                    this.hoverTooltipDelegate.tooltip = this.toolTip_;
                }
                this.toolTip_.setText(new LineBuilder().setParams(_arg_1, _arg_2));
            }
        }

        protected function init():void{
            this._iconButtonFactory = StaticInjectorContext.getInjector().getInstance(IconButtonFactory);
            this.hoverTooltipDelegate = new HoverTooltipDelegate();
            this.setBaseItemState();
            this._characterContainer = new Sprite();
            addChild(this._characterContainer);
        }

        private function setBaseItemState():void{
            switch (this._state){
                case SocialItemState.ONLINE:
                    this.listBackground = TextureParser.instance.getSliceScalingBitmap("UI", "listitem_content_background");
                    addChild(this.listBackground);
                    break;
                case SocialItemState.OFFLINE:
                    this.listBackground = TextureParser.instance.getSliceScalingBitmap("UI", "listitem_content_background_inactive");
                    addChild(this.listBackground);
                    break;
                case SocialItemState.INVITE:
                    this.listBackground = TextureParser.instance.getSliceScalingBitmap("UI", "listitem_content_background_indicator");
                    addChild(this.listBackground);
                    break;
            }
            this.listBackground.height = this.LIST_ITEM_HEIGHT;
            this.listBackground.width = this.LIST_ITEM_WIDTH;
        }

        protected function createListLabel(_arg_1:String):void{
            this.listLabel = new UILabel();
            this.listLabel.x = 40;
            this.listLabel.y = 12;
            this.listLabel.text = _arg_1;
            this.setLabelColorByState(this.listLabel);
            this._characterContainer.addChild(this.listLabel);
        }

        protected function createListPortrait(_arg_1:BitmapData):void{
            this.listPortrait = new Bitmap(_arg_1);
            this.listPortrait.x = (-(Math.round((this.listPortrait.width / 2))) + 22);
            this.listPortrait.y = (-(Math.round((this.listPortrait.height / 2))) + 20);
            if (this.listPortrait){
                this._characterContainer.addChild(this.listPortrait);
            }
        }

        protected function setLabelColorByState(_arg_1:UILabel):void{
            switch (this._state){
                case SocialItemState.ONLINE:
                    DefaultLabelFormat.friendsItemLabel(_arg_1, this.ONLINE_COLOR);
                    return;
                case SocialItemState.OFFLINE:
                    DefaultLabelFormat.friendsItemLabel(_arg_1, this.OFFLINE_COLOR);
                    return;
                default:
                    DefaultLabelFormat.defaultSmallPopupTitle(_arg_1);
            }
        }

        protected function addButton(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:String=""):IconButton{
            var _local_7:IconButton;
            _local_7 = this._iconButtonFactory.create(AssetLibrary.getImageFromSet(_arg_1, _arg_2), "", "", "");
            _local_7.setToolTipTitle(_arg_5);
            _local_7.setToolTipText(_arg_6);
            _local_7.x = _arg_3;
            _local_7.y = _arg_4;
            addChild(_local_7);
            return (_local_7);
        }

        public function setShowToolTipSignal(_arg_1:ShowTooltipSignal):void{
            this.hoverTooltipDelegate.setShowToolTipSignal(_arg_1);
        }

        public function getShowToolTip():ShowTooltipSignal{
            return (this.hoverTooltipDelegate.getShowToolTip());
        }

        public function setHideToolTipsSignal(_arg_1:HideTooltipsSignal):void{
            this.hoverTooltipDelegate.setHideToolTipsSignal(_arg_1);
        }

        public function getHideToolTips():HideTooltipsSignal{
            return (this.hoverTooltipDelegate.getHideToolTips());
        }


    }
}//package io.decagames.rotmg.social.widgets

