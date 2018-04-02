// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.chat.control.ClearTellModelCommand

package kabam.rotmg.chat.control
{
import kabam.rotmg.chat.model.TellModel;

import robotlegs.bender.bundles.mvcs.Command;

public class ClearTellModelCommand extends Command 
    {

        [Inject]
        public var tellModel:TellModel;


        override public function execute():void
        {
            this.tellModel.clearRecipients();
        }


    }
}//package kabam.rotmg.chat.control

