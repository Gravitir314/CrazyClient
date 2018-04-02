// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.external.command.MapExternalCallbacksCommand

package kabam.rotmg.external.command
{
import kabam.rotmg.external.service.ExternalServiceHelper;

import robotlegs.bender.bundles.mvcs.Command;

public class MapExternalCallbacksCommand extends Command
    {

        [Inject]
        public var externalServiceHelper:ExternalServiceHelper;


        override public function execute():void
        {
            this.externalServiceHelper.mapExternalCallbacks();
        }


    }
}//package kabam.rotmg.external.command

