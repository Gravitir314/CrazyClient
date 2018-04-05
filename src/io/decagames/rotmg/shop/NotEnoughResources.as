// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.NotEnoughResources

package io.decagames.rotmg.shop
{
import com.company.assembleegameclient.util.Currency;

import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.modal.TextModal;
import io.decagames.rotmg.ui.popups.modal.buttons.BuyGoldButton;
import io.decagames.rotmg.ui.popups.modal.buttons.ClosePopupButton;

public class NotEnoughResources extends TextModal
    {

        public function NotEnoughResources(_arg_1:int, _arg_2:int)
        {
            var _local_3:String = ((_arg_2 == Currency.GOLD) ? "gold" : "fame");
            var _local_4:String = ((_arg_2 == Currency.GOLD) ? "You do not have enough Gold for this item. Would you like to buy Gold?" : "You do not have enough Fame for this item. You gain Fame when your character dies after having accomplished great things.");
            var _local_5:Vector.<BaseButton> = new Vector.<BaseButton>();
            _local_5.push(new ClosePopupButton("Cancel"));
            if ((_arg_2 == Currency.GOLD))
            {
                _local_5.push(new BuyGoldButton());
            }
            super(_arg_1, ("Not enough " + _local_3), _local_4, _local_5);
        }

    }
}//package io.decagames.rotmg.shop

