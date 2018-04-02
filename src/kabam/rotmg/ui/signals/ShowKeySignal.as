// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.ui.signals.ShowKeySignal

package kabam.rotmg.ui.signals
{
import kabam.rotmg.ui.model.Key;

import org.osflash.signals.Signal;

public class ShowKeySignal extends Signal
    {

        public static var instance:ShowKeySignal;

        public function ShowKeySignal()
        {
            super(Key);
            instance = this;
        }

    }
}//package kabam.rotmg.ui.signals

