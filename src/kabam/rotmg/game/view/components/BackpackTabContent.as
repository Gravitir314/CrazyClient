// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.game.view.components.BackpackTabContent

package kabam.rotmg.game.view.components
{
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;

import flash.display.Sprite;

import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.ui.model.TabStripModel;
import kabam.rotmg.ui.view.PotionInventoryView;

public class BackpackTabContent extends Sprite
    {

        private var backpackContent:Sprite = new Sprite();
        private var _backpack:InventoryGrid;
        private var backpackPotionsInventory:PotionInventoryView = new PotionInventoryView();

        public function BackpackTabContent(_arg_1:Player)
        {
            this.init(_arg_1);
            this.addChildren();
            this.positionChildren();
        }

        private function init(_arg_1:Player):void
        {
            this.backpackContent.name = TabStripModel.BACKPACK;
            this._backpack = new InventoryGrid(_arg_1, _arg_1, (GeneralConstants.NUM_EQUIPMENT_SLOTS + GeneralConstants.NUM_INVENTORY_SLOTS), true);
        }

        private function positionChildren():void
        {
            this.backpackContent.x = 7;
            this.backpackContent.y = 7;
            this.backpackPotionsInventory.y = (this._backpack.height + 4);
        }

        private function addChildren():void
        {
            this.backpackContent.addChild(this._backpack);
            this.backpackContent.addChild(this.backpackPotionsInventory);
            addChild(this.backpackContent);
        }

        public function get backpack():InventoryGrid
        {
            return (this._backpack);
        }


    }
}//package kabam.rotmg.game.view.components

