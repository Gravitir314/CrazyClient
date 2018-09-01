﻿//com.company.assembleegameclient.objects.particles.PoisonEffect

package com.company.assembleegameclient.objects.particles
{
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.RandomUtil;

public class PoisonEffect extends ParticleEffect
{

	public var go_:GameObject;
	public var color_:int;

	public function PoisonEffect(_arg_1:GameObject, _arg_2:int)
	{
		this.go_ = _arg_1;
		this.color_ = _arg_2;
	}

	override public function update(_arg_1:int, _arg_2:int):Boolean
	{
		var _local_3:int;
		if (this.go_.map_ == null)
		{
			return (false);
		}
		x_ = this.go_.x_;
		y_ = this.go_.y_;
		var _local_4:int = 10;
		while (_local_3 < _local_4)
		{
			map_.addObj(new SparkParticle(100, this.color_, 400, 0.75, RandomUtil.plusMinus(4), RandomUtil.plusMinus(4)), x_, y_);
			_local_3++;
		}
		return (false);
	}


}
}//package com.company.assembleegameclient.objects.particles

