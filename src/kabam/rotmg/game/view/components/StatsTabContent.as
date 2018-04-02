// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.game.view.components.StatsTabContent

package kabam.rotmg.game.view.components
{
import flash.display.Sprite;

import kabam.rotmg.ui.model.TabStripModel;

public class StatsTabContent extends Sprite
    {

        private var stats:StatsView = new StatsView();

        public function StatsTabContent(_arg_1:uint)
        {
            this.init();
            this.positionChildren(_arg_1);
            this.addChildren();
        }

        private function addChildren():void
        {
            addChild(this.stats);
        }

        private function positionChildren(_arg_1:uint):void
        {
            this.stats.y = (((_arg_1 - TabConstants.TAB_TOP_OFFSET) / 2) - (this.stats.height / 2));
        }

        private function init():void
        {
            this.stats.name = TabStripModel.STATS;
        }


    }
}//package kabam.rotmg.game.view.components

