// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.ui.view.PotionInventoryView

package kabam.rotmg.ui.view
{
import flash.display.Sprite;

import kabam.rotmg.ui.view.components.PotionSlotView;

public class PotionInventoryView extends Sprite
    {

        private static const LEFT_BUTTON_CUTS:Array = [1, 0, 0, 1];
        private static const RIGHT_BUTTON_CUTS:Array = [0, 1, 1, 0];
        private static const BUTTON_SPACE:int = 4;

        private const cuts:Array = [LEFT_BUTTON_CUTS, RIGHT_BUTTON_CUTS];

        public function PotionInventoryView()
        {
            var _local_1:PotionSlotView;
            var _local_2:int;
            super();
            while (_local_2 < 2)
            {
                _local_1 = new PotionSlotView(this.cuts[_local_2], _local_2);
                _local_1.x = (_local_2 * (PotionSlotView.BUTTON_WIDTH + BUTTON_SPACE));
                addChild(_local_1);
                _local_2++;
            };
        }

    }
}//package kabam.rotmg.ui.view

