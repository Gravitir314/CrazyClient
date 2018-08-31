//io.decagames.rotmg.pets.signals.HatchPetSignal

package io.decagames.rotmg.pets.signals
{
import io.decagames.rotmg.pets.data.vo.HatchPetVO;

import org.osflash.signals.Signal;

public class HatchPetSignal extends Signal
    {

        public function HatchPetSignal()
        {
            super(HatchPetVO);
        }

    }
}//package io.decagames.rotmg.pets.signals

