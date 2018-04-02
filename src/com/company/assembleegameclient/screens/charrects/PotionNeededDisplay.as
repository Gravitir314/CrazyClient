// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.screens.charrects.PotionNeededDisplay

package com.company.assembleegameclient.screens.charrects
{
import com.company.assembleegameclient.objects.ObjectLibrary;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class PotionNeededDisplay extends Sprite 
    {

        private var text:TextFieldDisplayConcrete;
        private var icon:DisplayObject;

        public function PotionNeededDisplay(_arg_1:int, _arg_2:int)
        {
            this.icon = this.getItemIcon(_arg_1);
            this.icon.y = -13;
            this.text = new TextFieldDisplayConcrete().setSize(20).setColor(0xB3B3B3);
            this.text.setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
            this.text.setStringBuilder(new StaticStringBuilder(_arg_2.toString()));
            this.text.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
            this.text.x = 52;
            addChild(this.text);
            addChild(this.icon);
        }

        private function getItemIcon(_arg_1:int):DisplayObject
        {
            return (new Bitmap(ObjectLibrary.getRedrawnTextureFromType(_arg_1, 60, true)));
        }


    }
}//package com.company.assembleegameclient.screens.charrects

