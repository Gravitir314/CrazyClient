//kabam.rotmg.core.signals.TrackEventSignal

package kabam.rotmg.core.signals
{
import kabam.rotmg.core.service.TrackingData;

import org.osflash.signals.Signal;

public class TrackEventSignal extends Signal
    {

        public function TrackEventSignal()
        {
            super(TrackingData);
        }

    }
}//package kabam.rotmg.core.signals

