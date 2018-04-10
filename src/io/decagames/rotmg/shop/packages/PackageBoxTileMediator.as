// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.packages.PackageBoxTileMediator

package io.decagames.rotmg.shop.packages
{
import com.company.assembleegameclient.objects.Player;

import flash.events.MouseEvent;

import io.decagames.rotmg.shop.PurchaseInProgressModal;
import io.decagames.rotmg.shop.genericBox.BoxUtils;
import io.decagames.rotmg.shop.packages.contentPopup.PackageBoxContentPopup;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.packages.model.PackageInfo;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PackageBoxTileMediator extends Mediator 
    {

        [Inject]
        public var view:PackageBoxTile;
        [Inject]
        public var gameModel:GameModel;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var openDialogSignal:OpenDialogSignal;
        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        private var inProgressModal:PurchaseInProgressModal;


        override public function initialize():void
        {
            this.view.spinner.valueWasChanged.add(this.changeAmountHandler);
            this.view.buyButton.clickSignal.add(this.onBuyHandler);
            if (this.view.infoButton)
            {
                this.view.infoButton.clickSignal.add(this.onInfoClick);
            }
            if (this.view.clickMask)
            {
                this.view.clickMask.addEventListener(MouseEvent.CLICK, this.onBoxClickHandler);
            }
        }

        private function onBoxClickHandler(_arg_1:MouseEvent):void
        {
            this.onInfoClick(null);
        }

        private function changeAmountHandler(_arg_1:int):void
        {
            if (this.view.boxInfo.isOnSale())
            {
                this.view.buyButton.price = (_arg_1 * int(this.view.boxInfo.saleAmount));
            }
            else
            {
                this.view.buyButton.price = (_arg_1 * int(this.view.boxInfo.priceAmount));
            }
        }

        private function onBuyHandler(_arg_1:BaseButton):void
        {
            var _local_2:Boolean = BoxUtils.moneyCheckPass(this.view.boxInfo, this.view.spinner.value, this.gameModel, this.playerModel, this.showPopupSignal);
            if (_local_2)
            {
                this.inProgressModal = new PurchaseInProgressModal();
                this.showPopupSignal.dispatch(this.inProgressModal);
                this.sendPurchaseRequest();
            }
        }

        private function sendPurchaseRequest():void
        {
            var _local_1:Object = this.account.getCredentials();
            _local_1.boxId = this.view.boxInfo.id;
            if (this.view.boxInfo.isOnSale())
            {
                _local_1.quantity = this.view.spinner.value;
                _local_1.price = this.view.boxInfo.saleAmount;
                _local_1.currency = this.view.boxInfo.saleCurrency;
            }
            else
            {
                _local_1.quantity = this.view.spinner.value;
                _local_1.price = this.view.boxInfo.priceAmount;
                _local_1.currency = this.view.boxInfo.priceCurrency;
            }
            this.client.sendRequest("/account/purchasePackage", _local_1);
            this.client.complete.addOnce(this.onRollRequestComplete);
        }

        private function onRollRequestComplete(_arg_1:Boolean, _arg_2:*):void
        {
            var _local_3:XML;
            var _local_4:Player;
            var _local_5:String;
            var _local_6:Array;
            var _local_7:int;
            var _local_8:Array;
            var _local_9:int;
            var _local_10:Array;
            if (_arg_1)
            {
                _local_3 = new XML(_arg_2);
                if (((_local_3.hasOwnProperty("Left")) && (!(this.view.boxInfo.unitsLeft == -1))))
                {
                    this.view.boxInfo.unitsLeft = int(_local_3.Left);
                }
                _local_4 = this.gameModel.player;
                if (_local_4 != null)
                {
                    if (_local_3.hasOwnProperty("Gold"))
                    {
                        _local_4.setCredits(int(_local_3.Gold));
                    }
                    else
                    {
                        if (_local_3.hasOwnProperty("Fame"))
                        {
                            _local_4.setFame(int(_local_3.Fame));
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
                this.closePopupSignal.dispatch(this.inProgressModal);
                this.showPopupSignal.dispatch(new PurchaseCompleteModal(PackageInfo(this.view.boxInfo).purchaseType));
            }
            else
            {
                _local_5 = "MysteryBoxRollModal.pleaseTryAgainString";
                if (LineBuilder.getLocalizedStringFromKey(_arg_2) != "")
                {
                    _local_5 = _arg_2;
                }
                if (_arg_2.indexOf("MysteryBoxError.soldOut") >= 0)
                {
                    _local_6 = _arg_2.split("|");
                    if (_local_6.length == 2)
                    {
                        _local_7 = _local_6[1];
                        if (_local_7 == 0)
                        {
                            _local_5 = "MysteryBoxError.soldOutAll";
                        }
                        else
                        {
                            _local_5 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutLeft", {
                                "left":this.view.boxInfo.unitsLeft,
                                "box":((this.view.boxInfo.unitsLeft == 1) ? LineBuilder.getLocalizedStringFromKey("MysteryBoxError.box") : LineBuilder.getLocalizedStringFromKey("MysteryBoxError.boxes"))
                            });
                        }
                    }
                }
                if (_arg_2.indexOf("MysteryBoxError.maxPurchase") >= 0)
                {
                    _local_8 = _arg_2.split("|");
                    if (_local_8.length == 2)
                    {
                        _local_9 = _local_8[1];
                        if (_local_9 == 0)
                        {
                            _local_5 = "MysteryBoxError.maxPurchase";
                        }
                        else
                        {
                            _local_5 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.maxPurchaseLeft", {"left":_local_9});
                        }
                    }
                }
                if (_arg_2.indexOf("blockedForUser") >= 0)
                {
                    _local_10 = _arg_2.split("|");
                    if (_local_10.length == 2)
                    {
                        _local_5 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.blockedForUser", {"date":_local_10[1]});
                    }
                }
                this.showErrorMessage(_local_5);
            }
        }

        private function showErrorMessage(_arg_1:String):void
        {
            this.closePopupSignal.dispatch(this.inProgressModal);
            this.showPopupSignal.dispatch(new ErrorModal(300, LineBuilder.getLocalizedStringFromKey("MysteryBoxRollModal.purchaseFailedString", {}), LineBuilder.getLocalizedStringFromKey(_arg_1, {}).replace("box", "package")));
        }

        private function onInfoClick(_arg_1:BaseButton):void
        {
            this.showPopupSignal.dispatch(new PackageBoxContentPopup(PackageInfo(this.view.boxInfo)));
        }

        override public function destroy():void
        {
            this.view.spinner.valueWasChanged.remove(this.changeAmountHandler);
            this.view.buyButton.clickSignal.remove(this.onBuyHandler);
            if (this.view.infoButton)
            {
                this.view.infoButton.clickSignal.remove(this.onInfoClick);
            }
            if (this.view.clickMask)
            {
                this.view.clickMask.removeEventListener(MouseEvent.CLICK, this.onBoxClickHandler);
            }
        }


    }
}//package io.decagames.rotmg.shop.packages

