//io.decagames.rotmg.pets.windows.wardrobe.PetWardrobeWindowMediator

package io.decagames.rotmg.pets.windows.wardrobe
{
import com.company.assembleegameclient.ui.tooltip.TextToolTip;

import io.decagames.rotmg.pets.data.PetsModel;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.popups.header.PopupHeader;
import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.tooltips.HoverTooltipDelegate;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PetWardrobeWindowMediator extends Mediator 
    {

        [Inject]
        public var view:PetWardrobeWindow;
        [Inject]
        public var gameModel:GameModel;
        [Inject]
        public var openMoneyWindow:OpenMoneyWindowSignal;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        [Inject]
        public var petsModel:PetsModel;
        private var closeButton:SliceScalingButton;
        private var addButton:SliceScalingButton;
        private var contentBackground:SliceScalingBitmap;
        private var toolTip:TextToolTip = null;
        private var hoverTooltipDelegate:HoverTooltipDelegate;


        override public function initialize():void
        {
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.addButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "add_button"));
            this.view.header.setTitle("Wardrobe", 350, DefaultLabelFormat.defaultPopupTitle);
            this.view.header.showCoins(132).coinsAmount = this.gameModel.player.credits_;
            this.view.header.showFame(132).fameAmount = this.gameModel.player.fame_;
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.addButton.clickSignal.add(this.onAdd);
            this.view.header.addButton(this.addButton, PopupHeader.LEFT_BUTTON);
            this.contentBackground = TextureParser.instance.getSliceScalingBitmap("UI", "tab_cointainer_background_filled");
            this.contentBackground.width = 580;
            this.contentBackground.height = 445;
            this.view.contentContainer.addChildAt(this.contentBackground, 0);
            this.gameModel.player.creditsWereChanged.add(this.refreshCoins);
            this.gameModel.player.fameWasChanged.add(this.refreshFame);
            this.toolTip = new TextToolTip(0x363636, 0x9B9B9B, "Buy Gold", "Click to buy more Realm Gold!", 200);
            this.hoverTooltipDelegate = new HoverTooltipDelegate();
            this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
            this.hoverTooltipDelegate.setDisplayObject(this.addButton);
            this.hoverTooltipDelegate.tooltip = this.toolTip;
            this.view.renderCurrentPet();
            this.view.renderSelectedPet();
            this.view.renderCollection(this.petsModel.totalOwnedPetsSkins, this.petsModel.totalPetsSkins);
        }

        private function refreshCoins():void
        {
            this.view.header.showCoins(132).coinsAmount = this.gameModel.player.credits_;
        }

        private function refreshFame():void
        {
            this.view.header.showFame(132).fameAmount = this.gameModel.player.fame_;
        }

        private function onAdd(_arg_1:BaseButton):void
        {
            this.openMoneyWindow.dispatch();
        }

        override public function destroy():void
        {
            this.view.dispose();
            this.closeButton.dispose();
            this.addButton.dispose();
            this.gameModel.player.creditsWereChanged.remove(this.refreshCoins);
            this.gameModel.player.fameWasChanged.remove(this.refreshFame);
            this.toolTip = null;
            this.hoverTooltipDelegate.removeDisplayObject();
            this.hoverTooltipDelegate = null;
        }

        private function onClose(_arg_1:BaseButton):void
        {
            this.closePopupSignal.dispatch(this.view);
        }


    }
}//package io.decagames.rotmg.pets.windows.wardrobe

