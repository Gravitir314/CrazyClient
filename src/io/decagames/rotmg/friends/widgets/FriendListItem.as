// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.friends.widgets.FriendListItem

package io.decagames.rotmg.friends.widgets{
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.icons.IconButton;
import com.company.assembleegameclient.ui.icons.IconButtonFactory;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.Sprite;

import io.decagames.rotmg.friends.data.FriendItemState;
import io.decagames.rotmg.friends.model.FriendVO;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.ui.model.HUDModel;

public class FriendListItem extends Sprite {

        private const ONLINE_COLOR:uint = 3407650;
        private const OFFLINE_COLOR:uint = 0xB3B3B3;

        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var player:PlayerModel;
        public var teleportButton:IconButton;
        public var messageButton:IconButton;
        public var removeButton:IconButton;
        public var acceptButton:IconButton;
        public var rejectButton:IconButton;
        public var blockButton:IconButton;
        public var listLabel:UILabel;
        private var guildRank:IconButton;
        private var rankControl:IconButton;
        private var _state:Number;
        private var _isInGuild:Boolean;
        private var listPortrait:Bitmap;
        private var listBackground:SliceScalingBitmap;
        private var isLocked:Boolean;
        private var _vo:FriendVO;
        private var _iconButtonFactory:IconButtonFactory;

        public function FriendListItem(_arg_1:FriendVO, _arg_2:int){
            this._vo = _arg_1;
            this._state = _arg_2;
            this.init();
        }

        private function init():void{
            this._iconButtonFactory = StaticInjectorContext.getInjector().getInstance(IconButtonFactory);
            this.setState();
            this.createListLabel();
            this.createListPortrait();
        }

        private function createListLabel():void{
            this.listLabel = new UILabel();
            this.listLabel.x = 40;
            this.listLabel.y = 12;
            this.listLabel.text = this._vo.getName();
            this.setLabelColorByState();
            addChild(this.listLabel);
        }

        private function setLabelColorByState():void{
            if (this.isLocked){
                DefaultLabelFormat.defaultSmallPopupTitle(this.listLabel);
                return;
            }
            switch (this._state){
                case FriendItemState.ONLINE:
                    DefaultLabelFormat.friendsItemLabel(this.listLabel, this.ONLINE_COLOR);
                    return;
                case FriendItemState.OFFLINE:
                    DefaultLabelFormat.friendsItemLabel(this.listLabel, this.OFFLINE_COLOR);
                    return;
                default:
                    DefaultLabelFormat.defaultSmallPopupTitle(this.listLabel);
            }
        }

        private function createListPortrait():void{
            this.listPortrait = new Bitmap(this._vo.getPortrait());
            this.listPortrait.x = (-(Math.round((this.listPortrait.width / 2))) + 22);
            this.listPortrait.y = (-(Math.round((this.listPortrait.height / 2))) + 20);
            if (this.listPortrait){
                addChild(this.listPortrait);
            }
        }

        private function setState():void{
            var _local_1:String;
            var _local_2:String;
            var _local_3:String;
            switch (this._state){
                case FriendItemState.ONLINE:
                    this.listBackground = TextureParser.instance.getSliceScalingBitmap("UI", "listitem_content_background");
                    addChild(this.listBackground);
                    _local_1 = this._vo.getServerName();
                    _local_2 = ((Parameters.data_.preferredServer) ? Parameters.data_.preferredServer : Parameters.data_.bestServer);
                    if (_local_2 != _local_1){
                        _local_3 = (("Your friend is playing on server: " + _local_1) + ". Clicking this will take you to this server.");
                        this.teleportButton = this.addButton("lofiInterface2", 3, 230, 12, TextKey.FRIEND_TELEPORT_TITLE, _local_3);
                    }
                    this.messageButton = this.addButton("lofiInterfaceBig", 21, 0xFF, 12, TextKey.PLAYERMENU_PM);
                    this.removeButton = this.addButton("lofiInterfaceBig", 12, 280, 12, TextKey.FRIEND_REMOVE_BUTTON);
                    break;
                case FriendItemState.OFFLINE:
                    this.listBackground = TextureParser.instance.getSliceScalingBitmap("UI", "listitem_content_background_inactive");
                    addChild(this.listBackground);
                    this.removeButton = this.addButton("lofiInterfaceBig", 12, 280, 12, TextKey.FRIEND_REMOVE_BUTTON, TextKey.FRIEND_REMOVE_BUTTON_DESC);
                    break;
                case FriendItemState.INVITE:
                    this.listBackground = TextureParser.instance.getSliceScalingBitmap("UI", "listitem_content_background_selected");
                    addChild(this.listBackground);
                    this.acceptButton = this.addButton("lofiInterfaceBig", 11, 230, 12, TextKey.GUILD_ACCEPT);
                    this.rejectButton = this.addButton("lofiInterfaceBig", 12, 0xFF, 12, TextKey.GUILD_REJECTION);
                    this.blockButton = this.addButton("lofiInterfaceBig", 8, 280, 12, TextKey.FRIEND_BLOCK_BUTTON, TextKey.FRIEND_BLOCK_BUTTON_DESC);
                    break;
            }
            this.listBackground.height = 40;
            this.listBackground.width = 310;
        }

        private function addButton(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:String=""):IconButton{
            var _local_7:IconButton;
            _local_7 = this._iconButtonFactory.create(AssetLibrary.getImageFromSet(_arg_1, _arg_2), "", "", "");
            _local_7.setToolTipTitle(_arg_5);
            _local_7.setToolTipText(_arg_6);
            _local_7.x = _arg_3;
            _local_7.y = _arg_4;
            addChild(_local_7);
            return (_local_7);
        }

        public function get vo():FriendVO{
            return (this._vo);
        }


    }
}//package io.decagames.rotmg.friends.widgets

