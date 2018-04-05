// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo

package io.decagames.rotmg.shop.genericBox.data
{
import com.company.assembleegameclient.util.TimeUtil;

import io.decagames.rotmg.utils.date.TimeLeft;

public class GenericBoxInfo
    {

        protected var _id:String;
        protected var _title:String;
        protected var _description:String;
        protected var _weight:String;
        protected var _contents:String;
        protected var _priceAmount:int;
        protected var _priceCurrency:int;
        protected var _saleAmount:int;
        protected var _saleCurrency:int;
        protected var _quantity:int;
        protected var _saleEnd:Date;
        protected var _startTime:Date;
        protected var _endTime:Date;
        protected var _unitsLeft:int = -1;
        protected var _totalUnits:int = -1;
        protected var _slot:int = 0;
        protected var _tags:String = "";


        public function get id():String
        {
            return (this._id);
        }

        public function set id(_arg_1:String):void
        {
            this._id = _arg_1;
        }

        public function get title():String
        {
            return (this._title);
        }

        public function set title(_arg_1:String):void
        {
            this._title = _arg_1;
        }

        public function get description():String
        {
            return (this._description);
        }

        public function set description(_arg_1:String):void
        {
            this._description = _arg_1;
        }

        public function get weight():String
        {
            return (this._weight);
        }

        public function set weight(_arg_1:String):void
        {
            this._weight = _arg_1;
        }

        public function get contents():String
        {
            return (this._contents);
        }

        public function set contents(_arg_1:String):void
        {
            this._contents = _arg_1;
        }

        public function get priceAmount():int
        {
            return (this._priceAmount);
        }

        public function set priceAmount(_arg_1:int):void
        {
            this._priceAmount = _arg_1;
        }

        public function get priceCurrency():int
        {
            return (this._priceCurrency);
        }

        public function set priceCurrency(_arg_1:int):void
        {
            this._priceCurrency = _arg_1;
        }

        public function get saleAmount():int
        {
            return (this._saleAmount);
        }

        public function set saleAmount(_arg_1:int):void
        {
            this._saleAmount = _arg_1;
        }

        public function get saleCurrency():int
        {
            return (this._saleCurrency);
        }

        public function set saleCurrency(_arg_1:int):void
        {
            this._saleCurrency = _arg_1;
        }

        public function get quantity():int
        {
            return (this._quantity);
        }

        public function set quantity(_arg_1:int):void
        {
            this._quantity = _arg_1;
        }

        public function get saleEnd():Date
        {
            return (this._saleEnd);
        }

        public function set saleEnd(_arg_1:Date):void
        {
            this._saleEnd = _arg_1;
        }

        public function get startTime():Date
        {
            return (this._startTime);
        }

        public function set startTime(_arg_1:Date):void
        {
            this._startTime = _arg_1;
        }

        public function get endTime():Date
        {
            return (this._endTime);
        }

        public function set endTime(_arg_1:Date):void
        {
            this._endTime = _arg_1;
        }

        public function get unitsLeft():int
        {
            return (this._unitsLeft);
        }

        public function set unitsLeft(_arg_1:int):void
        {
            this._unitsLeft = _arg_1;
        }

        public function get totalUnits():int
        {
            return (this._totalUnits);
        }

        public function set totalUnits(_arg_1:int):void
        {
            this._totalUnits = _arg_1;
        }

        public function get slot():int
        {
            return (this._slot);
        }

        public function set slot(_arg_1:int):void
        {
            this._slot = _arg_1;
        }

        public function get tags():String
        {
            return (this._tags);
        }

        public function set tags(_arg_1:String):void
        {
            this._tags = _arg_1;
        }

        public function getSecondsToEnd():Number
        {
            if (!this._endTime)
            {
                return (int.MAX_VALUE);
            }
            var _local_1:Date = new Date();
            return ((this._endTime.time - _local_1.time) / 1000);
        }

        public function isOnSale():Boolean
        {
            var _local_1:Date;
            if (this._saleEnd)
            {
                _local_1 = new Date();
                return (_local_1.time < this._saleEnd.time);
            }
            return (false);
        }

        public function isNew():Boolean
        {
            var _local_1:Date = new Date();
            return (Math.ceil(TimeUtil.secondsToDays(((_local_1.time - this._startTime.time) / 1000))) <= 1);
        }

        public function getEndTimeString():String
        {
            if (!this._endTime)
            {
                return ("");
            }
            var _local_1:* = "Ends in: ";
            var _local_2:Number = this.getSecondsToEnd();
            if (_local_2 <= 0)
            {
                return ("");
            }
            if (_local_2 > TimeUtil.DAY_IN_S)
            {
                _local_1 = (_local_1 + TimeLeft.parse(_local_2, "%dd %hh"));
            }
            else
            {
                if (_local_2 > TimeUtil.HOUR_IN_S)
                {
                    _local_1 = (_local_1 + TimeLeft.parse(_local_2, "%hh %mm"));
                }
                else
                {
                    _local_1 = (_local_1 + TimeLeft.parse(_local_2, "%mm %ss"));
                }
            }
            return (_local_1);
        }


    }
}//package io.decagames.rotmg.shop.genericBox.data

