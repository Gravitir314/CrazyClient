// Decompiled by AS3 Sorcerer 5.64
// www.as3sorcerer.com

//io.decagames.rotmg.friends.widgets.FriendListItemMediator

package io.decagames.rotmg.friends.widgets{
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.parameters.Parameters;

import flash.events.MouseEvent;

import io.decagames.rotmg.friends.config.FriendsActions;
import io.decagames.rotmg.friends.model.FriendModel;
import io.decagames.rotmg.friends.model.FriendRequestVO;
import io.decagames.rotmg.friends.signals.FriendActionSignal;
import io.decagames.rotmg.friends.signals.RefreshFriendsListSignal;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.modal.ConfirmationModal;
import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;
import io.decagames.rotmg.ui.popups.signals.RemoveLockFade;
import io.decagames.rotmg.ui.popups.signals.ShowLockFade;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.chat.control.ShowChatInputSignal;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.game.model.GameInitData;
import kabam.rotmg.game.signals.PlayGameSignal;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.signals.EnterGameSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class FriendListItemMediator extends Mediator {

        [Inject]
        public var view:FriendListItem;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var showFade:ShowLockFade;
        [Inject]
        public var friendsAction:FriendActionSignal;
        [Inject]
        public var showPopup:ShowPopupSignal;
        [Inject]
        public var removeFade:RemoveLockFade;
        [Inject]
        public var model:FriendModel;
        [Inject]
        public var refreshSignal:RefreshFriendsListSignal;
        [Inject]
        public var chatSignal:ShowChatInputSignal;
        [Inject]
        public var closeCurrentPopup:CloseCurrentPopupSignal;
        [Inject]
        public var enterGame:EnterGameSignal;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var playGame:PlayGameSignal;


        override public function initialize():void{
            if (this.view.removeButton){
                this.view.removeButton.addEventListener(MouseEvent.CLICK, this.onRemoveClick);
            };
            if (this.view.acceptButton){
                this.view.acceptButton.addEventListener(MouseEvent.CLICK, this.onAcceptClick);
            };
            if (this.view.rejectButton){
                this.view.rejectButton.addEventListener(MouseEvent.CLICK, this.onRejectClick);
            };
            if (this.view.messageButton){
                this.view.messageButton.addEventListener(MouseEvent.CLICK, this.onMessageClick);
            };
            if (this.view.teleportButton){
                this.view.teleportButton.addEventListener(MouseEvent.CLICK, this.onTeleportClick);
            };
            if (this.view.blockButton){
                this.view.blockButton.addEventListener(MouseEvent.CLICK, this.onBlockClick);
            };
            this.model.dataSignal.add(this.onDataLoaded);
        }

        private function onMessageClick(_arg_1:MouseEvent):void{
            this.chatSignal.dispatch(true, (("/tell " + this.view.listLabel.text) + " "));
            this.closeCurrentPopup.dispatch();
        }

        override public function destroy():void{
            if (this.view.removeButton){
                this.view.removeButton.removeEventListener(MouseEvent.CLICK, this.onRemoveClick);
            };
            if (this.view.acceptButton){
                this.view.acceptButton.removeEventListener(MouseEvent.CLICK, this.onAcceptClick);
            };
            if (this.view.rejectButton){
                this.view.rejectButton.removeEventListener(MouseEvent.CLICK, this.onRejectClick);
            };
            if (this.view.messageButton){
                this.view.messageButton.removeEventListener(MouseEvent.CLICK, this.onMessageClick);
            };
            if (this.view.teleportButton){
                this.view.teleportButton.removeEventListener(MouseEvent.CLICK, this.onTeleportClick);
            };
            if (this.view.blockButton){
                this.view.blockButton.removeEventListener(MouseEvent.CLICK, this.onBlockClick);
            };
            this.model.dataSignal.remove(this.onDataLoaded);
        }

        private function onTeleportClick(_arg_1:MouseEvent):void{
            Parameters.data_.preferredServer = this.view.vo.getServerName();
            Parameters.save();
            this.enterGame.dispatch();
            var _local_2:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
            var _local_3:GameInitData = new GameInitData();
            _local_3.createCharacter = false;
            _local_3.charId = _local_2.charId();
            _local_3.isNewGame = true;
            this.playGame.dispatch(_local_3);
            this.closeCurrentPopup.dispatch();
        }

        private function onRemoveConfirmed(_arg_1:BaseButton):void{
            var _local_2:FriendRequestVO = new FriendRequestVO(FriendsActions.REMOVE, this.view.listLabel.text, this.onRemoveCallback);
            this.friendsAction.dispatch(_local_2);
            this.showFade.dispatch();
        }

        private function onBlockConfirmed(_arg_1:BaseButton):void{
            var _local_2:FriendRequestVO = new FriendRequestVO(FriendsActions.BLOCK, this.view.listLabel.text, this.onBlockCallback);
            this.friendsAction.dispatch(_local_2);
            this.showFade.dispatch();
        }

        private function onRemoveCallback(_arg_1:Boolean, _arg_2:Object, _arg_3:String):void{
            if (_arg_1){
                this.model.removeFriend(_arg_3);
            } else {
                this.showPopup.dispatch(new ErrorModal(350, "Friends List Error", LineBuilder.getLocalizedStringFromKey(String(_arg_2))));
            };
            this.removeFade.dispatch();
            this.refreshSignal.dispatch(_arg_1);
        }

        private function onBlockCallback(_arg_1:Boolean, _arg_2:Object, _arg_3:String):void{
            if (_arg_1){
                this.model.removeInvitation(_arg_3);
            } else {
                this.showPopup.dispatch(new ErrorModal(350, "Friends List Error", LineBuilder.getLocalizedStringFromKey(String(_arg_2))));
            };
            this.removeFade.dispatch();
            this.refreshSignal.dispatch(_arg_1);
        }

        private function onAcceptCallback(_arg_1:Boolean, _arg_2:Object, _arg_3:String):void{
            if (_arg_1){
                this.model.removeInvitation(_arg_3);
                if (!this.model.isDataStillLoading){
                    this.model.loadData();
                };
            } else {
                this.showPopup.dispatch(new ErrorModal(350, "Friends List Error", LineBuilder.getLocalizedStringFromKey(String(_arg_2))));
            };
            this.removeFade.dispatch();
            this.refreshSignal.dispatch(_arg_1);
        }

        private function onRejectCallback(_arg_1:Boolean, _arg_2:Object, _arg_3:String):void{
            if (_arg_1){
                this.model.removeInvitation(_arg_3);
            } else {
                this.showPopup.dispatch(new ErrorModal(350, "Friends List Error", LineBuilder.getLocalizedStringFromKey(String(_arg_2))));
            };
            this.removeFade.dispatch();
            this.refreshSignal.dispatch(_arg_1);
        }

        private function onDataLoaded(_arg_1:Boolean):void{
            this.removeFade.dispatch();
            this.refreshSignal.dispatch(_arg_1);
        }

        private function onRemoveClick(_arg_1:MouseEvent):void{
            var _local_2:ConfirmationModal = new ConfirmationModal(350, LineBuilder.getLocalizedStringFromKey(TextKey.FRIEND_REMOVE_TITLE), LineBuilder.getLocalizedStringFromKey(TextKey.FRIEND_REMOVE_TEXT, {"name":this.view.listLabel.text}), LineBuilder.getLocalizedStringFromKey(TextKey.FRIEND_REMOVE_BUTTON), LineBuilder.getLocalizedStringFromKey(TextKey.FRAME_CANCEL), 130);
            _local_2.confirmButton.clickSignal.addOnce(this.onRemoveConfirmed);
            this.showPopupSignal.dispatch(_local_2);
        }

        private function onAcceptClick(_arg_1:MouseEvent):void{
            var _local_2:FriendRequestVO = new FriendRequestVO(FriendsActions.ACCEPT, this.view.listLabel.text, this.onAcceptCallback);
            this.friendsAction.dispatch(_local_2);
            this.showFade.dispatch();
        }

        private function onRejectClick(_arg_1:MouseEvent):void{
            var _local_2:FriendRequestVO = new FriendRequestVO(FriendsActions.REJECT, this.view.listLabel.text, this.onRejectCallback);
            this.friendsAction.dispatch(_local_2);
            this.showFade.dispatch();
        }

        private function onBlockClick(_arg_1:MouseEvent):void{
            var _local_2:ConfirmationModal = new ConfirmationModal(350, LineBuilder.getLocalizedStringFromKey(TextKey.FRIEND_BLOCK_TITLE), LineBuilder.getLocalizedStringFromKey(TextKey.FRIEND_BLOCK_TEXT, {"name":this.view.listLabel.text}), LineBuilder.getLocalizedStringFromKey(TextKey.FRIEND_BLOCK_BUTTON), LineBuilder.getLocalizedStringFromKey(TextKey.FRAME_CANCEL), 130);
            _local_2.confirmButton.clickSignal.addOnce(this.onBlockConfirmed);
            this.showPopupSignal.dispatch(_local_2);
        }


    }
}//package io.decagames.rotmg.friends.widgets

