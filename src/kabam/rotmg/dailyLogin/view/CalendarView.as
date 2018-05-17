//kabam.rotmg.dailyLogin.view.CalendarView

package kabam.rotmg.dailyLogin.view
{
import flash.display.Sprite;

import kabam.rotmg.dailyLogin.config.CalendarSettings;
import kabam.rotmg.dailyLogin.model.CalendarDayModel;

public class CalendarView extends Sprite
    {


        public function init(_arg_1:Vector.<CalendarDayModel>, _arg_2:int, _arg_3:int):void
        {
            var _local_4:int;
            var _local_5:CalendarDayModel;
            var _local_6:int;
            var _local_7:CalendarDayBox;
            var _local_8:int;
            var _local_9:int;
            _local_4 = 0;
            for each (_local_5 in _arg_1)
            {
                _local_7 = new CalendarDayBox(_local_5, _arg_2, ((_local_8 + 1) == _arg_3));
                addChild(_local_7);
                _local_7.x = (_local_9 * CalendarSettings.BOX_WIDTH);
                if (_local_9 > 0)
                {
                    _local_7.x = (_local_7.x + (_local_9 * CalendarSettings.BOX_MARGIN));
                }
                _local_7.y = (_local_4 * CalendarSettings.BOX_HEIGHT);
                if (_local_4 > 0)
                {
                    _local_7.y = (_local_7.y + (_local_4 * CalendarSettings.BOX_MARGIN));
                }
                _local_9++;
                if ((++_local_8 % CalendarSettings.NUMBER_OF_COLUMNS) == 0)
                {
                    _local_9 = 0;
                    _local_4++;
                }
            }
            _local_6 = ((CalendarSettings.BOX_WIDTH * CalendarSettings.NUMBER_OF_COLUMNS) + ((CalendarSettings.NUMBER_OF_COLUMNS - 1) * CalendarSettings.BOX_MARGIN));
            this.x = ((this.parent.width - _local_6) / 2);
            this.y = (CalendarSettings.DAILY_LOGIN_TABS_PADDING + CalendarSettings.TABS_HEIGHT);
        }


    }
}//package kabam.rotmg.dailyLogin.view

