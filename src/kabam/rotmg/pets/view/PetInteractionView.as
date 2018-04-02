// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.pets.view.PetInteractionView

package kabam.rotmg.pets.view
{
import flash.display.Sprite;

import kabam.rotmg.pets.view.dialogs.ClearsPetSlots;

public class PetInteractionView extends Sprite implements ClearsPetSlots 
    {


        protected function positionThis():void
        {
            this.x = ((800 - this.width) / 2);
            this.y = ((600 - this.height) / 2);
        }


    }
}//package kabam.rotmg.pets.view

