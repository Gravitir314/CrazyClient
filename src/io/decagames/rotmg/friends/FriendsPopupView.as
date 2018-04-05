// Decompiled by AS3 Sorcerer 5.64
// www.as3sorcerer.com

//io.decagames.rotmg.friends.FriendsPopupView

package io.decagames.rotmg.friends{
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Rectangle;

import io.decagames.rotmg.friends.widgets.FriendListItem;
import io.decagames.rotmg.friends.widgets.GuildInfoItem;
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

public class FriendsPopupView extends ModalPopup {

        public var search:InputTextField;
        public var addButton:SliceScalingButton;
        private var searchInset:SliceScalingBitmap;
        private var contentTitle:UILabel;
        private var contentTabs:SliceScalingBitmap;
        private var contentInset:SliceScalingBitmap;
        private var friendsGrid:UIGrid;
        private var friendsElement:UIGridElement;
        private var guildsGrid:UIGrid;
        private var guildsElement:UIGridElement;
        private var invitesGrid:UIGrid;
        private var invitesElement:UIGridElement;
        private var totalFriendsLabel:UILabel;
        private var friendListPosition:int = 0;
        private var guildListPosition:int = 0;
        private var inviteListPosition:int = 0;
        private var friendsContainer:Sprite;
        private var guildContainer:Sprite;
        private var invitesContainer:Sprite;
        private var items:Vector.<DisplayObject>;
        private var tabs:UITabs;
        private var _hasInvitations:Boolean;

        public function FriendsPopupView(_arg_1:Boolean){
            super(350, 505, "Friends", DefaultLabelFormat.defaultSmallPopupTitle, new Rectangle(0, 0, 350, 565));
            this._hasInvitations = _arg_1;
            this.init();
        }

        public function totalFriends(_arg_1:int, _arg_2:int):void{
            if (!this.totalFriendsLabel){
                this.totalFriendsLabel = new UILabel();
                DefaultLabelFormat.totalFriendsLabel(this.totalFriendsLabel);
                this.totalFriendsLabel.y = 485;
                addChild(this.totalFriendsLabel);
            }
            this.totalFriendsLabel.text = ((("Total Friends: " + _arg_1) + " / ") + _arg_2);
            this.totalFriendsLabel.x = ((350 / 2) - (this.totalFriendsLabel.width / 2));
        }

        public function addFriendCategory(_arg_1:String):void{
            this.friendsElement = new UIGridElement();
            this.contentTitle = new UILabel();
            this.contentTitle.text = _arg_1;
            DefaultLabelFormat.defaultSmallPopupTitle(this.contentTitle);
            this.friendsElement.addChild(this.contentTitle);
            this.items.push(this.contentTitle);
            this.friendsGrid.addGridElement(this.friendsElement);
        }

        public function addFriend(_arg_1:FriendListItem):void{
            this.friendsElement = new UIGridElement();
            this.friendsElement.addChild(_arg_1);
            this.items.push(_arg_1);
            this.friendsGrid.addGridElement(this.friendsElement);
        }

        public function addGuildInfo(_arg_1:GuildInfoItem):void{
            this.guildsElement = new UIGridElement();
            this.guildsElement.addChild(_arg_1);
            this.guildsGrid.addGridElement(this.guildsElement);
        }

        public function addGuildCategory(_arg_1:String):void{
            this.guildsElement = new UIGridElement();
            this.contentTitle = new UILabel();
            this.contentTitle.text = _arg_1;
            DefaultLabelFormat.defaultSmallPopupTitle(this.contentTitle);
            this.guildsElement.addChild(this.contentTitle);
            this.guildsGrid.addGridElement(this.guildsElement);
        }

        public function addGuildMember(_arg_1:FriendListItem):void{
            this.guildsElement = new UIGridElement();
            this.guildsElement.addChild(_arg_1);
            this.guildsGrid.addGridElement(this.guildsElement);
        }

        public function addInviteCategory(_arg_1:String):void{
            this.invitesElement = new UIGridElement();
            this.contentTitle = new UILabel();
            this.contentTitle.text = _arg_1;
            DefaultLabelFormat.defaultSmallPopupTitle(this.contentTitle);
            this.invitesElement.addChild(this.contentTitle);
            this.items.push(this.contentTitle);
            this.invitesGrid.addGridElement(this.invitesElement);
        }

        public function addInvites(_arg_1:FriendListItem):void{
            this.invitesElement = new UIGridElement();
            this.invitesElement.addChild(_arg_1);
            this.items.push(_arg_1);
            this.invitesGrid.addGridElement(this.invitesElement);
            this.showInviteIndicator(true);
        }

        public function showInviteIndicator(_arg_1:Boolean):void{
            var _local_2:TabButton = this.tabs.getTabButtonByLabel("Invites");
            if (_local_2){
                this.tabs.getTabButtonByLabel("Invites").showIndicator = _arg_1;
            }
        }

        public function clear():void{
            var _local_1:DisplayObject;
            this.inviteListPosition = 0;
            this.guildListPosition = 0;
            this.friendListPosition = 0;
            this.showInviteIndicator(false);
            for each (_local_1 in this.items) {
                if (_local_1.parent){
                    _local_1.parent.removeChild(_local_1);
                }
            }
            this.items.length = 0;
            this.friendsGrid.clearGrid();
            this.guildsGrid.clearGrid();
            this.invitesGrid.clearGrid();
        }

        private function init():void{
            this.friendsGrid = new UIGrid(350, 1, 3);
            this.friendsGrid.x = 9;
            this.guildsGrid = new UIGrid(350, 1, 3);
            this.guildsGrid.x = 9;
            this.invitesGrid = new UIGrid(350, 1, 3);
            this.invitesGrid.x = 9;
            this.items = new Vector.<DisplayObject>();
            this.createAddButton();
            this.createSearchInset();
            this.createSearcgIcon();
            this.createSearchInputField();
            this.createContentInset();
            this.createContentTabs();
            this.addTabs();
        }

        private function addTabs():void{
            this.tabs = new UITabs(350);
            this.tabs.addTab(this.createFriendsTab(), (!(this._hasInvitations)));
            this.tabs.addTab(this.createInvitesTab(), this._hasInvitations);
            this.tabs.y = ((this.searchInset.height + this.searchInset.y) + 6);
            this.tabs.x = 0;
            addChild(this.tabs);
        }

        private function createContentTabs():void{
            this.contentTabs = TextureParser.instance.getSliceScalingBitmap("UI", "tab_inset_content_background", 350);
            this.contentTabs.height = 45;
            this.contentTabs.x = 0;
            this.contentTabs.y = ((this.searchInset.height + this.searchInset.y) + 5);
            addChild(this.contentTabs);
        }

        private function createContentInset():void{
            this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", 350);
            this.contentInset.height = 400;
            this.contentInset.x = 0;
            this.contentInset.y = ((this.searchInset.height + this.searchInset.y) + 40);
            addChild(this.contentInset);
        }

        private function createSearchInputField():void{
            this.search = new InputTextField("Search");
            DefaultLabelFormat.defaultSmallPopupTitle(this.search);
            this.search.width = 268;
            this.search.x = 30;
            this.search.y = (this.searchInset.y + 7);
            addChild(this.search);
        }

        private function createSearcgIcon():void{
            var _local_1:BitmapData = TextureRedrawer.redraw(AssetLibrary.getImageFromSet("lofiInterfaceBig", 40), 20, true, 0);
            var _local_2:Bitmap = new Bitmap(_local_1);
            _local_2.x = 0;
            _local_2.y = (this.searchInset.y - 5);
            addChild(_local_2);
        }

        private function createAddButton():void{
            this.addButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "add_button"));
            this.addButton.y = 1;
            this.addButton.x = (_contentWidth - this.addButton.width);
            addChild(this.addButton);
        }

        private function createSearchInset():void{
            this.searchInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", ((_contentWidth - this.addButton.width) - 5));
            this.searchInset.height = 30;
            this.searchInset.x = 0;
            this.searchInset.y = 5;
            addChild(this.searchInset);
        }

        private function createFriendsTab():UITab{
            var _local_2:Sprite;
            var _local_4:Sprite;
            var _local_1:UITab = new UITab("Friends");
            _local_2 = new Sprite();
            this.friendsContainer = new Sprite();
            this.friendsContainer.x = this.contentInset.x;
            this.friendsContainer.y = 9;
            this.friendsContainer.addChild(this.friendsGrid);
            _local_2.addChild(this.friendsContainer);
            var _local_3:UIScrollbar = new UIScrollbar(385);
            _local_3.mouseRollSpeedFactor = 1;
            _local_3.scrollObject = _local_1;
            _local_3.content = this.friendsContainer;
            _local_2.addChild(_local_3);
            _local_3.x = ((this.contentInset.x + this.contentInset.width) - 25);
            _local_3.y = 7;
            _local_4 = new Sprite();
            _local_4.graphics.beginFill(0);
            _local_4.graphics.drawRect(0, 0, 350, 385);
            _local_4.x = this.friendsContainer.x;
            _local_4.y = this.friendsContainer.y;
            this.friendsContainer.mask = _local_4;
            _local_2.addChild(_local_4);
            _local_1.addContent(_local_2);
            return (_local_1);
        }

        private function createGuildTab():UITab{
            var _local_1:UITab = new UITab("Guild");
            var _local_2:Sprite = new Sprite();
            this.guildContainer = new Sprite();
            this.guildContainer.x = this.contentInset.x;
            this.guildContainer.y = 9;
            this.guildContainer.addChild(this.guildsGrid);
            _local_2.addChild(this.guildContainer);
            var _local_3:UIScrollbar = new UIScrollbar(385);
            _local_3.mouseRollSpeedFactor = 1;
            _local_3.scrollObject = _local_1;
            _local_3.content = this.guildContainer;
            _local_2.addChild(_local_3);
            _local_3.x = ((this.contentInset.x + this.contentInset.width) - 25);
            _local_3.y = 7;
            var _local_4:Sprite = new Sprite();
            _local_4.graphics.beginFill(0);
            _local_4.graphics.drawRect(0, 0, 350, 385);
            _local_4.x = this.guildContainer.x;
            _local_4.y = this.guildContainer.y;
            this.guildContainer.mask = _local_4;
            _local_2.addChild(_local_4);
            _local_1.addContent(_local_2);
            return (_local_1);
        }

        private function createInvitesTab():UITab{
            var _local_1:UITab = new UITab("Invites");
            var _local_2:Sprite = new Sprite();
            this.invitesContainer = new Sprite();
            this.invitesContainer.x = this.contentInset.x;
            this.invitesContainer.y = 9;
            this.invitesContainer.addChild(this.invitesGrid);
            _local_2.addChild(this.invitesContainer);
            var _local_3:UIScrollbar = new UIScrollbar(385);
            _local_3.mouseRollSpeedFactor = 1;
            _local_3.scrollObject = _local_1;
            _local_3.content = this.invitesContainer;
            _local_2.addChild(_local_3);
            _local_3.x = ((this.contentInset.x + this.contentInset.width) - 25);
            _local_3.y = 7;
            var _local_4:Sprite = new Sprite();
            _local_4.graphics.beginFill(0);
            _local_4.graphics.drawRect(0, 0, 350, 385);
            _local_4.x = this.invitesContainer.x;
            _local_4.y = this.invitesContainer.y;
            this.invitesContainer.mask = _local_4;
            _local_2.addChild(_local_4);
            _local_1.addContent(_local_2);
            return (_local_1);
        }


    }
}//package io.decagames.rotmg.friends

