// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.utils.colors.RGB

package io.decagames.rotmg.utils.colors
{
    public class RGB 
    {


        public static function fromRGB(_arg_1:int, _arg_2:int, _arg_3:int):uint
        {
            return (((_arg_1 << 16) | (_arg_2 << 8)) | _arg_3);
        }

        public static function toRGB(_arg_1:uint):Array
        {
            return ([getRed(_arg_1), getGreen(_arg_1), getBlue(_arg_1)]);
        }

        public static function getRed(_arg_1:int):int
        {
            return ((_arg_1 >> 16) & 0xFF);
        }

        public static function getGreen(_arg_1:int):int
        {
            return ((_arg_1 >> 8) & 0xFF);
        }

        public static function getBlue(_arg_1:int):int
        {
            return (_arg_1 & 0xFF);
        }


    }
}//package io.decagames.rotmg.utils.colors

