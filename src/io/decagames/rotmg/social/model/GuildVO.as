// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.social.model.GuildVO

package io.decagames.rotmg.social.model{
public class GuildVO {

        private var _guildName:String;
        private var _guildId:String;
        private var _guildTotalFame:int;
        private var _guildCurrentFame:int;
        private var _guildHallType:String;
        private var _guildMembers:Vector.<GuildMemberVO>;
        private var _myRank:int;


        public function get guildName():String{
            return (this._guildName);
        }

        public function set guildName(_arg_1:String):void{
            this._guildName = _arg_1;
        }

        public function get guildId():String{
            return (this._guildId);
        }

        public function set guildId(_arg_1:String):void{
            this._guildId = _arg_1;
        }

        public function get guildTotalFame():int{
            return (this._guildTotalFame);
        }

        public function set guildTotalFame(_arg_1:int):void{
            this._guildTotalFame = _arg_1;
        }

        public function get guildCurrentFame():int{
            return (this._guildCurrentFame);
        }

        public function set guildCurrentFame(_arg_1:int):void{
            this._guildCurrentFame = _arg_1;
        }

        public function get guildHallType():String{
            return (this._guildHallType);
        }

        public function set guildHallType(_arg_1:String):void{
            this._guildHallType = _arg_1;
        }

        public function get myRank():int{
            return (this._myRank);
        }

        public function set myRank(_arg_1:int):void{
            this._myRank = _arg_1;
        }

        public function get guildMembers():Vector.<GuildMemberVO>{
            return (this._guildMembers);
        }

        public function set guildMembers(_arg_1:Vector.<GuildMemberVO>):void{
            this._guildMembers = _arg_1;
        }


    }
}//package io.decagames.rotmg.social.model

