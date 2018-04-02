// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.ui.signals.HideKeySignal

package kabam.rotmg.ui.signals
{
import kabam.rotmg.ui.model.Key;

import org.osflash.signals.Signal;

public class HideKeySignal extends Signal
    {

        public static var instance:HideKeySignal;

        public function HideKeySignal()
        {
            super(Key);
            instance = this;
        }

    }
}//package kabam.rotmg.ui.signals

