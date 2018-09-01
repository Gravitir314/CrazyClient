//kabam.rotmg.messaging.impl.outgoing.ChangePetSkin

package kabam.rotmg.messaging.impl.outgoing
{
import flash.utils.IDataOutput;

public class ChangePetSkin extends OutgoingMessage
{

	public var petId:int;
	public var skinType:int;
	public var currency:int;

	public function ChangePetSkin(_arg_1:uint, _arg_2:Function)
	{
		super(_arg_1, _arg_2);
	}

	override public function writeToOutput(_arg_1:IDataOutput):void
	{
		_arg_1.writeInt(this.petId);
		_arg_1.writeInt(this.skinType);
		_arg_1.writeInt(this.currency);
	}

	override public function toString():String
	{
		return (formatToString("PET_CHANGE_SKIN_MSG", "petId", "skinType"));
	}

}
}//package kabam.rotmg.messaging.impl.outgoing

