// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.options.ChoiceOption

package com.company.assembleegameclient.ui.options
{
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.MoreColorUtil;

import flash.events.Event;

import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class ChoiceOption extends BaseOption
    {

        private var callback_:Function;
        private var choiceBox_:ChoiceBox;
        private var color:Number = 0xFFFFFF;
        private var showRed:Boolean = false;

        public function ChoiceOption(_arg_1:String, _arg_2:Vector.<StringBuilder>, _arg_3:Array, _arg_4:String, _arg_5:String, _arg_6:Function, _arg_7:Number=0xFFFFFF, _arg_8:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
            this.color = _arg_7;
            this.showRed = _arg_8;
            desc_.setColor(this.color);
            tooltip_.tipText_.setColor(0xFFFFFF);
            this.callback_ = _arg_6;
            this.choiceBox_ = new ChoiceBox(_arg_2, _arg_3, Parameters.data_[paramName_], this.color, this.showRed);
            this.choiceBox_.addEventListener(Event.CHANGE, this.onChange);
            addChild(this.choiceBox_);
        }

        public function enable(_arg_1:Boolean):void
        {
            transform.colorTransform = ((_arg_1) ? MoreColorUtil.darkCT : MoreColorUtil.identity);
            mouseEnabled = (!(_arg_1));
            mouseChildren = (!(_arg_1));
        }

        override public function refresh():void
        {
            this.choiceBox_.setValue(Parameters.data_[paramName_]);
        }

        public function refreshNoCallback():void
        {
            this.choiceBox_.setValue(Parameters.data_[paramName_], false);
        }

        private function onChange(_arg_1:Event):void
        {
            if (this.showRed)
            {
                this.color = ((this.color == 0xFFFFFF) ? 0xFF0000 : 0xFFFFFF);
                desc_.setColor(this.color);
            }
            Parameters.data_[paramName_] = this.choiceBox_.value();
            if (this.callback_ != null)
            {
                this.callback_();
            }
            Parameters.save();
        }


    }
}//package com.company.assembleegameclient.ui.options

