//io.decagames.rotmg.dailyQuests.utils.SlotsRendered

package io.decagames.rotmg.dailyQuests.utils
{
import flash.display.Sprite;

import io.decagames.rotmg.dailyQuests.data.DailyQuestItemSlotType;
import io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot;

public class SlotsRendered 
    {


        public static function renderSlots(_arg_1:Vector.<int>, _arg_2:Vector.<int>, _arg_3:String, _arg_4:Sprite, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:Vector.<DailyQuestItemSlot>, _arg_9:Boolean=false):void
        {
            var _local_11:int;
            var _local_18:Sprite;
            var _local_19:int;
            var _local_20:int;
            var _local_21:int;
            var _local_22:int;
            var _local_23:DailyQuestItemSlot;
            var _local_10:int;
            _local_11 = 4;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:Boolean;
            var _local_16:Sprite = new Sprite();
            var _local_17:Sprite = new Sprite();
            _local_18 = _local_16;
            _arg_4.addChild(_local_16);
            _arg_4.addChild(_local_17);
            _local_17.y = (DailyQuestItemSlot.SLOT_SIZE + _arg_6);
            for each (_local_19 in _arg_1)
            {
                if (!_local_15)
                {
                    _local_13++;
                }
                else
                {
                    _local_14++;
                }
                _local_22 = _arg_2.indexOf(_local_19);
                if (_local_22 >= 0)
                {
                    _arg_2.splice(_local_22, 1);
                }
                _local_23 = new DailyQuestItemSlot(_local_19, _arg_3, ((_arg_3 == DailyQuestItemSlotType.REWARD) ? false : (_local_22 >= 0)), _arg_9);
                _local_23.x = (_local_10 * (DailyQuestItemSlot.SLOT_SIZE + _arg_6));
                _local_18.addChild(_local_23);
                _arg_8.push(_local_23);
                if (++_local_10 >= _local_11)
                {
                    _local_18 = _local_17;
                    _local_10 = 0;
                    _local_15 = true;
                }
            }
            _local_20 = ((_local_13 * DailyQuestItemSlot.SLOT_SIZE) + ((_local_13 - 1) * _arg_6));
            _local_21 = ((_local_14 * DailyQuestItemSlot.SLOT_SIZE) + ((_local_14 - 1) * _arg_6));
            _arg_4.y = _arg_5;
            if (!_local_15)
            {
                _arg_4.y = (_arg_4.y + Math.round(((DailyQuestItemSlot.SLOT_SIZE / 2) + (_arg_6 / 2))));
            }
            _local_16.x = Math.round(((_arg_7 - _local_20) / 2));
            _local_17.x = Math.round(((_arg_7 - _local_21) / 2));
        }


    }
}//package io.decagames.rotmg.dailyQuests.utils

