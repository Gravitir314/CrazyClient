// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.genericBox.BoxUtils

package io.decagames.rotmg.shop.genericBox
{
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.util.Currency;

import io.decagames.rotmg.shop.NotEnoughResources;
import io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.game.model.GameModel;

public class BoxUtils 
    {


        public static function moneyCheckPass(_arg_1:GenericBoxInfo, _arg_2:int, _arg_3:GameModel, _arg_4:PlayerModel, _arg_5:ShowPopupSignal):Boolean
        {
            var _local_6:int;
            var _local_7:int;
            if (((_arg_1.isOnSale()) && (_arg_1.saleAmount > 0)))
            {
                _local_6 = int(_arg_1.saleCurrency);
                _local_7 = (int(_arg_1.saleAmount) * _arg_2);
            }
            else
            {
                _local_6 = int(_arg_1.priceCurrency);
                _local_7 = (int(_arg_1.priceAmount) * _arg_2);
            }
            var _local_8:Boolean = true;
            var _local_9:int;
            var _local_10:int;
            var _local_11:Player = _arg_3.player;
            if (_local_11 != null)
            {
                _local_10 = _local_11.credits_;
                _local_9 = _local_11.fame_;
            }
            else
            {
                if (_arg_4 != null)
                {
                    _local_10 = _arg_4.getCredits();
                    _local_9 = _arg_4.getFame();
                }
            }
            if (((_local_6 == Currency.GOLD) && (_local_10 < _local_7)))
            {
                _arg_5.dispatch(new NotEnoughResources(300, Currency.GOLD));
                _local_8 = false;
            }
            else
            {
                if (((_local_6 == Currency.FAME) && (_local_9 < _local_7)))
                {
                    _arg_5.dispatch(new NotEnoughResources(300, Currency.FAME));
                    _local_8 = false;
                }
            }
            return (_local_8);
        }


    }
}//package io.decagames.rotmg.shop.genericBox

