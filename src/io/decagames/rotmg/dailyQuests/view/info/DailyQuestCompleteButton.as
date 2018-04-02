// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.info.DailyQuestCompleteButton

package io.decagames.rotmg.dailyQuests.view.info
{
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import io.decagames.rotmg.dailyQuests.assets.DailyQuestAssets;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class DailyQuestCompleteButton extends Sprite 
    {

        public static const BUTTON_WIDTH:int = 149;

        private var _enabled:Boolean;
        private var _completed:Boolean;
        private var background:Bitmap;
        private var buttonLabel:TextFieldDisplayConcrete;


        private function createLabel():void
        {
            this.buttonLabel = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setBold(true).setTextWidth(BUTTON_WIDTH).setAutoSize(TextFieldAutoSize.CENTER).setHorizontalAlign(TextFormatAlign.CENTER);
            this.buttonLabel.setStringBuilder(new StaticStringBuilder(((this._completed) ? "Completed" : "Complete!")));
            this.buttonLabel.y = 7;
            this.buttonLabel.x = 0;
            addChild(this.buttonLabel);
        }

        public function set enabled(_arg_1:Boolean):void
        {
            this._enabled = _arg_1;
        }

        public function set completed(_arg_1:Boolean):void
        {
            this._completed = _arg_1;
        }

        private function safetyRemove(_arg_1:DisplayObject):void
        {
            if (((_arg_1) && (_arg_1.parent)))
            {
                removeChild(_arg_1);
            };
        }

        public function draw():void
        {
            var _local_1:Class;
            this.safetyRemove(this.buttonLabel);
            this.safetyRemove(this.background);
            if (!this._completed)
            {
                _local_1 = ((this._enabled) ? DailyQuestAssets.DailyQuestsCompleteButtonOn : DailyQuestAssets.DailyQuestsCompleteButtonOff);
                this.background = new (_local_1)();
                addChildAt(this.background, 0);
            };
            this.createLabel();
        }

        public function get enabled():Boolean
        {
            return (this._enabled);
        }

        public function get completed():Boolean
        {
            return (this._completed);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.info

