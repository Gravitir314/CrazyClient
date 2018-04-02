// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.ui.BaseSimpleText

package com.company.ui
{
import flash.events.Event;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextLineMetrics;

import kabam.rotmg.text.model.FontModel_MyriadPro;

public class BaseSimpleText extends TextField
    {

        public static const MyriadPro:Class = FontModel_MyriadPro;

        public var inputWidth_:int;
        public var inputHeight_:int;
        public var actualWidth_:int;
        public var actualHeight_:int;

        public function BaseSimpleText(_arg_1:int, _arg_2:uint, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:int=0)
        {
            var _local_6:TextFormat;
            super();
            this.inputWidth_ = _arg_4;
            if (this.inputWidth_ != 0)
            {
                width = _arg_4;
            };
            this.inputHeight_ = _arg_5;
            if (this.inputHeight_ != 0)
            {
                height = _arg_5;
            };
            _local_6 = this.defaultTextFormat;
            Font.registerFont(MyriadPro);
            var _local_7:Font = new MyriadPro();
            embedFonts = true;
            _local_6.font = _local_7.fontName;
            _local_6.bold = false;
            _local_6.size = _arg_1;
            _local_6.color = _arg_2;
            defaultTextFormat = _local_6;
            if (_arg_3)
            {
                selectable = true;
                mouseEnabled = true;
                type = TextFieldType.INPUT;
                embedFonts = true;
                border = true;
                borderColor = _arg_2;
                setTextFormat(_local_6);
                addEventListener(Event.CHANGE, this.onChange);
            }
            else
            {
                selectable = false;
                mouseEnabled = false;
            };
        }

        public function setFont(_arg_1:String):void
        {
            var _local_2:TextFormat = defaultTextFormat;
            _local_2.font = _arg_1;
            defaultTextFormat = _local_2;
        }

        public function setSize(_arg_1:int):void
        {
            var _local_2:TextFormat = defaultTextFormat;
            _local_2.size = _arg_1;
            this.applyFormat(_local_2);
        }

        public function setColor(_arg_1:uint):void
        {
            var _local_2:TextFormat = defaultTextFormat;
            _local_2.color = _arg_1;
            this.applyFormat(_local_2);
        }

        public function setBold(_arg_1:Boolean):void
        {
            var _local_2:TextFormat = defaultTextFormat;
            _local_2.bold = _arg_1;
            this.applyFormat(_local_2);
        }

        public function setAlignment(_arg_1:String):void
        {
            var _local_2:TextFormat = defaultTextFormat;
            _local_2.align = _arg_1;
            this.applyFormat(_local_2);
        }

        public function setText(_arg_1:String):void
        {
            this.text = _arg_1;
        }

        public function setMultiLine(_arg_1:Boolean):void
        {
            multiline = _arg_1;
            wordWrap = _arg_1;
        }

        private function applyFormat(_arg_1:TextFormat):void
        {
            setTextFormat(_arg_1);
            defaultTextFormat = _arg_1;
        }

        private function onChange(_arg_1:Event):void
        {
            this.updateMetrics();
        }

        public function updateMetrics():void
        {
            var _local_1:TextLineMetrics;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            this.actualWidth_ = 0;
            this.actualHeight_ = 0;
            while (_local_4 < numLines)
            {
                _local_1 = getLineMetrics(_local_4);
                _local_2 = (_local_1.width + 4);
                _local_3 = (_local_1.height + 4);
                if (_local_2 > this.actualWidth_)
                {
                    this.actualWidth_ = _local_2;
                };
                this.actualHeight_ = (this.actualHeight_ + _local_3);
                _local_4++;
            };
            width = ((this.inputWidth_ == 0) ? this.actualWidth_ : this.inputWidth_);
            height = ((this.inputHeight_ == 0) ? this.actualHeight_ : this.inputHeight_);
        }

        public function useTextDimensions():void
        {
            width = ((this.inputWidth_ == 0) ? (textWidth + 4) : this.inputWidth_);
            height = ((this.inputHeight_ == 0) ? (textHeight + 4) : this.inputHeight_);
        }


    }
}//package com.company.ui

