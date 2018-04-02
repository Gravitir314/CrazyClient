// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.lib.console.controller.RegisterConsoleActionCommand

package kabam.lib.console.controller
{
import kabam.lib.console.model.Console;
import kabam.lib.console.vo.ConsoleAction;

import org.osflash.signals.Signal;

public class RegisterConsoleActionCommand 
    {

        [Inject]
        public var console:Console;
        [Inject]
        public var action:ConsoleAction;
        [Inject]
        public var trigger:Signal;


        public function execute():void
        {
            this.console.register(this.action, this.trigger);
        }


    }
}//package kabam.lib.console.controller

