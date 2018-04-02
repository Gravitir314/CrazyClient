// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.game.events.MoneyChangedEvent

package com.company.assembleegameclient.game.events
{
import flash.events.Event;

public class MoneyChangedEvent extends Event
    {

        public static const MONEY_CHANGED:String = "MONEY_CHANGED";

        public function MoneyChangedEvent()
        {
            super(MONEY_CHANGED, true);
        }

    }
}//package com.company.assembleegameclient.game.events

