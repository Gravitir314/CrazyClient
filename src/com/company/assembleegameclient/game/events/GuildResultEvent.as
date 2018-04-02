// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.game.events.GuildResultEvent

package com.company.assembleegameclient.game.events
{
import flash.events.Event;

public class GuildResultEvent extends Event
    {

        public static const EVENT:String = "GUILDRESULTEVENT";

        public var success_:Boolean;
        public var errorKey:String;
        public var errorTokens:Object;

        public function GuildResultEvent(_arg_1:Boolean, _arg_2:String, _arg_3:Object)
        {
            super(EVENT);
            this.success_ = _arg_1;
            this.errorKey = _arg_2;
            this.errorTokens = _arg_3;
        }

    }
}//package com.company.assembleegameclient.game.events

