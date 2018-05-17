//io.decagames.rotmg.shop.mysteryBox.rollModal.MysteryBoxRollModal

package io.decagames.rotmg.shop.mysteryBox.rollModal
{
import com.company.assembleegameclient.map.ParticleModalMap;
import com.gskinner.motion.GTween;
import com.gskinner.motion.easing.Sine;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;
import flash.utils.Dictionary;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

import io.decagames.rotmg.shop.ShopBuyButton;
import io.decagames.rotmg.shop.mysteryBox.contentPopup.UIItemContainer;
import io.decagames.rotmg.shop.mysteryBox.rollModal.elements.Spinner;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.gird.UIGrid;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.popups.modal.ModalPopup;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.spinner.FixedNumbersSpinner;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.mysterybox.model.MysteryBoxInfo;

import org.osflash.signals.Signal;

public class MysteryBoxRollModal extends ModalPopup 
    {

        private const iconSize:Number = 80;

        private var spinnersContainer:Sprite = new Sprite();
        private var _quantity:int;
        private var _info:MysteryBoxInfo;
        private var itemsBitmap:Vector.<Bitmap>;
        private var rollGrid:UIGrid;
        private var resultGrid:UIGrid;
        private var maxInColumn:int = 5;
        private var elementMargin:int = 10;
        private var maxResultWidth:int;
        private var maxResultRows:int = 3;
        private var resultElementWidth:int;
        private var resultGridMargin:int = 10;
        private var spinnerTopMargin:int = 165;
        private var buyButtonBackground:SliceScalingBitmap;
        private var maxResultHeight:int = 135;
        private var buySectionContainer:Sprite;
        public var buyButton:ShopBuyButton;
        public var spinner:FixedNumbersSpinner;
        public var bigSpinner:Spinner;
        public var littleSpinner:Spinner;
        private var particleModalMap:ParticleModalMap;
        private var vaultInfo:UILabel;
        public var finishedShowingResult:Signal = new Signal();
        private var exposeDuration:Number = 0.4;
        private var exposeScale:Number = 1.5;
        private var movingDuration:Number = 0.2;
        private var movingDelay:Number = 0.1;
        private var buyButtonAnimationDuration:Number = 0.4;

        public function MysteryBoxRollModal(_arg_1:MysteryBoxInfo, _arg_2:int=1)
        {
            super(415, 530, _arg_1.title);
            this._quantity = _arg_2;
            this._info = _arg_1;
            this.itemsBitmap = new Vector.<Bitmap>();
            this.createSpinners();
            this.vaultInfo = new UILabel();
            DefaultLabelFormat.mysteryBoxVaultInfo(this.vaultInfo);
            this.vaultInfo.text = "Rewards will be placed in your Vault!";
            this.vaultInfo.y = 2;
            this.vaultInfo.x = ((contentWidth - this.vaultInfo.textWidth) / 2);
            addChild(this.vaultInfo);
            this.vaultInfo.alpha = 0;
            this.particleModalMap = new ParticleModalMap(ParticleModalMap.MODE_AUTO_UPDATE);
            addChild(this.particleModalMap);
            this.rollGrid = new UIGrid((this.maxInColumn * this.iconSize), this.maxInColumn, this.elementMargin);
            this.rollGrid.centerLastRow = true;
            this.addBuyButton();
        }

        public function totalAnimationTime(_arg_1:int):Number
        {
            return (((this.exposeDuration * 2) + this.movingDuration) + ((_arg_1 - 1) * this.movingDelay));
        }

        private function calculateElementSize(_arg_1:Point):int
        {
            var _local_2:int = int(Math.floor((this.maxResultHeight / _arg_1.y)));
            if ((_local_2 * _arg_1.x) > this.maxResultWidth)
            {
                _local_2 = int(Math.floor((this.maxResultWidth / _arg_1.x)));
            }
            if ((_local_2 * _arg_1.y) > this.maxResultHeight)
            {
                return (-1);
            }
            return (_local_2);
        }

        private function calculateGrid(_arg_1:int):Point
        {
            var _local_5:int;
            var _local_6:int;
            var _local_2:Point = new Point(11, 4);
            var _local_3:int = int.MIN_VALUE;
            if (_arg_1 >= (_local_2.x * _local_2.y))
            {
                return (_local_2);
            }
            var _local_4:int = 11;
            while (_local_4 >= 1)
            {
                _local_5 = 4;
                while (_local_5 >= 1)
                {
                    if ((((_local_4 * _local_5) >= _arg_1) && (((_local_4 - 1) * (_local_5 - 1)) < _arg_1)))
                    {
                        _local_6 = this.calculateElementSize(new Point(_local_4, _local_5));
                        if (_local_6 != -1)
                        {
                            if (_local_6 > _local_3)
                            {
                                _local_3 = _local_6;
                                _local_2 = new Point(_local_4, _local_5);
                            }
                            else
                            {
                                if (_local_6 == _local_3)
                                {
                                    if (((_local_2.x * _local_2.y) - _arg_1) > ((_local_4 * _local_5) - _arg_1))
                                    {
                                        _local_3 = _local_6;
                                        _local_2 = new Point(_local_4, _local_5);
                                    }
                                }
                            }
                        }
                    }
                    _local_5--;
                }
                _local_4--;
            }
            return (_local_2);
        }

        public function prepareResultGrid(_arg_1:int):void
        {
            this.maxResultWidth = (contentWidth - (2 * this.resultGridMargin));
            var _local_2:Point = this.calculateGrid(_arg_1);
            this.resultElementWidth = this.calculateElementSize(_local_2);
            this.resultGrid = new UIGrid((this.resultElementWidth * _local_2.x), _local_2.x, 0);
            this.resultGrid.x = (this.resultGridMargin + Math.round(((this.maxResultWidth - (this.resultElementWidth * _local_2.x)) / 2)));
            this.resultGrid.y = Math.round((330 + ((this.maxResultHeight - (this.resultElementWidth * _local_2.y)) / 2)));
            addChild(this.resultGrid);
        }

        public function buyMore(_arg_1:int):void
        {
            this._quantity = _arg_1;
            removeChild(this.resultGrid);
            this.hideBuyButton();
        }

        public function showBuyButton():void
        {
            new GTween(this.buySectionContainer, this.buyButtonAnimationDuration, {"alpha":1}, {"ease":Sine.easeIn});
            new GTween(this.vaultInfo, this.buyButtonAnimationDuration, {"alpha":1}, {"ease":Sine.easeIn});
        }

        private function hideBuyButton():void
        {
            new GTween(this.buySectionContainer, this.buyButtonAnimationDuration, {"alpha":0}, {"ease":Sine.easeOut});
            new GTween(this.vaultInfo, this.buyButtonAnimationDuration, {"alpha":0}, {"ease":Sine.easeOut});
        }

        private function addBuyButton():void
        {
            this.buySectionContainer = new Sprite();
            this.buySectionContainer.alpha = 0;
            this.spinner = new FixedNumbersSpinner(TextureParser.instance.getSliceScalingBitmap("UI", "spinner_up_arrow"), 0, new <int>[1, 2, 3, 5, 10], "x");
            if (this.info.isOnSale())
            {
                this.buyButton = new ShopBuyButton(this.info.saleAmount, this.info.saleCurrency);
            }
            else
            {
                this.buyButton = new ShopBuyButton(this.info.priceAmount, this.info.priceCurrency);
            }
            this.buyButton.width = 95;
            this.buyButtonBackground = TextureParser.instance.getSliceScalingBitmap("UI", "buy_button_background", (this.buyButton.width + 60));
            this.buySectionContainer.addChild(this.buyButtonBackground);
            this.buySectionContainer.addChild(this.spinner);
            this.buySectionContainer.addChild(this.buyButton);
            this.buySectionContainer.x = 100;
            this.buySectionContainer.y = (contentHeight - 45);
            this.buyButton.x = ((this.buyButtonBackground.width - this.buyButton.width) - 6);
            this.buyButton.y = 4;
            this.spinner.y = -2;
            this.spinner.x = 32;
            addChild(this.buySectionContainer);
            this.buySectionContainer.x = Math.round(((contentWidth - this.buySectionContainer.width) / 2));
        }

        private function animateGridElement(element:UIItemContainer, delay:Number, triggerEventOnEnd:Boolean):void
        {
            var resultGridElement:UIItemContainer;
            var timeout:uint;
            resultGridElement = new UIItemContainer(element.itemId, 0, 0, this.resultElementWidth);
            resultGridElement.alpha = 0;
            if (element.quantity > 1)
            {
                resultGridElement.showQuantityLabel(element.quantity);
            }
            resultGridElement.showTooltip = false;
            this.resultGrid.addGridElement(resultGridElement);
            var scale:Number = (this.resultElementWidth / this.iconSize);
            var newX:Number = (Math.abs(resultGridElement.x) + (this.resultGrid.x - this.rollGrid.x));
            var newY:Number = (Math.abs((element.y - resultGridElement.y)) + (this.resultGrid.y - this.rollGrid.y));
            var toPoint:Point = new Point(newX, newY);
            var tween1:GTween = new GTween(element, this.movingDuration, {
                "x":toPoint.x,
                "y":toPoint.y,
                "scaleX":scale,
                "scaleY":scale
            }, {"ease":Sine.easeIn});
            tween1.delay = delay;
            tween1.onComplete = function ():*
            {
                element.alpha = 0;
                resultGridElement.alpha = 1;
                resultGridElement.showTooltip = true;
                if (triggerEventOnEnd)
                {
                    finishedShowingResult.dispatch();
                }
            };
            timeout = setTimeout(function ():*
            {
                particleModalMap.doLightning(((rollGrid.x + element.x) + (element.width / 2)), ((rollGrid.y + element.y) + (element.height / 2)), ((resultGrid.x + resultGridElement.x) + (resultGridElement.width / 2)), ((resultGrid.y + resultGridElement.y) + (resultGridElement.height / 2)), 115, 15787660, movingDuration);
                clearTimeout(timeout);
            }, (delay + 0.2));
        }

        public function displayResult(items:Array):void
        {
            var elements:Vector.<UIItemContainer>;
            elements = this.displayItems(items);
            var resetTween:GTween = new GTween(this.rollGrid, this.exposeDuration, {
                "scaleX":1,
                "scaleY":1,
                "x":this.rollGrid.x,
                "y":this.rollGrid.y
            }, {"ease":Sine.easeIn});
            resetTween.beginning();
            resetTween.onComplete = function ():*
            {
                var _local_1:UIItemContainer;
                var _local_2:int;
                for each (_local_1 in elements)
                {
                    _local_2 = elements.indexOf(_local_1);
                    animateGridElement(_local_1, (_local_2 * movingDelay), (_local_2 == (elements.length - 1)));
                }
            };
            var blinkTween:GTween = new GTween(this.rollGrid, this.exposeDuration, {
                "x":(this.rollGrid.x - ((this.rollGrid.width * (this.exposeScale - 1)) / 2)),
                "y":(this.rollGrid.y - ((this.rollGrid.height * (this.exposeScale - 1)) / 2)),
                "scaleX":this.exposeScale,
                "scaleY":this.exposeScale
            }, {"ease":Sine.easeOut});
            blinkTween.nextTween = resetTween;
        }

        public function displayItems(_arg_1:Array):Vector.<UIItemContainer>
        {
            var _local_3:Dictionary;
            var _local_4:String;
            var _local_5:UIItemContainer;
            var _local_6:int;
            this.rollGrid.clearGrid();
            var _local_2:Vector.<UIItemContainer> = new Vector.<UIItemContainer>();
            for each (_local_3 in _arg_1)
            {
                for (_local_4 in _local_3)
                {
                    _local_5 = new UIItemContainer(int(_local_4), 0, 0, this.iconSize);
                    _local_6 = _local_3[_local_4];
                    if (_local_6 > 1)
                    {
                        _local_5.showQuantityLabel(_local_6);
                    }
                    _local_5.showTooltip = false;
                    _local_2.push(_local_5);
                    this.rollGrid.addGridElement(_local_5);
                }
            }
            this.rollGrid.render();
            if (!this.rollGrid.parent)
            {
                addChild(this.rollGrid);
            }
            this.rollGrid.x = (this.spinnersContainer.x - (this.rollGrid.width / 2));
            this.rollGrid.y = (this.spinnersContainer.y - (this.rollGrid.height / 2));
            return (_local_2);
        }

        private function createSpinners():void
        {
            this.bigSpinner = new Spinner(50, true);
            this.littleSpinner = new Spinner((this.bigSpinner.degreesPerSecond * 1.5), true);
            var _local_1:Number = 0.7;
            this.littleSpinner.width = (this.bigSpinner.width * _local_1);
            this.littleSpinner.height = (this.bigSpinner.height * _local_1);
            this.littleSpinner.alpha = (this.bigSpinner.alpha = 0.7);
            this.spinnersContainer.addChild(this.bigSpinner);
            this.spinnersContainer.addChild(this.littleSpinner);
            this.littleSpinner.pause();
            addChild(this.spinnersContainer);
            this.spinnersContainer.x = (contentWidth / 2);
            this.spinnersContainer.y = this.spinnerTopMargin;
        }

        override public function dispose():void
        {
            this.rollGrid.dispose();
            if (this.resultGrid)
            {
                this.resultGrid.dispose();
            }
            this.buyButtonBackground.dispose();
            this.buyButton.dispose();
            this.spinner.dispose();
            this.particleModalMap.dispose();
            this.finishedShowingResult.removeAll();
        }

        public function get quantity():int
        {
            return (this._quantity);
        }

        public function get info():MysteryBoxInfo
        {
            return (this._info);
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.rollModal

