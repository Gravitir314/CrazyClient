//com.company.assembleegameclient.objects.particles.ParticleGenerator

package com.company.assembleegameclient.objects.particles
{
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;

public class ParticleGenerator extends ParticleEffect 
    {

        private var particlePool:Vector.<BaseParticle>;
        private var liveParticles:Vector.<BaseParticle>;
        private var targetGO:GameObject;
        private var generatedParticles:Number = 0;
        private var totalTime:Number = 0;
        private var effectProps:EffectProperties;
        private var bitmapData:BitmapData;
        private var friction:Number;

        public function ParticleGenerator(_arg_1:EffectProperties, _arg_2:GameObject)
        {
            this.targetGO = _arg_2;
            this.particlePool = new Vector.<BaseParticle>();
            this.liveParticles = new Vector.<BaseParticle>();
            this.effectProps = _arg_1;
            if (this.effectProps.bitmapFile)
            {
                this.bitmapData = AssetLibrary.getImageFromSet(this.effectProps.bitmapFile, this.effectProps.bitmapIndex);
                this.bitmapData = TextureRedrawer.redraw(this.bitmapData, this.effectProps.size, true, 0);
            }
            else
            {
                this.bitmapData = TextureRedrawer.redrawSolidSquare(this.effectProps.color, this.effectProps.size);
            }
        }

        public static function attachParticleGenerator(_arg_1:EffectProperties, _arg_2:GameObject):ParticleGenerator
        {
            return (new (ParticleGenerator)(_arg_1, _arg_2));
        }


        override public function update(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:Number;
            var _local_4:BaseParticle;
            var _local_5:BaseParticle;
            var _local_6:int;
            var _local_7:int;
            var _local_8:Number = (_arg_1 / 1000);
            _local_3 = (_arg_2 / 1000);
            if (this.targetGO.map_ == null)
            {
                return (false);
            }
            x_ = this.targetGO.x_;
            y_ = this.targetGO.y_;
            z_ = (this.targetGO.z_ + this.effectProps.zOffset);
            this.totalTime = (this.totalTime + _local_3);
            var _local_9:Number = (this.effectProps.rate * this.totalTime);
            var _local_10:int = (_local_9 - this.generatedParticles);
            while (_local_6 < _local_10)
            {
                if (this.particlePool.length)
                {
                    _local_4 = this.particlePool.pop();
                }
                else
                {
                    _local_4 = new BaseParticle(this.bitmapData);
                }
                _local_4.initialize((this.effectProps.life + (this.effectProps.lifeVariance * ((2 * Math.random()) - 1))), (this.effectProps.speed + (this.effectProps.speedVariance * ((2 * Math.random()) - 1))), (this.effectProps.speed + (this.effectProps.speedVariance * ((2 * Math.random()) - 1))), (this.effectProps.rise + (this.effectProps.riseVariance * ((2 * Math.random()) - 1))), z_);
                map_.addObj(_local_4, (x_ + (this.effectProps.rangeX * ((2 * Math.random()) - 1))), (y_ + (this.effectProps.rangeY * ((2 * Math.random()) - 1))));
                this.liveParticles.push(_local_4);
                _local_6++;
            }
            this.generatedParticles = (this.generatedParticles + _local_10);
            while (_local_7 < this.liveParticles.length)
            {
                _local_5 = this.liveParticles[_local_7];
                _local_5.timeLeft = (_local_5.timeLeft - _local_3);
                if (_local_5.timeLeft <= 0)
                {
                    this.liveParticles.splice(_local_7, 1);
                    map_.removeObj(_local_5.objectId_);
                    _local_7--;
                    this.particlePool.push(_local_5);
                }
                else
                {
                    _local_5.spdZ = (_local_5.spdZ + (this.effectProps.riseAcc * _local_3));
                    _local_5.x_ = (_local_5.x_ + (_local_5.spdX * _local_3));
                    _local_5.y_ = (_local_5.y_ + (_local_5.spdY * _local_3));
                    _local_5.z_ = (_local_5.z_ + (_local_5.spdZ * _local_3));
                }
                _local_7++;
            }
            return (true);
        }

        override public function removeFromMap():void
        {
            var _local_1:BaseParticle;
            for each (_local_1 in this.liveParticles)
            {
                map_.removeObj(_local_1.objectId_);
            }
            this.liveParticles = null;
            this.particlePool = null;
            super.removeFromMap();
        }


    }
}//package com.company.assembleegameclient.objects.particles

