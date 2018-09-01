//com.company.assembleegameclient.objects.particles.HealingEffect

package com.company.assembleegameclient.objects.particles
{
import com.company.assembleegameclient.objects.GameObject;

public class HealingEffect extends ParticleEffect
{

	public var go_:GameObject;
	public var lastPart_:int;

	public function HealingEffect(_arg_1:GameObject)
	{
		this.go_ = _arg_1;
		this.lastPart_ = 0;
	}

	override public function update(_arg_1:int, _arg_2:int):Boolean
	{
		var _local_3:Number;
		var _local_4:int;
		var _local_5:Number;
		var _local_6:HealParticle;
		if (this.go_.map_ == null)
		{
			return (false);
		}
		x_ = this.go_.x_;
		y_ = this.go_.y_;
		var _local_7:int = (_arg_1 - this.lastPart_);
		if (_local_7 > 500)
		{
			_local_3 = ((2 * Math.PI) * Math.random());
			_local_4 = ((3 + int((Math.random() * 5))) * 20);
			_local_5 = (0.3 + (0.4 * Math.random()));
			_local_6 = new HealParticle(0xFFFFFF, (Math.random() * 0.3), _local_4, 1000, (0.1 + (Math.random() * 0.1)), this.go_, _local_3, _local_5);
			map_.addObj(_local_6, (x_ + (_local_5 * Math.cos(_local_3))), (y_ + (_local_5 * Math.sin(_local_3))));
			this.lastPart_ = _arg_1;
		}
		return (true);
	}


}
}//package com.company.assembleegameclient.objects.particles

