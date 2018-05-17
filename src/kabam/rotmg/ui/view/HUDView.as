//kabam.rotmg.ui.view.HUDView

package kabam.rotmg.ui.view
{
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.TradePanel;
import com.company.assembleegameclient.ui.board.HelpBoard;
import com.company.assembleegameclient.ui.icons.SimpleIconButton;
import com.company.assembleegameclient.ui.options.Options;
import com.company.assembleegameclient.ui.panels.InteractPanel;
import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
import com.company.util.AssetLibrary;
import com.company.util.GraphicsUtil;
import com.company.util.SpriteUtil;

import flash.display.BitmapData;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.friends.view.FriendListView;
import kabam.rotmg.game.view.components.StatsView;
import kabam.rotmg.game.view.components.TabStripView;
import kabam.rotmg.messaging.impl.incoming.TradeAccepted;
import kabam.rotmg.messaging.impl.incoming.TradeChanged;
import kabam.rotmg.messaging.impl.incoming.TradeStart;
import kabam.rotmg.minimap.view.MiniMapImp;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.pets.view.components.PetsTabContentView;

import org.swiftsuspenders.Injector;

public class HUDView extends Sprite implements UnFocusAble
    {

        private const BG_POSITION:Point = new Point(0, 0);
        private const MAP_POSITION:Point = new Point(4, 4);
        private const CHARACTER_DETAIL_PANEL_POSITION:Point = new Point(0, 198);
        private const STAT_METERS_POSITION:Point = new Point(12, 230);
        private const EQUIPMENT_INVENTORY_POSITION:Point = new Point(14, 304);
        private const TAB_STRIP_POSITION:Point = new Point(7, 346);
        private const INTERACT_PANEL_POSITION:Point = new Point(0, 500);

        private var background:CharacterWindowBackground;
        public var miniMap:MiniMapImp;
        private var inventory:InventoryGrid;
        private var backpack:InventoryGrid;
        private var cdtimer:CooldownTimer;
        private var equippedGrid:EquippedGrid;
        private var pet:PetsTabContentView;
        private var statMeters:StatMetersView;
        private var potions:PotionInventoryView;
        public var characterDetails:CharacterDetailsView;
        private var equippedGridBG:Sprite;
        private var player:Player;
        private var petModel:PetsModel;
        public var tabStrip:TabStripView;
        public var interactPanel:InteractPanel;
        private var mainView:Boolean = true;
        public var tradePanel:TradePanel;
        private var stats:StatsView;
        private var optButton:SimpleIconButton;
        private var frButton:SimpleIconButton;
        private var helpButton:SimpleIconButton;
        private var showButton:SimpleIconButton;
        private var upArrow:BitmapData;
        private var downArrow:BitmapData;
        private var openDialog:OpenDialogSignal;

        public function HUDView()
        {
            var _local_1:Injector = StaticInjectorContext.getInjector();
            this.petModel = _local_1.getInstance(PetsModel);
            this.openDialog = _local_1.getInstance(OpenDialogSignal);
            this.createAssets();
            this.addAssets();
            this.positionAssets();
            this.upArrow = AssetLibrary.getImageFromSet("lofiInterface", 54);
            this.downArrow = AssetLibrary.getImageFromSet("lofiInterface", 55);
            this.createButtons();
        }

        private function createAssets():void
        {
            this.background = new CharacterWindowBackground();
            this.miniMap = new MiniMapImp(192, 192);
            (this.tabStrip = new TabStripView()).visible = (Parameters.data_.normalUI || Options.hidden);
            this.characterDetails = new CharacterDetailsView();
            this.statMeters = new StatMetersView();
            (this.potions = new PotionInventoryView()).visible = (!Parameters.data_.normalUI && !Options.hidden);
            this.stats = new StatsView();
            this.stats.visible = false;
            this.cdtimer = new CooldownTimer();
        }

        private function addAssets():void
        {
            addChild(this.background);
            addChild(this.miniMap);
            addChild(this.tabStrip);
            addChild(this.characterDetails);
            addChild(this.statMeters);
            addChild(this.potions);
            addChild(this.stats);
        }

        private function createPetWindow():void
        {
            if (this.petModel.getActivePet())
            {
                this.pet = new PetsTabContentView();
                this.pet.x = 5;
                this.pet.y = 354;
                this.pet.visible = false;
                addChild(this.pet);
            }
        }

        private function createInventories():void
        {
            this.inventory = new InventoryGrid(this.player, this.player, 4);
            this.inventory.x = 14;
            this.inventory.y = 392;
            if (this.player.hasBackpack_)
            {
                this.characterDetails.visible = (Parameters.data_.normalUI || Options.hidden);
                this.backpack = new InventoryGrid(this.player, this.player, 12);
                this.inventory.x = 14;
                this.inventory.y = 304;
                this.backpack.x = 14;
                this.backpack.y = 392;
                addChild(this.backpack);
                if (!Parameters.data_.normalUI && !Options.hidden)
                {
                    this.equippedGrid.y = 198;
                    this.statMeters.y = 240;
                    this.cdtimer.y = 198;
                    this.cdtimer.visible = true;
                }
                this.stats.visible = false;
            }
            else
            {
                if (!Parameters.data_.normalUI && !Options.hidden)
                {
                    this.equippedGrid.y = 348;
                    this.stats.visible = true;
                }
                else
                {
                    this.stats.visible = false;
                }
            }
            if (Parameters.data_.normalUI || Options.hidden)
            {
                this.inventory.visible = false;
                this.cdtimer.visible = false;
                if (this.player.hasBackpack_)
                {
                    this.backpack.visible = false;
                }
            }
            addChild(this.inventory);
        }

        private function positionAssets():void
        {
            this.background.x = this.BG_POSITION.x;
            this.background.y = this.BG_POSITION.y;
            this.miniMap.x = this.MAP_POSITION.x;
            this.miniMap.y = this.MAP_POSITION.y;
            this.tabStrip.x = this.TAB_STRIP_POSITION.x;
            this.tabStrip.y = this.TAB_STRIP_POSITION.y;
            this.characterDetails.x = this.CHARACTER_DETAIL_PANEL_POSITION.x;
            this.characterDetails.y = this.CHARACTER_DETAIL_PANEL_POSITION.y;
            this.statMeters.x = this.STAT_METERS_POSITION.x;
            this.statMeters.y = this.STAT_METERS_POSITION.y;
            this.potions.x = 14;
            this.potions.y = 480;
            this.cdtimer.x = 58;
            this.cdtimer.y = 348;
            this.cdtimer.mouseEnabled = false;
            this.cdtimer.mouseChildren = false;
            this.stats.x = 10;
            this.stats.y = 294;
        }

        public function setPlayerDependentAssets(_arg_1:GameSprite):void
        {
            this.player = _arg_1.map.player_;
            this.createEquippedGridBackground();
            this.createEquippedGrid();
            this.createInteractPanel(_arg_1);
            this.createPetWindow();
            this.createInventories();
        }

        private function createInteractPanel(_arg_1:GameSprite):void
        {
            this.interactPanel = new InteractPanel(_arg_1, this.player, 200, 100);
            this.interactPanel.x = this.INTERACT_PANEL_POSITION.x;
            this.interactPanel.y = this.INTERACT_PANEL_POSITION.y;
            addChild(this.interactPanel);
        }

        private function createEquippedGrid():void
        {
            this.equippedGrid = new EquippedGrid(this.player, this.player.slotTypes_, this.player);
            this.equippedGrid.x = this.EQUIPMENT_INVENTORY_POSITION.x;
            this.equippedGrid.y = this.EQUIPMENT_INVENTORY_POSITION.y;
            addChild(this.equippedGrid);
            addChild(this.cdtimer);
        }

        private function createEquippedGridBackground():void
        {
            var _local_1:Vector.<IGraphicsData>;
            var _local_2:GraphicsSolidFill = new GraphicsSolidFill(0x676767, 1);
            var _local_3:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
            _local_1 = new <IGraphicsData>[_local_2, _local_3, GraphicsUtil.END_FILL];
            GraphicsUtil.drawCutEdgeRect(0, 0, 178, 46, 6, [1, 1, 1, 1], _local_3);
            this.equippedGridBG = new Sprite();
            if (!Parameters.data_.normalUI && !Options.hidden)
            {
                this.equippedGridBG.visible = false;
            }
            this.equippedGridBG.x = (this.EQUIPMENT_INVENTORY_POSITION.x - 3);
            this.equippedGridBG.y = (this.EQUIPMENT_INVENTORY_POSITION.y - 3);
            this.equippedGridBG.graphics.drawGraphicsData(_local_1);
            addChild(this.equippedGridBG);
        }

        public function draw():void
        {
            if (this.equippedGrid)
            {
                this.equippedGrid.draw();
            }
            if (this.interactPanel)
            {
                this.interactPanel.draw();
            }
        }

        public function startTrade(_arg_1:AGameSprite, _arg_2:TradeStart):void
        {
            if (!this.tradePanel)
            {
                this.tradePanel = new TradePanel(_arg_1, _arg_2);
                this.tradePanel.y = 200;
                this.tradePanel.addEventListener(Event.CANCEL, this.onTradeCancel);
                addChild(this.tradePanel);
                this.setNonTradePanelAssetsVisible(false);
            }
        }

        private function setNonTradePanelAssetsVisible(_arg_1:Boolean):void
        {
            if (((Parameters.data_.normalUI || Options.hidden) || (!(this.player.hasBackpack_))))
            {
                this.characterDetails.visible = _arg_1;
            }
            this.statMeters.visible = _arg_1;
            if (Parameters.data_.normalUI || Options.hidden)
            {
                this.tabStrip.visible = _arg_1;
                this.equippedGridBG.visible = _arg_1;
            }
            else
            {
                this.optButton.visible = _arg_1;
                this.frButton.visible = _arg_1;
                this.showButton.visible = _arg_1;
                this.helpButton.visible = _arg_1;
                this.potions.visible = _arg_1;
                this.inventory.visible = _arg_1;
                this.cdtimer.visible = _arg_1;
                if (this.player.hasBackpack_)
                {
                    this.backpack.visible = _arg_1;
                    this.stats.visible = false;
                }
                else
                {
                    this.stats.visible = _arg_1;
                }
            }
            if (this.pet != null)
            {
                this.pet.visible = false;
            }
            this.mainView = true;
            this.equippedGrid.visible = _arg_1;
            this.interactPanel.visible = _arg_1;
        }

        public function tradeDone():void
        {
            this.removeTradePanel();
        }

        public function tradeChanged(_arg_1:TradeChanged):void
        {
            if (this.tradePanel)
            {
                this.tradePanel.setYourOffer(_arg_1.offer_);
            }
        }

        public function tradeAccepted(_arg_1:TradeAccepted):void
        {
            if (this.tradePanel)
            {
                this.tradePanel.youAccepted(_arg_1.myOffer_, _arg_1.yourOffer_);
            }
        }

        private function onTradeCancel(_arg_1:Event):void
        {
            this.removeTradePanel();
        }

        private function removeTradePanel():void
        {
            if (this.tradePanel)
            {
                SpriteUtil.safeRemoveChild(this, this.tradePanel);
                this.tradePanel.removeEventListener(Event.CANCEL, this.onTradeCancel);
                this.tradePanel = null;
                this.setNonTradePanelAssetsVisible(true);
            }
        }

        private function createButtons():void
        {
            this.optButton = new SimpleIconButton(AssetLibrary.getImageFromSet("lofiInterfaceBig", 5));
            this.optButton.x = 176;
            this.optButton.y = 160;
            this.optButton.visible = false;
            this.optButton.addEventListener(MouseEvent.CLICK, this.openOptions);
            addChild(this.optButton);
            this.frButton = new SimpleIconButton(AssetLibrary.getImageFromSet("lofiInterfaceBig", 13));
            this.frButton.x = 176;
            this.frButton.y = 140;
            this.frButton.visible = false;
            this.frButton.addEventListener(MouseEvent.CLICK, this.openFriends);
            addChild(this.frButton);
            this.helpButton = new SimpleIconButton(AssetLibrary.getImageFromSet("lofiInterfaceBig", 18));
            this.helpButton.x = 176;
            this.helpButton.y = 120;
            this.helpButton.visible = false;
            this.helpButton.addEventListener(MouseEvent.CLICK, this.openHelp);
            addChild(this.helpButton);
            this.showButton = new SimpleIconButton(this.upArrow);
            this.showButton.x = 176;
            this.showButton.y = 176;
            this.showButton.scaleX = 2;
            this.showButton.scaleY = 2;
            this.showButton.addEventListener(MouseEvent.CLICK, this.toggleIcons);
            this.showButton.visible = (!Parameters.data_.normalUI && !Options.hidden);
            addChild(this.showButton);
        }

        private function openOptions(_arg_1:MouseEvent):void
        {
            this.toggleIcons(_arg_1);
            this.player.map_.gs_.mui_.openOptions();
        }

        private function openFriends(_arg_1:MouseEvent):void
        {
            this.toggleIcons(_arg_1);
            this.openDialog.dispatch(new FriendListView());
        }

        private function openHelp(_arg_1:MouseEvent):void
        {
            this.toggleIcons(_arg_1);
            this.openDialog.dispatch(new HelpBoard());
        }

        private function toggleIcons(_arg_1:MouseEvent):void
        {
            this.optButton.visible = (!(this.optButton.visible));
            this.frButton.visible = (!(this.frButton.visible));
            this.helpButton.visible = (!(this.helpButton.visible));
            this.showButton.changeIcon(((this.showButton.iconBitmapData_ == this.upArrow) ? this.downArrow : this.upArrow));
        }

        public function toggle():void
        {
            if (this.tradePanel)
            {
                Parameters.data_.normalUI = !Parameters.data_.normalUI;
                return;
            }
            var _local_1:Boolean = (Parameters.data_.normalUI || Options.hidden);
            var _local_2:Boolean = this.player.hasBackpack_;
            this.showButton.visible = (!(_local_1));
            if (_local_1)
            {
                this.optButton.visible = false;
                this.frButton.visible = false;
                this.helpButton.visible = false;
            }
            this.equippedGrid.visible = true;
            this.characterDetails.visible = ((_local_2) ? _local_1 : true);
            this.tabStrip.visible = _local_1;
            this.inventory.visible = (!(_local_1));
            this.potions.visible = (!(_local_1));
            this.interactPanel.y = this.INTERACT_PANEL_POSITION.y;
            this.stats.visible = ((!(_local_1)) && (!(_local_2)));
            this.cdtimer.visible = (!(_local_1));
            if (this.pet != null)
            {
                this.pet.visible = false;
            }
            this.mainView = true;
            this.equippedGrid.y = this.EQUIPMENT_INVENTORY_POSITION.y;
            this.statMeters.y = 230;
            this.equippedGridBG.visible = _local_1;
            if (_local_2)
            {
                this.backpack.visible = (!(_local_1));
                if (!_local_1)
                {
                    this.equippedGrid.y = 198;
                    this.statMeters.y = 240;
                }
            }
            else
            {
                if (!_local_1)
                {
                    this.equippedGrid.y = 348;
                }
            }
            this.statMeters.toggle();
        }

        public function toggleStats():void
        {
            this.mainView = (!(this.mainView));
            this.cdtimer.visible = this.mainView;
            if (this.player.hasBackpack_)
            {
                this.inventory.visible = this.mainView;
                this.stats.visible = (!(this.mainView));
                this.stats.y = 304;
                if (this.pet != null)
                {
                    this.backpack.visible = this.mainView;
                    this.pet.visible = (!(this.mainView));
                }
            }
            else
            {
                if (this.pet != null)
                {
                    this.equippedGrid.visible = this.mainView;
                    this.inventory.visible = this.mainView;
                    this.pet.visible = (!(this.mainView));
                }
            }
        }


    }
}//package kabam.rotmg.ui.view

