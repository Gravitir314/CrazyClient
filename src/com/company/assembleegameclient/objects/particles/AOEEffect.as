// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.objects.particles.AOEEffect

package com.company.assembleegameclient.objects.particles
{
import flash.geom.Point;

public class AOEEffect extends ParticleEffect
    {

        public var start_:Point;
        public var novaRadius_:Number;
        public var color_:int;

        public function AOEEffect(_arg_1:Point, _arg_2:Number, _arg_3:int)
        {
            this.start_ = _arg_1;
            this.novaRadius_ = _arg_2;
            this.color_ = _arg_3;
        }

        override public function runNormalRendering(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:Number;
            var _local_4:Point;
            var _local_5:Particle;
            var _local_6:int;
            if (this.color_ == -1)
            {
                return (false);
            };
            x_ = this.start_.x;
            y_ = this.start_.y;
            var _local_7:int = 40;
            var _local_8:* = 200;
            var _local_9:int = (4 + (this.novaRadius_ * 2));
            while (_local_6 < _local_9)
            {
                _local_3 = (((_local_6 * 2) * Math.PI) / _local_9);
                _local_4 = new Point((this.start_.x + (this.novaRadius_ * Math.cos(_local_3))), (this.start_.y + (this.novaRadius_ * Math.sin(_local_3))));
                _local_5 = new SparkerParticle(_local_7, this.color_, _local_8, this.start_, _local_4);
                map_.addObj(_local_5, x_, y_);
                _local_6++;
            };
            return (false);
        }

        override public function runEasyRendering(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:Number;
            var _local_4:Point;
            var _local_5:Particle;
            var _local_6:int;
            if (this.color_ == -1)
            {
                return (false);
            };
            x_ = this.start_.x;
            y_ = this.start_.y;
            var _local_7:* = 200;
            var _local_8:* = 200;
            var _local_9:int = (4 + (this.novaRadius_ * 2));
            while (_local_6 < _local_9)
            {
                _local_3 = (((_local_6 * 2) * Math.PI) / _local_9);
                _local_4 = new Point((this.start_.x + (this.novaRadius_ * Math.cos(_local_3))), (this.start_.y + (this.novaRadius_ * Math.sin(_local_3))));
                _local_5 = new SparkerParticle(_local_7, this.color_, _local_8, this.start_, _local_4);
                map_.addObj(_local_5, x_, y_);
                _local_6++;
            };
            return (false);
        }


    }
}//package com.company.assembleegameclient.objects.particles

