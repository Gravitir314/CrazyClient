// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.social.config.GuildActions

package io.decagames.rotmg.social.config{
    public class GuildActions {

        public static const BASE_DIRECTORY:String = "/guild";
        public static const GUILD_LIST:String = "/listMembers";


        public static function getURL(_arg_1:String):String{
            return (BASE_DIRECTORY + _arg_1);
        }


    }
}//package io.decagames.rotmg.social.config

