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
            var _local_3:String;
            var _local_4:Array;
            var _local_5:Array;
            var _local_6:Array;
            var _local_7:String;
            var _local_8:int;
            var _local_9:UIGrid;
            var _local_10:UIItemContainer;
            var _local_11:int;
            var _local_2:Array = _arg_1.split("|");
            for each (_local_3 in _local_2)
            {
                _local_4 = _local_3.split(",");
                _local_5 = [];
                _local_6 = [];
                for each (_local_7 in _local_4)
                {
                    _local_8 = _local_5.indexOf(_local_7);
                    if (_local_8 == -1)
                    {
                        _local_5.push(_local_7);
                        _local_6.push(1);
                    }
                    else
                    {
                        _local_6[_local_8] = (_local_6[_local_8] + 1);
                    }
                }
                if (_arg_1.length > 0)
                {
                    _local_9 = new UIGrid(220, 5, 4);
                    _local_9.centerLastRow = true;
                    for each (_local_7 in _local_5)
                    {
                        _local_10 = new UIItemContainer(int(_local_7), 0x484848, 0, 40);
                        _local_10.showTooltip = true;
                        _local_9.addGridElement(_local_10);
                        _local_11 = _local_6[_local_5.indexOf(_local_7)];
                        if (_local_11 > 1)
                        {
                            _local_10.showQuantityLabel(_local_11);
                        }
                    }
                    this.jackpotUI = new JackpotContainer();
                    this.jackpotUI.x = 10;
                    this.jackpotUI.y = ((55 + this.jackpotsHeight) - 22);
                    if (this.jackpotsNumber == 0)
                    {
                        this.jackpotUI.diamondBackground();
                    }
                    else
                    {
                        if (this.jackpotsNumber == 1)
                        {
                            this.jackpotUI.goldBackground();
                        }
                        else
                        {
                            if (this.jackpotsNumber == 2)
                            {
                                this.jackpotUI.silverBackground();
                            }
                        }
                    }
                    this.jackpotUI.addGrid(_local_9);
                    this.view.addChild(this.jackpotUI);
                    this.jackpotsHeight = (this.jackpotsHeight + (this.jackpotUI.height + 5));
                    this.jackpotsNumber++;
                }
            }
        }

        private function addContentList(_arg_1:String, _arg_2:String):void
        {
            var _local_7:String;
            var _local_8:int;
            var _local_9:int;
            var _local_12:Array;
            var _local_13:Array;
            var _local_14:Array;
            var _local_15:String;
            var _local_16:Boolean;
            var _local_17:String;
            var _local_18:Array;
            var _local_19:Dictionary;
            var _local_20:String;
            var _local_21:UIGrid;
            var _local_22:Dictionary;
            var _local_23:Vector.<ItemBox>;
            var _local_24:String;
            var _local_25:ItemsSetBox;
            var _local_26:ItemBox;
            var _local_3:Array = _arg_1.split("|");
            var _local_4:Array = _arg_2.split("|");
            var _local_5:Array = [];
            var _local_6:int;
            for each (_local_7 in _local_3)
            {
                _local_13 = [];
                _local_14 = _local_7.split(";");
                for each (_local_15 in _local_14)
                {
                    _local_16 = false;
                    for each (_local_17 in _local_4)
                    {
                        if (_local_17 == _local_15)
                        {
                            _local_16 = true;
                            break;
                        }
                    }
                    if (!_local_16)
                    {
                        _local_18 = _local_15.split(",");
                        _local_19 = new Dictionary();
                        for each (_local_20 in _local_18)
                        {
                            if (_local_19[_local_20])
                            {
                                _local_19[_local_20]++;
                            }
                            else
                            {
                                _local_19[_local_20] = 1;
                            }
                        }
                        _local_13.push(_local_19);
                    }
                }
                _local_5[_local_6] = _local_13;
                _local_6++;
            }
            _local_8 = (486 - 11);
            _local_9 = 30;
            if (this.jackpotsNumber > 0)
            {
                _local_8 = (_local_8 - (this.jackpotsHeight + 10));
                _local_9 = (_local_9 + (this.jackpotsHeight + 10));
            }
            this.contentGrids = new Vector.<UIGrid>(0);
            var _local_10:int = 5;
            var _local_11:Number = ((260 - (_local_10 * (_local_5.length - 1))) / _local_5.length);
            for each (_local_12 in _local_5)
            {
                _local_21 = new UIGrid(_local_11, 1, 5);
                for each (_local_22 in _local_12)
                {
                    _local_23 = new Vector.<ItemBox>();
                    for (_local_24 in _local_22)
                    {
                        _local_26 = new ItemBox(_local_24, _local_22[_local_24], (_local_5.length == 1), "", false);
                        _local_26.clearBackground();
                        _local_23.push(_local_26);
                    }
                    _local_25 = new ItemsSetBox(_local_23);
                    _local_21.addGridElement(_local_25);
                }
                _local_21.y = _local_9;
                _local_21.x = ((10 + (_local_11 * this.contentGrids.length)) + (_local_10 * this.contentGrids.length));
                this.view.addChild(_local_21);
                this.contentGrids.push(_local_21);
            }
        }

        override public function destroy():void
        {
            var _local_1:UIGrid;
            this.closeButton.dispose();
            for each (_local_1 in this.contentGrids)
            {
                _local_1.dispose();
            }
            this.contentGrids = null;
        }

        private function onClose(_arg_1:BaseButton):void
        {
            this.closePopupSignal.dispatch(this.view);
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.contentPopup

