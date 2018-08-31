//kabam.rotmg.dailyLogin.model.DailyLoginModel

package kabam.rotmg.dailyLogin.model
{
public class DailyLoginModel
    {

        public static const DAY_IN_MILLISECONDS:Number = (((24 * 60) * 60) * 1000);//86400000

        public var shouldDisplayCalendarAtStartup:Boolean;
        public var currentDisplayedCaledar:String;
        private var serverTimestamp:Number;
        private var serverMeasureTime:Number;
        private var daysConfig:Object = {};
        private var userDayConfig:Object = {};
        private var currentDayConfig:Object = {};
        private var maxDayConfig:Object = {};
        private var _initialized:Boolean;
        private var _currentDay:int = -1;
        private var sortAsc:Function = function (_arg_1:CalendarDayModel, _arg_2:CalendarDayModel):Number
        {
            if (_arg_1.dayNumber < _arg_2.dayNumber)
            {
                return (-1);
            }
            if (_arg_1.dayNumber > _arg_2.dayNumber)
            {
                return (1);
            }
            return (0);
        };

        public function DailyLoginModel()
        {
            this.clear();
        }

        public function setServerTime(_arg_1:Number):void
        {
            this.serverTimestamp = _arg_1;
            this.serverMeasureTime = new Date().getTime();
        }

        public function hasCalendar(_arg_1:String):Boolean
        {
            return (this.daysConfig[_arg_1].length > 0);
        }

        public function getServerUTCTime():Date
        {
            var _local_1:Date = new Date();
            _local_1.setUTCMilliseconds(this.serverTimestamp);
            return (_local_1);
        }

        public function getServerTime():Date
        {
            var _local_1:Date = new Date();
            _local_1.setTime((this.serverTimestamp + (_local_1.getTime() - this.serverMeasureTime)));
            return (_local_1);
        }

        public function getTimestampDay():int
        {
            return (Math.floor((this.getServerTime().getTime() / DailyLoginModel.DAY_IN_MILLISECONDS)));
        }

        private function getDayCount(_arg_1:int, _arg_2:int):int
        {
            var _local_3:Date = new Date(_arg_1, _arg_2, 0);
            return (_local_3.getDate());
        }

        public function get daysLeftToCalendarEnd():int
        {
            var _local_1:Date = this.getServerTime();
            var _local_2:int = _local_1.getDate();
            var _local_3:int = this.getDayCount(_local_1.fullYear, (_local_1.month + 1));
            return (_local_3 - _local_2);
        }

        public function addDay(_arg_1:CalendarDayModel, _arg_2:String):void
        {
            this._initialized = true;
            this.daysConfig[_arg_2].push(_arg_1);
        }

        public function setUserDay(_arg_1:int, _arg_2:String):void
        {
            this.userDayConfig[_arg_2] = _arg_1;
        }

        public function calculateCalendar(_arg_1:String):void
        {
            var _local_6:CalendarDayModel;
            var _local_2:Vector.<CalendarDayModel> = this.sortCalendar(this.daysConfig[_arg_1]);
            var _local_3:int = _local_2.length;
            this.daysConfig[_arg_1] = _local_2;
            this.maxDayConfig[_arg_1] = _local_2[(_local_3 - 1)].dayNumber;
            var _local_4:Vector.<CalendarDayModel> = new Vector.<CalendarDayModel>();
            var _local_5:int = 1;
            while (_local_5 <= this.maxDayConfig[_arg_1])
            {
                _local_6 = this.getDayByNumber(_arg_1, _local_5);
                if (_local_5 == this.userDayConfig[_arg_1])
                {
                    _local_6.isCurrent = true;
                }
                _local_4.push(_local_6);
                _local_5++;
            }
            this.daysConfig[_arg_1] = _local_4;
        }

        private function getDayByNumber(_arg_1:String, _arg_2:int):CalendarDayModel
        {
            var _local_3:CalendarDayModel;
            for each (_local_3 in this.daysConfig[_arg_1])
            {
                if (_local_3.dayNumber == _arg_2)
                {
                    return (_local_3);
                }
            }
            return (new CalendarDayModel(_arg_2, -1, 0, 0, false, _arg_1));
        }

        public function getDaysConfig(_arg_1:String):Vector.<CalendarDayModel>
        {
            return (this.daysConfig[_arg_1]);
        }

        public function getMaxDays(_arg_1:String):int
        {
            return (this.maxDayConfig[_arg_1]);
        }

        public function get overallMaxDays():int
        {
            var _local_2:int;
            var _local_1:int;
            for each (_local_2 in this.maxDayConfig)
            {
                if (_local_2 > _local_1)
                {
                    _local_1 = _local_2;
                }
            }
            return (_local_1);
        }

        public function markAsClaimed(_arg_1:int, _arg_2:String):void
        {
            this.daysConfig[_arg_2][(_arg_1 - 1)].isClaimed = true;
        }

        private function sortCalendar(_arg_1:Vector.<CalendarDayModel>):Vector.<CalendarDayModel>
        {
            return (_arg_1.sort(this.sortAsc));
        }

        public function get initialized():Boolean
        {
            return (this._initialized);
        }

        public function clear():void
        {
            this.daysConfig[CalendarTypes.CONSECUTIVE] = new Vector.<CalendarDayModel>();
            this.daysConfig[CalendarTypes.NON_CONSECUTIVE] = new Vector.<CalendarDayModel>();
            this.daysConfig[CalendarTypes.UNLOCK] = new Vector.<CalendarDayModel>();
            this.shouldDisplayCalendarAtStartup = false;
        }

        public function getCurrentDay(_arg_1:String):int
        {
            return (this.currentDayConfig[_arg_1]);
        }

        public function setCurrentDay(_arg_1:String, _arg_2:int):void
        {
            this.currentDayConfig[_arg_1] = _arg_2;
        }


    }
}//package kabam.rotmg.dailyLogin.model

