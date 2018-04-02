// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.application.EnvironmentConfig

package kabam.rotmg.application
{
import kabam.rotmg.application.model.DomainModel;

import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.IConfig;

public class EnvironmentConfig implements IConfig
    {

        [Inject]
        public var injector:Injector;


        public function configure():void
        {
            this.injector.map(DomainModel).asSingleton();
        }


    }
}//package kabam.rotmg.application

