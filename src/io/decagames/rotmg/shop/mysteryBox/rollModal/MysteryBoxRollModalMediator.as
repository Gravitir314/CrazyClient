// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.mysteryBox.rollModal.MysteryBoxRollModalMediator

package io.decagames.rotmg.shop.mysteryBox.rollModal
{
import com.company.assembleegameclient.objects.Player;

import flash.events.TimerEvent;
import flash.utils.Dictionary;
import flash.utils.Timer;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

import io.decagames.rotmg.shop.genericBox.BoxUtils;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.popups.header.PopupHeader;
import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
import io.decagames.rotmg.ui.texture.TextureParser;
import io.decagames.rotmg.utils.dictionary.DictionaryUtils;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.mysterybox.services.GetMysteryBoxesTask;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import robotlegs.bender.bundles.mvcs.Mediator;

public class MysteryBoxRollModalMediator extends Mediator 
    {

        [Inject]
        public var view:MysteryBoxRollModal;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var gameModel:GameModel;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var getMysteryBoxesTask:GetMysteryBoxesTask;
        private var boxConfig:Array;
        private var swapImageTimer:Timer = new Timer(80);
        private var totalRollDelay:int = 2000;
        private var nextRollDelay:int = 550;
        private var quantity:int = 1;
        private var requestComplete:Boolean;
        private var timerComplete:Boolean;
        private var rollNumber:int = 0;
        private var timeout:uint;
        private var rewardsList:Array = [];
        private var totalRewards:int = 0;
        private var closeButton:SliceScalingButton;
        private var totalRolls:int = 1;


        override public function initialize():void
        {
            this.configureRoll();
            this.swapImageTimer.addEventListener(TimerEvent.TIMER, this.swapItems);
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.boxConfig = this.parseBoxContents();
            this.quantity = this.view.quantity;
            this.playRollAnimation();
            this.sendRollRequest();
        }

        override public function destroy():void
        {
            this.closeButton.clickSignal.remove(this.onClose);
            this.closeButton.dispose();
            this.swapImageTimer.removeEventListener(TimerEvent.TIMER, this.swapItems);
            this.view.spinner.valueWasChanged.remove(this.changeAmountHandler);
            this.view.buyButton.clickSignal.remove(this.buyMore);
            this.view.finishedShowingResult.remove(this.onAnimationFinished);
            clearTimeout(this.timeout);
        }

        private function sendRollRequest():void
        {
            this.view.spinner.valueWasChanged.remove(this.changeAmountHandler);
            this.view.buyButton.clickSignal.remove(this.buyMore);
            this.closeButton.clickSignal.remove(this.onClose);
            this.requestComplete = false;
            this.timerComplete = false;
            var _local_1:Object = this.account.getCredentials();
            _local_1.boxId = this.view.info.id;
            if (this.view.info.isOnSale())
            {
                _local_1.quantity = this.quantity;
                _local_1.price = this.view.info.saleAmount;
                _local_1.currency = this.view.info.saleCurrency;
            }
            else
            {
                _local_1.quantity = this.quantity;
                _local_1.price = this.view.info.priceAmount;
                _local_1.currency = this.view.info.priceCurrency;
            }
            this.client.sendRequest("/account/purchaseMysteryBox", _local_1);
            this.client.complete.addOnce(this.onRollRequestComplete);
            this.timeout = setTimeout(this.showRewards, this.totalRollDelay);
        }

        private function showRewards():void
        {
            var _local_1:Dictionary;
            this.timerComplete = true;
            clearTimeout(this.timeout);
            if (this.requestComplete)
            {
                this.view.finishedShowingResult.add(this.onAnimationFinished);
                this.view.bigSpinner.pause();
                this.view.littleSpinner.pause();
                this.swapImageTimer.stop();
                _local_1 = this.rewardsList[this.rollNumber];
                if (this.rollNumber == 0)
                {
                    this.view.prepareResultGrid(this.totalRewards);
                }
                this.view.displayResult([_local_1]);
            }
        }

        private function onRollRequestComplete(_arg_1:Boolean, _arg_2:*):void
        {
            var _local_3:XML;
            var _local_4:XML;
            var _local_5:Player;
            var _local_6:Array;
            var _local_7:Dictionary;
            var _local_8:String;
            var _local_9:Array;
            var _local_10:int;
            var _local_11:Array;
            var _local_12:int;
            var _local_13:Array;
            this.requestComplete = true;
            if (_arg_1)
            {
                _local_3 = new XML(_arg_2);
                this.rewardsList = [];
                for each (_local_4 in _local_3.elements("Awards"))
                {
                    _local_6 = _local_4.toString().split(",");
                    _local_7 = this.convertItemsToAmountDictionary(_local_6);
                    this.totalRewards = (this.totalRewards + DictionaryUtils.countKeys(_local_7));
                    this.rewardsList.push(_local_7);
                }
                if (((_local_3.hasOwnProperty("Left")) && (!(this.view.info.unitsLeft == -1))))
                {
                    this.view.info.unitsLeft = int(_local_3.Left);
                }
                _local_5 = this.gameModel.player;
                if (_local_5 != null)
                {
                    if (_local_3.hasOwnProperty("Gold"))
                    {
                        _local_5.setCredits(int(_local_3.Gold));
                    }
                    else
                    {
                        if (_local_3.hasOwnProperty("Fame"))
                        {
                            _local_5.setFame(int(_local_3.Fame));
                        }
                    }
                }
                else
                {
                    if (this.playerModel != null)
                    {
                        if (_local_3.hasOwnProperty("Gold"))
                        {
                            this.playerModel.setCredits(int(_local_3.Gold));
                        }
                        else
                        {
                            if (_local_3.hasOwnProperty("Fame"))
                            {
                                this.playerModel.setFame(int(_local_3.Fame));
                            }
                        }
                    }
                }
                if (this.timerComplete)
                {
                    this.showRewards();
                }
            }
            else
            {
                clearTimeout(this.timeout);
                _local_8 = "MysteryBoxRollModal.pleaseTryAgainString";
                if (LineBuilder.getLocalizedStringFromKey(_arg_2) != "")
                {
                    _local_8 = _arg_2;
                }
                if (_arg_2.indexOf("MysteryBoxError.soldOut") >= 0)
                {
                    _local_9 = _arg_2.split("|");
                    if (_local_9.length == 2)
                    {
                        _local_10 = _local_9[1];
                        if (_local_10 == 0)
                        {
                            _local_8 = "MysteryBoxError.soldOutAll";
                        }
                        else
                        {
                            _local_8 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutLeft", {
                                "left":this.view.info.unitsLeft,
                                "box":((this.view.info.unitsLeft == 1) ? LineBuilder.getLocalizedStringFromKey("MysteryBoxError.box") : LineBuilder.getLocalizedStringFromKey("MysteryBoxError.boxes"))
                            });
                        }
                    }
                }
                if (_arg_2.indexOf("MysteryBoxError.maxPurchase") >= 0)
                {
                    _local_11 = _arg_2.split("|");
                    if (_local_11.length == 2)
                    {
                        _local_12 = _local_11[1];
                        if (_local_12 == 0)
                        {
                            _local_8 = "MysteryBoxError.maxPurchase";
                        }
                        else
                        {
                            _local_8 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.maxPurchaseLeft", {"left":_local_12});
                        }
                    }
                }
                if (_arg_2.indexOf("blockedForUser") >= 0)
                {
                    _local_13 = _arg_2.split("|");
                    if (_local_13.length == 2)
                    {
                        _local_8 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.blockedForUser", {"date":_local_13[1]});
                    }
                }
                this.showErrorMessage(_local_8);
            }
        }

        private function showErrorMessage(_arg_1:String):void
        {
            this.closePopupSignal.dispatch(this.view);
            this.showPopupSignal.dispatch(new ErrorModal(300, LineBuilder.getLocalizedStringFromKey("MysteryBoxRollModal.purchaseFailedString", {}), LineBuilder.getLocalizedStringFromKey(_arg_1, {})));
            this.getMysteryBoxesTask.clearLastRanBlock();
            this.getMysteryBoxesTask.start();
        }

        private function configureRoll():void
        {
            if (this.view.info.quantity > 1)
            {
                this.totalRollDelay = 1000;
            }
        }

        private function convertItemsToAmountDictionary(_arg_1:Array):Dictionary
        {
            var _local_3:String;
            var _local_2:Dictionary = new Dictionary();
            for each (_local_3 in _arg_1)
            {
                if (_local_2[_local_3])
                {
                    _local_2[_local_3]++;
                }
                else
                {
                    _local_2[_local_3] = 1;
                }
            }
            return (_local_2);
        }

        private function parseBoxContents():Array
        {
            var _local_4:String;
            var _local_5:Array;
            var _local_6:Array;
            var _local_7:String;
            var _local_1:Array = this.view.info.contents.split("|");
            var _local_2:Array = [];
            var _local_3:int;
            for each (_local_4 in _local_1)
            {
                _local_5 = [];
                _local_6 = _local_4.split(";");
                for each (_local_7 in _local_6)
                {
                    _local_5.push(this.convertItemsToAmountDictionary(_local_7.split(",")));
                }
                _local_2[_local_3] = _local_5;
                _local_3++;
            }
            this.totalRolls = _local_3;
            return (_local_2);
        }

        private function onAnimationFinished():void
        {
            this.rollNumber++;
            if (this.rollNumber < this.view.quantity)
            {
                this.playRollAnimation();
                this.timeout = setTimeout(this.showRewards, (this.view.totalAnimationTime(this.totalRolls) + this.nextRollDelay));
            }
            else
            {
                this.closeButton.clickSignal.addOnce(this.onClose);
                this.view.spinner.valueWasChanged.add(this.changeAmountHandler);
                this.view.spinner.value = this.view.quantity;
                this.view.showBuyButton();
                this.view.buyButton.clickSignal.add(this.buyMore);
            }
        }

        private function changeAmountHandler(_arg_1:int):void
        {
            if (this.view.info.isOnSale())
            {
                this.view.buyButton.price = (_arg_1 * int(this.view.info.saleAmount));
            }
            else
            {
                this.view.buyButton.price = (_arg_1 * int(this.view.info.priceAmount));
            }
        }

        private function buyMore(_arg_1:BaseButton):void
        {
            var _local_2:Boolean = BoxUtils.moneyCheckPass(this.view.info, this.view.spinner.value, this.gameModel, this.playerModel, this.showPopupSignal);
            if (_local_2)
            {
                this.rollNumber = 0;
                this.totalRewards = 0;
                this.view.buyMore(this.view.spinner.value);
                this.configureRoll();
                this.quantity = this.view.quantity;
                this.playRollAnimation();
                this.sendRollRequest();
            }
        }

        private function playRollAnimation():void
        {
            this.view.bigSpinner.resume();
            this.view.littleSpinner.resume();
            this.swapImageTimer.start();
            this.swapItems(null);
        }

        private function swapItems(_arg_1:TimerEvent):void
        {
            var _local_3:Array;
            var _local_4:int;
            var _local_2:Array = [];
            for each (_local_3 in this.boxConfig)
            {
                _local_4 = int(Math.floor((Math.random() * _local_3.length)));
                _local_2.push(_local_3[_local_4]);
            }
            this.view.displayItems(_local_2);
        }

        private function onClose(_arg_1:BaseButton):void
        {
            this.closePopupSignal.dispatch(this.view);
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.rollModal

