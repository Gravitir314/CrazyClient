// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.utils.SlotsRendered

package io.decagames.rotmg.dailyQuests.utils
{
import flash.display.Sprite;

import io.decagames.rotmg.dailyQuests.data.DailyQuestItemSlotType;
import io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot;

public class SlotsRendered
    {


        public static function renderSlots(_arg_1:Vector.<int>, _arg_2:Vector.<int>, _arg_3:String, _arg_4:Sprite, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:Vector.<DailyQuestItemSlot>):void
        {
            var _local_9:Sprite;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:DailyQuestItemSlot;
            var _local_15:int;
            var _local_17:int;
            var _local_18:int;
            var _local_19:int;
            var _local_20:Boolean;
            var _local_22:Sprite;
            var _local_16:int = 4;
            var _local_21:Sprite = new Sprite();
            _local_22 = new Sprite();
            _local_9 = _local_21;
            _arg_4.addChild(_local_21);
            _arg_4.addChild(_local_22);
            _local_22.y = (DailyQuestItemSlot.SLOT_SIZE + _arg_6);
            for each (_local_10 in _arg_1)
            {
                if (!_local_20)
                {
                    _local_18++;
                }
                else
                {
                    _local_19++;
                }
                _local_13 = _arg_2.indexOf(_local_10);
                if (_local_13 >= 0)
                {
                    _arg_2.splice(_local_13, 1);
                }
                _local_14 = new DailyQuestItemSlot(_local_10, _arg_3, ((_arg_3 == DailyQuestItemSlotType.REWARD) ? false : (_local_13 >= 0)));
                _local_14.x = (_local_15 * (DailyQuestItemSlot.SLOT_SIZE + _arg_6));
                _local_9.addChild(_local_14);
                _arg_8.push(_local_14);
                if (++_local_15 >= _local_16)
                {
                    _local_9 = _local_22;
                    _local_15 = 0;
                    _local_20 = true;
                }
            }
            _local_11 = ((_local_18 * DailyQuestItemSlot.SLOT_SIZE) + ((_local_18 - 1) * _arg_6));
            _local_12 = ((_local_19 * DailyQuestItemSlot.SLOT_SIZE) + ((_local_19 - 1) * _arg_6));
            _arg_4.y = _arg_5;
            if (!_local_20)
            {
                _arg_4.y = (_arg_4.y + Math.round(((DailyQuestItemSlot.SLOT_SIZE / 2) + (_arg_6 / 2))));
            }
            _local_21.x = Math.round(((_arg_7 - _local_11) / 2));
            _local_22.x = Math.round(((_arg_7 - _local_12) / 2));
        }


    }
}//package io.decagames.rotmg.dailyQuests.utils

