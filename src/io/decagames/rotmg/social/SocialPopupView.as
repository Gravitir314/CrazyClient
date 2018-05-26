// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.social.SocialPopupView

package io.decagames.rotmg.social{
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import io.decagames.rotmg.social.widgets.FriendListItem;
import io.decagames.rotmg.social.widgets.GuildInfoItem;
import io.decagames.rotmg.social.widgets.GuildListItem;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.gird.UIGrid;
import io.decagames.rotmg.ui.gird.UIGridElement;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.popups.modal.ModalPopup;
import io.decagames.rotmg.ui.scroll.UIScrollbar;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.tabs.TabButton;
import io.decagames.rotmg.ui.tabs.UITab;
import io.decagames.rotmg.ui.tabs.UITabs;
import io.decagames.rotmg.ui.textField.InputTextField;
import io.decagames.rotmg.ui.texture.TextureParser;

public class SocialPopupView extends ModalPopup {

        public static const SOCIAL_LABEL:String = "Social";
        public static const FRIEND_TAB_LABEL:String = "Friends";
        public static const GUILD_TAB_LABEL:String = "Guild";
        public static const MAX_VISIBLE_INVITATIONS:int = 3;
        public static const DEFAULT_NO_GUILD_MESSAGE:String = ("You have not yet joined a Guild,\n" + "join a Guild to find Players to play with or\n create your own Guild.");

        public var search:InputTextField;
        public var addButton:SliceScalingButton;
        private var contentInset:SliceScalingBitmap;
        private var friendsGrid:UIGrid;
        private var guildsGrid:UIGrid;
        private var _tabs:UITabs;
        private var _tabContent:Sprite;

        public function SocialPopupView(){
            super(350, 505, SOCIAL_LABEL, DefaultLabelFormat.defaultSmallPopupTitle, new Rectangle(0, 0, 350, 565));
            this.init();
        }

        public function addFriendCategory(_arg_1:String):void{
            var _local_3:UILabel;
            var _local_2:UIGridElement = new UIGridElement();
            _local_3 = new UILabel();
            _local_3.text = _arg_1;
            DefaultLabelFormat.defaultSmallPopupTitle(_local_3);
            _local_2.addChild(_local_3);
            this.friendsGrid.addGridElement(_local_2);
        }

        public function addFriend(_arg_1:FriendListItem):void{
            var _local_2:UIGridElement = new UIGridElement();
            _local_2.addChild(_arg_1);
            this.friendsGrid.addGridElement(_local_2);
        }

        public function addGuildInfo(_arg_1:GuildInfoItem):void{
            var _local_2:UIGridElement;
            _local_2 = new UIGridElement();
            _local_2.addChild(_arg_1);
            _local_2.x = ((_contentWidth - _local_2.width) / 2);
            _local_2.y = 10;
            this._tabContent.addChild(_local_2);
        }

        public function addGuildCategory(_arg_1:String):void{
            var _local_2:UIGridElement = new UIGridElement();
            var _local_3:UILabel = new UILabel();
            _local_3.text = _arg_1;
            DefaultLabelFormat.defaultSmallPopupTitle(_local_3);
            _local_2.addChild(_local_3);
            this.guildsGrid.addGridElement(_local_2);
        }

        public function addGuildDefaultMessage(_arg_1:String):void{
            var _local_2:UIGridElement;
            var _local_3:UILabel;
            _local_2 = new UIGridElement();
            _local_3 = new UILabel();
            _local_3.width = 300;
            _local_3.multiline = true;
            _local_3.wordWrap = true;
            _local_3.text = _arg_1;
            _local_3.x = (((350 - 300) / 2) - 20);
            DefaultLabelFormat.guildInfoLabel(_local_3, 14, 0xB3B3B3, TextFormatAlign.CENTER);
            _local_2.addChild(_local_3);
            this.guildsGrid.addGridElement(_local_2);
        }

        public function addGuildMember(_arg_1:GuildListItem):void{
            var _local_2:UIGridElement = new UIGridElement();
            _local_2.addChild(_arg_1);
            this.guildsGrid.addGridElement(_local_2);
        }

        public function addInvites(_arg_1:FriendListItem):void{
            var _local_2:UIGridElement = new UIGridElement();
            _local_2.addChild(_arg_1);
            this.friendsGrid.addGridElement(_local_2);
        }

        public function showInviteIndicator(_arg_1:Boolean, _arg_2:String):void{
            var _local_3:TabButton = this._tabs.getTabButtonByLabel(_arg_2);
            if (_local_3){
                _local_3.showIndicator = _arg_1;
            }
        }

        public function clearFriendsList():void{
            this.friendsGrid.clearGrid();
            this.showInviteIndicator(false, FRIEND_TAB_LABEL);
        }

        public function clearGuildList():void{
            this.guildsGrid.clearGrid();
            this.showInviteIndicator(false, GUILD_TAB_LABEL);
        }

        private function init():void{
            this.friendsGrid = new UIGrid(350, 1, 3);
            this.friendsGrid.x = 9;
            this.friendsGrid.y = 15;
            this.guildsGrid = new UIGrid(350, 1, 3);
            this.guildsGrid.x = 9;
            this.createContentInset();
            this.createContentTabs();
            this.addTabs();
        }

        private function addTabs():void{
            this._tabs = new UITabs(350, true);
            var _local_1:Sprite = new Sprite();
            this._tabs.addTab(this.createTab(FRIEND_TAB_LABEL, _local_1, this.friendsGrid, true), true);
            var _local_2:Sprite = new Sprite();
            this._tabs.addTab(this.createTab(GUILD_TAB_LABEL, _local_2, this.guildsGrid), false);
            this._tabs.y = 6;
            this._tabs.x = 0;
            addChild(this._tabs);
        }

        private function createContentTabs():void{
            var _local_1:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "tab_inset_content_background", 350);
            _local_1.height = 45;
            _local_1.x = 0;
            _local_1.y = 5;
            addChild(_local_1);
        }

        private function createContentInset():void{
            this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", 350);
            this.contentInset.height = 465;
            this.contentInset.x = 0;
            this.contentInset.y = 40;
            addChild(this.contentInset);
        }

        private function createSearchInputField(_arg_1:int):InputTextField{
            var _local_2:InputTextField = new InputTextField("Filter");
            DefaultLabelFormat.defaultSmallPopupTitle(_local_2);
            _local_2.width = _arg_1;
            return (_local_2);
        }

        private function createSearchIcon():Bitmap{
            var _local_1:BitmapData = TextureRedrawer.redraw(AssetLibrary.getImageFromSet("lofiInterfaceBig", 40), 20, true, 0);
            return (new Bitmap(_local_1));
        }

        private function createAddButton():SliceScalingButton{
            return (new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "add_button")));
        }

        private function createSearchInset(_arg_1:int):SliceScalingBitmap{
            var _local_2:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", _arg_1);
            _local_2.height = 30;
            return (_local_2);
        }

        private function createTab(_arg_1:String, _arg_2:Sprite, _arg_3:UIGrid, _arg_4:Boolean=false):UITab{
            var _local_8:Sprite;
            var _local_5:UITab = new UITab(_arg_1, true);
            this._tabContent = new Sprite();
            _arg_2.x = this.contentInset.x;
            this._tabContent.addChild(_arg_2);
            if (_arg_4){
                this.createSearchAndAdd();
            }
            _arg_2.y = ((_arg_4) ? 50 : 85);
            _arg_2.addChild(_arg_3);
            var _local_6:int = ((_arg_4) ? 410 : 375);
            var _local_7:UIScrollbar = new UIScrollbar(_local_6);
            _local_7.mouseRollSpeedFactor = 1;
            _local_7.scrollObject = _local_5;
            _local_7.content = _arg_2;
            _local_7.x = ((this.contentInset.x + this.contentInset.width) - 25);
            _local_7.y = _arg_2.y;
            this._tabContent.addChild(_local_7);
            _local_8 = new Sprite();
            _local_8.graphics.beginFill(0);
            _local_8.graphics.drawRect(0, 0, 350, (_local_6 - 5));
            _local_8.x = _arg_2.x;
            _local_8.y = _arg_2.y;
            _arg_2.mask = _local_8;
            this._tabContent.addChild(_local_8);
            _local_5.addContent(this._tabContent);
            return (_local_5);
        }

        private function createSearchAndAdd():void{
            var _local_2:Bitmap;
            this.addButton = this.createAddButton();
            this.addButton.x = 7;
            this.addButton.y = 6;
            this._tabContent.addChild(this.addButton);
            var _local_1:SliceScalingBitmap = this.createSearchInset(296);
            _local_1.x = (this.addButton.x + this.addButton.width);
            _local_1.y = 10;
            this._tabContent.addChild(_local_1);
            _local_2 = this.createSearchIcon();
            _local_2.x = _local_1.x;
            _local_2.y = 5;
            this._tabContent.addChild(_local_2);
            this.search = this.createSearchInputField(250);
            this.search.autoSize = TextFieldAutoSize.NONE;
            this.search.multiline = false;
            this.search.wordWrap = false;
            this.search.x = ((_local_2.x + _local_2.width) - 5);
            this.search.y = (_local_1.y + 7);
            this._tabContent.addChild(this.search);
        }

        public function get tabs():UITabs{
            return (this._tabs);
        }


    }
}//package io.decagames.rotmg.social

