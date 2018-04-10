// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.mysteryBox.contentPopup.ItemsSetBox

package io.decagames.rotmg.shop.mysteryBox.contentPopup
{
import io.decagames.rotmg.ui.gird.UIGridElement;

public class ItemsSetBox extends UIGridElement 
    {

        private var items:Vector.<ItemBox>;

        public function ItemsSetBox(_arg_1:Vector.<ItemBox>)
        {
            var _local_3:ItemBox;
            super();
            this.items = _arg_1;
            var _local_2:int;
            for each (_local_3 in _arg_1)
            {
                _local_3.y = _local_2;
                addChild(_local_3);
                _local_2 = (_local_2 + _local_3.height);
            }
            this.drawBackground(260);
        }

        private function drawBackground(_arg_1:int):void
        {
            this.graphics.clear();
            this.graphics.lineStyle(1, 10915138);
            this.graphics.beginFill(0x2D2D2D);
            this.graphics.drawRect(0, 0, _arg_1, (this.items.length * 48));
            this.graphics.endFill();
        }

        override public function get height():Number
        {
            return (this.items.length * 48);
        }

        override public function resize(_arg_1:int, _arg_2:int=-1):void
        {
            this.drawBackground(_arg_1);
        }

        override public function dispose():void
        {
            var _local_1:ItemBox;
            for each (_local_1 in this.items)
            {
                _local_1.dispose();
            }
            this.items = null;
            super.dispose();
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.contentPopup

