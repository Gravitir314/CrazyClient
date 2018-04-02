// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.mysteryBox.MysteryBoxTileMediator

package io.decagames.rotmg.shop.mysteryBox
{
import io.decagames.rotmg.shop.genericBox.BoxUtils;
import io.decagames.rotmg.shop.mysteryBox.contentPopup.MysteryBoxContentPopup;
import io.decagames.rotmg.shop.mysteryBox.rollModal.MysteryBoxRollModal;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.mysterybox.model.MysteryBoxInfo;

import robotlegs.bender.bundles.mvcs.Mediator;

public class MysteryBoxTileMediator extends Mediator
    {

        [Inject]
        public var view:MysteryBoxTile;
        [Inject]
        public var gameModel:GameModel;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var openDialogSignal:OpenDialogSignal;


        override public function initialize():void
        {
            this.view.spinner.valueWasChanged.add(this.changeAmountHandler);
            this.view.buyButton.clickSignal.add(this.onBuyHandler);
            this.view.infoButton.clickSignal.add(this.onInfoClick);
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
            };
        }

        private function onBuyHandler(_arg_1:BaseButton):void
        {
            var _local_2:Boolean = BoxUtils.moneyCheckPass(this.view.boxInfo, this.view.spinner.value, this.gameModel, this.playerModel, this.showPopupSignal);
            if (_local_2)
            {
                this.showPopupSignal.dispatch(new MysteryBoxRollModal(MysteryBoxInfo(this.view.boxInfo), this.view.spinner.value));
            };
        }

        private function onInfoClick(_arg_1:BaseButton):void
        {
            this.showPopupSignal.dispatch(new MysteryBoxContentPopup(MysteryBoxInfo(this.view.boxInfo)));
        }

        override public function destroy():void
        {
            this.view.spinner.valueWasChanged.remove(this.changeAmountHandler);
            this.view.buyButton.clickSignal.remove(this.onBuyHandler);
            this.view.infoButton.clickSignal.remove(this.onInfoClick);
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox

