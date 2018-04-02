// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.mysteryBox.contentPopup.JackpotContainer

package io.decagames.rotmg.shop.mysteryBox.contentPopup
{
import flash.display.Sprite;

import io.decagames.rotmg.ui.gird.UIGrid;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class JackpotContainer extends Sprite 
    {

        private var background:SliceScalingBitmap;
        private var grid:UIGrid;


        public function addGrid(_arg_1:UIGrid):void
        {
            this.grid = _arg_1;
            if (_arg_1.numberOfElement > 5)
            {
                this.background = TextureParser.instance.getSliceScalingBitmap("UI", "mystery_box_jackpot2");
            }
            else
            {
                this.background = TextureParser.instance.getSliceScalingBitmap("UI", "mystery_box_jackpot");
            };
            addChild(this.background);
            _arg_1.y = 30;
            if (_arg_1.numberOfElement <= 5)
            {
                _arg_1.x = Math.round(((this.background.width - ((_arg_1.numberOfElement * 40) + ((_arg_1.numberOfElement - 1) * 4))) / 2));
            }
            else
            {
                _arg_1.x = Math.round(((this.background.width - ((5 * 40) + (4 * 4))) / 2));
            };
            addChild(_arg_1);
        }

        public function dispose():void
        {
            this.background.dispose();
            this.grid.dispose();
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.contentPopup

