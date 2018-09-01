//io.decagames.rotmg.dailyQuests.signal.QuestFetchCompleteSignal

package io.decagames.rotmg.dailyQuests.signal
{
import io.decagames.rotmg.dailyQuests.messages.incoming.QuestFetchResponse;

import org.osflash.signals.Signal;

public class QuestFetchCompleteSignal extends Signal
{

	public function QuestFetchCompleteSignal()
	{
		super(QuestFetchResponse);
	}

}
}//package io.decagames.rotmg.dailyQuests.signal

