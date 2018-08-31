//io.decagames.rotmg.pets.data.vo.requests.FeedPetRequestVO

package io.decagames.rotmg.pets.data.vo.requests
{
import kabam.rotmg.messaging.impl.data.SlotObjectData;

public class FeedPetRequestVO implements IUpgradePetRequestVO 
    {

        public var petInstanceId:int;
        public var slotObjects:Vector.<SlotObjectData>;
        public var paymentTransType:int;

        public function FeedPetRequestVO(_arg_1:int, _arg_2:Vector.<SlotObjectData>, _arg_3:int)
        {
            this.petInstanceId = _arg_1;
            this.slotObjects = _arg_2;
            this.paymentTransType = _arg_3;
        }

    }
}//package io.decagames.rotmg.pets.data.vo.requests

