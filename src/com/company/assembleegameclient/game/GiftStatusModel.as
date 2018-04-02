// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.game.GiftStatusModel

package com.company.assembleegameclient.game
{
import kabam.rotmg.game.signals.UpdateGiftStatusDisplaySignal;

public class GiftStatusModel 
    {

        [Inject]
        public var updateGiftStatusDisplay:UpdateGiftStatusDisplaySignal;
        public var hasGift:Boolean;


        public function setHasGift(_arg_1:Boolean):void
        {
            this.hasGift = _arg_1;
            this.updateGiftStatusDisplay.dispatch();
        }


    }
}//package com.company.assembleegameclient.game

