// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.utils.dictionary.DictionaryUtils

package io.decagames.rotmg.utils.dictionary
{
import flash.utils.Dictionary;

public class DictionaryUtils 
    {


        public static function countKeys(_arg_1:Dictionary):int
        {
            var _local_3:*;
            var _local_2:int;
            for (_local_3 in _arg_1)
            {
                _local_2++;
            }
            return (_local_2);
        }


    }
}//package io.decagames.rotmg.utils.dictionary

