// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.JitterWatcher

package kabam.rotmg.messaging.impl
{
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.utils.getTimer;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class JitterWatcher extends Sprite
    {

        private static const lineBuilder:LineBuilder = new LineBuilder();

        private var text_:TextFieldDisplayConcrete = null;
        private var lastRecord_:int = -1;
        private var ticks_:Vector.<int> = new Vector.<int>();
        private var sum_:int;

        public function JitterWatcher()
        {
            this.text_ = new TextFieldDisplayConcrete().setSize(14).setColor(0xFFFFFF);
            this.text_.setAutoSize(TextFieldAutoSize.LEFT);
            this.text_.filters = [new DropShadowFilter(0, 0, 0)];
            addChild(this.text_);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        public function record():void
        {
            var _local_1:int;
            var _local_2:int = getTimer();
            if (this.lastRecord_ == -1)
            {
                this.lastRecord_ = _local_2;
                return;
            }
            var _local_3:int = (_local_2 - this.lastRecord_);
            this.ticks_.push(_local_3);
            this.sum_ = (this.sum_ + _local_3);
            if (this.ticks_.length > 50)
            {
                _local_1 = this.ticks_.shift();
                this.sum_ = (this.sum_ - _local_1);
            }
            this.lastRecord_ = _local_2;
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            stage.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }

        private function onEnterFrame(_arg_1:Event):void
        {
            this.text_.setStringBuilder(lineBuilder.setParams(TextKey.JITTERWATCHER_DESC, {"jitter":this.jitter()}));
        }

        private function jitter():Number
        {
            var _local_1:int;
            var _local_2:int = this.ticks_.length;
            if (_local_2 == 0)
            {
                return (0);
            }
            var _local_3:Number = (this.sum_ / _local_2);
            var _local_4:Number = 0;
            for each (_local_1 in this.ticks_)
            {
                _local_4 = (_local_4 + ((_local_1 - _local_3) * (_local_1 - _local_3)));
            }
            return (this.trim(Math.sqrt((_local_4 / _local_2)), 2));
        }

        private function trim(_arg_1:Number, _arg_2:Number):Number
        {
            var _local_3:Number;
            if (_arg_2 >= 0)
            {
                _local_3 = Math.pow(10, _arg_2);
                return (Math.round((_arg_1 * _local_3)) / _local_3);
            }
            return (_arg_1);
        }


    }
}//package kabam.rotmg.messaging.impl

