//io.decagames.rotmg.shop.packages.contentPopup.PackageBoxContentPopupMediator

package io.decagames.rotmg.shop.packages.contentPopup
{
import flash.utils.Dictionary;

import io.decagames.rotmg.shop.mysteryBox.contentPopup.ItemBox;
import io.decagames.rotmg.shop.mysteryBox.contentPopup.SlotBox;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.gird.UIGrid;
import io.decagames.rotmg.ui.popups.header.PopupHeader;
import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
import io.decagames.rotmg.ui.texture.TextureParser;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PackageBoxContentPopupMediator extends Mediator 
    {

        [Inject]
        public var view:PackageBoxContentPopup;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        private var closeButton:SliceScalingButton;
        private var contentGrids:UIGrid;


        override public function initialize():void
        {
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.addContentList(this.view.info.contents, this.view.info.charSlot, this.view.info.vaultSlot, this.view.info.gold);
        }

        private function addContentList(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            var _local_7:Array;
            var _local_8:Dictionary;
            var _local_9:String;
            var _local_10:String;
            var _local_11:ItemBox;
            var _local_12:SlotBox;
            var _local_13:SlotBox;
            var _local_14:SlotBox;
            var _local_5:int = 5;
            var _local_6:Number = (260 - _local_5);
            this.contentGrids = new UIGrid(_local_6, 1, 2);
            if (_arg_1 != "")
            {
                _local_7 = _arg_1.split(",");
                _local_8 = new Dictionary();
                for each (_local_9 in _local_7)
                {
                    if (_local_8[_local_9])
                    {
                        _local_8[_local_9]++;
                    }
                    else
                    {
                        _local_8[_local_9] = 1;
                    }
                }
                for (_local_10 in _local_8)
                {
                    _local_11 = new ItemBox(_local_10, _local_8[_local_10], true, "", false);
                    this.contentGrids.addGridElement(_local_11);
                }
            }
            if (_arg_2 > 0)
            {
                _local_12 = new SlotBox(SlotBox.CHAR_SLOT, _arg_2, true, "", false);
                this.contentGrids.addGridElement(_local_12);
            }
            if (_arg_3 > 0)
            {
                _local_13 = new SlotBox(SlotBox.VAULT_SLOT, _arg_3, true, "", false);
                this.contentGrids.addGridElement(_local_13);
            }
            if (_arg_4 > 0)
            {
                _local_14 = new SlotBox(SlotBox.GOLD_SLOT, _arg_4, true, "", false);
                this.contentGrids.addGridElement(_local_14);
            }
            this.contentGrids.y = (this.view.infoLabel.textHeight + 8);
            this.contentGrids.x = 10;
            this.view.addChild(this.contentGrids);
        }

        override public function destroy():void
        {
            this.closeButton.clickSignal.remove(this.onClose);
            this.closeButton.dispose();
            this.contentGrids.dispose();
            this.contentGrids = null;
        }

        private function onClose(_arg_1:BaseButton):void
        {
            this.closePopupSignal.dispatch(this.view);
        }


    }
}//package io.decagames.rotmg.shop.packages.contentPopup

