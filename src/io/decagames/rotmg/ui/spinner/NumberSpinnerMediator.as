// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.spinner.NumberSpinnerMediator

package io.decagames.rotmg.ui.spinner
{
import io.decagames.rotmg.ui.buttons.SliceScalingButton;

import robotlegs.bender.bundles.mvcs.Mediator;

public class NumberSpinnerMediator extends Mediator 
    {

        [Inject]
        public var view:NumberSpinner;


        override public function initialize():void
        {
            this.view.upArrow.clickSignal.add(this.onUpClicked);
            this.view.downArrow.clickSignal.add(this.onDownClicked);
        }

        private function onUpClicked(_arg_1:SliceScalingButton):void
        {
            this.view.addToValue(this.view.step);
        }

        private function onDownClicked(_arg_1:SliceScalingButton):void
        {
            this.view.addToValue(-(this.view.step));
        }

        override public function destroy():void
        {
            this.view.upArrow.clickSignal.remove(this.onUpClicked);
            this.view.downArrow.clickSignal.remove(this.onDownClicked);
        }


    }
}//package io.decagames.rotmg.ui.spinner

