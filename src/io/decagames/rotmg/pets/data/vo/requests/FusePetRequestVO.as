//io.decagames.rotmg.pets.data.vo.requests.FusePetRequestVO

package io.decagames.rotmg.pets.data.vo.requests
{
public class FusePetRequestVO implements IUpgradePetRequestVO
{

	public var petInstanceIdOne:int;
	public var petInstanceIdTwo:int;
	public var paymentTransType:int;

	public function FusePetRequestVO(_arg_1:int, _arg_2:int, _arg_3:int)
	{
		this.petInstanceIdOne = _arg_1;
		this.petInstanceIdTwo = _arg_2;
		this.paymentTransType = _arg_3;
	}

}
}//package io.decagames.rotmg.pets.data.vo.requests

