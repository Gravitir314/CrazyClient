// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.pets.view.dialogs.evolving.configuration.AfterOpaqueTween

package kabam.rotmg.pets.view.dialogs.evolving.configuration
{
import com.gskinner.motion.GTween;

import flash.display.DisplayObject;

import kabam.rotmg.pets.view.dialogs.evolving.TweenProxy;

public class AfterOpaqueTween extends TweenProxy 
    {

        public function AfterOpaqueTween(_arg_1:DisplayObject)
        {
            super(_arg_1);
        }

        override public function start():void
        {
            var _local_1:GTween = new GTween(target, 1, {"alpha":1});
            _local_1.onComplete = this.pauseComplete;
        }

        private function pauseComplete(_arg_1:GTween):void
        {
            new GTween(target, 1, {"alpha":0});
        }


    }
}//package kabam.rotmg.pets.view.dialogs.evolving.configuration

