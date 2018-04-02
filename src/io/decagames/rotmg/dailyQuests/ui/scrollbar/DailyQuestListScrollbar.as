// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.ui.scrollbar.DailyQuestListScrollbar

package io.decagames.rotmg.dailyQuests.ui.scrollbar
{
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Rectangle;

import io.decagames.rotmg.dailyQuests.assets.DailyQuestAssets;
import io.decagames.rotmg.utils.display.ScaleBitmap;

public class DailyQuestListScrollbar extends Sprite 
    {

        public static const SCROLL_BAR_HEIGHT:int = 357;
        public static const SCROLL_SLIDER_MINIMUM_HEIGHT:int = 30;
        public static const SCROLL_SLIDER_SCALE_FACTOR:Number = 0.5;

        private var _slider:Sprite;
        private var sliderScaler:ScaleBitmap;
        private var _content:DisplayObject;
        private var contentHeight:int;
        private var percent:Number;

        public function DailyQuestListScrollbar(_arg_1:int)
        {
            this.contentHeight = _arg_1;
            addChild(new DailyQuestAssets.DailyQuestsListScrollbarBackground());
            this._slider = new Sprite();
            this.sliderScaler = new ScaleBitmap(new DailyQuestAssets.DailyQuestsListScrollbarSlider().bitmapData);
            this.sliderScaler.scale9Grid = new Rectangle(0, 18, 15, 1);
            this.sliderScaler.height = SCROLL_BAR_HEIGHT;
            this._slider.addChild(this.sliderScaler);
            addChild(this._slider);
        }

        public function set content(_arg_1:DisplayObject):void
        {
            this._content = _arg_1;
            this.update();
        }

        public function update():void
        {
            var _local_1:int;
            if (this._content.height <= this.contentHeight)
            {
                this._slider.height = SCROLL_BAR_HEIGHT;
            }
            else
            {
                this.percent = ((this._content.height - this.contentHeight) / this.contentHeight);
                _local_1 = ((1 - (this.percent * SCROLL_SLIDER_SCALE_FACTOR)) * SCROLL_BAR_HEIGHT);
                if (_local_1 < SCROLL_SLIDER_MINIMUM_HEIGHT)
                {
                    _local_1 = SCROLL_SLIDER_MINIMUM_HEIGHT;
                };
                this._slider.height = _local_1;
            };
        }

        public function updatePosition(_arg_1:Number):void
        {
            this._slider.y = (this._slider.y + Math.round(_arg_1));
            if (this._slider.y < 0)
            {
                this._slider.y = 0;
            };
            var _local_2:int = (SCROLL_BAR_HEIGHT - this._slider.height);
            if (this._slider.y > _local_2)
            {
                this._slider.y = _local_2;
            };
            this._content.y = -(Math.round((((this._content.height - this.contentHeight) * this._slider.y) / _local_2)));
        }

        public function get content():DisplayObject
        {
            return (this._content);
        }

        public function get slider():Sprite
        {
            return (this._slider);
        }


    }
}//package io.decagames.rotmg.dailyQuests.ui.scrollbar

