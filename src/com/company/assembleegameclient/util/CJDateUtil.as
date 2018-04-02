// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.util.CJDateUtil

package com.company.assembleegameclient.util
{
    public class CJDateUtil 
    {

        private var date:Date;

        public function CJDateUtil()
        {
            this.date = new Date();
        }

        public function getFormattedTime():String
        {
            return ((this.toDoubleDigit(this.date.getHours()) + ":") + this.toDoubleDigit(this.date.getMinutes()));
        }

        private function toDoubleDigit(_arg_1:int):String
        {
            return ((_arg_1 > 9) ? _arg_1.toString() : ("0" + _arg_1));
        }


    }
}//package com.company.assembleegameclient.util

