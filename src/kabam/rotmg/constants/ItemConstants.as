//kabam.rotmg.constants.ItemConstants

package kabam.rotmg.constants
{
import com.company.util.AssetLibrary;

import flash.display.BitmapData;

public class ItemConstants 
    {

        public static const NO_ITEM:int = -1;
        public static const ALL_TYPE:int = 0;
        public static const SWORD_TYPE:int = 1;
        public static const DAGGER_TYPE:int = 2;
        public static const BOW_TYPE:int = 3;
        public static const TOME_TYPE:int = 4;
        public static const SHIELD_TYPE:int = 5;
        public static const LEATHER_TYPE:int = 6;
        public static const PLATE_TYPE:int = 7;
        public static const WAND_TYPE:int = 8;
        public static const RING_TYPE:int = 9;
        public static const POTION_TYPE:int = 10;
        public static const SPELL_TYPE:int = 11;
        public static const SEAL_TYPE:int = 12;
        public static const CLOAK_TYPE:int = 13;
        public static const ROBE_TYPE:int = 14;
        public static const QUIVER_TYPE:int = 15;
        public static const HELM_TYPE:int = 16;
        public static const STAFF_TYPE:int = 17;
        public static const POISON_TYPE:int = 18;
        public static const SKULL_TYPE:int = 19;
        public static const TRAP_TYPE:int = 20;
        public static const ORB_TYPE:int = 21;
        public static const PRISM_TYPE:int = 22;
        public static const SCEPTER_TYPE:int = 23;
        public static const KATANA_TYPE:int = 24;
        public static const SHURIKEN_TYPE:int = 25;
        public static const EGG_TYPE:int = 26;
        public static const NEW_ABIL_TYPE:int = 27;


        public static function itemTypeToName(_arg_1:int):String
        {
            switch (_arg_1)
            {
                case ALL_TYPE:
                    return ("EquipmentType.Any");
                case SWORD_TYPE:
                    return ("EquipmentType.Sword");
                case DAGGER_TYPE:
                    return ("EquipmentType.Dagger");
                case BOW_TYPE:
                    return ("EquipmentType.Bow");
                case TOME_TYPE:
                    return ("EquipmentType.Tome");
                case SHIELD_TYPE:
                    return ("EquipmentType.Shield");
                case LEATHER_TYPE:
                    return ("EquipmentType.LeatherArmor");
                case PLATE_TYPE:
                    return ("EquipmentType.Armor");
                case WAND_TYPE:
                    return ("EquipmentType.Wand");
                case RING_TYPE:
                    return ("EquipmentType.Accessory");
                case POTION_TYPE:
                    return ("EquipmentType.Potion");
                case SPELL_TYPE:
                    return ("EquipmentType.Spell");
                case SEAL_TYPE:
                    return ("EquipmentType.HolySeal");
                case CLOAK_TYPE:
                    return ("EquipmentType.Cloak");
                case ROBE_TYPE:
                    return ("EquipmentType.Robe");
                case QUIVER_TYPE:
                    return ("EquipmentType.Quiver");
                case HELM_TYPE:
                    return ("EquipmentType.Helm");
                case STAFF_TYPE:
                    return ("EquipmentType.Staff");
                case POISON_TYPE:
                    return ("EquipmentType.Poison");
                case SKULL_TYPE:
                    return ("EquipmentType.Skull");
                case TRAP_TYPE:
                    return ("EquipmentType.Trap");
                case ORB_TYPE:
                    return ("EquipmentType.Orb");
                case PRISM_TYPE:
                    return ("EquipmentType.Prism");
                case SCEPTER_TYPE:
                    return ("EquipmentType.Scepter");
                case KATANA_TYPE:
                    return ("EquipmentType.Katana");
                case SHURIKEN_TYPE:
                    return ("EquipmentType.Shuriken");
                case EGG_TYPE:
                    return ("EquipmentType.Any");
                case NEW_ABIL_TYPE:
                    return ("Wakizashi");
            }
            return ("EquipmentType.InvalidType");
        }

        public static function itemTypeToBaseSprite(_arg_1:int):BitmapData
        {
            var _local_2:BitmapData;
            switch (_arg_1)
            {
                case ALL_TYPE:
                    break;
                case SWORD_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 48);
                    break;
                case DAGGER_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 96);
                    break;
                case BOW_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 80);
                    break;
                case TOME_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 80);
                    break;
                case SHIELD_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 112);
                    break;
                case LEATHER_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 0);
                    break;
                case PLATE_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 32);
                    break;
                case WAND_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 64);
                    break;
                case RING_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj", 44);
                    break;
                case SPELL_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 64);
                    break;
                case SEAL_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 160);
                    break;
                case CLOAK_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 32);
                    break;
                case ROBE_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 16);
                    break;
                case QUIVER_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 48);
                    break;
                case HELM_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 96);
                    break;
                case STAFF_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 112);
                    break;
                case POISON_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 128);
                    break;
                case SKULL_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 0);
                    break;
                case TRAP_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 16);
                    break;
                case ORB_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 144);
                    break;
                case PRISM_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 176);
                    break;
                case SCEPTER_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 192);
                    break;
                case KATANA_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj3", 540);
                    break;
                case SHURIKEN_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj3", 555);
                    break;
                case NEW_ABIL_TYPE:
                    _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 224);
                    break;
            }
            return (_local_2);
        }


    }
}//package kabam.rotmg.constants