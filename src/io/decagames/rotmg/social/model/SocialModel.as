
//io.decagames.rotmg.social.model.SocialModel

package io.decagames.rotmg.social.model{
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.FameUtil;
import com.company.assembleegameclient.util.TimeUtil;

import flash.utils.Dictionary;

import io.decagames.rotmg.social.config.FriendsActions;
import io.decagames.rotmg.social.config.GuildActions;
import io.decagames.rotmg.social.config.SocialConfig;
import io.decagames.rotmg.social.signals.SocialDataSignal;
import io.decagames.rotmg.social.tasks.FriendDataRequestTask;
import io.decagames.rotmg.social.tasks.GuildDataRequestTask;
import io.decagames.rotmg.social.tasks.ISocialTask;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.servers.api.Server;
import kabam.rotmg.servers.api.ServerModel;
import kabam.rotmg.ui.model.HUDModel;

import org.osflash.signals.Signal;

public class SocialModel {

        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var serverModel:ServerModel;
        [Inject]
        public var friendsDataRequest:FriendDataRequestTask;
        [Inject]
        public var guildDataRequest:GuildDataRequestTask;
        public var socialDataSignal:SocialDataSignal = new SocialDataSignal();
        public var noInvitationSignal:Signal = new Signal();
        private var _friendsList:Vector.<FriendVO>;
        private var _onlineFriends:Vector.<FriendVO>;
        private var _offlineFriends:Vector.<FriendVO>;
        private var _onlineFilteredFriends:Vector.<FriendVO>;
        private var _offlineFilteredFriends:Vector.<FriendVO>;
        private var _onlineGuildMembers:Vector.<GuildMemberVO>;
        private var _offlineGuildMembers:Vector.<GuildMemberVO>;
        private var _guildMembers:Vector.<GuildMemberVO>;
        private var _friends:Dictionary;
        private var _invitations:Dictionary;
        private var _friendsLoadInProcess:Boolean;
        private var _invitationsLoadInProgress:Boolean;
        private var _guildLoadInProgress:Boolean;
        private var _numberOfFriends:int;
        private var _numberOfGuildMembers:int;
        private var _numberOfInvitation:int;
        private var _isFriDataOK:Boolean;
        private var _serverDict:Dictionary;
        private var _currentServer:Server;
        private var _guildVO:GuildVO;

        public function SocialModel(){
            this._initSocialModel();
        }

        public function setCurrentServer(_arg_1:Server):void{
            this._currentServer = _arg_1;
        }

        public function getCurrentServerName():String{
            return ((this._currentServer) ? this._currentServer.name : "");
        }

        public function loadFriendsData():void{
            if (((this._friendsLoadInProcess) || (this._invitationsLoadInProgress))){
                return;
            }
            this._friendsLoadInProcess = true;
            this._invitationsLoadInProgress = true;
            this.loadList(this.friendsDataRequest, FriendsActions.getURL(FriendsActions.FRIEND_LIST), this.onFriendListResponse);
        }

        public function loadInvitations():void{
            if (((this._friendsLoadInProcess) || (this._invitationsLoadInProgress))){
                return;
            }
            this._invitationsLoadInProgress = true;
            this.loadList(this.friendsDataRequest, FriendsActions.getURL(FriendsActions.INVITE_LIST), this.onInvitationListResponse);
        }

        public function loadGuildData():void{
            if (this._guildLoadInProgress){
                return;
            }
            this._guildLoadInProgress = true;
            this.loadList(this.guildDataRequest, GuildActions.getURL(GuildActions.GUILD_LIST), this.onGuildListResponse);
        }

        public function seedFriends(_arg_1:XML):void{
            var _local_2:String;
            var _local_3:String;
            var _local_4:String;
            var _local_5:FriendVO;
            var _local_6:XML;
            this._onlineFriends.length = 0;
            this._offlineFriends.length = 0;
            for each (_local_6 in _arg_1.Account) {
                _local_2 = _local_6.Name;
                _local_5 = ((this._friends[_local_2] != null) ? (this._friends[_local_2].vo as FriendVO) : new FriendVO(Player.fromPlayerXML(_local_2, _local_6.Character[0])));
                if (_local_6.hasOwnProperty("Online")){
                    _local_4 = String(_local_6.Online);
                    _local_3 = this.serverNameDictionary()[_local_4];
                    _local_5.online(_local_3, _local_4);
                    this._onlineFriends.push(_local_5);
                    this._friends[_local_5.getName()] = {
                        "vo":_local_5,
                        "list":this._onlineFriends
                    };
                } else {
                    _local_5.offline();
                    _local_5.lastLogin = this.getLastLoginInSeconds(_local_6.LastLogin);
                    this._offlineFriends.push(_local_5);
                    this._friends[_local_5.getName()] = {
                        "vo":_local_5,
                        "list":this._offlineFriends
                    };
                }
            }
            this._onlineFriends.sort(this.sortFriend);
            this._offlineFriends.sort(this.sortFriend);
            this.updateFriendsList();
        }

        public function isMyFriend(_arg_1:String):Boolean{
            return (!(this._friends[_arg_1] == null));
        }

        public function updateFriendVO(_arg_1:String, _arg_2:Player):void{
            var _local_3:Object;
            var _local_4:FriendVO;
            if (this.isMyFriend(_arg_1)){
                _local_3 = this._friends[_arg_1];
                _local_4 = (_local_3.vo as FriendVO);
                _local_4.updatePlayer(_arg_2);
            }
        }

        public function getFilterFriends(_arg_1:String):Vector.<FriendVO>{
            var _local_3:FriendVO;
            var _local_2:RegExp = new RegExp(_arg_1, "gix");
            this._onlineFilteredFriends.length = 0;
            this._offlineFilteredFriends.length = 0;
            var _local_4:int;
            while (_local_4 < this._onlineFriends.length) {
                _local_3 = this._onlineFriends[_local_4];
                if (_local_3.getName().search(_local_2) >= 0){
                    this._onlineFilteredFriends.push(_local_3);
                }
                _local_4++;
            }
            _local_4 = 0;
            while (_local_4 < this._offlineFriends.length) {
                _local_3 = this._offlineFriends[_local_4];
                if (_local_3.getName().search(_local_2) >= 0){
                    this._offlineFilteredFriends.push(_local_3);
                }
                _local_4++;
            }
            this._onlineFilteredFriends.sort(this.sortFriend);
            this._offlineFilteredFriends.sort(this.sortFriend);
            return (this._onlineFilteredFriends.concat(this._offlineFilteredFriends));
        }

        public function ifReachMax():Boolean{
            return (this._numberOfFriends >= SocialConfig.MAX_FRIENDS);
        }

        public function getAllInvitations():Vector.<FriendVO>{
            var _local_2:FriendVO;
            var _local_1:Vector.<FriendVO> = new Vector.<FriendVO>();
            for each (_local_2 in this._invitations) {
                _local_1.push(_local_2);
            }
            _local_1.sort(this.sortFriend);
            return (_local_1);
        }

        public function removeFriend(_arg_1:String):Boolean{
            var _local_2:Object = this._friends[_arg_1];
            if (_local_2){
                this.removeFriendFromList(_arg_1);
                this.removeFromList(_local_2.list, _arg_1);
                this._friends[_arg_1] = null;
                delete this._friends[_arg_1];
                return (true);
            }
            return (false);
        }

        public function removeInvitation(_arg_1:String):Boolean{
            if (this._invitations[_arg_1] != null){
                this._invitations[_arg_1] = null;
                delete this._invitations[_arg_1];
                this._numberOfInvitation--;
                if (this._numberOfInvitation == 0){
                    this.noInvitationSignal.dispatch();
                }
                return (true);
            }
            return (false);
        }

        public function removeGuildMember(_arg_1:String):void{
            var _local_2:GuildMemberVO;
            for each (_local_2 in this._onlineGuildMembers) {
                if (_local_2.name == _arg_1){
                    this._onlineGuildMembers.splice(this._onlineGuildMembers.indexOf(_local_2), 1);
                    break;
                }
            }
            for each (_local_2 in this._offlineGuildMembers) {
                if (_local_2.name == _arg_1){
                    this._offlineGuildMembers.splice(this._offlineGuildMembers.indexOf(_local_2), 1);
                    break;
                }
            }
            this.updateGuildData();
        }

        private function _initSocialModel():void{
            this._numberOfFriends = 0;
            this._numberOfInvitation = 0;
            this._friends = new Dictionary(true);
            this._onlineFriends = new Vector.<FriendVO>(0);
            this._offlineFriends = new Vector.<FriendVO>(0);
            this._onlineFilteredFriends = new Vector.<FriendVO>(0);
            this._offlineFilteredFriends = new Vector.<FriendVO>(0);
            this._onlineGuildMembers = new Vector.<GuildMemberVO>(0);
            this._offlineGuildMembers = new Vector.<GuildMemberVO>(0);
            this._friendsLoadInProcess = false;
            this._invitationsLoadInProgress = false;
            this._guildLoadInProgress = false;
        }

        private function loadList(_arg_1:ISocialTask, _arg_2:String, _arg_3:Function):void{
            _arg_1.requestURL = _arg_2;
            (_arg_1 as BaseTask).finished.addOnce(_arg_3);
            (_arg_1 as BaseTask).start();
        }

        private function onFriendListResponse(_arg_1:FriendDataRequestTask, _arg_2:Boolean, _arg_3:String=""):void{
            this._isFriDataOK = _arg_2;
            if (this._isFriDataOK){
                this.seedFriends(_arg_1.xml);
                _arg_1.reset();
                this._friendsLoadInProcess = false;
                this.loadList(this.friendsDataRequest, FriendsActions.getURL(FriendsActions.INVITE_LIST), this.onInvitationListResponse);
            } else {
                this.socialDataSignal.dispatch(SocialDataSignal.FRIENDS_DATA_LOADED, this._isFriDataOK, _arg_3);
            }
        }

        private function onInvitationListResponse(_arg_1:FriendDataRequestTask, _arg_2:Boolean, _arg_3:String=""):void{
            if (_arg_2){
                this.seedInvitations(_arg_1.xml);
                this.socialDataSignal.dispatch(SocialDataSignal.FRIENDS_DATA_LOADED, this._isFriDataOK, _arg_3);
            } else {
                this.socialDataSignal.dispatch(SocialDataSignal.FRIEND_INVITATIONS_LOADED, _arg_2, _arg_3);
            }
            _arg_1.reset();
            this._invitationsLoadInProgress = false;
        }

        private function onGuildListResponse(_arg_1:GuildDataRequestTask, _arg_2:Boolean, _arg_3:String=""):void{
            if (_arg_2){
                this.seedGuild(_arg_1.xml);
            } else {
                this.clearGuildData();
            }
            _arg_1.reset();
            this._guildLoadInProgress = false;
            this.socialDataSignal.dispatch(SocialDataSignal.GUILD_DATA_LOADED, _arg_2, _arg_3);
        }

        private function seedInvitations(_arg_1:XML):void{
            var _local_2:String;
            var _local_3:XML;
            var _local_4:Player;
            this._invitations = new Dictionary(true);
            this._numberOfInvitation = 0;
            for each (_local_3 in _arg_1.Account) {
                if (this.starFilter(int(_local_3.Character[0].ObjectType), int(_local_3.Character[0].CurrentFame), _local_3.Stats[0])){
                    _local_2 = _local_3.Name;
                    _local_4 = Player.fromPlayerXML(_local_2, _local_3.Character[0]);
                    this._invitations[_local_2] = new FriendVO(_local_4);
                    this._numberOfInvitation++;
                }
            }
        }

        private function seedGuild(_arg_1:XML):void{
            var _local_3:XML;
            var _local_4:GuildMemberVO;
            var _local_5:String;
            var _local_6:String;
            this.clearGuildData();
            this._guildVO = new GuildVO();
            this._guildVO.guildName = _arg_1.@name;
            this._guildVO.guildId = _arg_1.@id;
            this._guildVO.guildTotalFame = _arg_1.TotalFame;
            this._guildVO.guildCurrentFame = _arg_1.CurrentFame.value;
            this._guildVO.guildHallType = _arg_1.HallType;
            var _local_2:XMLList = _arg_1.child("Member");
            if (_local_2.length() > 0){
                for each (_local_3 in _local_2) {
                    _local_4 = new GuildMemberVO();
                    _local_5 = _local_3.Name;
                    if (_local_5 == this.hudModel.getPlayerName()){
                        _local_4.isMe = true;
                        this._guildVO.myRank = _local_3.Rank;
                    }
                    _local_4.name = _local_5;
                    _local_4.rank = _local_3.Rank;
                    _local_4.fame = _local_3.Fame;
                    _local_4.player = Player.fromPlayerXML(_local_5, _local_3.Character[0]);
                    if (_local_3.hasOwnProperty("Online")){
                        _local_4.isOnline = true;
                        _local_6 = String(_local_3.Online);
                        _local_4.serverAddress = _local_6;
                        _local_4.serverName = this.serverNameDictionary()[_local_6];
                        this._onlineGuildMembers.push(_local_4);
                    } else {
                        _local_4.lastLogin = this.getLastLoginInSeconds(_local_3.LastLogin);
                        this._offlineGuildMembers.push(_local_4);
                    }
                }
            }
            this.updateGuildData();
        }

        private function getLastLoginInSeconds(_arg_1:String):Number{
            var _local_2:Date = new Date();
            return ((_local_2.getTime() - TimeUtil.parseUTCDate(_arg_1).getTime()) / 1000);
        }

        private function updateGuildData():void{
            this._onlineGuildMembers.sort(this.sortGuildMemberByRank);
            this._offlineGuildMembers.sort(this.sortGuildMemberByRank);
            this._onlineGuildMembers.sort(this.sortGuildMemberByAlphabet);
            this._offlineGuildMembers.sort(this.sortGuildMemberByAlphabet);
            this._guildMembers = this._onlineGuildMembers.concat(this._offlineGuildMembers);
            this._numberOfGuildMembers = this._guildMembers.length;
            this._guildVO.guildMembers = this._guildMembers;
        }

        private function clearGuildData():void{
            this._onlineGuildMembers.length = 0;
            this._offlineGuildMembers.length = 0;
            this._guildVO = null;
        }

        private function removeFriendFromList(_arg_1:String):void{
            var _local_2:FriendVO;
            for each (_local_2 in this._onlineFriends) {
                if (_local_2.getName() == _arg_1){
                    this._onlineFriends.splice(this._onlineFriends.indexOf(_local_2), 1);
                    break;
                }
            }
            for each (_local_2 in this._offlineFriends) {
                if (_local_2.getName() == _arg_1){
                    this._offlineFriends.splice(this._offlineFriends.indexOf(_local_2), 1);
                    break;
                }
            }
            this.updateFriendsList();
        }

        private function removeFromList(_arg_1:Vector.<FriendVO>, _arg_2:String):void{
            var _local_3:FriendVO;
            var _local_4:int;
            while (_local_4 < _arg_1.length) {
                _local_3 = _arg_1[_local_4];
                if (_local_3.getName() == _arg_2){
                    _arg_1.slice(_local_4, 1);
                    return;
                }
                _local_4++;
            }
        }

        private function sortFriend(_arg_1:FriendVO, _arg_2:FriendVO):Number{
            if (_arg_1.getName() < _arg_2.getName()){
                return (-1);
            }
            if (_arg_1.getName() > _arg_2.getName()){
                return (1);
            }
            return (0);
        }

        private function sortGuildMemberByRank(_arg_1:GuildMemberVO, _arg_2:GuildMemberVO):Number{
            if (_arg_1.rank > _arg_2.rank){
                return (-1);
            }
            if (_arg_1.rank < _arg_2.rank){
                return (1);
            }
            return (0);
        }

        private function sortGuildMemberByAlphabet(_arg_1:GuildMemberVO, _arg_2:GuildMemberVO):Number{
            if (_arg_1.rank == _arg_2.rank){
                if (_arg_1.name < _arg_2.name){
                    return (-1);
                }
                if (_arg_1.name > _arg_2.name){
                    return (1);
                }
                return (0);
            }
            return (0);
        }

        private function serverNameDictionary():Dictionary{
            var _local_2:Server;
            if (this._serverDict){
                return (this._serverDict);
            }
            var _local_1:Vector.<Server> = this.serverModel.getServers();
            this._serverDict = new Dictionary(true);
            for each (_local_2 in _local_1) {
                this._serverDict[_local_2.address] = _local_2.name;
            }
            return (this._serverDict);
        }

        private function starFilter(_arg_1:int, _arg_2:int, _arg_3:XML):Boolean{
            return (FameUtil.numAllTimeStars(_arg_1, _arg_2, _arg_3) >= Parameters.data_.friendStarRequirement);
        }

        private function updateFriendsList():void{
            this._friendsList = this._onlineFriends.concat(this._offlineFriends);
            this._numberOfFriends = this._friendsList.length;
        }

        public function get hasInvitations():Boolean{
            return (this._numberOfInvitation > 0);
        }

        public function get guildVO():GuildVO{
            return (this._guildVO);
        }

        public function get numberOfFriends():int{
            return (this._numberOfFriends);
        }

        public function get friendsList():Vector.<FriendVO>{
            return (this._friendsList);
        }

        public function get numberOfGuildMembers():int{
            return (this._numberOfGuildMembers);
        }


    }
}//package io.decagames.rotmg.social.model

