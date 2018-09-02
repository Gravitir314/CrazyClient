﻿//com.company.assembleegameclient.game.GameSprite

package com.company.assembleegameclient.game
{
import com.company.assembleegameclient.game.events.MoneyChangedEvent;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.IInteractiveObject;
import com.company.assembleegameclient.objects.Pet;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.Projectile;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.GuildText;
import com.company.assembleegameclient.ui.RankText;
import com.company.assembleegameclient.ui.menu.PlayerMenu;
import com.company.assembleegameclient.ui.options.Options;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.CachingColorTransformer;
import com.company.util.MoreColorUtil;
import com.company.util.MoreObjectUtil;
import com.company.util.PointUtil;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.filters.DropShadowFilter;
import flash.geom.Vector3D;
import flash.utils.ByteArray;
import flash.utils.getTimer;

import kabam.lib.loopedprocs.LoopedCallback;
import kabam.lib.loopedprocs.LoopedProcess;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.arena.view.ArenaTimer;
import kabam.rotmg.arena.view.ArenaWaveCounter;
import kabam.rotmg.chat.view.Chat;
import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.MapModel;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.dailyLogin.signal.ShowDailyCalendarPopupSignal;
import kabam.rotmg.dailyLogin.view.DailyLoginModal;
import kabam.rotmg.dialogs.control.AddPopupToStartupQueueSignal;
import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.dialogs.model.DialogsModel;
import kabam.rotmg.dialogs.model.PopupNamesConfig;
import kabam.rotmg.game.view.CreditDisplay;
import kabam.rotmg.game.view.GiftStatusDisplay;
import kabam.rotmg.game.view.NewsModalButton;
import kabam.rotmg.game.view.ShopDisplay;
import kabam.rotmg.maploading.signals.HideMapLoadingSignal;
import kabam.rotmg.maploading.signals.MapLoadedSignal;
import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;
import kabam.rotmg.messaging.impl.incoming.MapInfo;
import kabam.rotmg.news.model.NewsModel;
import kabam.rotmg.news.view.NewsTicker;
import kabam.rotmg.packages.services.PackageModel;
import kabam.rotmg.promotions.model.BeginnersPackageModel;
import kabam.rotmg.promotions.signals.ShowBeginnersPackageSignal;
import kabam.rotmg.promotions.view.SpecialOfferButton;
import kabam.rotmg.protip.signals.ShowProTipSignal;
import kabam.rotmg.servers.api.Server;
import kabam.rotmg.stage3D.Renderer;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.ui.UIUtils;
import kabam.rotmg.ui.view.HUDView;
import kabam.rotmg.ui.view.QuestHealthBar;

import org.osflash.signals.Signal;

import robotlegs.bender.framework.api.ILogger;

public class GameSprite extends AGameSprite
{

	public static const NON_COMBAT_MAPS:Vector.<String> = new <String>[Map.NEXUS, Map.VAULT, Map.GUILD_HALL, Map.CLOTH_BAZAAR, Map.NEXUS_EXPLANATION, Map.DAILY_QUEST_ROOM];
	public static const DISPLAY_AREA_Y_SPACE:int = 32;
	protected const EMPTY_FILTER:DropShadowFilter = new DropShadowFilter(0, 0, 0);
	protected static const PAUSED_FILTER:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);

	public const monitor:Signal = new Signal(String, int);
	public const modelInitialized:Signal = new Signal();
	public const drawCharacterWindow:Signal = new Signal(Player);

	public var isNexus_:Boolean = false;
	public var shopDisplay:ShopDisplay;

	public var giftStatusDisplay:GiftStatusDisplay;

	public var beginnersPackageModel:BeginnersPackageModel;
	public var dialogsModel:DialogsModel;
	public var showBeginnersPackage:ShowBeginnersPackageSignal;
	public var openDailyCalendarPopupSignal:ShowDailyCalendarPopupSignal;

	public var showPackage:Signal = new Signal();
	public var packageModel:PackageModel;
	public var addToQueueSignal:AddPopupToStartupQueueSignal;
	public var flushQueueSignal:FlushPopupStartupQueueSignal;

	private var currentPackage:DisplayObject = new Sprite();
	private var packageY:Number;
	private var specialOfferButton:SpecialOfferButton;

	public var chatBox_:Chat;
	public var newsModalButton:NewsModalButton;
	public var rankText_:RankText;
	public var guildText_:GuildText;
	public var creditDisplay_:CreditDisplay;
	public var newsTicker:NewsTicker;
	public var arenaTimer:ArenaTimer;
	public var arenaWaveCounter:ArenaWaveCounter;
	public var mapModel:MapModel;
	private var focus:GameObject;
	private var frameTimeSum_:int = 0;
	private var frameTimeCount_:int = 0;
	private var isGameStarted:Boolean;
	private var displaysPosY:uint = 4;
	public var chatPlayerMenu:PlayerMenu;
	public var questBar:QuestHealthBar;
	private var timerCounter:TextFieldDisplayConcrete;
	public var openDialog:OpenDialogSignal;

	public function GameSprite(_arg_1:Server, _arg_2:int, _arg_3:Boolean, _arg_4:int, _arg_5:int, _arg_6:ByteArray, _arg_7:PlayerModel, _arg_8:String, _arg_9:Boolean)
	{
		this.model = _arg_7;
		map = new Map(this);
		addChild(map);
		gsc_ = new GameServerConnectionConcrete(this, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_8, _arg_9);
		mui_ = new MapUserInput(this);
		this.chatBox_ = new Chat();
		this.chatBox_.list.addEventListener(MouseEvent.MOUSE_DOWN, this.onChatDown);
		this.chatBox_.list.addEventListener(MouseEvent.MOUSE_UP, this.onChatUp);
		addChild(this.chatBox_);
	}


	public static function dispatchMapLoaded(_arg_1:MapInfo):void
	{
		var _local_2:MapLoadedSignal = StaticInjectorContext.getInjector().getInstance(MapLoadedSignal);
		((_local_2) && (_local_2.dispatch(_arg_1)));
	}

	public static function hidePreloader():void
	{
		var _local_1:HideMapLoadingSignal = StaticInjectorContext.getInjector().getInstance(HideMapLoadingSignal);
		((_local_1) && (_local_1.dispatch()));
	}


	public function onChatDown(_arg_1:MouseEvent):void
	{
		if (this.chatPlayerMenu != null)
		{
			this.removeChatPlayerMenu();
		}
		mui_.onMouseDown(_arg_1);
	}

	public function onChatUp(_arg_1:MouseEvent):void
	{
		mui_.onMouseUp(_arg_1);
	}

	override public function setFocus(_arg_1:GameObject):void
	{
		_arg_1 = ((_arg_1) || (map.player_));
		this.focus = _arg_1;
	}

	public function chatMenuPositionFixed():void
	{
		var _local_1:Number = NaN;
		var _local_2:Number = ((((stage.mouseX + (stage.stageWidth / 2)) - 400) / stage.stageWidth) * 800);
		_local_1 = ((((stage.mouseY + (stage.stageHeight / 2)) - 300) / stage.stageHeight) * 600);
		this.chatPlayerMenu.x = _local_2;
		this.chatPlayerMenu.y = (_local_1 - this.chatPlayerMenu.height);
	}

	public function addChatPlayerMenu(_arg_1:Player, _arg_2:Number, _arg_3:Number, _arg_4:String = null, _arg_5:Boolean = false, _arg_6:Boolean = false):void
	{
		this.removeChatPlayerMenu();
		this.chatPlayerMenu = new PlayerMenu();
		if (_arg_4 == null)
		{
			this.chatPlayerMenu.init(this, _arg_1);
		}
		else
		{
			if (_arg_6)
			{
				this.chatPlayerMenu.initDifferentServer(this, _arg_4, _arg_5, _arg_6);
			}
			else
			{
				if (((_arg_4.length > 0) && (((_arg_4.charAt(0) == "#") || (_arg_4.charAt(0) == "*")) || (_arg_4.charAt(0) == "@"))))
				{
					return;
				}
				this.chatPlayerMenu.initDifferentServer(this, _arg_4, _arg_5);
			}
		}
		addChild(this.chatPlayerMenu);
		this.chatPlayerMenu.x = _arg_2;
		this.chatPlayerMenu.y = (_arg_3 - this.chatPlayerMenu.height);
	}

	public function removeChatPlayerMenu():void
	{
		if (((!(this.chatPlayerMenu == null)) && (!(this.chatPlayerMenu.parent == null))))
		{
			removeChild(this.chatPlayerMenu);
			this.chatPlayerMenu = null;
		}
	}

	override public function applyMapInfo(_arg_1:MapInfo):void
	{
		map.setProps(_arg_1.width_, _arg_1.height_, _arg_1.name_, _arg_1.background_, _arg_1.allowPlayerTeleport_, _arg_1.showDisplays_);
		dispatchMapLoaded(_arg_1);
	}

	public function hudModelInitialized():void
	{
		hudView = new HUDView();
		hudView.x = 600;
		addChild(hudView);
	}

	override public function initialize():void
	{
		var _local_1:Account;
		var _local_2:ShowProTipSignal;
		map.initialize();
		this.modelInitialized.dispatch();
		if (this.evalIsNotInCombatMapArea())
		{
			this.showSafeAreaDisplays();
		}
		if (map.name_ == "Arena")
		{
			this.showTimer();
			this.showWaveCounter();
		}
		if (map.name_ == Map.DAILY_QUEST_ROOM)
		{
			gsc_.questFetch();
		}
		_local_1 = StaticInjectorContext.getInjector().getInstance(Account);
		this.questBar = new QuestHealthBar();
		this.questBar.x = 4;
		this.questBar.y = 16;
		addChild(this.questBar);
		switch (map.name_)
		{
			case Map.NEXUS:
			case Map.DAILY_QUEST_ROOM:
			case Map.PET_YARD_1:
			case Map.PET_YARD_2:
			case Map.PET_YARD_3:
			case Map.PET_YARD_4:
			case Map.PET_YARD_5:
			case Map.VAULT:
			default:
				if (map.name_ == Map.NEXUS)
				{
					this.addToQueueSignal.dispatch(PopupNamesConfig.DAILY_LOGIN_POPUP, this.openDailyCalendarPopupSignal, -1, null);
					if (this.beginnersPackageModel.status == BeginnersPackageModel.STATUS_CAN_BUY_SHOW_POP_UP)
					{
						this.addToQueueSignal.dispatch(PopupNamesConfig.BEGINNERS_OFFER_POPUP, this.showBeginnersPackage, 1, null);
					}
					else
					{
						this.addToQueueSignal.dispatch(PopupNamesConfig.PACKAGES_OFFER_POPUP, this.showPackage, 1, null);
					}
				}
				this.creditDisplay_ = new CreditDisplay(this, true, true);
				this.creditDisplay_.x = 594;
				this.creditDisplay_.y = 0;
				addChild(this.creditDisplay_);
		}

		var _local_3:AppEngineClient = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
		var _local_4:Object = {
			"game_net_user_id": _local_1.gameNetworkUserId(),
			"game_net": _local_1.gameNetwork(),
			"play_platform": _local_1.playPlatform()
		};
		MoreObjectUtil.addToObject(_local_4, _local_1.getCredentials());
		isSafeMap = this.evalIsNotInCombatMapArea();
		hidePreloader();
		stage.dispatchEvent(new Event(Event.RESIZE));
		this.parent.parent.setChildIndex((this.parent.parent as Layers).top, 2);
	}


	private function showSafeAreaDisplays():void
	{
		this.showRankText();
		this.showGuildText();
		this.showShopDisplay();
		this.showGiftStatusDisplay();
		this.showNewsUpdate();
		this.showNewsTicker();
	}

	private function setDisplayPosY(_arg_1:Number):void
	{
		var _local_2:Number = (UIUtils.NOTIFICATION_SPACE * _arg_1);
		if (_arg_1 != 0)
		{
			this.displaysPosY = (4 + _local_2);
		}
		else
		{
			this.displaysPosY = 2;
		}
	}

	public function positionDynamicDisplays():void
	{
		var _local_1:NewsModel = StaticInjectorContext.getInjector().getInstance(NewsModel);
		var _local_2:int = 66;
		if (this.giftStatusDisplay && this.giftStatusDisplay.isOpen)
		{
			this.giftStatusDisplay.y = _local_2;
			_local_2 = (_local_2 + DISPLAY_AREA_Y_SPACE);
		}
		if (this.newsModalButton && (NewsModalButton.showsHasUpdate || _local_1.hasValidModalNews()))
		{
			this.newsModalButton.y = _local_2;
			_local_2 = (_local_2 + DISPLAY_AREA_Y_SPACE);
		}
		if (this.specialOfferButton && this.specialOfferButton.isSpecialOfferAvailable)
		{
			this.specialOfferButton.y = _local_2;
		}
		if (this.newsTicker && this.newsTicker.visible)
		{
			this.newsTicker.y = _local_2;
		}
	}

	private function showTimer():void
	{
		this.arenaTimer = new ArenaTimer();
		this.arenaTimer.y = 5;
		addChild(this.arenaTimer);
	}

	private function showWaveCounter():void
	{
		this.arenaWaveCounter = new ArenaWaveCounter();
		this.arenaWaveCounter.y = 5;
		this.arenaWaveCounter.x = 5;
		addChild(this.arenaWaveCounter);
	}

	private function showNewsTicker():void
	{
		this.newsTicker = new NewsTicker();
		this.newsTicker.x = (300 - (this.newsTicker.width / 2));
		addChild(this.newsTicker);
		this.positionDynamicDisplays();
	}

	private function showGiftStatusDisplay():void
	{
		this.giftStatusDisplay = new GiftStatusDisplay();
		this.giftStatusDisplay.x = 6;
		addChild(this.giftStatusDisplay);
		this.positionDynamicDisplays();
	}

	private function showShopDisplay():void
	{
		this.shopDisplay = new ShopDisplay((map.name_ == Map.NEXUS));
		this.shopDisplay.x = 6;
		this.shopDisplay.y = 34;
		addChild(this.shopDisplay);
	}

	private function showNewsUpdate(_arg_1:Boolean = true):void
	{
		var _local_4:NewsModalButton;
		var _local_2:ILogger = StaticInjectorContext.getInjector().getInstance(ILogger);
		var _local_3:NewsModel = StaticInjectorContext.getInjector().getInstance(NewsModel);
		_local_2.debug("NEWS UPDATE -- making button");
		if (_local_3.hasValidModalNews())
		{
			_local_2.debug("NEWS UPDATE -- making button - ok");
			_local_4 = new NewsModalButton();
			if (this.newsModalButton != null)
			{
				removeChild(this.newsModalButton);
			}
			_local_4.x = 6;
			this.newsModalButton = _local_4;
			addChild(this.newsModalButton);
			this.positionDynamicDisplays();
		}
	}

	public function refreshNewsUpdateButton():void
	{
		var _local_1:ILogger = StaticInjectorContext.getInjector().getInstance(ILogger);
		_local_1.debug("NEWS UPDATE -- refreshing button, update noticed");
		this.showNewsUpdate(false);
	}

	private function setYAndPositionPackage():void
	{
		this.packageY = (this.displaysPosY + 2);
		this.displaysPosY = (this.displaysPosY + UIUtils.NOTIFICATION_SPACE);
		this.positionPackage();
	}

	public function showSpecialOfferIfSafe():void
	{
		if (this.evalIsNotInCombatMapArea())
		{
			this.specialOfferButton = new SpecialOfferButton();
			this.specialOfferButton.x = 6;
			addChild(this.specialOfferButton);
			this.positionDynamicDisplays();
		}
	}

	public function showPackageButtonIfSafe():void
	{
		if (this.evalIsNotInCombatMapArea())
		{
		}
	}

	private function addAndPositionPackage(_arg_1:DisplayObject):void
	{
		this.currentPackage = _arg_1;
		addChild(this.currentPackage);
		this.positionPackage();
	}

	private function positionPackage():void
	{
		this.currentPackage.x = 80;
		this.setDisplayPosY(1);
		this.currentPackage.y = this.displaysPosY;
	}

	private function showGuildText():void
	{
		this.guildText_ = new GuildText("", -1);
		this.guildText_.x = 64;
		this.guildText_.y = 2;
		addChild(this.guildText_);
	}

	private function showRankText():void
	{
		this.rankText_ = new RankText(-1, true, false);
		this.rankText_.x = 8;
		this.rankText_.y = 2;
		addChild(this.rankText_);
	}

	private function updateNearestInteractive():void
	{
		var _local_2:GameObject;
		var _local_3:IInteractiveObject;
		var _local_4:IInteractiveObject;
		var _local_1:Number = NaN;
		if (!map || !map.player_)
		{
			return;
		}
		var _local_5:Player = map.player_;
		var _local_6:Number = GeneralConstants.MAXIMUM_INTERACTION_DISTANCE;
		var _local_7:Number = _local_5.x_;
		var _local_8:Number = _local_5.y_;
		for each (_local_2 in map.goDict_)
		{
			_local_3 = (_local_2 as IInteractiveObject);
			if (_local_3 && (!(_local_3 is Pet) || this.map.isPetYard))
			{
				if (((Math.abs((_local_7 - _local_2.x_)) < GeneralConstants.MAXIMUM_INTERACTION_DISTANCE) || (Math.abs((_local_8 - _local_2.y_)) < GeneralConstants.MAXIMUM_INTERACTION_DISTANCE)))
				{
					_local_1 = PointUtil.distanceXY(_local_2.x_, _local_2.y_, _local_7, _local_8);
					if (((_local_1 < GeneralConstants.MAXIMUM_INTERACTION_DISTANCE) && (_local_1 < _local_6)))
					{
						_local_6 = _local_1;
						_local_4 = _local_3;
					}
				}
			}
		}
		this.mapModel.currentInteractiveTarget = _local_4;
	}

	private function isPetMap():Boolean
	{
		return (true);
	}

	public function onScreenResize(_arg_1:Event):void
	{
		var _local_2:Boolean = Parameters.data_.uiscale;
		var _local_3:Number = (800 / stage.stageWidth);
		var _local_4:Number = (600 / stage.stageHeight);
		var _local_5:Number = (_local_3 / _local_4);
		var _local_6:int = 66;
		if (this.map != null)
		{
			this.map.scaleX = (_local_3 * Parameters.data_.mscale);
			this.map.scaleY = (_local_4 * Parameters.data_.mscale);
		}
		if (this.hudView != null)
		{
			if (_local_2)
			{
				this.hudView.scaleX = _local_5;
				this.hudView.scaleY = 1;
				this.hudView.y = 0;
			}
			else
			{
				this.hudView.scaleX = _local_3;
				this.hudView.scaleY = _local_4;
				this.hudView.y = (300 * (1 - _local_4));
			}
			this.hudView.x = (800 - (200 * this.hudView.scaleX));
			if (this.creditDisplay_ != null)
			{
				this.creditDisplay_.x = (this.hudView.x - (6 * this.creditDisplay_.scaleX));
			}
		}
		if (this.questBar != null)
		{
			this.questBar.scaleX = _local_5;
			this.questBar.scaleY = 1;
		}
		if (this.chatBox_ != null)
		{
			if (_local_2)
			{
				this.chatBox_.scaleX = _local_5;
				this.chatBox_.scaleY = 1;
			}
			else
			{
				this.chatBox_.scaleX = _local_3;
				this.chatBox_.scaleY = _local_4;
			}
			this.chatBox_.y = (300 + (300 * (1 - this.chatBox_.scaleY)));
		}
		if (this.rankText_ != null)
		{
			if (_local_2)
			{
				this.rankText_.scaleX = _local_5;
				this.rankText_.scaleY = 1;
			}
			else
			{
				this.rankText_.scaleX = _local_3;
				this.rankText_.scaleY = _local_4;
			}
			this.rankText_.x = (8 * this.rankText_.scaleX);
			this.rankText_.y = (2 * this.rankText_.scaleY);
		}
		if (this.giftStatusDisplay != null)
		{
			if (_local_2)
			{
				this.giftStatusDisplay.scaleX = _local_5;
				this.giftStatusDisplay.scaleY = 1;
			}
			else
			{
				this.giftStatusDisplay.scaleX = _local_3;
				this.giftStatusDisplay.scaleY = _local_4;
			}
			this.giftStatusDisplay.x = (6 * this.giftStatusDisplay.scaleX);
			this.giftStatusDisplay.y = (_local_6 * this.giftStatusDisplay.scaleY);
			_local_6 = (_local_6 + DISPLAY_AREA_Y_SPACE);
		}
		if (this.newsModalButton != null)
		{
			if (_local_2)
			{
				this.newsModalButton.scaleX = _local_5;
				this.newsModalButton.scaleY = 1;
			}
			else
			{
				this.newsModalButton.scaleX = _local_3;
				this.newsModalButton.scaleY = _local_4;
			}
			this.newsModalButton.x = (6 * this.newsModalButton.scaleX);
			this.newsModalButton.y = (_local_6 * this.newsModalButton.scaleY);
			_local_6 = (_local_6 + DISPLAY_AREA_Y_SPACE);
		}
		if (this.specialOfferButton != null)
		{
			if (_local_2)
			{
				this.specialOfferButton.scaleX = _local_5;
				this.specialOfferButton.scaleY = 1;
			}
			else
			{
				this.specialOfferButton.scaleX = _local_3;
				this.specialOfferButton.scaleY = _local_4;
			}
			this.specialOfferButton.x = (6 * this.specialOfferButton.scaleX);
			this.specialOfferButton.y = (_local_6 * this.specialOfferButton.scaleY);
		}
		if (this.shopDisplay != null)
		{
			if (_local_2)
			{
				this.shopDisplay.scaleX = _local_5;
				this.shopDisplay.scaleY = 1;
			}
			else
			{
				this.shopDisplay.scaleX = _local_3;
				this.shopDisplay.scaleY = _local_4;
			}
			this.shopDisplay.x = (6 * this.shopDisplay.scaleX);
			this.shopDisplay.y = (34 * this.shopDisplay.scaleY);
		}
		if (this.guildText_ != null)
		{
			if (_local_2)
			{
				this.guildText_.scaleX = _local_5;
				this.guildText_.scaleY = 1;
			}
			else
			{
				this.guildText_.scaleX = _local_3;
				this.guildText_.scaleY = _local_4;
			}
			this.guildText_.x = (64 * this.guildText_.scaleX);
			this.guildText_.y = (2 * this.guildText_.scaleY);
		}
		if (this.creditDisplay_ != null)
		{
			if (_local_2)
			{
				this.creditDisplay_.scaleX = _local_5;
				this.creditDisplay_.scaleY = 1;
			}
			else
			{
				this.creditDisplay_.scaleX = _local_3;
				this.creditDisplay_.scaleY = _local_4;
			}
		}
	}

	public function connect():void
	{
		if (!this.isGameStarted)
		{
			this.isGameStarted = true;
			Renderer.inGame = true;
			gsc_.connect();
			lastUpdate_ = getTimer();
			stage.addEventListener(MoneyChangedEvent.MONEY_CHANGED, this.onMoneyChanged);
			stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			this.parent.parent.setChildIndex((this.parent.parent as Layers).top, 0);
			if (Parameters.data_.mscale == undefined)
			{
				Parameters.data_.mscale = "1.0";
			}
			if (Parameters.data_.stageScale == undefined)
			{
				Parameters.data_.stageScale = StageScaleMode.NO_SCALE;
			}
			if (Parameters.data_.uiscale == undefined)
			{
				Parameters.data_.uiscale = true;
			}
			Parameters.save();
			stage.scaleMode = Parameters.data_.stageScale;
			stage.addEventListener(Event.RESIZE, this.onScreenResize);
			stage.dispatchEvent(new Event(Event.RESIZE));
			LoopedProcess.addProcess(new LoopedCallback(100, this.updateNearestInteractive));
		}
	}

	public function disconnect():void
	{
		if (this.isGameStarted)
		{
			this.isGameStarted = false;
			Renderer.inGame = false;
			stage.removeEventListener(MoneyChangedEvent.MONEY_CHANGED, this.onMoneyChanged);
			stage.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			stage.removeEventListener(Event.RESIZE, this.onScreenResize);
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			stage.dispatchEvent(new Event(Event.RESIZE));
			LoopedProcess.destroyAll();
			((contains(map)) && (removeChild(map)));
			map.dispose();
			CachingColorTransformer.clear();
			TextureRedrawer.clearCache();
			Projectile.dispose();
			if (((this.timerCounter) && (!((Parameters.phaseName == "Realm Closed") || (Parameters.phaseName == "Oryx Shake") || (Parameters.phaseName == "Portal Opened")))))
			{
				Parameters.timerActive = false;
				this.timerCounter.visible = false;
				this.timerCounter = null;
			}
			gsc_.disconnect();
		}
	}

	private function onMoneyChanged(_arg_1:Event):void
	{
		gsc_.checkCredits();
	}

	override public function evalIsNotInCombatMapArea():Boolean
	{
		return (!((NON_COMBAT_MAPS.indexOf(map.name_) == -1)));
	}

	private function onEnterFrame(_arg_1:Event):void
	{
		var _local_2:Number = NaN;
		var _local_3:int = getTimer();
		var _local_4:int = (_local_3 - lastUpdate_);
		var _local_8:int;
		var _local_9:int;
		if (mui_.held)
		{
			_local_9 = (WebMain.STAGE.mouseX - mui_.heldX);
			Parameters.data_.cameraAngle = (mui_.heldAngle + (_local_9 * (Math.PI / 180)));
			if (!Options.hidden && Parameters.data_.tiltCam)
			{
				_local_8 = (WebMain.STAGE.mouseY - mui_.heldY);
				mui_.heldY = WebMain.STAGE.mouseY;
				this.camera_.nonPPMatrix_.appendRotation(_local_8, Vector3D.X_AXIS, null);
			}
		}
		LoopedProcess.runProcesses(_local_3);
		this.frameTimeSum_ = (this.frameTimeSum_ + _local_4);
		this.frameTimeCount_ = (this.frameTimeCount_ + 1);
		if (this.frameTimeSum_ > 300000)
		{
			_local_2 = int(Math.round(((1000 * this.frameTimeCount_) / this.frameTimeSum_)));
			this.frameTimeCount_ = 0;
			this.frameTimeSum_ = 0;
		}
		var _local_5:int = getTimer();
		map.update(_local_3, _local_4);
		this.monitor.dispatch("Map.update", (getTimer() - _local_5));
		camera_.update(_local_4);
		if (Parameters.timerActive)
		{
			if (this.timerCounter == null)
			{
				this.addTimer();
			}
			if (_local_5 >= Parameters.phaseChangeAt)
			{
				Parameters.phaseChangeAt = 2147483647;
				Parameters.timerActive = false;
				this.timerCounter.visible = false;
			}
			else
			{
				this.updateTimer(_local_5);
			}
		}
		var _local_6:Player = map.player_;
		if (this.focus)
		{
			camera_.configureCamera(this.focus, ((_local_6) ? Boolean(_local_6.isHallucinating()) : false));
			map.draw(camera_, _local_3);
		}
		if (_local_6 != null)
		{
			if (this.creditDisplay_ != null)
			{
				this.creditDisplay_.draw(_local_6.credits_, _local_6.fame_, _local_6.tokens_);
			}
			this.drawCharacterWindow.dispatch(_local_6);
			if (this.evalIsNotInCombatMapArea())
			{
				this.rankText_.draw(_local_6.numStars_);
				this.guildText_.draw(_local_6.guildName_, _local_6.guildRank_);
			}
			if (_local_6.isPaused())
			{
				map.filters = [PAUSED_FILTER];
				hudView.filters = [PAUSED_FILTER];
				map.mouseEnabled = false;
				map.mouseChildren = false;
				hudView.mouseEnabled = false;
				hudView.mouseChildren = false;
			}
			else
			{
				if (map.filters.length > 0)
				{
					map.filters = [];
					hudView.filters = [];
					map.mouseEnabled = true;
					map.mouseChildren = true;
					hudView.mouseEnabled = true;
					hudView.mouseChildren = true;
				}
			}
			moveRecords_.addRecord(_local_3, _local_6.x_, _local_6.y_);
			if (_local_6.followPlayer)
			{
				_local_6.followPos.x = _local_6.followPlayer.x_;
				_local_6.followPos.y = _local_6.followPlayer.y_;
			}
		}
		lastUpdate_ = _local_3;
		var _local_7:int = (getTimer() - _local_3);
		this.monitor.dispatch("GameSprite.loop", _local_7);
	}

	public function showPetToolTip(_arg_1:Boolean):void
	{
	}

	private function updateTimer(_arg_1:int):void
	{
		this.timerCounter.visible = true;
		this.timerCounter.setText(((Parameters.phaseName + "\n") + toTimeCode((Parameters.phaseChangeAt - _arg_1))));
	}

	public static function toTimeCode(_arg_1:Number):String
	{
		var _local_2:int = Math.floor(((_arg_1 * 0.001) % 60));
		var _local_3:String = ((_local_2 < 10) ? ("0" + _local_2) : String(_local_2));
		var _local_4:int = Math.round(Math.floor(((_arg_1 * 0.001) * 0.0166666666666667)));
		var _local_5:String = String(_local_4);
		var _local_6:String = ((_local_5 + ":") + _local_3);
		return (_local_6);
	}

	private function addTimer():void
	{
		if (this.timerCounter == null)
		{
			this.timerCounter = new TextFieldDisplayConcrete().setSize(Parameters.data_.uiTextSize).setColor(0xFFFFFF);
			this.timerCounter.mouseChildren = false;
			this.timerCounter.setBold(true);
			this.timerCounter.filters = [EMPTY_FILTER];
			this.timerCounter.x = 3;
			this.timerCounter.y = 80;
			addChild(this.timerCounter);
		}
	}

	override public function showDailyLoginCalendar():void
	{
		this.openDialog.dispatch(new DailyLoginModal());
	}

}
}//package com.company.assembleegameclient.game

