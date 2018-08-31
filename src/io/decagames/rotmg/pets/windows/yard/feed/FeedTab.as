//io.decagames.rotmg.pets.windows.yard.feed.FeedTab

package io.decagames.rotmg.pets.windows.yard.feed
{
import com.company.assembleegameclient.util.Currency;

import io.decagames.rotmg.pets.windows.yard.feed.items.FeedItem;
import io.decagames.rotmg.shop.ShopBuyButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.gird.UIGrid;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.tabs.UITab;

public class FeedTab extends UITab
    {

        private var feedGrid:UIGrid;
        private var _feedGoldButton:ShopBuyButton;
        private var _feedFameButton:ShopBuyButton;
        private var feedButtonsMargin:int = 20;
        private var feedLabel:UILabel;

        public function FeedTab(_arg_1:int)
        {
            var _local_2:int;
            super("Feed");
            this.feedLabel = new UILabel();
            DefaultLabelFormat.feedPetInfo(this.feedLabel);
            this.feedLabel.text = "Select Items to Feed";
            this.feedLabel.width = _arg_1;
            this.feedLabel.wordWrap = true;
            this.feedLabel.y = 102;
            addChild(this.feedLabel);
            this.feedGrid = new UIGrid((_arg_1 - 100), 4, 5);
            this.feedGrid.x = 50;
            this.feedGrid.y = 10;
            addChild(this.feedGrid);
            this._feedGoldButton = new ShopBuyButton(0, Currency.GOLD);
            this._feedFameButton = new ShopBuyButton(0, Currency.FAME);
            this._feedGoldButton.width = (this._feedFameButton.width = 100);
            this._feedGoldButton.y = (this._feedFameButton.y = 125);
            _local_2 = int(((_arg_1 - ((this._feedGoldButton.width + this._feedFameButton.width) + this.feedButtonsMargin)) / 2));
            this._feedGoldButton.x = _local_2;
            this._feedFameButton.x = ((this._feedGoldButton.x + this._feedGoldButton.width) + _local_2);
            addChild(this._feedGoldButton);
            addChild(this._feedFameButton);
        }

        public function updateFeedPower(_arg_1:int, _arg_2:Boolean):void
        {
            if (((_arg_1 == 0) || (_arg_2)))
            {
                this.feedLabel.text = ((_arg_2) ? "Fully Maxed" : "Select Items to Feed");
                this._feedGoldButton.alpha = 0;
                this._feedFameButton.alpha = 0;
            }
            else
            {
                this.feedLabel.text = ("Feed power: " + _arg_1);
                this._feedGoldButton.alpha = 1;
                this._feedFameButton.alpha = 1;
            }
            this._feedGoldButton.disabled = (_arg_1 == 0);
            this._feedFameButton.disabled = (_arg_1 == 0);
        }

        public function clearGrid():void
        {
            this.feedGrid.clearGrid();
        }

        public function addItem(_arg_1:FeedItem):void
        {
            this.feedGrid.addGridElement(_arg_1);
        }

        public function get feedGoldButton():ShopBuyButton
        {
            return (this._feedGoldButton);
        }

        public function get feedFameButton():ShopBuyButton
        {
            return (this._feedFameButton);
        }


    }
}//package io.decagames.rotmg.pets.windows.yard.feed

