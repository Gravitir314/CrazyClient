// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.social.signals.SocialDataSignal

package io.decagames.rotmg.social.signals{
import org.osflash.signals.Signal;

public class SocialDataSignal extends Signal {

        public static const FRIENDS_DATA_LOADED:String = "SocialDataSignal.FRIENDS_DATA_LOADED";
        public static const FRIEND_INVITATIONS_LOADED:String = "SocialDataSignal.FRIEND_INVITATIONS_LOADED";
        public static const GUILD_DATA_LOADED:String = "SocialDataSignal.GUILD_DATA_LOADED";

        public function SocialDataSignal(){
            super(String, Boolean, String);
        }

    }
}//package io.decagames.rotmg.social.signals

