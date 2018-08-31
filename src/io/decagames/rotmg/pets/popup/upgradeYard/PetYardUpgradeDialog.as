//io.decagames.rotmg.pets.popup.upgradeYard.PetYardUpgradeDialog

package io.decagames.rotmg.pets.popup.upgradeYard
{
import com.company.assembleegameclient.util.Currency;

import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
import io.decagames.rotmg.shop.ShopBuyButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.popups.modal.ModalPopup;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class PetYardUpgradeDialog extends ModalPopup 
    {

        private var _upgradeGoldButton:ShopBuyButton;
        private var _upgradeFameButton:ShopBuyButton;
        private var upgradeButtonsMargin:int = 20;

        public function PetYardUpgradeDialog(_arg_1:PetRarityEnum, _arg_2:int, _arg_3:int)
        {
            var _local_4:SliceScalingBitmap;
            var _local_5:UILabel;
            var _local_6:UILabel;
            super(270, 0, "Upgrade Pet Yard");
            _local_4 = TextureParser.instance.getSliceScalingBitmap("UI", ("petYard_" + LineBuilder.getLocalizedStringFromKey((("{" + _arg_1.rarityKey) + "}"))));
            _local_4.x = Math.round(((contentWidth - _local_4.width) / 2));
            addChild(_local_4);
            _local_5 = new UILabel();
            DefaultLabelFormat.petYardUpgradeInfo(_local_5);
            _local_5.x = 50;
            _local_5.y = (_local_4.height + 10);
            _local_5.width = 170;
            _local_5.wordWrap = true;
            _local_5.text = LineBuilder.getLocalizedStringFromKey("YardUpgraderView.info");
            addChild(_local_5);
            _local_6 = new UILabel();
            DefaultLabelFormat.petYardUpgradeRarityInfo(_local_6);
            _local_6.y = ((_local_5.y + _local_5.textHeight) + 8);
            _local_6.width = contentWidth;
            _local_6.wordWrap = true;
            _local_6.text = LineBuilder.getLocalizedStringFromKey((("{" + _arg_1.rarityKey) + "}"));
            addChild(_local_6);
            this._upgradeGoldButton = new ShopBuyButton(_arg_2, Currency.GOLD);
            this._upgradeFameButton = new ShopBuyButton(_arg_3, Currency.FAME);
            this._upgradeGoldButton.width = (this._upgradeFameButton.width = 120);
            this._upgradeGoldButton.y = (this._upgradeFameButton.y = ((_local_6.y + _local_6.height) + 15));
            var _local_7:int = int(((contentWidth - ((this._upgradeGoldButton.width + this._upgradeFameButton.width) + this.upgradeButtonsMargin)) / 2));
            this._upgradeGoldButton.x = _local_7;
            this._upgradeFameButton.x = ((this._upgradeGoldButton.x + this._upgradeGoldButton.width) + this.upgradeButtonsMargin);
            addChild(this._upgradeGoldButton);
            addChild(this._upgradeFameButton);
        }

        public function get upgradeGoldButton():ShopBuyButton
        {
            return (this._upgradeGoldButton);
        }

        public function get upgradeFameButton():ShopBuyButton
        {
            return (this._upgradeFameButton);
        }


    }
}//package io.decagames.rotmg.pets.popup.upgradeYard

