//io.decagames.rotmg.pets.utils.PetAbilityDisplayIDGetter

package io.decagames.rotmg.pets.utils
{
import com.company.assembleegameclient.objects.ObjectLibrary;

public class PetAbilityDisplayIDGetter
    {


        public function getID(_arg_1:int):String
        {
            return (String(ObjectLibrary.getPetDataXMLByType(_arg_1).@id));
        }


    }
}//package io.decagames.rotmg.pets.utils

