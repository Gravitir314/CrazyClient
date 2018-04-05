// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.tooltip.RankToolTip

package com.company.assembleegameclient.ui.tooltip
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.ui.LineBreakDesign;
import com.company.assembleegameclient.util.FameUtil;
import com.company.rotmg.graphics.StarGraphic;

import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;
import flash.geom.Rectangle;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

public class RankToolTip extends ToolTip 
    {

        private static const PADDING_LEFT:int = 6;

        private var earnedText_:TextFieldDisplayConcrete;
        private var star_:StarGraphic;
        private var howToText_:TextFieldDisplayConcrete;
        private var lineBreak_:LineBreakDesign = new LineBreakDesign(100, 0x1C1C1C);

        public function RankToolTip(_arg_1:int)
        {
            super(0x363636, 1, 0xFFFFFF, 1);
            this.earnedText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3).setBold(true);
            this.earnedText_.setVerticalAlign(TextFieldDisplayConcrete.BOTTOM);
            this.earnedText_.setStringBuilder(new LineBuilder().setParams(TextKey.RANK_TOOL_TIP_EARNED, {"numStars":_arg_1}));
            this.earnedText_.filters = [new DropShadowFilter(0, 0, 0)];
            this.earnedText_.x = PADDING_LEFT;
            addChild(this.earnedText_);
            this.howToText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3);
            this.howToText_.setTextWidth(174);
            this.howToText_.setMultiLine(true).setWordWrap(true);
            this.howToText_.setStringBuilder(new LineBuilder().setParams(TextKey.RANK_TOOL_TIP_COMPLETING_CLASS_QUESTS));
            this.howToText_.filters = [new DropShadowFilter(0, 0, 0)];
            this.howToText_.x = PADDING_LEFT;
            this.howToText_.y = 30;
            addChild(this.howToText_);
            var _local_2:SignalWaiter = new SignalWaiter().push(this.earnedText_.textChanged).push(this.howToText_.textChanged);
            _local_2.complete.addOnce(this.textAdded);
        }

        private function textAdded():void
        {
            var _local_1:LegendLine;
            var _local_2:int;
            var _local_3:int;
            this.earnedText_.y = (this.earnedText_.height + 2);
            this.star_ = new StarGraphic();
            this.star_.transform.colorTransform = new ColorTransform((179 / 0xFF), (179 / 0xFF), (179 / 0xFF));
            var _local_4:Rectangle = this.earnedText_.getBounds(this);
            this.star_.x = (_local_4.right + 7);
            this.star_.y = (this.earnedText_.y - this.star_.height);
            addChild(this.star_);
            this.lineBreak_.x = PADDING_LEFT;
            this.lineBreak_.y = (height + 10);
            addChild(this.lineBreak_);
            _local_2 = (this.lineBreak_.y + 4);
            while (_local_3 < FameUtil.COLORS.length)
            {
                _local_1 = new LegendLine((_local_3 * ObjectLibrary.playerChars_.length), (((_local_3 + 1) * ObjectLibrary.playerChars_.length) - 1), FameUtil.COLORS[_local_3]);
                _local_1.x = PADDING_LEFT;
                _local_1.y = _local_2;
                addChild(_local_1);
                _local_2 = (_local_2 + _local_1.height);
                _local_3++;
            }
            _local_1 = new LegendLine(FameUtil.maxStars(), FameUtil.maxStars(), new ColorTransform());
            _local_1.x = PADDING_LEFT;
            _local_1.y = _local_2;
            addChild(_local_1);
            this.draw();
        }

        override public function draw():void
        {
            this.lineBreak_.setWidthColor((width - 10), 0x1C1C1C);
            super.draw();
        }


    }
}//package com.company.assembleegameclient.ui.tooltip

import com.company.rotmg.graphics.StarGraphic;

import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

class LegendLine extends Sprite 
{

    private var coloredStar_:StarGraphic;
    private var rangeText_:TextFieldDisplayConcrete;
    private var star_:StarGraphic;

    public function LegendLine(_arg_1:int, _arg_2:int, _arg_3:ColorTransform)
    {
        this.addColoredStar(_arg_3);
        this.addRangeText(_arg_1, _arg_2);
        this.addGreyStar();
    }

    public function addGreyStar():void
    {
        this.star_ = new StarGraphic();
        this.star_.transform.colorTransform = new ColorTransform((179 / 0xFF), (179 / 0xFF), (179 / 0xFF));
        addChild(this.star_);
    }

    public function addRangeText(_arg_1:int, _arg_2:int):void
    {
        this.rangeText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3);
        this.rangeText_.setVerticalAlign(TextFieldDisplayConcrete.BOTTOM);
        this.rangeText_.setStringBuilder(new StaticStringBuilder((": " + ((_arg_1 == _arg_2) ? _arg_1.toString() : ((_arg_1 + " - ") + _arg_2)))));
        this.rangeText_.setBold(true);
        filters = [new DropShadowFilter(0, 0, 0)];
        this.rangeText_.x = this.coloredStar_.width;
        this.rangeText_.y = this.coloredStar_.getBounds(this).bottom;
        this.rangeText_.textChanged.addOnce(this.positionGreyStar);
        addChild(this.rangeText_);
    }

    public function addColoredStar(_arg_1:ColorTransform):void
    {
        this.coloredStar_ = new StarGraphic();
        this.coloredStar_.transform.colorTransform = _arg_1;
        this.coloredStar_.y = 4;
        addChild(this.coloredStar_);
    }

    private function positionGreyStar():void
    {
        this.star_.x = (this.rangeText_.getBounds(this).right + 2);
        this.star_.y = 4;
    }


}


