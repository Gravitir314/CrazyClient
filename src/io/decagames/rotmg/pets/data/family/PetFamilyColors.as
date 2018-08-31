//io.decagames.rotmg.pets.data.family.PetFamilyColors

package io.decagames.rotmg.pets.data.family
{
public class PetFamilyColors 
    {

        public static const AQUATIC:uint = 2453493;
        public static const AUTOMATON:uint = 5853776;
        public static const AVIAN:uint = 16483201;
        public static const CANINE:uint = 15828793;
        public static const EXOTIC:uint = 15673487;
        public static const FARM:uint = 6897954;
        public static const FELINE:uint = 14519612;
        public static const HUMANOID:uint = 13074611;
        public static const INSECT:uint = 1109351;
        public static const PENGUIN:uint = 0x282828;
        public static const REPTILE:uint = 49227;
        public static const SPOOKY:uint = 10564850;
        public static const WOODLAND:uint = 8269343;
        public static const MISCELLANEOUS:uint = 16725303;
        public static const KEYS_TO_COLORS:Object = {
            "Pets.humanoid":HUMANOID,
            "Pets.feline":FELINE,
            "Pets.canine":CANINE,
            "Pets.avian":AVIAN,
            "Pets.exotic":EXOTIC,
            "Pets.farm":FARM,
            "Pets.woodland":WOODLAND,
            "Pets.reptile":REPTILE,
            "Pets.insect":INSECT,
            "Pets.penguin":PENGUIN,
            "Pets.aquatic":AQUATIC,
            "Pets.spooky":SPOOKY,
            "Pets.automaton":AUTOMATON,
            "Pets.miscellaneous":MISCELLANEOUS,
            "? ? ? ?":MISCELLANEOUS
        };


        public static function getColorByFamilyKey(_arg_1:String):uint
        {
            return (KEYS_TO_COLORS[PetFamilyKeys.getTranslationKey(_arg_1)]);
        }


    }
}//package io.decagames.rotmg.pets.data.family

