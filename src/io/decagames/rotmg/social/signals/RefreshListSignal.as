// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.social.signals.RefreshListSignal

package io.decagames.rotmg.social.signals{
import org.osflash.signals.Signal;

public class RefreshListSignal extends Signal {

        public static const CONTEXT_FRIENDS_LIST:String = "RefreshListSignal.CONTEXT_FRIENDS_LIST";
        public static const CONTEXT_GUILD_LIST:String = "RefreshListSignal.CONTEXT_GUILD_LIST";

        public function RefreshListSignal(){
            super(String, Boolean);
        }

    }
}//package io.decagames.rotmg.social.signals

