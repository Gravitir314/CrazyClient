//io.decagames.rotmg.pets.signals.SelectPetSkinSignal

package io.decagames.rotmg.pets.signals
{
import io.decagames.rotmg.pets.data.vo.IPetVO;

import org.osflash.signals.Signal;

public class SelectPetSkinSignal extends Signal
{

	public function SelectPetSkinSignal()
	{
		super(IPetVO);
	}

}
}//package io.decagames.rotmg.pets.signals

