package kabam.rotmg.ui.view.components
{
import flash.display.*;
import flash.events.*;
import flash.utils.getTimer;

import kabam.rotmg.assets.*;

public class Spinner extends Sprite
{
	public function Spinner()
	{
		super();
		this.secondsElapsed = 0;
		this.defaultConfig();
		this.addGraphic();
		addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);

	}

	public function defaultConfig():void
	{
		this.degreesPerSecond = 50;

	}

	public function addGraphic():void
	{
		addChild(this.graphic);
		this.graphic.x = -1 * width / 2;
		this.graphic.y = -1 * height / 2;

	}

	public function onRemoved(arg1:Event):void
	{
		removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
		removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);

	}

	public function onEnterFrame(arg1:Event):void
	{
		this.updateTimeElapsed();
		rotation = this.degreesPerSecond * this.secondsElapsed % 360;

	}

	public function updateTimeElapsed():void
	{
		var loc1:* = getTimer() / 1000;
		if (this.previousSeconds)
		{
			this.secondsElapsed = this.secondsElapsed + (loc1 - this.previousSeconds);
		}
		this.previousSeconds = loc1;

	}

	public const graphic:DisplayObject = new EmbeddedAssets.StarburstSpinner();

	public var degreesPerSecond:Number;

	public var secondsElapsed:Number;

	public var previousSeconds:Number;
}
}
