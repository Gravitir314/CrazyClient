// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.packages.contentPopup.PackageBoxContentPopupMediator

package io.decagames.rotmg.shop.packages.contentPopup
{
import flash.utils.Dictionary;

import io.decagames.rotmg.shop.mysteryBox.contentPopup.ItemBox;
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
            this.addContentList(this.view.info.contents);
        }

        private function addContentList(_arg_1:String):void
        {
            var _local_2:String;
            var _local_3:int;
            var _local_6:ItemBox;
            var _local_4:Number = NaN;
            var _local_5:* = null;
            var _local_7:Array = _arg_1.split(",");
            var _local_8:Dictionary = new Dictionary();
            for each (_local_2 in _local_7)
            {
                if (_local_8[_local_2])
                {
                    _local_8[_local_2]++;
                }
                else
                {
                    _local_8[_local_2] = 1;
                };
            };
            _local_3 = 5;
            _local_4 = (260 - _local_3);
            this.contentGrids = new UIGrid(_local_4, 1, 2);
            for (_local_5 in _local_8)
            {
                _local_6 = new ItemBox(_local_5, _local_8[_local_5], true, "", false);
                this.contentGrids.addGridElement(_local_6);
            };
            this.contentGrids.y = 20;
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

