//io.decagames.rotmg.pets.signals.ChangePetSkinSignal

package io.decagames.rotmg.pets.signals
{
import io.decagames.rotmg.pets.data.vo.IPetVO;

import org.osflash.signals.Signal;

public class ChangePetSkinSignal extends Signal
    {

        public function ChangePetSkinSignal()
        {
            super(IPetVO);
        }

    }
}//package io.decagames.rotmg.pets.signals

