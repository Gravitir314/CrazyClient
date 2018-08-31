//io.decagames.rotmg.pets.windows.yard.InteractionInfo

package io.decagames.rotmg.pets.windows.yard
{
import flash.display.Sprite;

import io.decagames.rotmg.pets.windows.yard.feed.FeedTab;
import io.decagames.rotmg.pets.windows.yard.fuse.FuseTab;
import io.decagames.rotmg.ui.gird.UIGrid;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.tabs.UITabs;
import io.decagames.rotmg.ui.texture.TextureParser;

public class InteractionInfo extends Sprite 
    {

        public static var INFO_WIDTH:int = 275;
        public static const INFO_HEIGHT:int = 207;

        private var contentInset:SliceScalingBitmap;
        private var contentTabs:SliceScalingBitmap;
        private var tabs:UITabs;
        private var feedGrid:UIGrid;

        public function InteractionInfo()
        {
            this.feedGrid = new UIGrid((INFO_WIDTH - 100), 4, 5);
            this.contentTabs = TextureParser.instance.getSliceScalingBitmap("UI", "tab_inset_content_background", INFO_WIDTH);
            addChild(this.contentTabs);
            this.contentTabs.height = 45;
            this.contentTabs.x = 0;
            this.contentTabs.y = 0;
            this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", INFO_WIDTH);
            addChild(this.contentInset);
            this.contentInset.height = (INFO_HEIGHT - 35);
            this.contentInset.x = 0;
            this.contentInset.y = 35;
            this.tabs = new UITabs(INFO_WIDTH, true);
            this.tabs.addTab(new FeedTab(275), true);
            this.tabs.addTab(new FuseTab(275), false);
            this.tabs.y = 1;
            this.tabs.x = 0;
            addChild(this.tabs);
        }

    }
}//package io.decagames.rotmg.pets.windows.yard

