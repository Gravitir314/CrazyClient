// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.pets.view.components.PetTooltipMediator

package kabam.rotmg.pets.view.components
{
import robotlegs.bender.bundles.mvcs.Mediator;

public class PetTooltipMediator extends Mediator 
    {

        [Inject]
        public var view:PetTooltip;


        override public function initialize():void
        {
            this.view.init();
        }


    }
}//package kabam.rotmg.pets.view.components

