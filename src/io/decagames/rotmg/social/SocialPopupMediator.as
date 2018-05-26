// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.social.SocialPopupMediator

package io.decagames.rotmg.social{
import com.company.assembleegameclient.ui.tooltip.TextToolTip;

import flash.events.KeyboardEvent;

import io.decagames.rotmg.social.config.SocialConfig;
import io.decagames.rotmg.social.data.SocialItemState;
import io.decagames.rotmg.social.model.FriendVO;
import io.decagames.rotmg.social.model.GuildMemberVO;
import io.decagames.rotmg.social.model.GuildVO;
import io.decagames.rotmg.social.model.SocialModel;
import io.decagames.rotmg.social.popups.InviteFriendPopup;
import io.decagames.rotmg.social.signals.RefreshListSignal;
import io.decagames.rotmg.social.signals.SocialDataSignal;
import io.decagames.rotmg.social.widgets.FriendListItem;
import io.decagames.rotmg.social.widgets.GuildInfoItem;
import io.decagames.rotmg.social.widgets.GuildListItem;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.popups.header.PopupHeader;
import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class SocialPopupMediator extends Mediator {

        [Inject]
        public var view:SocialPopupView;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var socialModel:SocialModel;
        [Inject]
        public var refreshSignal:RefreshListSignal;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        private var _isFriendsListLoaded:Boolean;
        private var _isGuildListLoaded:Boolean;
        private var closeButton:SliceScalingButton;
        private var addFriendToolTip:TextToolTip;
        private var hoverTooltipDelegate:HoverTooltipDelegate;


        override public function initialize():void{
            this.socialModel.socialDataSignal.add(this.onDataLoaded);
            this.view.tabs.tabSelectedSignal.add(this.onTabSelected);
            this.refreshSignal.add(this.refreshListHandler);
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.view.addButton.clickSignal.add(this.addButtonHandler);
            this.createAddButtonTooltip();
            this.view.search.addEventListener(KeyboardEvent.KEY_UP, this.onSearchHandler);
        }

        private function onTabSelected(_arg_1:String):void{
            if (_arg_1 == SocialPopupView.FRIEND_TAB_LABEL){
                if (!this._isFriendsListLoaded){
                    this.socialModel.loadFriendsData();
                }
            } else {
                if (_arg_1 == SocialPopupView.GUILD_TAB_LABEL){
                    if (!this._isGuildListLoaded){
                        this.socialModel.loadGuildData();
                    }
                }
            }
        }

        private function onDataLoaded(_arg_1:String, _arg_2:Boolean, _arg_3:String):void{
            switch (_arg_1){
                case SocialDataSignal.FRIENDS_DATA_LOADED:
                    this.view.clearFriendsList();
                    if (_arg_2){
                        this.showFriends();
                        this._isFriendsListLoaded = true;
                    } else {
                        this._isFriendsListLoaded = false;
                        this.showError(_arg_1, _arg_3);
                    }
                    return;
                case SocialDataSignal.GUILD_DATA_LOADED:
                    this.view.clearGuildList();
                    this.showGuild();
                    this._isGuildListLoaded = true;
                    return;
            }
        }

        private function createAddButtonTooltip():void{
            this.addFriendToolTip = new TextToolTip(0x363636, 0x9B9B9B, "Add a friend", "Click to add a friend", 200);
            this.hoverTooltipDelegate = new HoverTooltipDelegate();
            this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
            this.hoverTooltipDelegate.setDisplayObject(this.view.addButton);
            this.hoverTooltipDelegate.tooltip = this.addFriendToolTip;
        }

        private function addButtonHandler(_arg_1:BaseButton):void{
            this.showPopupSignal.dispatch(new InviteFriendPopup());
        }

        private function refreshListHandler(_arg_1:String, _arg_2:Boolean):void{
            if (_arg_1 == RefreshListSignal.CONTEXT_FRIENDS_LIST){
                this.view.search.reset();
                this.view.clearFriendsList();
                this.showFriends();
            } else {
                if (_arg_1 == RefreshListSignal.CONTEXT_GUILD_LIST){
                    this.view.clearGuildList();
                    this.showGuild();
                }
            }
        }

        private function onSearchHandler(_arg_1:KeyboardEvent):void{
            this.view.clearFriendsList();
            this.showFriends(this.view.search.text);
        }

        override public function destroy():void{
            this.closeButton.dispose();
            this.refreshSignal.remove(this.refreshListHandler);
            this.view.addButton.clickSignal.remove(this.addButtonHandler);
            this.view.search.removeEventListener(KeyboardEvent.KEY_UP, this.onSearchHandler);
            this.addFriendToolTip = null;
            this.hoverTooltipDelegate.removeDisplayObject();
            this.hoverTooltipDelegate = null;
        }

        private function onClose(_arg_1:BaseButton):void{
            this.closePopupSignal.dispatch(this.view);
        }

        private function showFriends(_arg_1:String=""):void{
            var _local_3:Vector.<FriendVO>;
            var _local_4:FriendVO;
            var _local_5:Vector.<FriendVO>;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_2:* = (!(_arg_1 == ""));
            if (this.socialModel.hasInvitations){
                _local_5 = this.socialModel.getAllInvitations();
                this.view.addFriendCategory((("Invitations (" + _local_5.length) + ")"));
                _local_6 = ((_local_5.length > SocialPopupView.MAX_VISIBLE_INVITATIONS) ? SocialPopupView.MAX_VISIBLE_INVITATIONS : _local_5.length);
                _local_7 = 0;
                while (_local_7 < _local_6) {
                    this.view.addInvites(new FriendListItem(_local_5[_local_7], SocialItemState.INVITE));
                    _local_7++;
                }
                this.view.showInviteIndicator(true, SocialPopupView.FRIEND_TAB_LABEL);
            } else {
                this.view.showInviteIndicator(false, SocialPopupView.FRIEND_TAB_LABEL);
            }
            _local_3 = ((_local_2) ? this.socialModel.getFilterFriends(_arg_1) : this.socialModel.friendsList);
            this.view.addFriendCategory((((("Friends (" + this.socialModel.numberOfFriends) + "/") + SocialConfig.MAX_FRIENDS) + ")"));
            for each (_local_4 in _local_3) {
                _local_8 = ((_local_4.isOnline) ? SocialItemState.ONLINE : SocialItemState.OFFLINE);
                this.view.addFriend(new FriendListItem(_local_4, _local_8));
            }
            this.view.addFriendCategory("");
        }

        private function showError(_arg_1:String, _arg_2:String):void{
            switch (_arg_1){
                case SocialDataSignal.FRIENDS_DATA_LOADED:
                    this.view.addFriendCategory(("Error: " + _arg_2));
                    return;
                case SocialDataSignal.FRIEND_INVITATIONS_LOADED:
                    this.view.addFriendCategory(("Invitation Error: " + _arg_2));
                    return;
            }
        }

        private function showGuild():void{
            var _local_4:Vector.<GuildMemberVO>;
            var _local_5:int;
            var _local_6:int;
            var _local_7:GuildMemberVO;
            var _local_8:int;
            var _local_1:GuildVO = this.socialModel.guildVO;
            var _local_2:String = ((_local_1) ? _local_1.guildName : "No Guild");
            var _local_3:int = ((_local_1) ? _local_1.guildTotalFame : 0);
            this.view.addGuildInfo(new GuildInfoItem(_local_2, _local_3));
            if (((_local_1) && (this.socialModel.numberOfGuildMembers > 0))){
                this.view.addGuildCategory((((("Guild Members (" + this.socialModel.numberOfGuildMembers) + "/") + 50) + ")"));
                _local_4 = _local_1.guildMembers;
                _local_5 = _local_4.length;
                _local_6 = 0;
                while (_local_6 < _local_5) {
                    _local_7 = _local_4[_local_6];
                    _local_8 = ((_local_7.isOnline) ? SocialItemState.ONLINE : SocialItemState.OFFLINE);
                    this.view.addGuildMember(new GuildListItem(_local_7, _local_8, _local_1.myRank));
                    _local_6++;
                }
                this.view.addGuildCategory("");
            } else {
                this.view.addGuildDefaultMessage(SocialPopupView.DEFAULT_NO_GUILD_MESSAGE);
            }
        }


    }
}//package io.decagames.rotmg.social

