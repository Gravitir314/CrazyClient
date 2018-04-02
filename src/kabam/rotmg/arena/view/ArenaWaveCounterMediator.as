// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.arena.view.ArenaWaveCounterMediator

package kabam.rotmg.arena.view
{
import kabam.rotmg.arena.model.CurrentArenaRunModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ArenaWaveCounterMediator extends Mediator 
    {

        [Inject]
        public var view:ArenaWaveCounter;
        [Inject]
        public var currentRunModel:CurrentArenaRunModel;


        override public function initialize():void
        {
            this.currentRunModel.waveUpdated.add(this.onUpdateWaveNumber);
        }

        override public function destroy():void
        {
            this.currentRunModel.waveUpdated.remove(this.onUpdateWaveNumber);
        }

        private function onUpdateWaveNumber():void
        {
            this.view.setWaveNumber(this.currentRunModel.entry.currentWave);
        }


    }
}//package kabam.rotmg.arena.view

