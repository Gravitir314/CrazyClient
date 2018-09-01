//com.company.assembleegameclient.objects.particles.LightningEffect

package com.company.assembleegameclient.objects.particles
{
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.RandomUtil;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class LightningEffect extends ParticleEffect
{

	public var start_:Point;
	public var end_:Point;
	public var color_:int;
	public var particleSize_:int;
	public var lifetimeMultiplier_:Number;

	public function LightningEffect(_arg_1:GameObject, _arg_2:WorldPosData, _arg_3:int, _arg_4:int, _arg_5:* = 1)
	{
		this.start_ = new Point(_arg_1.x_, _arg_1.y_);
		this.end_ = new Point(_arg_2.x_, _arg_2.y_);
		this.color_ = _arg_3;
		this.particleSize_ = _arg_4;
		this.lifetimeMultiplier_ = _arg_5;
	}

	override public function runNormalRendering(_arg_1:int, _arg_2:int):Boolean
	{
		var _local_3:Point;
		var _local_4:Particle;
		var _local_5:Number;
		var _local_6:int;
		x_ = this.start_.x;
		y_ = this.start_.y;
		var _local_7:Number = Point.distance(this.start_, this.end_);
		var _local_8:int = (_local_7 * 3);
		while (_local_6 < _local_8)
		{
			_local_3 = Point.interpolate(this.start_, this.end_, (_local_6 / _local_8));
			_local_4 = new SparkParticle(this.particleSize_, this.color_, ((1000 * this.lifetimeMultiplier_) - (((_local_6 / _local_8) * 900) * this.lifetimeMultiplier_)), 0.5, 0, 0);
			_local_5 = Math.min(_local_6, (_local_8 - _local_6));
			map_.addObj(_local_4, (_local_3.x + RandomUtil.plusMinus(((_local_7 / 200) * _local_5))), (_local_3.y + RandomUtil.plusMinus(((_local_7 / 200) * _local_5))));
			_local_6++;
		}
		return (false);
	}

	override public function runEasyRendering(_arg_1:int, _arg_2:int):Boolean
	{
		var _local_3:Point;
		var _local_4:Particle;
		var _local_5:Number;
		var _local_6:int;
		x_ = this.start_.x;
		y_ = this.start_.y;
		var _local_7:Number = Point.distance(this.start_, this.end_);
		var _local_8:int = (_local_7 * 2);
		this.particleSize_ = 80;
		while (_local_6 < _local_8)
		{
			_local_3 = Point.interpolate(this.start_, this.end_, (_local_6 / _local_8));
			_local_4 = new SparkParticle(this.particleSize_, this.color_, ((750 * this.lifetimeMultiplier_) - (((_local_6 / _local_8) * 675) * this.lifetimeMultiplier_)), 0.5, 0, 0);
			_local_5 = Math.min(_local_6, (_local_8 - _local_6));
			map_.addObj(_local_4, (_local_3.x + RandomUtil.plusMinus(((_local_7 / 200) * _local_5))), (_local_3.y + RandomUtil.plusMinus(((_local_7 / 200) * _local_5))));
			_local_6++;
		}
		return (false);
	}


}
}//package com.company.assembleegameclient.objects.particles

