//com.company.assembleegameclient.objects.particles.TeleportEffect

package com.company.assembleegameclient.objects.particles
{
public class TeleportEffect extends ParticleEffect
{


	override public function runNormalRendering(_arg_1:int, _arg_2:int):Boolean
	{
		var _local_3:Number;
		var _local_4:Number;
		var _local_5:int;
		var _local_6:TeleportParticle;
		var _local_7:int;
		var _local_8:int = 20;
		while (_local_7 < _local_8)
		{
			_local_3 = ((2 * Math.PI) * Math.random());
			_local_4 = (0.7 * Math.random());
			_local_5 = int(int((500 + (1000 * Math.random()))));
			_local_6 = new TeleportParticle(0xFF, 50, 0.1, _local_5);
			map_.addObj(_local_6, (x_ + (_local_4 * Math.cos(_local_3))), (y_ + (_local_4 * Math.sin(_local_3))));
			_local_7++;
		}
		return (false);
	}

	override public function runEasyRendering(_arg_1:int, _arg_2:int):Boolean
	{
		var _local_3:Number;
		var _local_4:Number;
		var _local_5:int;
		var _local_6:TeleportParticle;
		var _local_7:int;
		var _local_8:int = 10;
		while (_local_7 < _local_8)
		{
			_local_3 = ((2 * Math.PI) * Math.random());
			_local_4 = (0.7 * Math.random());
			_local_5 = int(int((5 + (500 * Math.random()))));
			_local_6 = new TeleportParticle(0xFF, 50, 0.1, _local_5);
			map_.addObj(_local_6, (x_ + (_local_4 * Math.cos(_local_3))), (y_ + (_local_4 * Math.sin(_local_3))));
			_local_7++;
		}
		return (false);
	}


}
}//package com.company.assembleegameclient.objects.particles

import com.company.assembleegameclient.objects.particles.Particle;

import flash.geom.Vector3D;

class TeleportParticle extends Particle
{

	public var timeLeft_:int;
	protected var moveVec_:Vector3D = new Vector3D();

	public function TeleportParticle(_arg_1:uint, _arg_2:int, _arg_3:Number, _arg_4:int)
	{
		super(_arg_1, 0, _arg_2);
		this.moveVec_.z = _arg_3;
		this.timeLeft_ = _arg_4;
	}

	override public function update(_arg_1:int, _arg_2:int):Boolean
	{
		this.timeLeft_ = (this.timeLeft_ - _arg_2);
		if (this.timeLeft_ <= 0)
		{
			return (false);
		}
		z_ = (z_ + ((this.moveVec_.z * _arg_2) * 0.008));
		return (true);
	}


}


