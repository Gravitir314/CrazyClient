// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.maploading.signals.MapLoadedSignal

package kabam.rotmg.maploading.signals
{
import kabam.rotmg.messaging.impl.incoming.MapInfo;

import org.osflash.signals.Signal;

public class MapLoadedSignal extends Signal
    {

        public function MapLoadedSignal()
        {
            super(MapInfo);
        }

    }
}//package kabam.rotmg.maploading.signals

