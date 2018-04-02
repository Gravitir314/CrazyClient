// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.startup.model.impl.TaskDelegate

package kabam.rotmg.startup.model.impl
{
import kabam.lib.tasks.Task;
import kabam.rotmg.startup.model.api.StartupDelegate;

import org.swiftsuspenders.Injector;

public class TaskDelegate implements StartupDelegate
    {

        public var injector:Injector;
        public var taskClass:Class;
        public var priority:int;


        public function getPriority():int
        {
            return (this.priority);
        }

        public function make():Task
        {
            return (this.injector.getInstance(this.taskClass));
        }


    }
}//package kabam.rotmg.startup.model.impl

