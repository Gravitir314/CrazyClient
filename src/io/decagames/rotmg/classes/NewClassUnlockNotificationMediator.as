//io.decagames.rotmg.classes.NewClassUnlockNotificationMediator

package io.decagames.rotmg.classes
{
import robotlegs.bender.bundles.mvcs.Mediator;

public class NewClassUnlockNotificationMediator extends Mediator 
    {

        [Inject]
        public var view:NewClassUnlockNotification;
        [Inject]
        public var newClassUnlockSignal:NewClassUnlockSignal;


        override public function initialize():void
        {
            this.newClassUnlockSignal.add(this.onNewClassUnlocked);
        }

        override public function destroy():void
        {
            super.destroy();
            this.newClassUnlockSignal.remove(this.onNewClassUnlocked);
        }

        private function onNewClassUnlocked(_arg_1:Array):void
        {
            this.view.playNotification(_arg_1);
        }


    }
}//package io.decagames.rotmg.classes

