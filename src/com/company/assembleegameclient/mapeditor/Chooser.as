//com.company.assembleegameclient.mapeditor.Chooser

package com.company.assembleegameclient.mapeditor
{
import com.adobe.images.PNGEncoder;
import com.company.assembleegameclient.ui.Scrollbar;
import com.company.util.GraphicsUtil;

import flash.display.BitmapData;
import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.FileReference;
import flash.utils.ByteArray;

public class Chooser extends Sprite
{

	public static const WIDTH:int = 136;
	public static const HEIGHT:int = 430;
	public static const SCROLLBAR_WIDTH:int = 20;

	private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_, backgroundFill_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];

	public var layer_:int;
	public var selected_:Element;
	protected var elementContainer_:Sprite;
	protected var scrollBar_:Scrollbar;
	private var elements_:Vector.<Element> = new Vector.<Element>();
	private var outlineFill_:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
	private var lineStyle_:GraphicsStroke = new GraphicsStroke(1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, outlineFill_);
	private var backgroundFill_:GraphicsSolidFill = new GraphicsSolidFill(0x363636, 1);
	private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
	private var _hasBeenLoaded:Boolean;

	public function Chooser(_arg_1:int)
	{
		this.layer_ = _arg_1;
		this.init();
	}

	public function selectedType():int
	{
		return (this.selected_.type_);
	}

	public function setSelectedType(_arg_1:int):void
	{
		var _local_2:Element;
		for each (_local_2 in this.elements_)
		{
			if (_local_2.type_ == _arg_1)
			{
				this.setSelected(_local_2);
				return;
			}
		}
	}

	protected function addElement(_arg_1:Element):void
	{
		var _local_2:int = this.elements_.length;
		_arg_1.x = (((_local_2 % 2) == 0) ? 0 : (2 + Element.WIDTH));
		_arg_1.y = ((int((_local_2 / 2)) * Element.HEIGHT) + 6);
		this.elementContainer_.addChild(_arg_1);
		if (_local_2 == 0)
		{
			this.setSelected(_arg_1);
		}
		_arg_1.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
		this.elements_.push(_arg_1);
	}

	protected function removeElements():void
	{
		this.elementContainer_.removeChildren();
		if (!this.elements_)
		{
			this.elements_ = new Vector.<Element>();
		}
		else
		{
			this.cleanupElements();
		}
		this._hasBeenLoaded = false;
	}

	private function cleanupElements():void
	{
		var _local_2:Element;
		var _local_1:int = (this.elements_.length - 1);
		while (_local_1 >= 0)
		{
			_local_2 = this.elements_.pop();
			_local_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
			_local_1--;
		}
	}

	protected function setSelected(_arg_1:Element):void
	{
		if (this.selected_ != null)
		{
			this.selected_.setSelected(false);
		}
		this.selected_ = _arg_1;
		this.selected_.setSelected(true);
	}

	private function init():void
	{
		this.drawBackground();
		this.elementContainer_ = new Sprite();
		this.elementContainer_.x = 4;
		this.elementContainer_.y = 6;
		addChild(this.elementContainer_);
		this.scrollBar_ = new Scrollbar(SCROLLBAR_WIDTH, (HEIGHT - 8), 0.1, this);
		this.scrollBar_.x = ((WIDTH - SCROLLBAR_WIDTH) - 6);
		this.scrollBar_.y = 4;
		var _local_1:Shape = new Shape();
		_local_1.graphics.beginFill(0);
		_local_1.graphics.drawRect(0, 2, ((Chooser.WIDTH - SCROLLBAR_WIDTH) - 4), (Chooser.HEIGHT - 4));
		addChild(_local_1);
		this.elementContainer_.mask = _local_1;
		addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
	}

	private function downloadElement(_arg_1:Element):void
	{
		var _local_3:ByteArray;
		var _local_4:FileReference;
		var _local_2:BitmapData = _arg_1.objectBitmap;
		if (_local_2 != null)
		{
			_local_3 = PNGEncoder.encode(_arg_1.objectBitmap);
			_local_4 = new FileReference();
			_local_4.save(_local_3, (_arg_1.type_ + ".png"));
		}
	}

	private function drawBackground():void
	{
		GraphicsUtil.clearPath(this.path_);
		GraphicsUtil.drawCutEdgeRect(0, 0, WIDTH, HEIGHT, 4, [1, 1, 1, 1], this.path_);
		graphics.drawGraphicsData(this.graphicsData_);
	}

	protected function onMouseDown(_arg_1:MouseEvent):void
	{
		var _local_2:Element = (_arg_1.currentTarget as Element);
		if (_local_2.downloadOnly)
		{
			this.downloadElement(_local_2);
		}
		else
		{
			this.setSelected(_local_2);
		}
	}

	protected function onScrollBarChange(_arg_1:Event):void
	{
		this.elementContainer_.y = (6 - (this.scrollBar_.pos() * ((this.elementContainer_.height + 12) - HEIGHT)));
	}

	protected function onAddedToStage(_arg_1:Event):void
	{
		removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
		this.scrollBar_.addEventListener(Event.CHANGE, this.onScrollBarChange);
		this.scrollBar_.setIndicatorSize(HEIGHT, this.elementContainer_.height);
		addChild(this.scrollBar_);
	}

	protected function onRemovedFromStage(_arg_1:Event):void
	{
		removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
	}

	public function get hasBeenLoaded():Boolean
	{
		return (this._hasBeenLoaded);
	}

	public function set hasBeenLoaded(_arg_1:Boolean):void
	{
		this._hasBeenLoaded = _arg_1;
	}


}
}//package com.company.assembleegameclient.mapeditor

