// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.ui.view.CooldownTimer

package kabam.rotmg.ui.view
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;

import flash.display.Graphics;
import flash.display.Sprite;
import flash.utils.getTimer;

public class CooldownTimer extends Sprite
    {

        private var percentage:Number = 1;
        private var tper:Number = 0;
        private var circleToMask:Sprite;
        private var circleMask:Sprite;
        private var cd:int = 500;

        public function CooldownTimer()
        {
            this.circleToMask = new Sprite();
            this.circleToMask.graphics.beginFill(0, 0.7);
            this.circleToMask.graphics.drawRect(0, 0, 40, 40);
            this.circleToMask.graphics.endFill();
            addChild(this.circleToMask);
            this.circleMask = new Sprite();
            this.circleMask.x = 20;
            this.circleMask.y = 20;
            this.circleToMask.mask = this.circleMask;
            addChild(this.circleMask);
        }

        public function update(_arg_1:Player):void
        {
            var _local_2:XML;
            this.percentage = ((getTimer() - _arg_1.lastAltAttack_) / this.cd);
            if (this.percentage < 1)
            {
                this.circleMask.graphics.clear();
                this.circleMask.graphics.beginFill(0);
                this.drawPieMask(this.circleMask.graphics, this.percentage, (20 * Math.sqrt(2)), 0, 0, (-(Math.PI) / 2), 3);
                this.circleMask.graphics.endFill();
            }
            else
            {
                this.circleMask.graphics.clear();
                this.cd = 500;
                _local_2 = ObjectLibrary.xmlLibrary_[_arg_1.equipment_[1]];
                if (((!(_local_2 == null)) && (_local_2.hasOwnProperty("Cooldown"))))
                {
                    this.cd = (Number(_local_2.Cooldown) * 1000);
                    _arg_1.lastAltAttack_ = (getTimer() - this.cd);
                }
            }
        }

        private function drawPieMask(graphics:Graphics, p:Number, radius:Number, x:Number=0, y:Number=0, rotation:Number=0, sides:int=6):void
        {
            var i:int;
            p = (1 - p);
            graphics.moveTo(x, y);
            if (sides < 3)
            {
                sides = 3;
            }
            radius = (radius / Math.cos(((1 / sides) * Math.PI)));
            var lineToRadians:Function = function (_arg_1:Number):void
            {
                _arg_1 = (Math.PI - _arg_1);
                graphics.lineTo(((Math.cos(_arg_1) * radius) + x), ((Math.sin(_arg_1) * radius) + y));
            };
            var sidesToDraw:int = Math.floor((p * sides));
            while (i <= sidesToDraw)
            {
                (lineToRadians((((i / sides) * (Math.PI * 2)) + rotation)));
                i = (i + 1);
            }
            if ((p * sides) != sidesToDraw)
            {
                (lineToRadians(((p * (Math.PI * 2)) + rotation)));
            }
        }


    }
}//package kabam.rotmg.ui.view

