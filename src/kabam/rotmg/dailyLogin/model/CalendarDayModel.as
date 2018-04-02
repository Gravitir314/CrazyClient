// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.dailyLogin.model.CalendarDayModel

package kabam.rotmg.dailyLogin.model
{
    public class CalendarDayModel 
    {

        private var _dayNumber:int;
        private var _quantity:int;
        private var _itemID:int;
        private var _gold:int;
        private var _isClaimed:Boolean;
        private var _isCurrent:Boolean;
        private var _claimKey:String = "";
        private var _calendarType:String = "";

        public function CalendarDayModel(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean, _arg_6:String)
        {
            this._dayNumber = _arg_1;
            this._itemID = _arg_2;
            this._gold = _arg_3;
            this._isClaimed = _arg_5;
            this._quantity = _arg_4;
            this._calendarType = _arg_6;
        }

        public function get dayNumber():int
        {
            return (this._dayNumber);
        }

        public function set dayNumber(_arg_1:int):void
        {
            this._dayNumber = _arg_1;
        }

        public function get itemID():int
        {
            return (this._itemID);
        }

        public function set itemID(_arg_1:int):void
        {
            this._itemID = _arg_1;
        }

        public function get gold():int
        {
            return (this._gold);
        }

        public function set gold(_arg_1:int):void
        {
            this._gold = _arg_1;
        }

        public function get isClaimed():Boolean
        {
            return (this._isClaimed);
        }

        public function set isClaimed(_arg_1:Boolean):void
        {
            this._isClaimed = _arg_1;
        }

        public function toString():String
        {
            return ((((("Day " + this._dayNumber) + ", item: ") + this._itemID) + " x") + this._quantity);
        }

        public function get isCurrent():Boolean
        {
            return (this._isCurrent);
        }

        public function set isCurrent(_arg_1:Boolean):void
        {
            this._isCurrent = _arg_1;
        }

        public function get quantity():int
        {
            return (this._quantity);
        }

        public function set quantity(_arg_1:int):void
        {
            this._quantity = _arg_1;
        }

        public function get claimKey():String
        {
            return (this._claimKey);
        }

        public function set claimKey(_arg_1:String):void
        {
            this._claimKey = _arg_1;
        }

        public function get calendarType():String
        {
            return (this._calendarType);
        }

        public function set calendarType(_arg_1:String):void
        {
            this._calendarType = _arg_1;
        }


    }
}//package kabam.rotmg.dailyLogin.model

