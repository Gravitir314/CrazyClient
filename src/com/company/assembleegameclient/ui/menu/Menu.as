//com.company.assembleegameclient.ui.menu.Menu

package com.company.assembleegameclient.ui.menu
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.GraphicsUtil;
import com.company.util.RectangleUtil;

import flash.display.CapsStyle;
import flash.display.DisplayObjectContainer;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Rectangle;

import kabam.rotmg.ui.view.UnFocusAble;

public class Menu extends Sprite implements UnFocusAble
{

	private var background_:uint;
	private var outline_:uint;
	protected var yOffset:int;

	private var backgroundFill_:GraphicsSolidFill = new GraphicsSolidFill(0, 1);
	private var outlineFill_:GraphicsSolidFill = new GraphicsSolidFill(0, 1);
	private var lineStyle_:GraphicsStroke = new GraphicsStroke(1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, outlineFill_);
	private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
	private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_, backgroundFill_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];

	public function Menu(_arg_1:uint, _arg_2:uint)
	{
		this.background_ = _arg_1;
		this.outline_ = _arg_2;
		this.yOffset = 40;
		filters = [new DropShadowFilter(0, 0, 0, 1, 16, 16)];
		addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
	}

	protected function addOption(_arg_1:MenuOption):void
	{
		_arg_1.x = 8;
		_arg_1.y = this.yOffset;
		addChild(_arg_1);
		this.yOffset = (this.yOffset + 28);
	}

	protected function onAddedToStage(_arg_1:Event):void
	{
		this.draw();
		this.position();
		addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
	}

	protected function onRemovedFromStage(_arg_1:Event):void
	{
		removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
	}

	protected function onEnterFrame(_arg_1:Event):void
	{
		if (stage == null)
		{
			return;
		}
		var _local_2:Rectangle = getRect(stage);
		var _local_3:Number = RectangleUtil.pointDist(_local_2, stage.mouseX, stage.mouseY);
		if (_local_3 > 40)
		{
			this.remove();
		}
	}

	public function scaleParent(_arg_1:Boolean):void
	{
		var _local_2:DisplayObjectContainer;
		if ((this.parent is GameSprite))
		{
			_local_2 = this;
		}
		else
		{
			_local_2 = this.parent;
		}
		var _local_3:Number = (800 / stage.stageWidth);
		var _local_4:Number = (600 / stage.stageHeight);
		if (_arg_1 == true)
		{
			_local_2.scaleX = (_local_3 / _local_4);
			_local_2.scaleY = 1;
		}
		else
		{
			_local_2.scaleX = _local_3;
			_local_2.scaleY = _local_4;
		}
	}

	private function position():void
	{
		var _local_1:Number;
		var _local_2:Boolean = Parameters.data_.uiscale;
		var _local_3:Number = (((stage.stageWidth - 800) / 2) + stage.mouseX);
		_local_1 = (((stage.stageHeight - 600) / 2) + stage.mouseY);
		var _local_4:Number = (600 / stage.stageHeight);
		this.scaleParent(_local_2);
		if (_local_2)
		{
			_local_3 = (_local_3 * _local_4);
			_local_1 = (_local_1 * _local_4);
		}
		if (stage == null)
		{
			return;
		}
		if (((stage.mouseX + (0.5 * stage.stageWidth)) - 400) < (stage.stageWidth / 2))
		{
			x = (_local_3 + 12);
		}
		else
		{
			x = ((_local_3 - width) - 1);
		}
		if (x < 12)
		{
			x = 12;
		}
		if (((stage.mouseY + (0.5 * stage.stageHeight)) - 300) < (stage.stageHeight / 3))
		{
			y = (_local_1 + 12);
		}
		else
		{
			y = ((_local_1 - height) - 1);
		}
		if (y < 12)
		{
			y = 12;
		}
	}

	protected function onRollOut(_arg_1:Event):void
	{
		this.remove();
	}

	public function remove():void
	{
		if (parent != null)
		{
			parent.removeChild(this);
		}
	}

	protected function draw():void
	{
		this.backgroundFill_.color = this.background_;
		this.outlineFill_.color = this.outline_;
		graphics.clear();
		GraphicsUtil.clearPath(this.path_);
		GraphicsUtil.drawCutEdgeRect(-6, -6, Math.max(154, (width + 12)), (height + 12), 4, [1, 1, 1, 1], this.path_);
		graphics.drawGraphicsData(this.graphicsData_);
	}


}
}//package com.company.assembleegameclient.ui.menu

