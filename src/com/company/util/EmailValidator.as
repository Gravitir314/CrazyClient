// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.util.EmailValidator

package com.company.util
{
    public class EmailValidator 
    {

        public static const EMAIL_REGEX:RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;


        public static function isValidEmail(_arg_1:String):Boolean
        {
            return (Boolean(_arg_1.match(EMAIL_REGEX)));
        }


    }
}//package com.company.util

