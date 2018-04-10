// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.mysteryBox.rollModal.elements.Spinner

package io.decagames.rotmg.shop.mysteryBox.rollModal.elements
{
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.getTimer;

import io.decagames.rotmg.utils.colors.RGB;
import io.decagames.rotmg.utils.colors.RandomColorGenerator;
import io.decagames.rotmg.utils.colors.Tint;

import kabam.rotmg.assets.EmbeddedAssets;

public class Spinner extends Sprite 
    {

        public const graphic:DisplayObject = new EmbeddedAssets.StarburstSpinner();

        private var _degreesPerSecond:int;
        private var secondsElapsed:Number;
        private var previousSeconds:Number;
        private var startColor:uint;
        private var endColor:uint;
        private var direction:Boolean;
        private var previousProgress:Number = 0;
        private var multicolor:Boolean;
        private var rStart:Number = -1;
        private var gStart:Number = -1;
        private var bStart:Number = -1;
        private var rFinal:Number = -1;
        private var gFinal:Number = -1;
        private var bFinal:Number = -1;

        public function Spinner(_arg_1:int, _arg_2:Boolean=false)
        {
            this._degreesPerSecond = _arg_1;
            this.multicolor = _arg_2;
            this.secondsElapsed = 0;
            this.setupStartAndFinalColors();
            this.addGraphic();
            this.applyColor(0);
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
        }

        private function addGraphic():void
        {
            addChild(this.graphic);
            this.graphic.x = ((-1 * width) / 2);
            this.graphic.y = ((-1 * height) / 2);
        }

        private function onRemoved(_arg_1:Event):void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }

        public function pause():void
        {
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.previousSeconds = 0;
        }

        public function resume():void
        {
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }

        private function onEnterFrame(_arg_1:Event):void
        {
            this.updateTimeElapsed();
            var _local_2:Number = ((this._degreesPerSecond * this.secondsElapsed) % 360);
            rotation = _local_2;
            this.applyColor((_local_2 / 360));
        }

        private function applyColor(_arg_1:Number):void
        {
            if (!this.multicolor)
            {
                return;
            }
            if (_arg_1 < this.previousProgress)
            {
                this.direction = (!(this.direction));
            }
            this.previousProgress = _arg_1;
            if (this.direction)
            {
                _arg_1 = (1 - _arg_1);
            }
            var _local_2:uint = this.getColorByProgress(_arg_1);
            Tint.add(this.graphic, _local_2, 1);
        }

        private function getColorByProgress(_arg_1:Number):uint
        {
            var _local_2:Number = (this.rStart + ((this.rFinal - this.rStart) * _arg_1));
            var _local_3:Number = (this.gStart + ((this.gFinal - this.gStart) * _arg_1));
            var _local_4:Number = (this.bStart + ((this.bFinal - this.bStart) * _arg_1));
            return (RGB.fromRGB(_local_2, _local_3, _local_4));
        }

        private function setupStartAndFinalColors():void
        {
            var _local_1:RandomColorGenerator = new RandomColorGenerator();
            var _local_2:Array = _local_1.randomColor();
            var _local_3:Array = _local_1.randomColor();
            this.rStart = _local_2[0];
            this.gStart = _local_2[1];
            this.bStart = _local_2[2];
            this.rFinal = _local_3[0];
            this.gFinal = _local_3[1];
            this.bFinal = _local_3[2];
        }

        private function updateTimeElapsed():void
        {
            var _local_1:Number = (getTimer() / 1000);
            if (this.previousSeconds)
            {
                this.secondsElapsed = (this.secondsElapsed + (_local_1 - this.previousSeconds));
            }
            this.previousSeconds = _local_1;
        }

        public function get degreesPerSecond():int
        {
            return (this._degreesPerSecond);
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.rollModal.elements

