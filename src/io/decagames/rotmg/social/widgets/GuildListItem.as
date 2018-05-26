// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.social.widgets.GuildListItem

package io.decagames.rotmg.social.widgets{
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.icons.IconButton;
import com.company.assembleegameclient.util.GuildUtil;
import com.company.assembleegameclient.util.TimeUtil;

import flash.events.Event;

import io.decagames.rotmg.social.model.GuildMemberVO;

import kabam.rotmg.text.model.TextKey;

public class GuildListItem extends BaseListItem {

        public var promoteButton:IconButton;
        public var demoteButton:IconButton;
        public var guildRank:IconButton;
        public var teleportButton:IconButton;
        public var messageButton:IconButton;
        public var removeButton:IconButton;
        private var _guildMemberVO:GuildMemberVO;
        private var _guildMemberRank:int;
        private var _myRank:int;
        private var _isMe:Boolean;
        private var _isOnline:Boolean;

        public function GuildListItem(_arg_1:GuildMemberVO, _arg_2:int, _arg_3:int){
            super(_arg_2);
            this._guildMemberVO = _arg_1;
            this._myRank = _arg_3;
            this._isMe = this._guildMemberVO.isMe;
            this._isOnline = this._guildMemberVO.isOnline;
            this.init();
        }

        override protected function init():void{
            super.init();
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
            this._guildMemberRank = this._guildMemberVO.rank;
            if (!this._isOnline){
                hoverTooltipDelegate.setDisplayObject(_characterContainer);
                setToolTipTitle("Last Seen:");
                setToolTipText((TimeUtil.humanReadableTime(this._guildMemberVO.lastLogin) + " ago!"));
            }
            this.createButtons();
            createListLabel(this._guildMemberVO.name);
            createListPortrait(this._guildMemberVO.player.getPortrait());
        }

        private function onRemoved(_arg_1:Event):void{
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
            ((this.teleportButton) && (this.teleportButton.destroy()));
            ((this.messageButton) && (this.messageButton.destroy()));
            ((this.removeButton) && (this.removeButton.destroy()));
            ((this.promoteButton) && (this.promoteButton.destroy()));
            ((this.demoteButton) && (this.demoteButton.destroy()));
            ((this.guildRank) && (this.guildRank.destroy()));
        }

        private function createButtons():void{
            var _local_3:String;
            var _local_4:String;
            var _local_5:String;
            var _local_1:int = ((this._isMe) ? 0xFF : 205);
            this.guildRank = addButton("lofiInterfaceBig", GuildUtil.getRankIconIdByRank(this._guildMemberRank), _local_1, 12, GuildUtil.rankToString(this._guildMemberRank));
            if (!this._isMe){
                this.promoteButton = addButton("lofiInterface", 54, 155, 12, "Promote");
                this.promoteButton.enabled = GuildUtil.canPromote(this._myRank, this._guildMemberRank);
                this.demoteButton = addButton("lofiInterface", 55, 180, 12, "Demote");
                this.demoteButton.enabled = GuildUtil.canDemote(this._myRank, this._guildMemberRank);
                _local_3 = this._guildMemberVO.serverName;
                _local_4 = ((Parameters.data_.preferredServer) ? Parameters.data_.preferredServer : Parameters.data_.bestServer);
                _local_5 = ((("Your friend is playing on server: " + _local_3) + ". ") + "Clicking this will take you to this server.");
                this.teleportButton = addButton("lofiInterface2", 3, 230, 12, TextKey.FRIEND_TELEPORT_TITLE, _local_5);
                this.teleportButton.enabled = ((this._isOnline) && (!(_local_4 == _local_3)));
                this.messageButton = addButton("lofiInterfaceBig", 21, 0xFF, 12, TextKey.PLAYERMENU_PM);
                this.messageButton.enabled = this._isOnline;
            }
            var _local_2:String = ((this._isMe) ? "Leave Guild" : "Remove member");
            this.removeButton = addButton("lofiInterfaceBig", 12, 280, 12, _local_2);
            if (!this._isMe){
                this.removeButton.enabled = GuildUtil.canRemove(this._myRank, this._guildMemberRank);
            }
        }

        public function get guildMemberVO():GuildMemberVO{
            return (this._guildMemberVO);
        }


    }
}//package io.decagames.rotmg.social.widgets

