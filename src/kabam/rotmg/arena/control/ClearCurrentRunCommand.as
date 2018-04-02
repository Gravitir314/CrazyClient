// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.arena.control.ClearCurrentRunCommand

package kabam.rotmg.arena.control
{
import kabam.rotmg.arena.model.CurrentArenaRunModel;

import robotlegs.bender.bundles.mvcs.Command;

public class ClearCurrentRunCommand extends Command 
    {

        [Inject]
        public var currentRunModel:CurrentArenaRunModel;


        override public function execute():void
        {
            this.currentRunModel.clear();
        }


    }
}//package kabam.rotmg.arena.control

