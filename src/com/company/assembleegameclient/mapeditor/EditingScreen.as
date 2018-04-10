// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.EditingScreen

package com.company.assembleegameclient.mapeditor{
import com.company.assembleegameclient.account.ui.CheckBoxField;
import com.company.assembleegameclient.account.ui.TextInputField;
import com.company.assembleegameclient.editor.CommandEvent;
import com.company.assembleegameclient.editor.CommandList;
import com.company.assembleegameclient.editor.CommandQueue;
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.map.RegionLibrary;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.ui.DeprecatedClickableText;
import com.company.assembleegameclient.ui.dropdown.DropDown;
import com.company.util.IntPoint;
import com.company.util.SpriteUtil;
import com.hurlant.util.Base64;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.text.TextFieldAutoSize;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import kabam.lib.json.JsonParser;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.ui.view.components.ScreenBase;

import org.swiftsuspenders.Injector;

public class EditingScreen extends Sprite {

    private static const MAP_Y:int = ((600 - MEMap.SIZE) - 10);//78

    public var commandMenu_:MECommandMenu;
    private var commandQueue_:CommandQueue;
    public var meMap_:MEMap;
    public var infoPane_:InfoPane;
    public var chooserDropDown_:DropDown;
    public var mapSizeDropDown_:DropDown;
    public var choosers_:Dictionary;
    public var groundChooser_:GroundChooser;
    public var objChooser_:ObjectChooser;
    public var enemyChooser_:EnemyChooser;
    public var object3DChooser_:Object3DChooser;
    public var wallChooser_:WallChooser;
    public var allObjChooser_:AllObjectChooser;
    public var allGameObjChooser_:AllObjectChooser;
    public var regionChooser_:RegionChooser;
    public var dungeonChooser_:DungeonChooser;
    public var search:TextInputField;
    public var filter:Filter;
    public var returnButton_:TitleMenuOption;
    public var chooser_:Chooser;
    public var filename_:String = null;
    public var checkBoxArray:Array;
    private var json:JsonParser;
    private var pickObjHolder:Sprite;
    private var injector:Injector;
    private var isPlayerAdmin:Boolean;
    private var tilesBackup:Vector.<METile>;
    private var loadedFile_:FileReference = null;

    public function EditingScreen(){
        this.init();
    }

    private function init():void{
        this.injector = StaticInjectorContext.getInjector();
        var _local_1:PlayerModel = this.injector.getInstance(PlayerModel);
        this.isPlayerAdmin = _local_1.isAdmin();
        addChild(new ScreenBase());
        this.json = this.injector.getInstance(JsonParser);
        this.createCommandMenu();
        this.createMEMap();
        this.createInfoPane();
        this.createChooserDropDown();
        this.createMapSizeDropDown();
        this.createCheckboxes();
        this.createFilter();
        this.createReturnButton();
        this.createChoosers();
    }

    private function createCommandMenu():void{
        this.commandMenu_ = new MECommandMenu();
        this.commandMenu_.x = 15;
        this.commandMenu_.y = (MAP_Y - 60);
        this.commandMenu_.addEventListener(CommandEvent.UNDO_COMMAND_EVENT, this.onUndo);
        this.commandMenu_.addEventListener(CommandEvent.REDO_COMMAND_EVENT, this.onRedo);
        this.commandMenu_.addEventListener(CommandEvent.CLEAR_COMMAND_EVENT, this.onClear);
        this.commandMenu_.addEventListener(CommandEvent.LOAD_COMMAND_EVENT, this.onLoad);
        this.commandMenu_.addEventListener(CommandEvent.SAVE_COMMAND_EVENT, this.onSave);
        this.commandMenu_.addEventListener(CommandEvent.SUBMIT_COMMAND_EVENT, this.onSubmit);
        this.commandMenu_.addEventListener(CommandEvent.TEST_COMMAND_EVENT, this.onTest);
        this.commandMenu_.addEventListener(CommandEvent.SELECT_COMMAND_EVENT, this.onMenuSelect);
        addChild(this.commandMenu_);
        this.commandQueue_ = new CommandQueue();
    }

    private function createMEMap():void{
        this.meMap_ = new MEMap();
        this.meMap_.addEventListener(TilesEvent.TILES_EVENT, this.onTilesEvent);
        this.meMap_.x = ((800 / 2) - (MEMap.SIZE / 2));
        this.meMap_.y = MAP_Y;
        addChild(this.meMap_);
    }

    private function createInfoPane():void{
        this.infoPane_ = new InfoPane(this.meMap_);
        this.infoPane_.x = 4;
        this.infoPane_.y = ((600 - InfoPane.HEIGHT) - 10);
        addChild(this.infoPane_);
    }

    private function createChooserDropDown():void{
        var _local_1:Vector.<String>;
        if (this.isPlayerAdmin){
            this.chooserDropDown_ = new DropDown(GroupDivider.GROUP_LABELS, Chooser.WIDTH, 26);
        } else {
            _local_1 = GroupDivider.GROUP_LABELS.concat();
            _local_1.splice(_local_1.indexOf(AllObjectChooser.GROUP_NAME_GAME_OBJECTS), 1);
            this.chooserDropDown_ = new DropDown(_local_1, Chooser.WIDTH, 26);
        }
        this.chooserDropDown_.x = ((this.meMap_.x + MEMap.SIZE) + 4);
        this.chooserDropDown_.y = ((MAP_Y - this.chooserDropDown_.height) - 4);
        this.chooserDropDown_.addEventListener(Event.CHANGE, this.onDropDownChange);
        addChild(this.chooserDropDown_);
    }

    private function createMapSizeDropDown():void{
        var _local_1:Vector.<String> = new Vector.<String>(0);
        var _local_2:Number = MEMap.MAX_ALLOWED_SQUARES;
        while (_local_2 >= 64) {
            _local_1.push(((_local_2 + "x") + _local_2));
            _local_2 = (_local_2 / 2);
        }
        this.mapSizeDropDown_ = new DropDown(_local_1, Chooser.WIDTH, 26);
        this.mapSizeDropDown_.setValue(((MEMap.NUM_SQUARES + "x") + MEMap.NUM_SQUARES));
        this.mapSizeDropDown_.x = ((this.chooserDropDown_.x - this.chooserDropDown_.width) - 4);
        this.mapSizeDropDown_.y = this.chooserDropDown_.y;
        this.mapSizeDropDown_.addEventListener(Event.CHANGE, this.onDropDownSizeChange);
        addChild(this.mapSizeDropDown_);
    }

    private function createCheckboxes():void{
        var _local_1:DeprecatedClickableText;
        this.checkBoxArray = [];
        _local_1 = new DeprecatedClickableText(14, true, "(Show All)");
        _local_1.buttonMode = true;
        _local_1.x = (this.mapSizeDropDown_.x - 380);
        _local_1.y = (this.mapSizeDropDown_.y - 20);
        _local_1.setAutoSize(TextFieldAutoSize.LEFT);
        _local_1.addEventListener(MouseEvent.CLICK, this.onCheckBoxUpdated);
        addChild(_local_1);
        var _local_2:CheckBoxField = new CheckBoxField("Objects", true);
        _local_2.x = (_local_1.x + 80);
        _local_2.y = (this.mapSizeDropDown_.y - 20);
        _local_2.scaleX = (_local_2.scaleY = 0.8);
        _local_2.addEventListener(MouseEvent.CLICK, this.onCheckBoxUpdated);
        addChild(_local_2);
        var _local_3:DeprecatedClickableText = new DeprecatedClickableText(14, true, "(Hide All)");
        _local_3.buttonMode = true;
        _local_3.x = (this.mapSizeDropDown_.x - 380);
        _local_3.y = (this.mapSizeDropDown_.y + 8);
        _local_3.setAutoSize(TextFieldAutoSize.LEFT);
        _local_3.addEventListener(MouseEvent.CLICK, this.onCheckBoxUpdated);
        addChild(_local_3);
        var _local_4:CheckBoxField = new CheckBoxField("Regions", true);
        _local_4.x = (_local_1.x + 80);
        _local_4.y = (this.mapSizeDropDown_.y + 8);
        _local_4.scaleX = (_local_4.scaleY = 0.8);
        _local_4.addEventListener(MouseEvent.CLICK, this.onCheckBoxUpdated);
        addChild(_local_4);
        this.checkBoxArray.push(_local_1);
        this.checkBoxArray.push(_local_2);
        this.checkBoxArray.push(_local_4);
        this.checkBoxArray.push(_local_3);
    }

    private function createFilter():void{
        this.filter = new Filter();
        this.filter.x = ((this.meMap_.x + MEMap.SIZE) + 4);
        this.filter.y = MAP_Y;
        addChild(this.filter);
        this.filter.addEventListener(Event.CHANGE, this.onFilterChange);
        this.filter.enableDropDownFilter(true);
        this.filter.enableValueFilter(false);
    }

    private function createReturnButton():void{
        this.returnButton_ = new TitleMenuOption("Screens.back", 18, false);
        this.returnButton_.setAutoSize(TextFieldAutoSize.RIGHT);
        this.returnButton_.x = ((this.chooserDropDown_.x + this.chooserDropDown_.width) - 7);
        this.returnButton_.y = 2;
        addChild(this.returnButton_);
    }

    private function createChoosers():void{
        GroupDivider.divideObjects();
        this.choosers_ = new Dictionary(true);
        var _local_1:int = ((MAP_Y + this.mapSizeDropDown_.height) + 50);
        this.groundChooser_ = new GroundChooser();
        this.groundChooser_.x = this.chooserDropDown_.x;
        this.groundChooser_.y = _local_1;
        this.choosers_[GroupDivider.GROUP_LABELS[0]] = this.groundChooser_;
        this.objChooser_ = new ObjectChooser();
        this.objChooser_.x = this.chooserDropDown_.x;
        this.objChooser_.y = _local_1;
        this.choosers_[GroupDivider.GROUP_LABELS[1]] = this.objChooser_;
        this.enemyChooser_ = new EnemyChooser();
        this.enemyChooser_.x = this.chooserDropDown_.x;
        this.enemyChooser_.y = _local_1;
        this.choosers_[GroupDivider.GROUP_LABELS[2]] = this.enemyChooser_;
        this.wallChooser_ = new WallChooser();
        this.wallChooser_.x = this.chooserDropDown_.x;
        this.wallChooser_.y = _local_1;
        this.choosers_[GroupDivider.GROUP_LABELS[3]] = this.wallChooser_;
        this.object3DChooser_ = new Object3DChooser();
        this.object3DChooser_.x = this.chooserDropDown_.x;
        this.object3DChooser_.y = _local_1;
        this.choosers_[GroupDivider.GROUP_LABELS[4]] = this.object3DChooser_;
        this.allObjChooser_ = new AllObjectChooser();
        this.allObjChooser_.x = this.chooserDropDown_.x;
        this.allObjChooser_.y = _local_1;
        this.choosers_[GroupDivider.GROUP_LABELS[5]] = this.allObjChooser_;
        this.regionChooser_ = new RegionChooser();
        this.regionChooser_.x = this.chooserDropDown_.x;
        this.regionChooser_.y = _local_1;
        this.choosers_[GroupDivider.GROUP_LABELS[6]] = this.regionChooser_;
        this.dungeonChooser_ = new DungeonChooser();
        this.dungeonChooser_.x = this.chooserDropDown_.x;
        this.dungeonChooser_.y = _local_1;
        this.choosers_[GroupDivider.GROUP_LABELS[7]] = this.dungeonChooser_;
        if (this.isPlayerAdmin){
            this.allGameObjChooser_ = new AllObjectChooser();
            this.allGameObjChooser_.x = this.chooserDropDown_.x;
            this.allGameObjChooser_.y = _local_1;
            this.choosers_[GroupDivider.GROUP_LABELS[8]] = this.allGameObjChooser_;
        }
        this.chooser_ = this.groundChooser_;
        this.groundChooser_.reloadObjects("", "");
        addChild(this.groundChooser_);
        this.chooserDropDown_.setIndex(0);
    }

    private function setSearch(_arg_1:String):void{
        this.filter.removeEventListener(Event.CHANGE, this.onFilterChange);
        this.filter.setSearch(_arg_1);
        this.filter.addEventListener(Event.CHANGE, this.onFilterChange);
    }

    private function onFilterChange(_arg_1:Event):void{
        switch (this.chooser_){
            case this.groundChooser_:
                this.groundChooser_.reloadObjects(this.filter.searchStr, this.filter.filterType);
                return;
            case this.objChooser_:
                this.objChooser_.reloadObjects(this.filter.searchStr);
                return;
            case this.enemyChooser_:
                this.enemyChooser_.reloadObjects(this.filter.searchStr, this.filter.filterType, this.filter.minValue, this.filter.maxValue);
                return;
            case this.wallChooser_:
                this.wallChooser_.reloadObjects(this.filter.searchStr);
                return;
            case this.object3DChooser_:
                this.object3DChooser_.reloadObjects(this.filter.searchStr);
                return;
            case this.allObjChooser_:
                this.allObjChooser_.reloadObjects(this.filter.searchStr);
                return;
            case this.allGameObjChooser_:
                this.allGameObjChooser_.reloadObjects(this.filter.searchStr, AllObjectChooser.GROUP_NAME_MAP_OBJECTS);
                return;
            case this.regionChooser_:
                return;
            case this.dungeonChooser_:
                this.dungeonChooser_.reloadObjects(this.filter.dungeon, this.filter.searchStr);
                return;
        }
    }

    private function onCheckBoxUpdated(_arg_1:MouseEvent):void{
        var _local_2:CheckBoxField;
        switch (_arg_1.currentTarget){
            case this.checkBoxArray[0]:
                this.meMap_.ifShowGroundLayer = true;
                this.meMap_.ifShowObjectLayer = true;
                this.meMap_.ifShowRegionLayer = true;
                (this.checkBoxArray[Layer.OBJECT] as CheckBoxField).setChecked();
                (this.checkBoxArray[Layer.REGION] as CheckBoxField).setChecked();
                break;
            case this.checkBoxArray[Layer.OBJECT]:
                _local_2 = (_arg_1.currentTarget as CheckBoxField);
                this.meMap_.ifShowObjectLayer = _local_2.isChecked();
                break;
            case this.checkBoxArray[Layer.REGION]:
                _local_2 = (_arg_1.currentTarget as CheckBoxField);
                this.meMap_.ifShowRegionLayer = _local_2.isChecked();
                break;
            case this.checkBoxArray[3]:
                this.meMap_.ifShowGroundLayer = false;
                this.meMap_.ifShowObjectLayer = false;
                this.meMap_.ifShowRegionLayer = false;
                (this.checkBoxArray[Layer.OBJECT] as CheckBoxField).setUnchecked();
                (this.checkBoxArray[Layer.REGION] as CheckBoxField).setUnchecked();
                break;
        }
        this.meMap_.draw();
    }

    private function onTilesEvent(_arg_1:TilesEvent):void{
        var _local_2:IntPoint;
        var _local_3:METile;
        var _local_4:int;
        var _local_5:String;
        var _local_6:String;
        var _local_7:EditTileProperties;
        var _local_8:Vector.<METile>;
        var _local_9:Bitmap;
        var _local_10:uint;
        _local_2 = _arg_1.tiles_[0];
        switch (this.commandMenu_.getCommand()){
            case MECommandMenu.DRAW_COMMAND:
                this.addModifyCommandList(_arg_1.tiles_, this.chooser_.layer_, this.chooser_.selectedType());
                break;
            case MECommandMenu.ERASE_COMMAND:
                this.addModifyCommandList(_arg_1.tiles_, this.chooser_.layer_, -1);
                break;
            case MECommandMenu.SAMPLE_COMMAND:
                _local_4 = this.meMap_.getType(_local_2.x_, _local_2.y_, this.chooser_.layer_);
                if (_local_4 == -1){
                    return;
                }
                _local_5 = GroupDivider.getCategoryByType(_local_4, this.chooser_.layer_);
                if (_local_5 == "") break;
                this.chooser_ = this.choosers_[_local_5];
                this.chooserDropDown_.setValue(_local_5);
                this.chooser_.setSelectedType(_local_4);
                this.commandMenu_.setCommand(MECommandMenu.DRAW_COMMAND);
                break;
            case MECommandMenu.EDIT_COMMAND:
                _local_6 = this.meMap_.getObjectName(_local_2.x_, _local_2.y_);
                _local_7 = new EditTileProperties(_arg_1.tiles_, _local_6);
                _local_7.addEventListener(Event.COMPLETE, this.onEditComplete);
                addChild(_local_7);
                break;
            case MECommandMenu.CUT_COMMAND:
                this.tilesBackup = new Vector.<METile>();
                _local_8 = new Vector.<METile>();
                for each (_local_2 in _arg_1.tiles_) {
                    _local_3 = this.meMap_.getTile(_local_2.x_, _local_2.y_);
                    if (_local_3 != null){
                        _local_3 = _local_3.clone();
                    }
                    this.tilesBackup.push(_local_3);
                    _local_8.push(null);
                }
                this.addPasteCommandList(_arg_1.tiles_, _local_8);
                this.meMap_.freezeSelect();
                this.commandMenu_.setCommand(MECommandMenu.PASTE_COMMAND);
                break;
            case MECommandMenu.COPY_COMMAND:
                this.tilesBackup = new Vector.<METile>();
                for each (_local_2 in _arg_1.tiles_) {
                    _local_3 = this.meMap_.getTile(_local_2.x_, _local_2.y_);
                    if (_local_3 != null){
                        _local_3 = _local_3.clone();
                    }
                    this.tilesBackup.push(_local_3);
                }
                this.meMap_.freezeSelect();
                this.commandMenu_.setCommand(MECommandMenu.PASTE_COMMAND);
                break;
            case MECommandMenu.PASTE_COMMAND:
                this.addPasteCommandList(_arg_1.tiles_, this.tilesBackup);
                break;
            case MECommandMenu.PICK_UP_COMMAND:
                _local_3 = this.meMap_.getTile(_local_2.x_, _local_2.y_);
                if (((!(_local_3 == null)) && (!(_local_3.types_[Layer.OBJECT] == -1)))){
                    _local_9 = new Bitmap(ObjectLibrary.getTextureFromType(_local_3.types_[Layer.OBJECT]));
                    this.pickObjHolder = new Sprite();
                    this.pickObjHolder.addChild(_local_9);
                    this.pickObjHolder.startDrag();
                    this.pickObjHolder.name = String(_local_3.types_[Layer.OBJECT]);
                    this.addModifyCommandList(_arg_1.tiles_, Layer.OBJECT, -1);
                    this.commandMenu_.setCommand(MECommandMenu.DROP_COMMAND);
                }
                break;
            case MECommandMenu.DROP_COMMAND:
                if (this.pickObjHolder != null){
                    _local_10 = int(this.pickObjHolder.name);
                    this.addModifyCommandList(_arg_1.tiles_, Layer.OBJECT, _local_10);
                    this.pickObjHolder.stopDrag();
                    this.pickObjHolder.removeChildAt(0);
                    this.pickObjHolder = null;
                    this.commandMenu_.setCommand(MECommandMenu.PICK_UP_COMMAND);
                }
                break;
        }
        this.meMap_.draw();
    }

    private function onEditComplete(_arg_1:Event):void{
        var _local_2:EditTileProperties = (_arg_1.currentTarget as EditTileProperties);
        this.addObjectNameCommandList(_local_2.tiles_, _local_2.getObjectName());
    }

    private function addModifyCommandList(_arg_1:Vector.<IntPoint>, _arg_2:int, _arg_3:int):void{
        var _local_5:IntPoint;
        var _local_6:int;
        var _local_4:CommandList = new CommandList();
        for each (_local_5 in _arg_1) {
            _local_6 = this.meMap_.getType(_local_5.x_, _local_5.y_, _arg_2);
            if (_local_6 != _arg_3){
                _local_4.addCommand(new MEModifyCommand(this.meMap_, _local_5.x_, _local_5.y_, _arg_2, _local_6, _arg_3));
            }
        }
        if (_local_4.empty()){
            return;
        }
        this.commandQueue_.addCommandList(_local_4);
    }

    private function addPasteCommandList(_arg_1:Vector.<IntPoint>, _arg_2:Vector.<METile>):void{
        var _local_5:IntPoint;
        var _local_6:METile;
        var _local_3:CommandList = new CommandList();
        var _local_4:int;
        for each (_local_5 in _arg_1) {
            if (_local_4 >= _arg_2.length) break;
            _local_6 = this.meMap_.getTile(_local_5.x_, _local_5.y_);
            _local_3.addCommand(new MEReplaceCommand(this.meMap_, _local_5.x_, _local_5.y_, _local_6, _arg_2[_local_4]));
            _local_4++;
        }
        if (_local_3.empty()){
            return;
        }
        this.commandQueue_.addCommandList(_local_3);
    }

    private function addObjectNameCommandList(_arg_1:Vector.<IntPoint>, _arg_2:String):void{
        var _local_4:IntPoint;
        var _local_5:String;
        var _local_3:CommandList = new CommandList();
        for each (_local_4 in _arg_1) {
            _local_5 = this.meMap_.getObjectName(_local_4.x_, _local_4.y_);
            if (_local_5 != _arg_2){
                _local_3.addCommand(new MEObjectNameCommand(this.meMap_, _local_4.x_, _local_4.y_, _local_5, _arg_2));
            }
        }
        if (_local_3.empty()){
            return;
        }
        this.commandQueue_.addCommandList(_local_3);
    }

    private function safeRemoveCategoryChildren():void{
        SpriteUtil.safeRemoveChild(this, this.groundChooser_);
        SpriteUtil.safeRemoveChild(this, this.objChooser_);
        SpriteUtil.safeRemoveChild(this, this.enemyChooser_);
        SpriteUtil.safeRemoveChild(this, this.regionChooser_);
        SpriteUtil.safeRemoveChild(this, this.wallChooser_);
        SpriteUtil.safeRemoveChild(this, this.object3DChooser_);
        SpriteUtil.safeRemoveChild(this, this.allObjChooser_);
        SpriteUtil.safeRemoveChild(this, this.allGameObjChooser_);
        SpriteUtil.safeRemoveChild(this, this.dungeonChooser_);
    }

    private function onDropDownChange(_arg_1:Event=null):void{
        switch (this.chooserDropDown_.getValue()){
            case GroundLibrary.GROUND_CATEGORY:
                if (!this.groundChooser_.hasBeenLoaded){
                    this.groundChooser_.reloadObjects("", "");
                }
                this.setSearch(this.groundChooser_.getLastSearch());
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.groundChooser_);
                this.chooser_ = this.groundChooser_;
                this.filter.setFilterType(ObjectLibrary.TILE_FILTER_LIST);
                this.filter.enableDropDownFilter(true);
                this.filter.enableValueFilter(false);
                this.filter.enableDungeonFilter(false);
                return;
            case "Basic Objects":
                if (!this.objChooser_.hasBeenLoaded){
                    this.objChooser_.reloadObjects("");
                }
                this.setSearch(this.objChooser_.getLastSearch());
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.objChooser_);
                this.chooser_ = this.objChooser_;
                this.filter.enableDropDownFilter(false);
                this.filter.enableValueFilter(false);
                this.filter.enableDungeonFilter(false);
                return;
            case "Enemies":
                if (!this.enemyChooser_.hasBeenLoaded){
                    this.enemyChooser_.reloadObjects("", "", 0, -1);
                }
                this.setSearch(this.enemyChooser_.getLastSearch());
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.enemyChooser_);
                this.chooser_ = this.enemyChooser_;
                this.filter.setFilterType(ObjectLibrary.ENEMY_FILTER_LIST);
                this.filter.enableDropDownFilter(true);
                this.filter.enableValueFilter(true);
                this.filter.enableDungeonFilter(false);
                return;
            case "Regions":
                this.setSearch("");
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.regionChooser_);
                this.chooser_ = this.regionChooser_;
                this.filter.enableDropDownFilter(false);
                this.filter.enableValueFilter(false);
                this.filter.enableDungeonFilter(false);
                return;
            case "Walls":
                if (!this.wallChooser_.hasBeenLoaded){
                    this.wallChooser_.reloadObjects("");
                }
                this.setSearch(this.wallChooser_.getLastSearch());
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.wallChooser_);
                this.chooser_ = this.wallChooser_;
                this.filter.enableDropDownFilter(false);
                this.filter.enableValueFilter(false);
                this.filter.enableDungeonFilter(false);
                return;
            case "3D Objects":
                if (!this.object3DChooser_.hasBeenLoaded){
                    this.object3DChooser_.reloadObjects("");
                }
                this.setSearch(this.object3DChooser_.getLastSearch());
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.object3DChooser_);
                this.chooser_ = this.object3DChooser_;
                this.filter.enableDropDownFilter(false);
                this.filter.enableValueFilter(false);
                this.filter.enableDungeonFilter(false);
                return;
            case "All Map Objects":
                if (!this.allObjChooser_.hasBeenLoaded){
                    this.allObjChooser_.reloadObjects("");
                }
                this.setSearch(this.allObjChooser_.getLastSearch());
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.allObjChooser_);
                this.chooser_ = this.allObjChooser_;
                this.filter.enableDropDownFilter(false);
                this.filter.enableValueFilter(false);
                return;
            case "All Game Objects":
                if (!this.allGameObjChooser_.hasBeenLoaded){
                    this.allGameObjChooser_.reloadObjects("", AllObjectChooser.GROUP_NAME_GAME_OBJECTS);
                }
                this.setSearch(this.allGameObjChooser_.getLastSearch());
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.allGameObjChooser_);
                this.chooser_ = this.allGameObjChooser_;
                this.filter.enableDropDownFilter(false);
                this.filter.enableValueFilter(false);
                return;
            case "Dungeons":
                if (!this.dungeonChooser_.hasBeenLoaded){
                    this.dungeonChooser_.reloadObjects(GroupDivider.DEFAULT_DUNGEON, "");
                }
                this.setSearch(this.dungeonChooser_.getLastSearch());
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.dungeonChooser_);
                this.chooser_ = this.dungeonChooser_;
                this.filter.enableDropDownFilter(false);
                this.filter.enableValueFilter(false);
                this.filter.enableDungeonFilter(true);
                return;
        }
    }

    private function onDropDownSizeChange(_arg_1:Event):void{
        var _local_2:Number;
        switch (this.mapSizeDropDown_.getValue()){
            case "64x64":
                _local_2 = 64;
                break;
            case "128x128":
                _local_2 = 128;
                break;
            case "256x256":
                _local_2 = 0x0100;
                break;
            case "512x512":
                _local_2 = 0x0200;
                break;
            case "1024x1024":
                _local_2 = 0x0400;
                break;
        }
        this.meMap_.resize(_local_2);
        this.meMap_.draw();
    }

    private function onUndo(_arg_1:CommandEvent):void{
        this.commandQueue_.undo();
        this.meMap_.draw();
    }

    private function onRedo(_arg_1:CommandEvent):void{
        this.commandQueue_.redo();
        this.meMap_.draw();
    }

    private function onClear(_arg_1:CommandEvent):void{
        var _local_4:IntPoint;
        var _local_5:METile;
        var _local_2:Vector.<IntPoint> = this.meMap_.getAllTiles();
        var _local_3:CommandList = new CommandList();
        for each (_local_4 in _local_2) {
            _local_5 = this.meMap_.getTile(_local_4.x_, _local_4.y_);
            if (_local_5 != null){
                _local_3.addCommand(new MEClearCommand(this.meMap_, _local_4.x_, _local_4.y_, _local_5));
            }
        }
        if (_local_3.empty()){
            return;
        }
        this.commandQueue_.addCommandList(_local_3);
        this.meMap_.draw();
        this.filename_ = null;
    }

    private function createMapJSON():String{
        var _local_7:int;
        var _local_8:METile;
        var _local_9:Object;
        var _local_10:String;
        var _local_11:int;
        var _local_1:Rectangle = this.meMap_.getTileBounds();
        if (_local_1 == null){
            return (null);
        }
        var _local_2:Object = {};
        _local_2["width"] = int(_local_1.width);
        _local_2["height"] = int(_local_1.height);
        var _local_3:Object = {};
        var _local_4:Array = [];
        var _local_5:ByteArray = new ByteArray();
        var _local_6:int = _local_1.y;
        while (_local_6 < _local_1.bottom) {
            _local_7 = _local_1.x;
            while (_local_7 < _local_1.right) {
                _local_8 = this.meMap_.getTile(_local_7, _local_6);
                _local_9 = this.getEntry(_local_8);
                _local_10 = this.json.stringify(_local_9);
                if (!_local_3.hasOwnProperty(_local_10)){
                    _local_11 = _local_4.length;
                    _local_3[_local_10] = _local_11;
                    _local_4.push(_local_9);
                } else {
                    _local_11 = _local_3[_local_10];
                }
                _local_5.writeShort(_local_11);
                _local_7++;
            }
            _local_6++;
        }
        _local_2["dict"] = _local_4;
        _local_5.compress();
        _local_2["data"] = Base64.encodeByteArray(_local_5);
        return (this.json.stringify(_local_2));
    }

    private function onSave(_arg_1:CommandEvent):void{
        var _local_2:String = this.createMapJSON();
        if (_local_2 == null){
            return;
        }
        new FileReference().save(_local_2, ((this.filename_ == null) ? "map.jm" : this.filename_));
    }

    private function onSubmit(_arg_1:CommandEvent):void{
        var _local_2:String = this.createMapJSON();
        if (_local_2 == null){
            return;
        }
        this.meMap_.setMinZoom();
        this.meMap_.draw();
        dispatchEvent(new SubmitJMEvent(_local_2, this.meMap_.getMapStatistics()));
    }

    private function getEntry(_arg_1:METile):Object{
        var _local_3:Vector.<int>;
        var _local_4:String;
        var _local_5:Object;
        var _local_2:Object = {};
        if (_arg_1 != null){
            _local_3 = _arg_1.types_;
            if (_local_3[Layer.GROUND] != -1){
                _local_4 = GroundLibrary.getIdFromType(_local_3[Layer.GROUND]);
                _local_2["ground"] = _local_4;
            }
            if (_local_3[Layer.OBJECT] != -1){
                _local_4 = ObjectLibrary.getIdFromType(_local_3[Layer.OBJECT]);
                _local_5 = {"id":_local_4};
                if (_arg_1.objName_ != null){
                    _local_5["name"] = _arg_1.objName_;
                }
                _local_2["objs"] = [_local_5];
            }
            if (_local_3[Layer.REGION] != -1){
                _local_4 = RegionLibrary.getIdFromType(_local_3[Layer.REGION]);
                _local_2["regions"] = [{"id":_local_4}];
            }
        }
        return (_local_2);
    }

    private function onLoad(_arg_1:CommandEvent):void{
        this.loadedFile_ = new FileReference();
        this.loadedFile_.addEventListener(Event.SELECT, this.onFileBrowseSelect);
        this.loadedFile_.browse([new FileFilter("JSON Map (*.jm)", "*.jm")]);
    }

    private function onFileBrowseSelect(event:Event):void{
        var loadedFile:FileReference = (event.target as FileReference);
        loadedFile.addEventListener(Event.COMPLETE, this.onFileLoadComplete);
        loadedFile.addEventListener(IOErrorEvent.IO_ERROR, this.onFileLoadIOError);
        try {
            loadedFile.load();
        } catch(e:Error) {
        }
    }

    private function onFileLoadComplete(_arg_1:Event):void{
        var _local_7:String;
        var _local_11:int;
        var _local_13:int;
        var _local_14:Object;
        var _local_15:Array;
        var _local_16:Array;
        var _local_17:Object;
        var _local_18:Object;
        var _local_2:FileReference = (_arg_1.target as FileReference);
        this.filename_ = _local_2.name;
        var _local_3:Object = this.json.parse(_local_2.data.toString());
        var _local_4:int = _local_3["width"];
        var _local_5:int = _local_3["height"];
        var _local_6:Number = 64;
        while (((_local_6 < _local_3["width"]) || (_local_6 < _local_3["height"]))) {
            _local_6 = (_local_6 * 2);
        }
        if (MEMap.NUM_SQUARES != _local_6){
            _local_7 = ((_local_6 + "x") + _local_6);
            if (!this.mapSizeDropDown_.setValue(_local_7)){
                this.mapSizeDropDown_.setValue("512x512");
            }
        }
        var _local_8:Rectangle = new Rectangle(int(((MEMap.NUM_SQUARES / 2) - (_local_4 / 2))), int(((MEMap.NUM_SQUARES / 2) - (_local_5 / 2))), _local_4, _local_5);
        this.meMap_.clear();
        this.commandQueue_.clear();
        var _local_9:Array = _local_3["dict"];
        var _local_10:ByteArray = Base64.decodeToByteArray(_local_3["data"]);
        _local_10.uncompress();
        var _local_12:int = _local_8.y;
        while (_local_12 < _local_8.bottom) {
            _local_13 = _local_8.x;
            while (_local_13 < _local_8.right) {
                _local_14 = _local_9[_local_10.readShort()];
                if (_local_14.hasOwnProperty("ground")){
                    _local_11 = GroundLibrary.idToType_[_local_14["ground"]];
                    this.meMap_.modifyTile(_local_13, _local_12, Layer.GROUND, _local_11);
                }
                _local_15 = _local_14["objs"];
                if (_local_15 != null){
                    for each (_local_17 in _local_15) {
                        if (ObjectLibrary.idToType_.hasOwnProperty(_local_17["id"])){
                            _local_11 = ObjectLibrary.idToType_[_local_17["id"]];
                            this.meMap_.modifyTile(_local_13, _local_12, Layer.OBJECT, _local_11);
                            if (_local_17.hasOwnProperty("name")){
                                this.meMap_.modifyObjectName(_local_13, _local_12, _local_17["name"]);
                            }
                        }
                    }
                }
                _local_16 = _local_14["regions"];
                if (_local_16 != null){
                    for each (_local_18 in _local_16) {
                        _local_11 = RegionLibrary.idToType_[_local_18["id"]];
                        this.meMap_.modifyTile(_local_13, _local_12, Layer.REGION, _local_11);
                    }
                }
                _local_13++;
            }
            _local_12++;
        }
        this.meMap_.draw();
    }

    public function disableInput():void{
        removeChild(this.commandMenu_);
    }

    public function enableInput():void{
        addChild(this.commandMenu_);
    }

    private function onFileLoadIOError(_arg_1:Event):void{
    }

    private function onTest(_arg_1:Event):void{
        dispatchEvent(new MapTestEvent(this.createMapJSON()));
    }

    private function onMenuSelect(_arg_1:Event):void{
        if (this.meMap_ != null){
            this.meMap_.clearSelect();
        }
    }


}
}//package com.company.assembleegameclient.mapeditor

