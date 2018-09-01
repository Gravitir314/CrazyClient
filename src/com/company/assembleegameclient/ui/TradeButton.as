﻿//com.company.assembleegameclient.ui.TradeButton

package com.company.assembleegameclient.ui
{
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;
import flash.utils.getTimer;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class TradeButton extends BackgroundFilledText
{

	private const WAIT_TIME:int = 2999;

	public var statusBar_:Sprite;
	public var barMask_:Shape;
	public var myText:StaticTextDisplay;
	public var h_:int;
	private var barGraphicsData_:Vector.<IGraphicsData>;
	private var outlineGraphicsData_:Vector.<IGraphicsData>;
	public var lastResetTime_:int;
	public var state:int;
	private var lastState:int;

	public function TradeButton(_arg_1:int, _arg_2:int)
	{
		super(_arg_2);
		this.makeGraphics();
		this.lastResetTime_ = getTimer();
		this.myText = new StaticTextDisplay();
		this.myText.setAutoSize(TextFieldAutoSize.CENTER).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
		this.myText.setSize(_arg_1).setColor(0x363636).setBold(true);
		this.myText.setStringBuilder(new LineBuilder().setParams(TextKey.PLAYERMENU_TRADE));
		w_ = ((_arg_2 != 0) ? _arg_2 : (this.myText.width + 12));
		this.h_ = (this.myText.height + 8);
		this.myText.x = (w_ / 2);
		this.myText.y = (this.h_ / 2);
		GraphicsUtil.clearPath(path_);
		GraphicsUtil.drawCutEdgeRect(0, 0, w_, (this.myText.height + 8), 4, [1, 1, 1, 1], path_);
		this.statusBar_ = this.newStatusBar();
		addChild(this.statusBar_);
		addChild(this.myText);
		this.draw();
		addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
		addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
		addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
	}

	private function makeGraphics():void
	{
		var _local_1:GraphicsSolidFill = new GraphicsSolidFill(0xBFBFBF, 1);
		this.barGraphicsData_ = new <IGraphicsData>[_local_1, path_, GraphicsUtil.END_FILL];
		var _local_2:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
		var _local_3:GraphicsStroke = new GraphicsStroke(2, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, _local_2);
		this.outlineGraphicsData_ = new <IGraphicsData>[_local_3, path_, GraphicsUtil.END_STROKE];
	}

	private function setText(_arg_1:String):void
	{
		this.myText.setStringBuilder(new LineBuilder().setParams(_arg_1));
	}

	public function setState(_arg_1:int):void
	{
		this.lastResetTime_ = getTimer();
		this.state = _arg_1;
		this.draw();
	}

	private function draw():void
	{
		var _local_1:int = (getTimer() - this.lastResetTime_);
		switch (this.state)
		{
			case 0:
				if (this.lastState != 0)
				{
					this.statusBar_.visible = true;
					graphicsData_[0] = enabledFill_;
					this.setText("Trade");
				}
				if (_local_1 >= this.WAIT_TIME)
				{
					this.state = 1;
				}
				else
				{
					this.drawCountDown((_local_1 / this.WAIT_TIME));
				}
				break;
			case 1:
				if (this.lastState != 1)
				{
					this.statusBar_.visible = false;
					graphicsData_[0] = enabledFill_;
					this.setText("Trade");
				}
				break;
			case 2:
				if (this.lastState != 2)
				{
					this.statusBar_.visible = false;
					graphicsData_[0] = disabledFill_;
					this.setText("Waiting");
				}
				break;
			case 3:
				if (this.lastState != 2)
				{
					this.statusBar_.visible = false;
					graphicsData_[0] = disabledFill_;
					this.setText("Trade");
				}
				break;
		}
		this.lastState = this.state;
		graphics.clear();
		graphics.drawGraphicsData(graphicsData_);
	}

	private function onAddedToStage(_arg_1:Event):void
	{
		addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		this.setState(0);
		this.draw();
	}

	private function onRemovedFromStage(_arg_1:Event):void
	{
		removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
	}

	private function onEnterFrame(_arg_1:Event):void
	{
		this.draw();
	}

	private function onMouseOver(_arg_1:MouseEvent):void
	{
		enabledFill_.color = 16768133;
		this.draw();
	}

	private function onRollOut(_arg_1:MouseEvent):void
	{
		enabledFill_.color = 0xFFFFFF;
		this.draw();
	}

	private function newStatusBar():Sprite
	{
		var _local_1:Sprite = new Sprite();
		var _local_2:Sprite = new Sprite();
		var _local_3:Shape = new Shape();
		_local_3.graphics.clear();
		_local_3.graphics.drawGraphicsData(this.barGraphicsData_);
		_local_2.addChild(_local_3);
		this.barMask_ = new Shape();
		_local_2.addChild(this.barMask_);
		_local_2.mask = this.barMask_;
		_local_1.addChild(_local_2);
		var _local_4:Shape = new Shape();
		_local_4.graphics.clear();
		_local_4.graphics.drawGraphicsData(this.outlineGraphicsData_);
		_local_1.addChild(_local_4);
		return (_local_1);
	}

	private function drawCountDown(_arg_1:Number):void
	{
		this.barMask_.graphics.clear();
		this.barMask_.graphics.beginFill(0xBFBFBF);
		this.barMask_.graphics.drawRect((w_ * _arg_1), 0, (w_ - (w_ * _arg_1)), this.h_);
		this.barMask_.graphics.endFill();
	}


}
}//package com.company.assembleegameclient.ui

