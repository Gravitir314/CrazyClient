//io.decagames.rotmg.pets.utils.PetItemFactory

package io.decagames.rotmg.pets.utils
{
import io.decagames.rotmg.pets.components.petIcon.PetIcon;
import io.decagames.rotmg.pets.components.petIcon.PetIconFactory;
import io.decagames.rotmg.pets.components.petItem.PetItem;
import io.decagames.rotmg.pets.data.vo.PetVO;

public class PetItemFactory 
    {

        [Inject]
        public var petIconFactory:PetIconFactory;


        public function create(_arg_1:PetVO, _arg_2:int, _arg_3:uint=0x545454, _arg_4:Number=1):PetItem
        {
            var _local_5:PetItem = new PetItem(_arg_3);
            var _local_6:PetIcon = this.petIconFactory.create(_arg_1, _arg_2);
            _local_5.setPetIcon(_local_6);
            _local_5.setSize(_arg_2);
            _local_5.setBackground(PetItem.REGULAR, _arg_3, _arg_4);
            return (_local_5);
        }


    }
}//package io.decagames.rotmg.pets.utils

