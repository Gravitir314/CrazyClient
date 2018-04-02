// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.TradeSlotMediator

package com.company.assembleegameclient.ui
{
import kabam.rotmg.text.view.BitmapTextFactory;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TradeSlotMediator extends Mediator
    {

        [Inject]
        public var bitmapFactory:BitmapTextFactory;
        [Inject]
        public var view:TradeSlot;


        override public function initialize():void
        {
            this.view.setBitmapFactory(this.bitmapFactory);
        }


    }
}//package com.company.assembleegameclient.ui

