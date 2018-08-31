//com.company.assembleegameclient.ui.board.HelpBoard

package com.company.assembleegameclient.ui.board
{
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.ui.Scrollbar;
import com.company.rotmg.graphics.DeleteXGraphic;

import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class HelpBoard extends Frame
{

    private var closeDialogs:CloseDialogsSignal;
    private var deleteButton:Sprite;
    private var scrollBar:Scrollbar;
    private var container:HelpContainer;
    private var title:TextFieldDisplayConcrete;

    public function HelpBoard()
    {
        super("", "", "");
        this.closeDialogs = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
        w_ = 700;
        h_ = 550;
        this.container = new HelpContainer();
        addChild(this.container);
        this.createScrollbar();
        this.makeMask();
        this.makeDeleteButton();
    }

    private function createScrollbar():void
    {
        this.scrollBar = new Scrollbar(16, 510);
        this.scrollBar.x = 674;
        this.scrollBar.y = 32;
        this.scrollBar.setIndicatorSize(510, this.container.height);
        this.scrollBar.addEventListener(Event.CHANGE, this.onScrollBarChange);
        addChild(this.scrollBar);
    }

    private function onScrollBarChange(_arg_1:Event):void
    {
        this.container.setPos((-(this.scrollBar.pos()) * (this.container.height - 510)));
    }

    private function makeMask():void
    {
        var _local_1:Shape;
        _local_1 = new Shape();
        _local_1.x = -6;
        _local_1.y = -6;
        var _local_2:Graphics = _local_1.graphics;
        _local_2.beginFill(0);
        _local_2.drawRect(0, 0, 701, 551);
        _local_2.endFill();
        addChild(_local_1);
        mask = _local_1;
        _local_1 = new Shape();
        _local_1.y = 544;
        _local_2 = _local_1.graphics;
        _local_2.beginFill(0xFFFFFF);
        _local_2.drawRect(0, 0, 670, 1);
        _local_2.endFill();
        addChild(_local_1);
        _local_1 = new Shape();
        _local_1.y = -6;
        _local_2 = _local_1.graphics;
        _local_2.beginFill(0xFFFFFF);
        _local_2.drawRect(0, 0, 670, 1);
        _local_2.endFill();
        addChild(_local_1);
        _local_1 = new Shape();
        _local_1.y = 26;
        _local_1.x = -5;
        _local_2 = _local_1.graphics;
        _local_2.beginFill(0, (100 / 0xFF));
        _local_2.drawRect(0, 0, 699, 1);
        _local_2.endFill();
        addChild(_local_1);
        _local_1 = new Shape();
        _local_1.y = 27;
        _local_1.x = -5;
        _local_2 = _local_1.graphics;
        _local_2.beginFill(0, (50 / 0xFF));
        _local_2.drawRect(0, 0, 699, 1);
        _local_2.endFill();
        addChild(_local_1);
        _local_1 = new Shape();
        _local_1.y = 28;
        _local_1.x = -5;
        _local_2 = _local_1.graphics;
        _local_2.beginFill(0, (25 / 0xFF));
        _local_2.drawRect(0, 0, 699, 1);
        _local_2.endFill();
        addChild(_local_1);
        _local_1 = new Shape();
        _local_1.y = -5;
        _local_2 = _local_1.graphics;
        _local_2.beginFill(0x4D4D4D);
        _local_2.drawRect(0, 0, 670, 31);
        _local_2.endFill();
        addChild(_local_1);
    }

    private function makeDeleteButton():void
    {
        this.title = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3);
        this.title.setStringBuilder(new StaticStringBuilder("Commands"));
        this.title.filters = [new DropShadowFilter(0, 0, 0)];
        this.title.x = 5;
        this.title.y = 3;
        addChild(this.title);
        this.deleteButton = new DeleteXGraphic();
        this.deleteButton.addEventListener(MouseEvent.CLICK, this.onClose);
        this.deleteButton.x = 668;
        addChild(this.deleteButton);
    }

    private function onClose(_arg_1:MouseEvent):void
    {
        this.closeDialogs.dispatch();
    }


}
}//package com.company.assembleegameclient.ui.board
