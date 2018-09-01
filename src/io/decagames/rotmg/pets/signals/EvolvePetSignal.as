//io.decagames.rotmg.pets.signals.EvolvePetSignal

package io.decagames.rotmg.pets.signals
{
import kabam.rotmg.messaging.impl.EvolvePetInfo;

import org.osflash.signals.Signal;

public class EvolvePetSignal extends Signal
{

	public function EvolvePetSignal()
	{
		super(EvolvePetInfo);
	}

}
}//package io.decagames.rotmg.pets.signals

