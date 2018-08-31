//io.decagames.rotmg.pets.data.rarity.PetRarityEnum

package io.decagames.rotmg.pets.data.rarity
{
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class PetRarityEnum
    {

        public static const COMMON:PetRarityEnum = new PetRarityEnum("Pets.common", 0, 12960964, 0x454545);
        public static const UNCOMMON:PetRarityEnum = new PetRarityEnum("Pets.uncommon", 1, 12960964, 0x454545);
        public static const RARE:PetRarityEnum = new PetRarityEnum("Pets.rare", 2, 222407, 672896);
        public static const LEGENDARY:PetRarityEnum = new PetRarityEnum("Pets.legendary", 3, 222407, 672896);
        public static const DIVINE:PetRarityEnum = new PetRarityEnum("Pets.divine", 4, 0xC5A100, 8349960);

        public var rarityKey:String;
        public var ordinal:int;
        public var rarityName:String;
        public var color:uint;
        public var backgroundColor:uint;

        public function PetRarityEnum(_arg_1:String, _arg_2:int, _arg_3:uint, _arg_4:uint)
        {
            this.rarityKey = _arg_1;
            this.ordinal = _arg_2;
            this.color = _arg_3;
            this.backgroundColor = _arg_4;
        }

        public static function parseNames():void
        {
            var _local_1:PetRarityEnum;
            for each (_local_1 in PetRarityEnum.list)
            {
                _local_1.rarityName = LineBuilder.getLocalizedStringFromKey(_local_1.rarityKey);
            }
        }

        public static function get list():Array
        {
            return ([COMMON, UNCOMMON, RARE, LEGENDARY, DIVINE]);
        }

        public static function selectByRarityKey(_arg_1:String):PetRarityEnum
        {
            var _local_2:PetRarityEnum;
            var _local_3:PetRarityEnum;
            for each (_local_3 in PetRarityEnum.list)
            {
                if (_arg_1 == _local_3.rarityKey)
                {
                    _local_2 = _local_3;
                }
            }
            return (_local_2);
        }

        public static function selectByRarityName(_arg_1:String):PetRarityEnum
        {
            var _local_2:PetRarityEnum;
            var _local_3:PetRarityEnum;
            for each (_local_3 in PetRarityEnum.list)
            {
                if (_arg_1 == _local_3.rarityName)
                {
                    _local_2 = _local_3;
                }
            }
            return (_local_2);
        }

        public static function selectByOrdinal(_arg_1:int):PetRarityEnum
        {
            var _local_2:PetRarityEnum;
            var _local_3:PetRarityEnum;
            for each (_local_3 in PetRarityEnum.list)
            {
                if (_arg_1 == _local_3.ordinal)
                {
                    _local_2 = _local_3;
                }
            }
            return (_local_2);
        }


    }
}//package io.decagames.rotmg.pets.data.rarity

