// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.packages.PurchaseCompleteModal

package io.decagames.rotmg.shop.packages
{
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.modal.TextModal;
import io.decagames.rotmg.ui.popups.modal.buttons.ClosePopupButton;

import kabam.rotmg.packages.model.PackageInfo;

public class PurchaseCompleteModal extends TextModal 
    {

        public function PurchaseCompleteModal(_arg_1:String)
        {
            var _local_2:Vector.<BaseButton> = new Vector.<BaseButton>();
            _local_2.push(new ClosePopupButton("OK"));
            var _local_3:* = "";
            switch (_arg_1)
            {
                case PackageInfo.PURCHASE_TYPE_SLOTS_ONLY:
                    _local_3 = "Your purchase has been validated!";
                    break;
                case PackageInfo.PURCHASE_TYPE_CONTENTS_ONLY:
                    _local_3 = "Your items have been sent to the Gift Chest!";
                    break;
                case PackageInfo.PURCHASE_TYPE_MIXED:
                    _local_3 = "Your purchase has been validated! You will find your items in the Gift Chest.";
                    break;
            }
            super(300, "Package Purchased", _local_3, _local_2);
        }

    }
}//package io.decagames.rotmg.shop.packages

