// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.board.HelpElement

package com.company.assembleegameclient.ui.board
{
import flash.display.Sprite;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class HelpElement extends Sprite
    {

        private var title:TextFieldDisplayConcrete;
        private var content:TextFieldDisplayConcrete;

        public function HelpElement(_arg_1:String, _arg_2:String, _arg_3:int)
        {
            graphics.beginFill(0x545454);
            graphics.drawRoundRect(0, 0, 670, (36 + (_arg_3 * 12)), 8, 8);
            graphics.endFill();
            this.title = new TextFieldDisplayConcrete().setSize(16).setColor(0xB3B3B3).setBold(true);
            this.title.x = 5;
            this.title.y = 2;
            this.title.setStringBuilder(new StaticStringBuilder(_arg_1));
            this.title.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
            addChild(this.title);
            this.content = new TextFieldDisplayConcrete().setSize(12).setColor(0xB3B3B3);
            this.content.x = 5;
            this.content.y = 18;
            this.content.setStringBuilder(new StaticStringBuilder(_arg_2));
            this.content.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
            addChild(this.content);
        }

    }
}//package com.company.assembleegameclient.ui.board

