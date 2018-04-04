// Decompiled by AS3 Sorcerer 5.64
// www.as3sorcerer.com

//io.decagames.rotmg.friends.FriendsPopupMediator

package io.decagames.rotmg.friends{
import com.company.assembleegameclient.ui.tooltip.TextToolTip;

import flash.events.KeyboardEvent;

import io.decagames.rotmg.friends.config.FriendsConfig;
import io.decagames.rotmg.friends.data.FriendItemState;
import io.decagames.rotmg.friends.model.FriendModel;
import io.decagames.rotmg.friends.model.FriendVO;
import io.decagames.rotmg.friends.popups.InviteFriendPopup;
import io.decagames.rotmg.friends.signals.RefreshFriendsListSignal;
import io.decagames.rotmg.friends.widgets.FriendListItem;
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

public class FriendsPopupMediator extends Mediator {

        [Inject]
        public var view:FriendsPopupView;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        private var closeButton:SliceScalingButton;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var model:FriendModel;
        [Inject]
        public var refreshSignal:RefreshFriendsListSignal;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        private var addFriendToolTip:TextToolTip;
        private var hoverTooltipDelegate:HoverTooltipDelegate;


        override public function initialize():void{
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.model.loadData();
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.view.addButton.clickSignal.add(this.addButtonHandler);
            this.createAddButtonTooltip();
            this.model.dataSignal.add(this.refreshListHandler);
            this.refreshSignal.add(this.refreshListHandler);
            this.view.search.addEventListener(KeyboardEvent.KEY_UP, this.onSearchHandler);
            this.showContent();
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

        private function refreshListHandler(_arg_1:Boolean):void{
            this.view.search.reset();
            this.showContent();
        }

        private function onSearchHandler(_arg_1:KeyboardEvent):void{
            this.view.clear();
            this.showFriends(this.view.search.text);
            this.showInvites();
        }

        override public function destroy():void{
            this.closeButton.dispose();
            this.refreshSignal.remove(this.refreshListHandler);
            this.model.dataSignal.remove(this.refreshListHandler);
            this.view.addButton.clickSignal.remove(this.addButtonHandler);
            this.view.search.removeEventListener(KeyboardEvent.KEY_UP, this.onSearchHandler);
            this.addFriendToolTip = null;
            this.hoverTooltipDelegate.removeDisplayObject();
            this.hoverTooltipDelegate = null;
        }

        private function onClose(_arg_1:BaseButton):void{
            this.closePopupSignal.dispatch(this.view);
        }

        private function showFriends(filter:String=""):void{
            var onlineFriend:FriendVO;
            var offlineFriend:FriendVO;
            var allFriends:Vector.<FriendVO> = ((filter == "") ? this.model.getAllFriends() : this.model.getFilterFriends(filter));
            this.view.totalFriends(((this.model.isDataStillLoading) ? 0 : allFriends.length), FriendsConfig.MAX_FRIENDS);
            var onlineFilter:Function = function (_arg_1:FriendVO, _arg_2:int, _arg_3:Vector.<FriendVO>):Boolean{
                return (_arg_1.isOnline);
            };
            var offlineFilter:Function = function (_arg_1:FriendVO, _arg_2:int, _arg_3:Vector.<FriendVO>):Boolean{
                return (!(_arg_1.isOnline));
            };
            var onlineFriends:Vector.<FriendVO> = allFriends.filter(onlineFilter);
            var offlineFriends:Vector.<FriendVO> = allFriends.filter(offlineFilter);
            this.view.addFriendCategory(((this.model.isDataStillLoading) ? "Loading..." : "Online"));
            if (!this.model.isDataStillLoading){
                for each (onlineFriend in onlineFriends) {
                    this.view.addFriend(new FriendListItem(onlineFriend, FriendItemState.ONLINE));
                };
            };
            this.view.addFriendCategory(((this.model.isDataStillLoading) ? "Loading..." : "Offline"));
            if (!this.model.isDataStillLoading){
                for each (offlineFriend in offlineFriends) {
                    this.view.addFriend(new FriendListItem(offlineFriend, FriendItemState.OFFLINE));
                };
            };
        }

        private function showGuild():void{
        }

        private function showInvites():void{
            var _local_2:FriendVO;
            this.view.addInviteCategory(((this.model.isDataStillLoading) ? "Loading..." : "Invitations"));
            var _local_1:Vector.<FriendVO> = this.model.getAllInvitations();
            if (!this.model.isDataStillLoading){
                for each (_local_2 in _local_1) {
                    this.view.addInvites(new FriendListItem(_local_2, FriendItemState.INVITE));
                };
            };
        }

        private function showContent():void{
            this.view.clear();
            this.showFriends();
            this.showInvites();
        }


    }
}//package io.decagames.rotmg.friends

