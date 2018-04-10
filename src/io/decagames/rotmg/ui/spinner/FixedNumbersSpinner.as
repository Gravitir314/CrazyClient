// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.spinner.FixedNumbersSpinner

package io.decagames.rotmg.ui.spinner
{
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;

public class FixedNumbersSpinner extends NumberSpinner
    {

        private var _numbers:Vector.<int>;

        public function FixedNumbersSpinner(_arg_1:SliceScalingBitmap, _arg_2:int, _arg_3:Vector.<int>, _arg_4:String="")
        {
            super(_arg_1, _arg_2, 0, (_arg_3.length - 1), 1, _arg_4);
            this._numbers = _arg_3;
            this.updateLabel();
        }

        override protected function updateLabel():void
        {
            label.text = (this._numbers[_value] + suffix);
            label.x = (-(label.width) / 2);
        }

        override public function get value():int
        {
            return (this._numbers[_value]);
        }

        override public function set value(_arg_1:int):void
        {
            var _local_2:int = _value;
            _value = this._numbers.indexOf(_arg_1);
            if (_value < 0)
            {
                _value = 0;
            }
            if (_value != _local_2)
            {
                valueWasChanged.dispatch(this.value);
            }
            this.updateLabel();
        }


    }
}//package io.decagames.rotmg.ui.spinner

