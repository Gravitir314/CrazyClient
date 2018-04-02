// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.packages.PurchaseCompleteModal

package io.decagames.rotmg.shop.packages
{
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.modal.TextModal;
import io.decagames.rotmg.ui.popups.modal.buttons.ClosePopupButton;

public class PurchaseCompleteModal extends TextModal 
    {

        public function PurchaseCompleteModal()
        {
            var _local_1:Vector.<BaseButton> = new Vector.<BaseButton>();
            _local_1.push(new ClosePopupButton("OK"));
            super(300, "Package Purchased", "Your items have been sent to the Gift Chest!", _local_1);
        }

    }
}//package io.decagames.rotmg.shop.packages

