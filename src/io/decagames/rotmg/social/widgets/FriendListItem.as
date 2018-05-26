// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.social.widgets.FriendListItem

package io.decagames.rotmg.social.widgets{
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.icons.IconButton;
import com.company.assembleegameclient.util.TimeUtil;

import flash.events.Event;

import io.decagames.rotmg.social.data.SocialItemState;
import io.decagames.rotmg.social.model.FriendVO;

import kabam.rotmg.text.model.TextKey;

public class FriendListItem extends BaseListItem {

        public var teleportButton:IconButton;
        public var messageButton:IconButton;
        public var removeButton:IconButton;
        public var acceptButton:IconButton;
        public var rejectButton:IconButton;
        public var blockButton:IconButton;
        private var _vo:FriendVO;

        public function FriendListItem(_arg_1:FriendVO, _arg_2:int){
            super(_arg_2);
            this._vo = _arg_1;
            this.init();
        }

        override protected function init():void{
            super.init();
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
            this.setState();
            createListLabel(this._vo.getName());
            createListPortrait(this._vo.getPortrait());
        }

        private function onRemoved(_arg_1:Event):void{
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
            ((this.teleportButton) && (this.teleportButton.destroy()));
            ((this.messageButton) && (this.messageButton.destroy()));
            ((this.removeButton) && (this.removeButton.destroy()));
            ((this.acceptButton) && (this.acceptButton.destroy()));
            ((this.rejectButton) && (this.rejectButton.destroy()));
            ((this.blockButton) && (this.blockButton.destroy()));
        }

        private function setState():void{
            var _local_1:String;
            var _local_2:String;
            var _local_3:String;
            switch (_state){
                case SocialItemState.ONLINE:
                    _local_1 = this._vo.getServerName();
                    _local_2 = ((Parameters.data_.preferredServer) ? Parameters.data_.preferredServer : Parameters.data_.bestServer);
                    if (_local_2 != _local_1){
                        _local_3 = ((("Your friend is playing on server: " + _local_1) + ". ") + "Clicking this will take you to this server.");
                        this.teleportButton = addButton("lofiInterface2", 3, 230, 12, TextKey.FRIEND_TELEPORT_TITLE, _local_3);
                    }
                    this.messageButton = addButton("lofiInterfaceBig", 21, 0xFF, 12, TextKey.PLAYERMENU_PM);
                    this.removeButton = addButton("lofiInterfaceBig", 12, 280, 12, TextKey.FRIEND_REMOVE_BUTTON);
                    return;
                case SocialItemState.OFFLINE:
                    hoverTooltipDelegate.setDisplayObject(_characterContainer);
                    setToolTipTitle("Last Seen:");
                    setToolTipText((TimeUtil.humanReadableTime(this._vo.lastLogin) + " ago!"));
                    this.removeButton = addButton("lofiInterfaceBig", 12, 280, 12, TextKey.FRIEND_REMOVE_BUTTON, TextKey.FRIEND_REMOVE_BUTTON_DESC);
                    return;
                case SocialItemState.INVITE:
                    this.acceptButton = addButton("lofiInterfaceBig", 11, 230, 12, TextKey.GUILD_ACCEPT);
                    this.rejectButton = addButton("lofiInterfaceBig", 12, 0xFF, 12, TextKey.GUILD_REJECTION);
                    this.blockButton = addButton("lofiInterfaceBig", 8, 280, 12, TextKey.FRIEND_BLOCK_BUTTON, TextKey.FRIEND_BLOCK_BUTTON_DESC);
                    return;
            }
        }

        public function get vo():FriendVO{
            return (this._vo);
        }


    }
}//package io.decagames.rotmg.social.widgets

