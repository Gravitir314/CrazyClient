// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.death.control.HandleDeathSignal

package kabam.rotmg.death.control
{
import kabam.rotmg.messaging.impl.incoming.Death;

import org.osflash.signals.Signal;

public class HandleDeathSignal extends Signal 
    {

        public function HandleDeathSignal()
        {
            super(Death);
        }

    }
}//package kabam.rotmg.death.control

