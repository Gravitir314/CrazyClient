// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.mysteryBox.contentPopup.MysteryBoxContentPopupMediator

package io.decagames.rotmg.shop.mysteryBox.contentPopup
{
import flash.utils.Dictionary;

import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.gird.UIGrid;
import io.decagames.rotmg.ui.popups.header.PopupHeader;
import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
import io.decagames.rotmg.ui.texture.TextureParser;

import robotlegs.bender.bundles.mvcs.Mediator;

public class MysteryBoxContentPopupMediator extends Mediator 
    {

        [Inject]
        public var view:MysteryBoxContentPopup;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        private var closeButton:SliceScalingButton;
        private var contentGrids:Vector.<UIGrid>;
        private var jackpotsNumber:int = 0;
        private var jackpotsHeight:int = 0;
        private var jackpotUI:JackpotContainer;


        override public function initialize():void
        {
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.addJackpots(this.view.info.jackpots);
            this.addContentList(this.view.info.contents, this.view.info.jackpots);
        }

        private function addJackpots(_arg_1:String):void
        {
            var _local_2:String;
            var _local_3:Array;
            var _local_4:Array;
            var _local_5:Array;
            var _local_6:String;
            var _local_7:int;
            var _local_8:UIGrid;
            var _local_9:UIItemContainer;
            var _local_10:Array = _arg_1.split("|");
            for each (_local_2 in _local_10)
            {
                _local_3 = _local_2.split(",");
                _local_4 = [];
                _local_5 = [];
                for each (_local_6 in _local_3)
                {
                    _local_7 = _local_4.indexOf(_local_6);
                    if (_local_7 == -1)
                    {
                        _local_4.push(_local_6);
                        _local_5.push(1);
                    }
                    else
                    {
                        _local_5[_local_7] = (_local_5[_local_7] + 1);
                    };
                };
                if (_arg_1.length > 0)
                {
                    _local_8 = new UIGrid(220, 5, 4);
                    _local_8.centerLastRow = true;
                    for each (_local_6 in _local_4)
                    {
                        _local_9 = new UIItemContainer(int(_local_6), 0x484848, 0, 40);
                        _local_9.showTooltip = true;
                        _local_8.addGridElement(_local_9);
                    };
                    this.jackpotUI = new JackpotContainer();
                    this.jackpotUI.x = 10;
                    this.jackpotUI.y = ((55 + this.jackpotsHeight) - 22);
                    this.jackpotUI.addGrid(_local_8);
                    this.view.addChild(this.jackpotUI);
                    this.jackpotsHeight = (this.jackpotsHeight + (this.jackpotUI.height + 5));
                    this.jackpotsNumber++;
                };
            };
        }

        private function addContentList(_arg_1:String, _arg_2:String):void
        {
            var _local_3:String;
            var _local_4:int;
            var _local_5:int;
            var _local_6:Array;
            var _local_7:Array;
            var _local_8:Array;
            var _local_9:String;
            var _local_10:Boolean;
            var _local_11:String;
            var _local_12:Array;
            var _local_13:Dictionary;
            var _local_14:String;
            var _local_15:UIGrid;
            var _local_16:Dictionary;
            var _local_17:Vector.<ItemBox>;
            var _local_19:ItemsSetBox;
            var _local_20:ItemBox;
            var _local_24:int;
            var _local_25:int;
            var _local_26:Number;
            var _local_18:* = null;
            var _local_21:Array = _arg_1.split("|");
            var _local_22:Array = _arg_2.split("|");
            var _local_23:Array = [];
            for each (_local_3 in _local_21)
            {
                _local_7 = [];
                _local_8 = _local_3.split(";");
                for each (_local_9 in _local_8)
                {
                    _local_10 = false;
                    for each (_local_11 in _local_22)
                    {
                        if (_local_11 == _local_9)
                        {
                            _local_10 = true;
                            break;
                        };
                    };
                    if (!_local_10)
                    {
                        _local_12 = _local_9.split(",");
                        _local_13 = new Dictionary();
                        for each (_local_14 in _local_12)
                        {
                            if (_local_13[_local_14])
                            {
                                _local_13[_local_14]++;
                            }
                            else
                            {
                                _local_13[_local_14] = 1;
                            };
                        };
                        _local_7.push(_local_13);
                    };
                };
                _local_23[_local_24] = _local_7;
                _local_24++;
            };
            _local_4 = (486 - 11);
            _local_5 = 30;
            if (this.jackpotsNumber > 0)
            {
                _local_4 = (_local_4 - (this.jackpotsHeight + 10));
                _local_5 = (_local_5 + (this.jackpotsHeight + 10));
            };
            this.contentGrids = new Vector.<UIGrid>(0);
            _local_25 = 5;
            _local_26 = ((260 - (_local_25 * (_local_23.length - 1))) / _local_23.length);
            for each (_local_6 in _local_23)
            {
                _local_15 = new UIGrid(_local_26, 1, 5);
                for each (_local_16 in _local_6)
                {
                    _local_17 = new Vector.<ItemBox>();
                    for (_local_18 in _local_16)
                    {
                        _local_20 = new ItemBox(_local_18, _local_16[_local_18], (_local_23.length == 1), "", false);
                        _local_20.clearBackground();
                        _local_17.push(_local_20);
                    };
                    _local_19 = new ItemsSetBox(_local_17);
                    _local_15.addGridElement(_local_19);
                };
                _local_15.y = _local_5;
                _local_15.x = ((10 + (_local_26 * this.contentGrids.length)) + (_local_25 * this.contentGrids.length));
                this.view.addChild(_local_15);
                this.contentGrids.push(_local_15);
            };
        }

        override public function destroy():void
        {
            var _local_1:UIGrid;
            this.closeButton.dispose();
            for each (_local_1 in this.contentGrids)
            {
                _local_1.dispose();
            };
            this.contentGrids = null;
        }

        private function onClose(_arg_1:BaseButton):void
        {
            this.closePopupSignal.dispatch(this.view);
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.contentPopup

