// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.list.DailyQuestsList

package io.decagames.rotmg.dailyQuests.view.list{
import flash.display.Sprite;

import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.scroll.UIScrollbar;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.tabs.TabButton;
import io.decagames.rotmg.ui.tabs.UITab;
import io.decagames.rotmg.ui.tabs.UITabs;
import io.decagames.rotmg.ui.texture.TextureParser;

public class DailyQuestsList extends Sprite {

    public static const LIST_WIDTH:int = 223;
    public static const SCROLL_WIDTH:int = 14;
    public static const SCROLL_TOP_MARGIN:int = 0;
    public static const SCROLL_RIGHT_MARGIN:int = 6;
    public static const QUEST_ELEMENTS_MARGIN:int = 9;
    public static const QUEST_ELEMENTS_LEFT_MARGIN:int = 5;
    public static const SCROLL_BAR_HEIGHT:int = 435;

    private var questLinesPosition:int = 0;
    private var eventLinesPosition:int = 0;
    private var questsContainer:Sprite;
    private var eventsContainer:Sprite;
    private var _tabs:UITabs;
    private var eventsTab:TabButton;
    private var contentTabs:SliceScalingBitmap;
    private var contentInset:SliceScalingBitmap;

    public function DailyQuestsList(){
        this.contentTabs = TextureParser.instance.getSliceScalingBitmap("UI", "tab_inset_content_background", 230);
        addChild(this.contentTabs);
        this.contentTabs.height = 45;
        this.contentTabs.x = 0;
        this.contentTabs.y = 0;
        this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", 230);
        addChild(this.contentInset);
        this.contentInset.height = 380;
        this.contentInset.x = 0;
        this.contentInset.y = 35;
        this._tabs = new UITabs(230, true);
        this._tabs.addTab(this.createQuestsTab(), true);
        this._tabs.addTab(this.createEventsTab());
        this._tabs.y = 1;
        this._tabs.x = 0;
        addChild(this._tabs);
    }

    private function createQuestsTab():UITab{
        var _local_1:UITab;
        var _local_2:Sprite;
        var _local_3:UIScrollbar;
        var _local_4:Sprite;
        _local_1 = new UITab("Quests");
        _local_2 = new Sprite();
        this.questsContainer = new Sprite();
        this.questsContainer.x = this.contentInset.x;
        this.questsContainer.y = 10;
        _local_2.addChild(this.questsContainer);
        _local_3 = new UIScrollbar(365);
        _local_3.mouseRollSpeedFactor = 1;
        _local_3.scrollObject = _local_1;
        _local_3.content = this.questsContainer;
        _local_2.addChild(_local_3);
        _local_3.x = ((this.contentInset.x + this.contentInset.width) - 25);
        _local_3.y = 7;
        _local_4 = new Sprite();
        _local_4.graphics.beginFill(0);
        _local_4.graphics.drawRect(0, 0, 230, 365);
        _local_4.x = this.questsContainer.x;
        _local_4.y = this.questsContainer.y;
        this.questsContainer.mask = _local_4;
        _local_2.addChild(_local_4);
        _local_1.addContent(_local_2);
        return (_local_1);
    }

    private function createEventsTab():UITab{
        var _local_1:UITab;
        var _local_4:Sprite;
        _local_1 = new UITab("Events");
        var _local_2:Sprite = new Sprite();
        this.eventsContainer = new Sprite();
        this.eventsContainer.x = this.contentInset.x;
        this.eventsContainer.y = 10;
        _local_2.addChild(this.eventsContainer);
        var _local_3:UIScrollbar = new UIScrollbar(365);
        _local_3.mouseRollSpeedFactor = 1;
        _local_3.scrollObject = _local_1;
        _local_3.content = this.eventsContainer;
        _local_2.addChild(_local_3);
        _local_3.x = ((this.contentInset.x + this.contentInset.width) - 25);
        _local_3.y = 7;
        _local_4 = new Sprite();
        _local_4.graphics.beginFill(0);
        _local_4.graphics.drawRect(0, 0, 230, 365);
        _local_4.x = this.eventsContainer.x;
        _local_4.y = this.eventsContainer.y;
        this.eventsContainer.mask = _local_4;
        _local_2.addChild(_local_4);
        _local_1.addContent(_local_2);
        return (_local_1);
    }

    public function addIndicator(_arg_1:Boolean):void{
        this.eventsTab = this._tabs.getTabButtonByLabel("Events");
        if (this.eventsTab){
            this.eventsTab.showIndicator = _arg_1;
            this.eventsTab.clickSignal.add(this.onEventsClick);
        }
    }

    private function onEventsClick(_arg_1:BaseButton):void{
        if (TabButton(_arg_1).hasIndicator){
            TabButton(_arg_1).showIndicator = false;
        }
    }

    public function addQuestToList(_arg_1:DailyQuestListElement):void{
        _arg_1.x = 10;
        _arg_1.y = (this.questLinesPosition * 35);
        this.questsContainer.addChild(_arg_1);
        this.questLinesPosition++;
    }

    public function addEventToList(_arg_1:DailyQuestListElement):void{
        _arg_1.x = 10;
        _arg_1.y = (this.eventLinesPosition * 35);
        this.eventsContainer.addChild(_arg_1);
        this.eventLinesPosition++;
    }

    public function get list():Sprite{
        return (this.questsContainer);
    }

    public function get tabs():UITabs{
        return (this._tabs);
    }


}
}//package io.decagames.rotmg.dailyQuests.view.list

