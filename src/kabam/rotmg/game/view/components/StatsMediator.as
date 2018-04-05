// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.game.view.components.StatsMediator

package kabam.rotmg.game.view.components
{
import com.company.assembleegameclient.objects.Player;

import kabam.rotmg.ui.signals.UpdateHUDSignal;
import kabam.rotmg.ui.view.StatsDockedSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class StatsMediator extends Mediator
    {

        [Inject]
        public var view:StatsView;
        [Inject]
        public var updateHUD:UpdateHUDSignal;
        [Inject]
        public var statsUndocked:StatsUndockedSignal;
        [Inject]
        public var statsDocked:StatsDockedSignal;


        override public function initialize():void
        {
            this.updateHUD.add(this.onUpdateHUD);
        }

        override public function destroy():void
        {
            this.updateHUD.remove(this.onUpdateHUD);
        }

        private function onUpdateHUD(_arg_1:Player):void
        {
            if (this.view.myPlayer == false)
            {
                return;
            }
            this.view.draw(_arg_1);
        }


    }
}//package kabam.rotmg.game.view.components

