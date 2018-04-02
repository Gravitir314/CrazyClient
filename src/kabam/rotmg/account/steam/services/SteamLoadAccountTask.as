// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.account.steam.services.SteamLoadAccountTask

package kabam.rotmg.account.steam.services
{
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.account.core.services.LoadAccountTask;

public class SteamLoadAccountTask extends TaskSequence implements LoadAccountTask
    {

        [Inject]
        public var loadAPI:SteamLoadApiTask;
        [Inject]
        public var getCredentials:SteamGetCredentialsTask;


        [PostConstruct]
        public function setup():void
        {
            add(this.loadAPI);
            add(this.getCredentials);
        }

        override protected function startTask():void
        {
            super.startTask();
        }


    }
}//package kabam.rotmg.account.steam.services

