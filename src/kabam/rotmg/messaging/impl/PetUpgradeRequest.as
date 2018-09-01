//kabam.rotmg.messaging.impl.PetUpgradeRequest

package kabam.rotmg.messaging.impl
{
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;

public class PetUpgradeRequest extends OutgoingMessage
{

	public static const GOLD_PAYMENT_TYPE:int = 0;
	public static const FAME_PAYMENT_TYPE:int = 1;

	public var petTransType:int;
	public var PIDOne:int;
	public var PIDTwo:int;
	public var objectId:int;
	public var slotsObject:Vector.<SlotObjectData>;
	public var paymentTransType:int;

	public function PetUpgradeRequest(_arg_1:uint, _arg_2:Function)
	{
		this.slotsObject = new Vector.<SlotObjectData>();
		super(_arg_1, _arg_2);
	}

	override public function writeToOutput(_arg_1:IDataOutput):void
	{
		var _local_2:SlotObjectData;
		_arg_1.writeByte(this.petTransType);
		_arg_1.writeInt(this.PIDOne);
		_arg_1.writeInt(this.PIDTwo);
		_arg_1.writeInt(this.objectId);
		_arg_1.writeByte(this.paymentTransType);
		_arg_1.writeShort(this.slotsObject.length);
		for each (_local_2 in this.slotsObject)
		{
			_local_2.writeToOutput(_arg_1);
		}
	}

}
}//package kabam.rotmg.messaging.impl

