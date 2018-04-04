// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.list.DailyQuestsList

package io.decagames.rotmg.dailyQuests.view.list
{
import flash.display.Bitmap;
import flash.display.Sprite;

import io.decagames.rotmg.dailyQuests.assets.DailyQuestAssets;
import io.decagames.rotmg.dailyQuests.ui.scrollbar.DailyQuestListScrollbar;

public class DailyQuestsList extends Sprite 
    {

        public static const LIST_WIDTH:int = 223;
        public static const SCROLL_WIDTH:int = 14;
        public static const SCROLL_TOP_MARGIN:int = 0;
        public static const SCROLL_RIGHT_MARGIN:int = 6;
        public static const QUEST_ELEMENTS_MARGIN:int = 9;
        public static const QUEST_ELEMENTS_LEFT_MARGIN:int = 5;

        private var _scrollBar:DailyQuestListScrollbar;
        private var _list:Sprite;

        public function DailyQuestsList()
        {
            var _local_1:Bitmap;
            var _local_2:Bitmap;
            _local_1 = null;
            super();
            this._list = new Sprite();
            addChild(this._list);
            this._list.y = SCROLL_TOP_MARGIN;
            this._list.x = QUEST_ELEMENTS_LEFT_MARGIN;
            _local_1 = new DailyQuestAssets.DailyQuestsListHeader();
            _local_2 = new DailyQuestAssets.DailyQuestsListFooter();
            var _local_3:Sprite = new Sprite();
            _local_3.graphics.beginFill(0xFF0000);
            _local_3.graphics.drawRect(0, 0, LIST_WIDTH, (DailyQuestListScrollbar.SCROLL_BAR_HEIGHT + 15));
            _local_3.graphics.endFill();
            addChild(_local_3);
            _local_3.y = -8;
            this._list.mask = _local_3;
            addChild(_local_1);
            addChild(_local_2);
            _local_1.x = (_local_2.x = -3);
            _local_1.y = -10;
            _local_2.y = 350;
            this._scrollBar = new DailyQuestListScrollbar(DailyQuestListScrollbar.SCROLL_BAR_HEIGHT);
            this._scrollBar.x = ((LIST_WIDTH - SCROLL_WIDTH) - SCROLL_RIGHT_MARGIN);
            this._scrollBar.y = SCROLL_TOP_MARGIN;
            addChild(this._scrollBar);
            this._scrollBar.content = this._list;
        }

        public function addQuestToList(_arg_1:DailyQuestListElement):void
        {
            _arg_1.y = (this._list.height + ((this._list.numChildren == 0) ? 0 : QUEST_ELEMENTS_MARGIN));
            this._list.addChild(_arg_1);
        }

        public function get scrollBar():DailyQuestListScrollbar
        {
            return (this._scrollBar);
        }

        public function get list():Sprite
        {
            return (this._list);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.list

