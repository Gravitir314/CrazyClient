﻿//kabam.rotmg.ui.view.components.PotionSlotView

package kabam.rotmg.ui.view.components
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.GraphicsUtil;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.filters.ColorMatrixFilter;
import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.utils.Timer;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeSignal;

public class PotionSlotView extends Sprite
{

	public static var BUTTON_WIDTH:int = 84;
	private static var BUTTON_HEIGHT:int = 24;
	private static var SMALL_SIZE:int = 4;
	private static var CENTER_ICON_X:int = 6;
	private static var LEFT_ICON_X:int = -6;
	public static const READABILITY_SHADOW_1:DropShadowFilter = new DropShadowFilter(0, 0, 0, 1, 4, 4, 2);
	public static const READABILITY_SHADOW_2:DropShadowFilter = new DropShadowFilter(0, 0, 0, 1, 4, 4, 3);
	private static const DOUBLE_CLICK_PAUSE:uint = 250;
	private static const DRAG_DIST:int = 3;

	public var position:int;
	public var objectType:int;
	public var click:NativeSignal;
	public var buyUse:Signal;
	public var drop:Signal;
	private var lightGrayFill:GraphicsSolidFill = new GraphicsSolidFill(0x545454, 1);
	private var midGrayFill:GraphicsSolidFill = new GraphicsSolidFill(4078909, 1);
	private var darkGrayFill:GraphicsSolidFill = new GraphicsSolidFill(2368034, 1);
	private var outerPath:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
	private var innerPath:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
	private var useGraphicsData:Vector.<IGraphicsData> = new <IGraphicsData>[lightGrayFill, outerPath, GraphicsUtil.END_FILL];
	private var buyOuterGraphicsData:Vector.<IGraphicsData> = new <IGraphicsData>[midGrayFill, outerPath, GraphicsUtil.END_FILL];
	private var buyInnerGraphicsData:Vector.<IGraphicsData> = new <IGraphicsData>[darkGrayFill, innerPath, GraphicsUtil.END_FILL];
	private var text:TextFieldDisplayConcrete;
	private var subText:TextFieldDisplayConcrete;
	private var costIcon:Bitmap;
	private var potionIconDraggableSprite:Sprite;
	private var potionIcon:Bitmap;
	private var bg:Sprite;
	private var grayscaleMatrix:ColorMatrixFilter;
	private var doubleClickTimer:Timer;
	private var dragStart:Point;
	private var pendingSecondClick:Boolean;
	private var isDragging:Boolean;

	public function PotionSlotView(_arg_1:Array, _arg_2:int)
	{
		var _local_3:BitmapData;
		super();
		mouseChildren = false;
		this.position = _arg_2;
		this.grayscaleMatrix = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
		_local_3 = AssetLibrary.getImageFromSet("lofiObj3", 225);
		_local_3 = TextureRedrawer.redraw(_local_3, 30, false, 0);
		this.text = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setTextWidth(BUTTON_WIDTH).setTextHeight(BUTTON_HEIGHT);
		this.text.filters = [READABILITY_SHADOW_1];
		this.subText = new TextFieldDisplayConcrete().setSize(12).setColor(0xB6B6B6).setTextWidth(BUTTON_WIDTH).setTextHeight(BUTTON_HEIGHT);
		this.subText.filters = [READABILITY_SHADOW_1];
		this.subText.y = 8;
		this.costIcon = new Bitmap(_local_3);
		this.costIcon.x = 52;
		this.costIcon.y = -6;
		this.costIcon.visible = false;
		this.bg = new Sprite();
		GraphicsUtil.clearPath(this.outerPath);
		GraphicsUtil.drawCutEdgeRect(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT, 4, _arg_1, this.outerPath);
		GraphicsUtil.drawCutEdgeRect(2, 2, (BUTTON_WIDTH - SMALL_SIZE), (BUTTON_HEIGHT - SMALL_SIZE), 4, _arg_1, this.innerPath);
		this.bg.graphics.drawGraphicsData(this.buyOuterGraphicsData);
		this.bg.graphics.drawGraphicsData(this.buyInnerGraphicsData);
		addChild(this.bg);
		addChild(this.costIcon);
		addChild(this.text);
		addChild(this.subText);
		this.potionIconDraggableSprite = new Sprite();
		this.doubleClickTimer = new Timer(DOUBLE_CLICK_PAUSE, 1);
		this.doubleClickTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onDoubleClickTimerComplete);
		addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
		addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
		addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
		addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
		this.click = new NativeSignal(this, MouseEvent.CLICK, MouseEvent);
		this.buyUse = new Signal();
		this.drop = new Signal(DisplayObject);
	}

	public function setData(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:int = -1):void
	{
		var _local_6:int;
		var _local_7:BitmapData;
		var _local_8:Bitmap;
		if (_arg_4 != -1)
		{
			this.objectType = _arg_4;
			if (this.potionIcon != null)
			{
				removeChild(this.potionIcon);
			}
			_local_7 = ObjectLibrary.getRedrawnTextureFromType(_arg_4, 55, false);
			this.potionIcon = new Bitmap(_local_7);
			this.potionIcon.y = -11;
			addChild(this.potionIcon);
			_local_7 = ObjectLibrary.getRedrawnTextureFromType(_arg_4, 80, true);
			_local_8 = new Bitmap(_local_7);
			_local_8.x = (_local_8.x - 30);
			_local_8.y = (_local_8.y - 30);
			this.potionIconDraggableSprite.addChild(_local_8);
		}
		var _local_5:* = (_arg_1 > 0);
		if (_local_5)
		{
			this.setTextString(String(_arg_1));
			this.subText.setStringBuilder(new StaticStringBuilder("/6"));
			this.subText.x = 67;
			_local_6 = CENTER_ICON_X;
			this.bg.graphics.clear();
			this.bg.graphics.drawGraphicsData(this.useGraphicsData);
			this.text.x = 55;
			this.text.y = 2;
			this.text.setBold(true);
			this.text.setSize(18);
		}
		else
		{
			this.setTextString(String(_arg_2));
			this.subText.setStringBuilder(new StaticStringBuilder(""));
			_local_6 = LEFT_ICON_X;
			this.bg.graphics.clear();
			this.bg.graphics.drawGraphicsData(this.buyOuterGraphicsData);
			this.bg.graphics.drawGraphicsData(this.buyInnerGraphicsData);
			this.text.x = ((this.costIcon.x - this.text.width) + 10);
			this.text.y = 4;
			this.text.setBold(false);
			this.text.setSize(14);
		}
		if (this.potionIcon)
		{
			this.potionIcon.x = _local_6;
		}
		if (!_local_5)
		{
			if (Parameters.data_.contextualPotionBuy)
			{
				this.text.setBold(false);
				this.text.setColor(0xFFFFFF);
				this.costIcon.filters = [];
				this.costIcon.visible = true;
			}
			else
			{
				this.text.setBold(false);
				this.text.setColor(0xAAAAAA);
				this.costIcon.filters = [this.grayscaleMatrix];
				this.costIcon.visible = true;
			}
		}
		else
		{
			if (_arg_1 <= 1)
			{
				this.text.setColor(16589603);
			}
			else
			{
				if (_arg_1 <= 4)
				{
					this.text.setColor(16611363);
				}
				else
				{
					if (_arg_1 >= 4)
					{
						this.text.setColor(3007543);
					}
				}
			}
			this.costIcon.filters = [];
			this.costIcon.visible = false;
		}
	}

	public function setTextString(_arg_1:String):void
	{
		this.text.setStringBuilder(new StaticStringBuilder(_arg_1));
	}

	private function onMouseOut(_arg_1:MouseEvent):void
	{
		this.setPendingDoubleClick(false);
	}

	private function onMouseUp(_arg_1:MouseEvent):void
	{
		if (this.isDragging)
		{
			return;
		}
		if (_arg_1.shiftKey)
		{
			this.setPendingDoubleClick(false);
			this.buyUse.dispatch();
		}
		else
		{
			if ((!(this.pendingSecondClick)))
			{
				this.setPendingDoubleClick(true);
			}
			else
			{
				this.setPendingDoubleClick(false);
				this.buyUse.dispatch();
			}
		}
	}

	private function onMouseDown(_arg_1:MouseEvent):void
	{
		if ((!(this.costIcon.visible)))
		{
			this.beginDragCheck(_arg_1);
		}
	}

	private function setPendingDoubleClick(_arg_1:Boolean):void
	{
		this.pendingSecondClick = _arg_1;
		if (this.pendingSecondClick)
		{
			this.doubleClickTimer.reset();
			this.doubleClickTimer.start();
		}
		else
		{
			this.doubleClickTimer.stop();
		}
	}

	private function beginDragCheck(_arg_1:MouseEvent):void
	{
		this.dragStart = new Point(_arg_1.stageX, _arg_1.stageY);
		addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveCheckDrag);
		addEventListener(MouseEvent.MOUSE_OUT, this.cancelDragCheck);
		addEventListener(MouseEvent.MOUSE_UP, this.cancelDragCheck);
	}

	private function cancelDragCheck(_arg_1:MouseEvent):void
	{
		removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveCheckDrag);
		removeEventListener(MouseEvent.MOUSE_OUT, this.cancelDragCheck);
		removeEventListener(MouseEvent.MOUSE_UP, this.cancelDragCheck);
	}

	private function onMouseMoveCheckDrag(_arg_1:MouseEvent):void
	{
		var _local_2:Number = (_arg_1.stageX - this.dragStart.x);
		var _local_3:Number = (_arg_1.stageY - this.dragStart.y);
		var _local_4:Number = Math.sqrt(((_local_2 * _local_2) + (_local_3 * _local_3)));
		if (_local_4 > DRAG_DIST)
		{
			this.cancelDragCheck(null);
			this.setPendingDoubleClick(false);
			this.beginDrag();
		}
	}

	private function onDoubleClickTimerComplete(_arg_1:TimerEvent):void
	{
		this.setPendingDoubleClick(false);
	}

	private function beginDrag():void
	{
		this.isDragging = true;
		this.potionIconDraggableSprite.startDrag(true);
		stage.addChild(this.potionIconDraggableSprite);
		this.potionIconDraggableSprite.addEventListener(MouseEvent.MOUSE_UP, this.endDrag);
	}

	private function endDrag(_arg_1:MouseEvent):void
	{
		this.isDragging = false;
		this.potionIconDraggableSprite.stopDrag();
		this.potionIconDraggableSprite.x = this.dragStart.x;
		this.potionIconDraggableSprite.y = this.dragStart.y;
		stage.removeChild(this.potionIconDraggableSprite);
		this.potionIconDraggableSprite.removeEventListener(MouseEvent.MOUSE_UP, this.endDrag);
		this.drop.dispatch(this.potionIconDraggableSprite.dropTarget);
	}

	private function onRemovedFromStage(_arg_1:Event):void
	{
		this.setPendingDoubleClick(false);
		this.cancelDragCheck(null);
		if (this.isDragging)
		{
			this.potionIconDraggableSprite.stopDrag();
		}
	}


}
}//package kabam.rotmg.ui.view.components

