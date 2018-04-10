// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.list.DailyQuestListElement

package io.decagames.rotmg.dailyQuests.view.list
{
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.filters.BitmapFilterQuality;
import flash.filters.DropShadowFilter;

import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class DailyQuestListElement extends Sprite 
    {

        private var _id:String;
        private var _questName:String;
        private var _completed:Boolean;
        private var selectedBorder:Sprite;
        private var _isSelected:Boolean;
        private var ready:Boolean;
        private var background:SliceScalingBitmap;
        private var icon:Bitmap;
        private var questNameTextfield:UILabel;
        private var category:int;

        public function DailyQuestListElement(_arg_1:String, _arg_2:String, _arg_3:Boolean, _arg_4:Boolean, _arg_5:int)
        {
            this._id = _arg_1;
            this._questName = _arg_2;
            this._completed = _arg_3;
            this.ready = _arg_4;
            this.category = _arg_5;
            this.setElements();
        }

        public function set isSelected(_arg_1:Boolean):void
        {
            this._isSelected = _arg_1;
            this.draw();
        }

        private function setElements():void
        {
            this.selectedBorder = new Sprite();
            this.background = TextureParser.instance.getSliceScalingBitmap("UI", "daily_quest_list_element_grey", 190);
            this.icon = TextureParser.instance.getTexture("UI", "daily_quest_list_element_available_icon");
            this.background.height = 30;
            this.icon.x = 5;
            this.icon.y = 5;
            this.questNameTextfield = new UILabel();
            DefaultLabelFormat.questNameListLabel(this.questNameTextfield, ((this.category == 3) ? 2201331 : (((this._completed) || (this._isSelected)) ? 0xFFFFFF : 0xCFCFCF)));
            this.questNameTextfield.filters = [new DropShadowFilter(1, 90, 0, 1, 2, 2), new DropShadowFilter(0, 90, 0, 0.4, 4, 4, 1, BitmapFilterQuality.HIGH)];
            this.questNameTextfield.text = this._questName;
            this.questNameTextfield.x = 24;
            this.questNameTextfield.y = 7;
            addChild(this.background);
            addChild(this.icon);
            addChild(this.questNameTextfield);
            this.draw();
        }

        private function draw():void{
            removeChild(this.icon);
            removeChild(this.background);
            if (this._completed){
                this.icon = TextureParser.instance.getTexture("UI", "daily_quest_list_element_complete_icon");
            } else {
                if (this.ready){
                    this.icon = TextureParser.instance.getTexture("UI", "daily_quest_list_element_ready_icon");
                } else {
                    this.icon = TextureParser.instance.getTexture("UI", "daily_quest_list_element_available_icon");
                }
            }
            this.icon.x = 5;
            this.icon.y = 5;
            if (this._isSelected){
                this.background = TextureParser.instance.getSliceScalingBitmap("UI", "daily_quest_list_element_orange", 190);
            } else {
                if (this._completed){
                    this.background = TextureParser.instance.getSliceScalingBitmap("UI", "daily_quest_list_element_green", 190);
                } else {
                    this.background = TextureParser.instance.getSliceScalingBitmap("UI", "daily_quest_list_element_grey", 190);
                }
            }
            DefaultLabelFormat.questNameListLabel(this.questNameTextfield, ((this.category == 3) ? 2201331 : (((this._completed) || (this._isSelected)) ? 0xFFFFFF : 0xCFCFCF)));
            this.questNameTextfield.alpha = (((this._completed) || (this._isSelected)) ? 1 : 0.5);
            this.background.height = 30;
            addChild(this.background);
            addChild(this.icon);
            addChild(this.questNameTextfield);
        }

        public function get id():String
        {
            return (this._id);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.list

