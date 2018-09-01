﻿//kabam.rotmg.game.view.CreditDisplay

package kabam.rotmg.game.view
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.FameUtil;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.TimeUtil;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import io.decagames.rotmg.fame.FameContentPopup;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.assets.services.IconFactory;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.fortune.model.FortuneInfo;
import kabam.rotmg.fortune.services.FortuneModel;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.Signal;
import org.swiftsuspenders.Injector;

public class CreditDisplay extends Sprite
{

	private static const FONT_SIZE:int = 18;
	public static const IMAGE_NAME:String = "lofiObj3";
	public static const IMAGE_ID:int = 225;
	public static const waiter:SignalWaiter = new SignalWaiter();

	private var creditsText_:TextFieldDisplayConcrete;
	private var fameText_:TextFieldDisplayConcrete;
	private var fortuneText_:TextFieldDisplayConcrete;
	private var fortuneTimeText_:TextFieldDisplayConcrete;
	private var coinIcon_:Bitmap;
	private var fameIcon_:Bitmap;
	private var fortuneIcon_:Bitmap;
	private var credits_:int = -1;
	private var fame_:int = -1;
	private var fortune_:int = -1;
	private var displayFortune_:Boolean = false;
	private var displayFame_:Boolean = true;
	public var gs:GameSprite;
	public var _creditsButton:SliceScalingButton;
	public var _fameButton:SliceScalingButton;
	public var openAccountDialog:Signal = new Signal();
	public var displayFameTooltip:Signal = new Signal();
	private var fortuneTimeEnd:Number = -1;
	private var fortuneTimeLeftString:String = "";
	public var resourcePadding:int;

	public function CreditDisplay(_arg_1:GameSprite = null, _arg_2:Boolean = true, _arg_3:Boolean = false, _arg_4:Number = 0)
	{
		var _local_6:FortuneInfo;
		super();
		this.displayFortune_ = _arg_3;
		this.displayFame_ = _arg_2;
		this.gs = _arg_1;
		this.creditsText_ = this.makeTextField();
		waiter.push(this.creditsText_.textChanged);
		addChild(this.creditsText_);
		var _local_5:BitmapData = AssetLibrary.getImageFromSet(IMAGE_NAME, IMAGE_ID);
		_local_5 = TextureRedrawer.redraw(_local_5, 40, true, 0);
		this.coinIcon_ = new Bitmap(_local_5);
		addChild(this.coinIcon_);
		if (this.displayFame_)
		{
			this.fameText_ = this.makeTextField();
			waiter.push(this.fameText_.textChanged);
			addChild(this.fameText_);
			this.fameIcon_ = new Bitmap(FameUtil.getFameIcon());
			addChild(this.fameIcon_);
		}
		if (((this.displayFortune_) && (FortuneModel.HAS_FORTUNES)))
		{
			_local_6 = StaticInjectorContext.getInjector().getInstance(FortuneModel).getFortune();
			if (_local_6._endTime != null)
			{
				this.fortuneTimeEnd = _local_6._endTime.time;
				this.fortuneTimeText_ = this.makeTextField(0xFFFFFF);
				waiter.push(this.fortuneTimeText_.textChanged);
				this.fortuneTimeText_.setStringBuilder(new StaticStringBuilder(this.getFortuneTimeLeftStr()));
				addChild(this.fortuneTimeText_);
				this.fortuneTimeText_.visible = false;
			}
			this.fortuneText_ = this.makeTextField(0xFFFFFF);
			waiter.push(this.fortuneText_.textChanged);
			addChild(this.fortuneText_);
			this.fortuneIcon_ = new Bitmap(IconFactory.makeFortune());
			addChild(this.fortuneIcon_);
		}
		else
		{
			this.displayFortune_ = false;
		}
		this.draw(0, 0, 0);
		mouseEnabled = true;
		waiter.complete.add(this.onAlignHorizontal);
	}

	public function addResourceButtons():void
	{
		this.resourcePadding = 30;
		this._creditsButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "resourcesAddButton"));
		this._fameButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "tab_info_button"));
		addChild(this._creditsButton);
		addChild(this._fameButton);
	}

	public function removeResourceButtons():void
	{
		this.resourcePadding = 5;
		if (this._creditsButton)
		{
			removeChild(this._creditsButton);
		}
		if (this._fameButton)
		{
			removeChild(this._fameButton);
		}
	}

	private function onAlignHorizontal():void
	{
		if (this.displayFortune_)
		{
			this.coinIcon_.x = -(this.coinIcon_.width);
			this.fortuneIcon_.x = (-(this.coinIcon_.width) + 10);
			this.fortuneIcon_.y = 10;
			this.fortuneText_.x = ((this.coinIcon_.x - this.fortuneText_.width) + 8);
			this.fortuneText_.y = ((this.coinIcon_.y + (this.coinIcon_.height / 2)) - (this.creditsText_.height / 2));
			this.fortuneTimeText_.x = (-(this.fortuneTimeText_.width) - 2);
			this.fortuneTimeText_.y = 33;
			this.coinIcon_.x = (this.fortuneText_.x - this.coinIcon_.width);
			this.creditsText_.x = ((this.coinIcon_.x - this.creditsText_.width) + 8);
			this.creditsText_.y = ((this.coinIcon_.y + (this.coinIcon_.height / 2)) - (this.creditsText_.height / 2));
		}
		else
		{
			this.coinIcon_.x = -(this.coinIcon_.width);
			this.creditsText_.x = ((this.coinIcon_.x - this.creditsText_.width) + 8);
			this.creditsText_.y = ((this.coinIcon_.y + (this.coinIcon_.height / 2)) - (this.creditsText_.height / 2));
			if (this._creditsButton)
			{
				this._creditsButton.x = ((this.coinIcon_.x - this.creditsText_.width) - 16);
				this._creditsButton.y = 7;
			}
		}
		if (this.displayFame_)
		{
			this.fameIcon_.x = ((this.creditsText_.x - this.fameIcon_.width) - this.resourcePadding);
			this.fameText_.x = ((this.fameIcon_.x - this.fameText_.width) + 8);
			this.fameText_.y = ((this.fameIcon_.y + (this.fameIcon_.height / 2)) - (this.fameText_.height / 2));
			if (this._fameButton)
			{
				this._fameButton.x = ((this.fameIcon_.x - this.fameText_.width) - 16);
				this._fameButton.y = 7;
			}
		}
	}

	public function onFameClick(_arg_1:MouseEvent):void
	{
		this.onFameMask();
	}

	private function onFameMask():void
	{
		var _local_1:Injector = StaticInjectorContext.getInjector();
		var _local_2:ShowPopupSignal = _local_1.getInstance(ShowPopupSignal);
		_local_2.dispatch(new FameContentPopup());
	}

	public function onCreditsClick(_arg_1:MouseEvent):void
	{
		if ((((!(this.gs)) || (this.gs.evalIsNotInCombatMapArea())) || (Parameters.data_.clickForGold == true)))
		{
			this.openAccountDialog.dispatch();
		}
	}

	public function makeTextField(_arg_1:uint = 0xFFFFFF):TextFieldDisplayConcrete
	{
		var _local_2:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(FONT_SIZE).setColor(_arg_1).setTextHeight(16);
		_local_2.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
		return (_local_2);
	}

	private function handleFortuneTimeTextUpdate():void
	{
		var _local_1:String = this.getFortuneTimeLeftStr();
		if (_local_1 != this.fortuneTimeLeftString)
		{
			if (_local_1 == "Ended")
			{
				this.displayFortune_ = false;
				removeChild(this.fortuneTimeText_);
				removeChild(this.fortuneIcon_);
				removeChild(this.fortuneText_);
				FortuneModel.HAS_FORTUNES = false;
			}
			else
			{
				this.fortuneTimeText_.setStringBuilder(new StaticStringBuilder(_local_1));
				this.fortuneTimeLeftString = _local_1;
			}
			this.onAlignHorizontal();
		}
	}

	public function draw(_arg_1:int, _arg_2:int, _arg_3:int = 0):void
	{
		if (this.displayFortune_)
		{
			this.handleFortuneTimeTextUpdate();
		}
		if ((((_arg_1 == this.credits_) && ((this.displayFame_) && (_arg_2 == this.fame_))) && ((this.displayFortune_) && (_arg_3 == this.fortune_))))
		{
			return;
		}
		this.credits_ = _arg_1;
		this.creditsText_.setStringBuilder(new StaticStringBuilder(this.credits_.toString()));
		if (this.displayFame_)
		{
			this.fame_ = _arg_2;
			this.fameText_.setStringBuilder(new StaticStringBuilder(this.fame_.toString()));
		}
		if (this.displayFortune_)
		{
			this.fortune_ = _arg_3;
			this.fortuneText_.setStringBuilder(new StaticStringBuilder(this.fortune_.toString()));
		}
		if (waiter.isEmpty())
		{
			this.onAlignHorizontal();
		}
	}

	public function getFortuneTimeLeftStr():String
	{
		var _local_1:* = "";
		var _local_2:Date = new Date();
		var _local_3:Number = ((this.fortuneTimeEnd - _local_2.time) / 1000);
		if (_local_3 > TimeUtil.DAY_IN_S)
		{
			_local_1 = (String(Math.ceil(TimeUtil.secondsToDays(_local_3))) + " days");
		}
		else
		{
			if (_local_3 > TimeUtil.HOUR_IN_S)
			{
				_local_1 = (String(Math.ceil(TimeUtil.secondsToHours(_local_3))) + " hours");
			}
			else
			{
				if (_local_3 > TimeUtil.MIN_IN_S)
				{
					_local_1 = (String(Math.ceil(TimeUtil.secondsToMins(_local_3))) + " minutes");
				}
				else
				{
					if (_local_3 > (TimeUtil.MIN_IN_S / 2))
					{
						_local_1 = "One Minute Left!";
					}
					else
					{
						if (_local_3 > 0)
						{
							_local_1 = "Ending in a few seconds!!";
						}
						else
						{
							_local_1 = "Ended";
						}
					}
				}
			}
		}
		return (_local_1);
	}

	public function get creditsButton():SliceScalingButton
	{
		return (this._creditsButton);
	}

	public function get fameButton():SliceScalingButton
	{
		return (this._fameButton);
	}


}
}//package kabam.rotmg.game.view

