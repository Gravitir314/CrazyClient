//io.decagames.rotmg.pets.utils.ItemBackgroundFactory

package io.decagames.rotmg.pets.utils
{
import io.decagames.rotmg.pets.components.petItem.PetItemBackground;

public class ItemBackgroundFactory 
    {


        public static function create(_arg_1:int, _arg_2:Array, _arg_3:uint, _arg_4:Number):PetItemBackground
        {
            return (new PetItemBackground(_arg_1, _arg_2, _arg_3, _arg_4));
        }


    }
}//package io.decagames.rotmg.pets.utils

