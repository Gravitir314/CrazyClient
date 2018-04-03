// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.options.Options

package com.company.assembleegameclient.ui.options
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.game.MapUserInput;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.sound.Music;
import com.company.assembleegameclient.sound.SFX;
import com.company.assembleegameclient.ui.StatusBar;
import com.company.rotmg.graphics.ScreenGraphic;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.system.Capabilities;
import flash.text.TextFieldAutoSize;
import flash.ui.Mouse;
import flash.ui.MouseCursor;
import flash.ui.MouseCursorData;

import kabam.rotmg.game.view.components.StatView;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;
import kabam.rotmg.ui.UIUtils;

public class Options extends Sprite
    {

        private static const TABS:Vector.<String> = new <String>[TextKey.OPTIONS_CONTROLS, TextKey.OPTIONS_HOTKEYS, TextKey.OPTIONS_CHAT, TextKey.OPTIONS_GRAPHICS, TextKey.OPTIONS_SOUND, AUTOAIM_, ABILMENU_, VISUAL_, DEBUFF_, EXTRA_, LOOT_, RECON_, OTHER_, MESSAGE_, "Experimental", NULL_, DBKEYS_];
        private static const AUTOAIM_:String = "Auto Aim";
        private static const EXTRA_:String = "Extra";
        private static const DEBUFF_:String = "Debuffs";
        private static const DBKEYS_:String = "DBKeys";
        private static const VISUAL_:String = "Visual";
        private static const ABILMENU_:String = "Ability";
        private static const LOOT_:String = "Loot";
        private static const RECON_:String = "Reconnect";
        private static const OTHER_:String = "Other";
        private static const MESSAGE_:String = "Messages";
        private static const NULL_:String = "";
        public static const Y_POSITION:int = 550;
        public static const CHAT_COMMAND:String = "chatCommand";
        public static const CHAT:String = "chat";
        public static const TELL:String = "tell";
        public static const GUILD_CHAT:String = "guildChat";
        public static const SCROLL_CHAT_UP:String = "scrollChatUp";
        public static const SCROLL_CHAT_DOWN:String = "scrollChatDown";
        private static var registeredCursors:Vector.<String> = new Vector.<String>(0);

        private var gs_:GameSprite;
        private var continueButton_:TitleMenuOption;
        private var resetToDefaultsButton_:TitleMenuOption;
        private var homeButton_:TitleMenuOption;
        private var tabs_:Vector.<OptionsTabTitle> = new Vector.<OptionsTabTitle>();
        private var selected_:OptionsTabTitle = null;
        private var options_:Vector.<Sprite> = new Vector.<Sprite>();

        public function Options(_arg_1:GameSprite)
        {
            var _local_2:TextFieldDisplayConcrete;
            var _local_3:OptionsTabTitle;
            var _local_4:OptionsTabTitle;
            var _local_5:int;
            var _local_7:int;
            super();
            this.gs_ = _arg_1;
            graphics.clear();
            graphics.beginFill(0x2B2B2B, 0.8);
            graphics.drawRect(0, 0, 800, 600);
            graphics.endFill();
            graphics.lineStyle(1, 0x5E5E5E);
            graphics.moveTo(0, 100);
            graphics.lineTo(800, 100);
            graphics.lineStyle();
            _local_2 = new TextFieldDisplayConcrete().setSize(32).setColor(0xFFFFFF);
            _local_2.setBold(true);
            _local_2.setStringBuilder(new LineBuilder().setParams(TextKey.OPTIONS_TITLE));
            _local_2.setAutoSize(TextFieldAutoSize.CENTER);
            _local_2.filters = [new DropShadowFilter(0, 0, 0)];
            _local_2.x = (400 - (_local_2.width / 2));
            _local_2.y = 8;
            addChild(_local_2);
            addChild(new ScreenGraphic());
            this.continueButton_ = new TitleMenuOption(TextKey.OPTIONS_CONTINUE_BUTTON, 36, false);
            this.continueButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
            this.continueButton_.setAutoSize(TextFieldAutoSize.CENTER);
            this.continueButton_.addEventListener(MouseEvent.CLICK, this.onContinueClick);
            addChild(this.continueButton_);
            this.resetToDefaultsButton_ = new TitleMenuOption(TextKey.OPTIONS_RESET_TO_DEFAULTS_BUTTON, 22, false);
            this.resetToDefaultsButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
            this.resetToDefaultsButton_.setAutoSize(TextFieldAutoSize.LEFT);
            this.resetToDefaultsButton_.addEventListener(MouseEvent.CLICK, this.onResetToDefaultsClick);
            addChild(this.resetToDefaultsButton_);
            this.homeButton_ = new TitleMenuOption(TextKey.OPTIONS_HOME_BUTTON, 22, false);
            this.homeButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
            this.homeButton_.setAutoSize(TextFieldAutoSize.RIGHT);
            this.homeButton_.addEventListener(MouseEvent.CLICK, this.onHomeClick);
            addChild(this.homeButton_);
            var _local_6:int = 8;
            _local_7 = 8;
            while (_local_5 < TABS.length)
            {
                _local_4 = new OptionsTabTitle(TABS[_local_5]);
                _local_4.x = _local_6;
                _local_4.y = (50 + (25 * int((_local_5 / _local_7))));
                if ((_local_5 % _local_7) == 0)
                {
                    _local_6 = 8;
                    _local_4.x = _local_6;
                };
                if (_local_5 == 8)
                {
                    _local_4.x = 8;
                    _local_4.y = 70;
                }
                else
                {
                    if (_local_5 == 16)
                    {
                        _local_4.x = 8;
                        _local_4.y = 85;
                    };
                };
                addChild(_local_4);
                _local_4.addEventListener(MouseEvent.CLICK, this.onTabClick);
                this.tabs_.push(_local_4);
                _local_6 = int((_local_6 + (800 / _local_7)));
                _local_5++;
            };
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        private static function makePotionBuy():ChoiceOption
        {
            return (new ChoiceOption("contextualPotionBuy", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CONTEXTUAL_POTION_BUY, TextKey.OPTIONS_CONTEXTUAL_POTION_BUY_DESC, null));
        }

        private static function makeOnOffLabels():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[makeLineBuilder(TextKey.OPTIONS_ON), makeLineBuilder(TextKey.OPTIONS_OFF)]);
        }

        private static function makeHighLowLabels():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("High"), new StaticStringBuilder("Low")]);
        }

        private static function makeCursorSelectLabels():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("ProX"), new StaticStringBuilder("X2"), new StaticStringBuilder("X3"), new StaticStringBuilder("X4"), new StaticStringBuilder("Corner1"), new StaticStringBuilder("Corner2"), new StaticStringBuilder("Symb"), new StaticStringBuilder("Alien"), new StaticStringBuilder("Xhair"), new StaticStringBuilder("Dystopia+")]);
        }

        private static function onToMaxTextToggle():void
        {
            StatusBar.barTextSignal.dispatch(Parameters.data_.toggleBarText);
            StatView.toMaxTextSignal.dispatch(Parameters.data_.toggleToMaxText);
        }

        private static function makeLineBuilder(_arg_1:String):LineBuilder
        {
            return (new LineBuilder().setParams(_arg_1));
        }

        private static function makeClickForGold():ChoiceOption
        {
            return (new ChoiceOption("clickForGold", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CLICK_FOR_GOLD, TextKey.OPTIONS_CLICK_FOR_GOLD_DESC, null));
        }

        private static function onUIQualityToggle():void
        {
            UIUtils.toggleQuality(Parameters.data_.uiQuality);
        }

        private static function onBarTextToggle():void
        {
            StatusBar.barTextSignal.dispatch(Parameters.data_.toggleBarText);
        }

        public static function refreshCursor():void
        {
            var _local_1:MouseCursorData;
            var _local_2:Vector.<BitmapData>;
            if (((!(Parameters.data_.cursorSelect == MouseCursor.AUTO)) && (registeredCursors.indexOf(Parameters.data_.cursorSelect) == -1)))
            {
                _local_1 = new MouseCursorData();
                _local_1.hotSpot = new Point(15, 15);
                _local_2 = new Vector.<BitmapData>(1, true);
                _local_2[0] = AssetLibrary.getImageFromSet("cursorsEmbed", int(Parameters.data_.cursorSelect));
                _local_1.data = _local_2;
                Mouse.registerCursor(Parameters.data_.cursorSelect, _local_1);
                registeredCursors.push(Parameters.data_.cursorSelect);
            };
            Mouse.cursor = Parameters.data_.cursorSelect;
        }

        private static function makeDegreeOptions():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("45�"), new StaticStringBuilder("0�")]);
        }

        private static function onDefaultCameraAngleChange():void
        {
            Parameters.data_.cameraAngle = Parameters.data_.defaultCameraAngle;
            Parameters.save();
        }

        private static function makeStarSelectLabels():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("Light Blue"), new StaticStringBuilder("Blue"), new StaticStringBuilder("Red"), new StaticStringBuilder("Orange"), new StaticStringBuilder("Yellow"), new StaticStringBuilder("Alone")]);
        }


        private function BoundingDistValues():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("1"), new StaticStringBuilder("2"), new StaticStringBuilder("3"), new StaticStringBuilder("4"), new StaticStringBuilder("5"), new StaticStringBuilder("6"), new StaticStringBuilder("7"), new StaticStringBuilder("8"), new StaticStringBuilder("9"), new StaticStringBuilder("10"), new StaticStringBuilder("15"), new StaticStringBuilder("20")]);
        }

        private function ZeroSix():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("0"), new StaticStringBuilder("1"), new StaticStringBuilder("2"), new StaticStringBuilder("3"), new StaticStringBuilder("4"), new StaticStringBuilder("5"), new StaticStringBuilder("6")]);
        }

        private function OneTen():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("1"), new StaticStringBuilder("2"), new StaticStringBuilder("3"), new StaticStringBuilder("4"), new StaticStringBuilder("5"), new StaticStringBuilder("6"), new StaticStringBuilder("7"), new StaticStringBuilder("8"), new StaticStringBuilder("9"), new StaticStringBuilder("10")]);
        }

        private function ZeroThirteen():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("0"), new StaticStringBuilder("1"), new StaticStringBuilder("2"), new StaticStringBuilder("3"), new StaticStringBuilder("4"), new StaticStringBuilder("5"), new StaticStringBuilder("6"), new StaticStringBuilder("7"), new StaticStringBuilder("8"), new StaticStringBuilder("9"), new StaticStringBuilder("10"), new StaticStringBuilder("11"), new StaticStringBuilder("12"), new StaticStringBuilder("13")]);
        }

        private function ZeroTwelve():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("0"), new StaticStringBuilder("1"), new StaticStringBuilder("2"), new StaticStringBuilder("3"), new StaticStringBuilder("4"), new StaticStringBuilder("5"), new StaticStringBuilder("6"), new StaticStringBuilder("7"), new StaticStringBuilder("8"), new StaticStringBuilder("9"), new StaticStringBuilder("10"), new StaticStringBuilder("11"), new StaticStringBuilder("12")]);
        }

        private function onContinueClick(_arg_1:MouseEvent):void
        {
            this.close();
        }

        private function onResetToDefaultsClick(_arg_1:MouseEvent):void
        {
            var _local_2:BaseOption;
            var _local_3:int;
            while (_local_3 < this.options_.length)
            {
                _local_2 = (this.options_[_local_3] as BaseOption);
                if (_local_2 != null)
                {
                    delete Parameters.data_[_local_2.paramName_];
                };
                _local_3++;
            };
            Parameters.setDefaults();
            Parameters.save();
            this.refresh();
        }

        private function onHomeClick(_arg_1:MouseEvent):void
        {
            this.close();
            this.gs_.closed.dispatch();
        }

        private function onTabClick(_arg_1:MouseEvent):void
        {
            var _local_2:OptionsTabTitle = (_arg_1.currentTarget as OptionsTabTitle);
            this.setSelected(_local_2);
        }

        private function setSelected(_arg_1:OptionsTabTitle):void
        {
            if (_arg_1 == this.selected_)
            {
                return;
            };
            if (this.selected_ != null)
            {
                this.selected_.setSelected(false);
            };
            this.selected_ = _arg_1;
            this.selected_.setSelected(true);
            this.removeOptions();
            switch (this.selected_.text_)
            {
                case TextKey.OPTIONS_CONTROLS:
                    this.addControlsOptions();
                    return;
                case TextKey.OPTIONS_HOTKEYS:
                    this.addHotKeysOptions();
                    return;
                case TextKey.OPTIONS_CHAT:
                    this.addChatOptions();
                    return;
                case TextKey.OPTIONS_GRAPHICS:
                    this.addGraphicsOptions();
                    return;
                case TextKey.OPTIONS_SOUND:
                    this.addSoundOptions();
                    return;
                case "Experimental":
                    this.addExperimentalOptions();
                    return;
                case DEBUFF_:
                    this.addDebuffsOptions();
                    return;
                case OTHER_:
                    this.addOtherOptions();
                    return;
                case AUTOAIM_:
                    this.addAimOptions();
                    return;
                case ABILMENU_:
                    this.addAbilityOptions();
                    return;
                case VISUAL_:
                    this.addVisualOptions();
                    return;
                case LOOT_:
                    this.addLootOptions();
                    return;
                case RECON_:
                    this.addReconnectOptions();
                    return;
                case MESSAGE_:
                    this.addMessageOptions();
                    return;
                case EXTRA_:
                    this.addExtraOptions();
                    return;
                case DBKEYS_:
                    this.dbKeys();
                    return;
            };
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            MapUserInput.optionsOpen = true;
            this.continueButton_.x = 400;
            this.continueButton_.y = Y_POSITION;
            this.resetToDefaultsButton_.x = 20;
            this.resetToDefaultsButton_.y = Y_POSITION;
            this.homeButton_.x = 780;
            this.homeButton_.y = Y_POSITION;
            this.setSelected(this.tabs_[8]);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false, 1);
            stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp, false, 1);
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            MapUserInput.optionsOpen = false;
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false);
            stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp, false);
        }

        private function onKeyDown(_arg_1:KeyboardEvent):void
        {
            if (_arg_1.keyCode == Parameters.data_.options)
            {
                this.close();
            };
            _arg_1.stopImmediatePropagation();
        }

        private function close():void
        {
            stage.focus = null;
            parent.removeChild(this);
        }

        private function onKeyUp(_arg_1:KeyboardEvent):void
        {
            _arg_1.stopImmediatePropagation();
        }

        private function removeOptions():void
        {
            var _local_1:Sprite;
            for each (_local_1 in this.options_)
            {
                removeChild(_local_1);
            };
            this.options_.length = 0;
        }

        private function addControlsOptions():void
        {
            this.addOptionAndPosition(new KeyMapper("moveUp", TextKey.OPTIONS_MOVE_UP, TextKey.OPTIONS_MOVE_UP_DESC));
            this.addOptionAndPosition(new KeyMapper("moveLeft", TextKey.OPTIONS_MOVE_LEFT, TextKey.OPTIONS_MOVE_LEFT_DESC));
            this.addOptionAndPosition(new KeyMapper("moveDown", TextKey.OPTIONS_MOVE_DOWN, TextKey.OPTIONS_MOVE_DOWN_DESC));
            this.addOptionAndPosition(new KeyMapper("moveRight", TextKey.OPTIONS_MOVE_RIGHT, TextKey.OPTIONS_MOVE_RIGHT_DESC));
            this.addOptionAndPosition(this.makeAllowCameraRotation());
            this.addOptionAndPosition(this.makeAllowMiniMapRotation());
            this.addOptionAndPosition(new KeyMapper("rotateLeft", TextKey.OPTIONS_ROTATE_LEFT, TextKey.OPTIONS_ROTATE_LEFT_DESC, (!(Parameters.data_.allowRotation))));
            this.addOptionAndPosition(new KeyMapper("rotateRight", TextKey.OPTIONS_ROTATE_RIGHT, TextKey.OPTIONS_ROTATE_RIGHT_DESC, (!(Parameters.data_.allowRotation))));
            this.addOptionAndPosition(new KeyMapper("useSpecial", TextKey.OPTIONS_USE_SPECIAL_ABILITY, TextKey.OPTIONS_USE_SPECIAL_ABILITY_DESC));
            this.addOptionAndPosition(new KeyMapper("autofireToggle", TextKey.OPTIONS_AUTOFIRE_TOGGLE, TextKey.OPTIONS_AUTOFIRE_TOGGLE_DESC));
            this.addOptionAndPosition(new KeyMapper("toggleHPBar", TextKey.OPTIONS_TOGGLE_HPBAR, TextKey.OPTIONS_TOGGLE_HPBAR_DESC));
            this.addOptionAndPosition(new KeyMapper("resetToDefaultCameraAngle", "Reset to Default Camera Angle", TextKey.OPTIONS_RESET_CAMERA_DESC));
            this.addOptionAndPosition(new KeyMapper("togglePerformanceStats", TextKey.OPTIONS_TOGGLE_PERFORMANCE_STATS, TextKey.OPTIONS_TOGGLE_PERFORMANCE_STATS_DESC));
            this.addOptionAndPosition(new KeyMapper("toggleCentering", TextKey.OPTIONS_TOGGLE_CENTERING, TextKey.OPTIONS_TOGGLE_CENTERING_DESC));
            this.addOptionAndPosition(new KeyMapper("interact", TextKey.OPTIONS_INTERACT_OR_BUY, TextKey.OPTIONS_INTERACT_OR_BUY_DESC));
            this.addOptionAndPosition(makeClickForGold());
        }

        private function onToggleUI():void
        {
            this.gs_.hudView.toggle();
        }

        private function showMobInfo_():void
        {
            if (((!(Parameters.data_.showMobInfo)) && (!(this.gs_.map.mapOverlay_ == null))))
            {
                this.gs_.map.mapOverlay_.removeChildren(0);
            };
        }

        private function scaleui():void
        {
            Parameters.root.dispatchEvent(new Event(Event.RESIZE));
        }

        private function fsv3():void
        {
            stage.scaleMode = Parameters.data_.stageScale;
            Parameters.root.dispatchEvent(new Event(Event.RESIZE));
            this.fsv3_options();
        }

        private function fsv3_options():void
        {
            var _local_1:ChoiceOption;
            var _local_2:int;
            for each (_local_1 in this.options_)
            {
                if (_local_1.paramName_ == "uiscale")
                {
                    _local_1.enable((Parameters.data_.stageScale == StageScaleMode.EXACT_FIT));
                };
            };
        }

        private function updateEffId():void
        {
            var _local_1:ChoiceOption;
            var _local_2:int;
            while (_local_2 < this.options_.length)
            {
                _local_1 = (this.options_[_local_2] as ChoiceOption);
                if (_local_1 != null)
                {
                    if (_local_1.paramName_ == "noOption")
                    {
                        _local_1.setDescription(new StaticStringBuilder(("Current Effect ID: " + this.calcEffId())));
                    };
                };
                _local_2++;
            };
        }

        private function addDebuffsOptions():void
        {
            this.addOptionAndPosition(new ChoiceOption("dbArmorBroken", makeOnOffLabels(), [true, false], "Armor Broken", "Red means you will take this status effect. Increases risk of getting disconnected when turned off.", this.updateEffId, ((Parameters.data_.dbArmorBroken) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("dbBlind", makeOnOffLabels(), [true, false], "Blind", "Red means you will take this status effect.", null, ((Parameters.data_.dbBlind) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("dbBleeding", makeOnOffLabels(), [true, false], "Bleeding", "Red means you will take this status effect. Increases risk of getting disconnected when turned off.", this.updateEffId, ((Parameters.data_.dbBleeding) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("dbConfused", makeOnOffLabels(), [true, false], "Confused", "Red means you will take this status effect.", null, ((Parameters.data_.dbConfused) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("dbDazed", makeOnOffLabels(), [true, false], "Dazed", "Red means you will take this status effect. Increases risk of getting disconnected when turned off.", this.updateEffId, ((Parameters.data_.dbDazed) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("dbDarkness", makeOnOffLabels(), [true, false], "Darkness", "Red means you will take this status effect.", null, ((Parameters.data_.dbDarkness) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("dbParalyzed", makeOnOffLabels(), [true, false], "Paralyzed", "Red means you will take this status effect. Increases risk of getting disconnected when turned off.", this.updateEffId, ((Parameters.data_.dbParalyzed) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("dbDrunk", makeOnOffLabels(), [true, false], "Drunk", "Red means you will take this status effect.", null, ((Parameters.data_.dbDrunk) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("dbSick", makeOnOffLabels(), [true, false], "Sick", "Red means you will take this status effect. Increases risk of getting disconnected when turned off.", this.updateEffId, ((Parameters.data_.dbSick) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("dbHallucinating", makeOnOffLabels(), [true, false], "Hallucinating", "Red means you will take this status effect.", null, ((Parameters.data_.dbHallucinating) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("dbSlowed", makeOnOffLabels(), [true, false], "Slowed", "Red means you will take this status effect. Increases risk of getting disconnected when turned off.", this.updateEffId, ((Parameters.data_.dbSlowed) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("dbUnstable", makeOnOffLabels(), [true, false], "Unstable", "Red means you will take this status effect.", this.unstableAbil_options, ((Parameters.data_.dbUnstable) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("dbStunned", makeOnOffLabels(), [true, false], "Stunned", "Red means you will take this status effect. Increases risk of getting disconnected when turned off.", this.updateEffId, ((Parameters.data_.dbStunned) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("dbUnstableAbil", makeOnOffLabels(), [true, false], "Unstable Ability", "Red means your ability will be affected by unstable. Unstable must be turned off for this to have an effect", null, ((Parameters.data_.dbUnstableAbil) ? 0xFF0000 : 0xFFFFFF), true));
            this.unstableAbil_options();
            this.addOptionAndPosition(new ChoiceOption("dbWeak", makeOnOffLabels(), [true, false], "Weak", "Red means you will take this status effect. Increases risk of getting disconnected when turned off.", this.updateEffId, ((Parameters.data_.dbWeak) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("noOption", new <StringBuilder>[new StaticStringBuilder("")], [], ("Current Effect ID: " + this.calcEffId()), "Turn on the effects that you want to toggle and use the value displayed here to set a hotkey for it.", null));
            this.addOptionAndPosition(new ChoiceOption("dbQuiet", makeOnOffLabels(), [true, false], "Quiet", "Red means you will take this status effect. Increases risk of getting disconnected when turned off.", this.quietCastle_options, ((Parameters.data_.dbQuiet) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("dbQuietCastle", makeOnOffLabels(), [true, false], "Quiet in Castle", "This should be turned on. If you choose not to take quiet in castle you're almost guaranteed to get disconnected.", null, ((Parameters.data_.dbQuietCastle) ? 0xFFFFFF : 0xFF0000), true));
            this.addOptionAndPosition(new ChoiceOption("dbPetStasis", makeOnOffLabels(), [true, false], "Pet Stasis", "Red means you will take this status effect. Increases risk of getting disconnected when turned off.", this.updateEffId, ((Parameters.data_.dbPetStasis) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("dbPetrify", makeOnOffLabels(), [true, false], "Petrify", "Red means you will take this status effect. Increases risk of getting disconnected when turned off.", this.updateEffId, ((Parameters.data_.dbPetrify) ? 0xFF0000 : 0xFFFFFF), true));
            this.quietCastle_options();
        }

        private function dbKeys():void
        {
            this.addOptionAndPosition(new KeyMapper("kdbArmorBroken", "Armor Broken", "Toggles the effect."));
            this.addOptionAndPosition(new KeyMapper("kdbPre1", Parameters.data_.dbPre1[0], (("EffectId: " + Parameters.data_.dbPre1[1]) + "\\nUse /eff 1 <effect id> <name> to change this preset.")));
            this.addOptionAndPosition(new KeyMapper("kdbBleeding", "Bleeding", "Toggles the effect."));
            this.addOptionAndPosition(new KeyMapper("kdbPre2", Parameters.data_.dbPre2[0], (("EffectId: " + Parameters.data_.dbPre2[1]) + "\\nUse /eff 2 <effect id> <name> to change this preset.")));
            this.addOptionAndPosition(new KeyMapper("kdbDazed", "Dazed", "Toggles the effect"));
            this.addOptionAndPosition(new KeyMapper("kdbPre3", Parameters.data_.dbPre3[0], (("EffectId: " + Parameters.data_.dbPre3[1]) + "\\nUse /eff 3 <effect id> <name> to change this preset.")));
            this.addOptionAndPosition(new KeyMapper("kdbParalyzed", "Paralyzed", "Toggles the effect."));
            this.addOptionAndPosition(new ChoiceOption("deactPre", makeOnOffLabels(), [true, false], "Auto Deactivate Presets", "Deactivates presets when leaving a dungeon.", null));
            this.addOptionAndPosition(new KeyMapper("kdbSick", "Sick", "Toggles the effect."));
            this.addOptionAndPosition(new NullOption());
            this.addOptionAndPosition(new KeyMapper("kdbSlowed", "Slowed", "Toggles the effect."));
            this.addOptionAndPosition(new NullOption());
            this.addOptionAndPosition(new KeyMapper("kdbStunned", "Stunned", "Toggles the effect."));
            this.addOptionAndPosition(new NullOption());
            this.addOptionAndPosition(new KeyMapper("kdbWeak", "Weak", "Toggles the effect."));
            this.addOptionAndPosition(new NullOption());
            this.addOptionAndPosition(new KeyMapper("kdbQuiet", "Quiet", "Toggles the effect."));
            this.addOptionAndPosition(new KeyMapper("kdbAll", "All", "Toggles all effects that can disconnect you."));
            this.addOptionAndPosition(new KeyMapper("kdbPetStasis", "Pet Stasis", "Toggles the effect."));
            this.addOptionAndPosition(new KeyMapper("kdbPetrify", "Petrify", "Toggles the effect."));
        }

        private function calcEffId():int
        {
            var _local_1:int;
            if (Parameters.data_.dbArmorBroken)
            {
                _local_1 = (_local_1 + 1);
            };
            if (Parameters.data_.dbBleeding)
            {
                _local_1 = (_local_1 + 2);
            };
            if (Parameters.data_.dbDazed)
            {
                _local_1 = (_local_1 + 4);
            };
            if (Parameters.data_.dbParalyzed)
            {
                _local_1 = (_local_1 + 8);
            };
            if (Parameters.data_.dbSick)
            {
                _local_1 = (_local_1 + 16);
            };
            if (Parameters.data_.dbSlowed)
            {
                _local_1 = (_local_1 + 32);
            };
            if (Parameters.data_.dbStunned)
            {
                _local_1 = (_local_1 + 64);
            };
            if (Parameters.data_.dbWeak)
            {
                _local_1 = (_local_1 + 128);
            };
            if (Parameters.data_.dbQuiet)
            {
                _local_1 = (_local_1 + 0x0100);
            };
            if (Parameters.data_.dbPetStasis)
            {
                _local_1 = (_local_1 + 0x0200);
            };
            if (Parameters.data_.dbPetrify)
            {
                _local_1 = (_local_1 + 0x0400);
            };
            return (_local_1);
        }

        private function quietCastle_options():void
        {
            var _local_1:ChoiceOption;
            var _local_2:int;
            this.updateEffId();
            while (_local_2 < this.options_.length)
            {
                _local_1 = (this.options_[_local_2] as ChoiceOption);
                if (_local_1 != null)
                {
                    if (_local_1.paramName_ == "dbQuietCastle")
                    {
                        _local_1.enable(Parameters.data_.dbQuiet);
                    };
                };
                _local_2++;
            };
        }

        private function unstableAbil_options():void
        {
            var _local_1:ChoiceOption;
            var _local_2:int;
            while (_local_2 < this.options_.length)
            {
                _local_1 = (this.options_[_local_2] as ChoiceOption);
                if (_local_1 != null)
                {
                    if (_local_1.paramName_ == "dbUnstableAbil")
                    {
                        _local_1.enable((!(Parameters.data_.dbUnstable)));
                    };
                };
                _local_2++;
            };
        }

        private function addAimOptions():void
        {
            this.addOptionAndPosition(new ChoiceOption("AAAddOne", makeOnOffLabels(), [true, false], "+0.5 Search Radius", "Increase the range at which auto aim will lock on and shoot at mobs by half a tile.", null));
            this.addOptionAndPosition(new KeyMapper("AAHotkey", "Auto Aim", "A key that toggles auto aim on and off."));
            this.addOptionAndPosition(new ChoiceOption("AABoundingDist", this.BoundingDistValues(), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20], "Bounding Distance", "Restrict auto aim to see only as far as the bounding distance from the mouse cursor in closest to cursor aim mode.", null));
            this.addOptionAndPosition(new KeyMapper("AAModeHotkey", "Cycle Mode", "Key that will cycle through the various auto aim modes."));
            this.addOptionAndPosition(new ChoiceOption("damageIgnored", makeOnOffLabels(), [true, false], "Damage Ignore Mobs", "Damage mobs on auto aim ignore list.", null));
            this.addOptionAndPosition(new ChoiceOption("PassesCover", makeOnOffLabels(), [true, false], "Projectile No-Clip", "Toggle allowing projectiles to pass through solid objects as well as invulnerable enemies. Only you can see the effect.", null));
            this.addOptionAndPosition(new ChoiceOption("AATargetLead", makeOnOffLabels(), [true, false], "Target Lead", "Enables leading of targets.", null));
            this.addOptionAndPosition(new KeyMapper("tPassCover", "Toggle Projectile No-Clip", "Toggles the hack on and off."));
            this.addOptionAndPosition(new ChoiceOption("autoDecrementHP", makeOnOffLabels(), [true, false], "Remove HP when dealing damage", "Decreases an enemy's health when you deal damage to them, this allows you to one shot enemies with spellbombs.", null));
        }

        private function addAbilityOptions():void
        {
            this.addOptionAndPosition(new ChoiceOption("perfectBomb", makeOnOffLabels(), [true, false], "Spell Bomb and Poison Aim", "Targets the mob with highest max health in 15 tile radius from the player.", this.pbOptions));
            this.addOptionAndPosition(new KeyMapper("pbToggle", "Toggle Ability Aim", "Toggles ability aim."));
            this.addOptionAndPosition(new ChoiceOption("perfectQuiv", makeOnOffLabels(), [true, false], "Quiver Aim", "Targets the mob closest to cursor.", null));
            this.addOptionAndPosition(new ChoiceOption("perfectLead", makeOnOffLabels(), [true, false], "Ability Aim Target Lead", "Enables leading of ability aim targets.", null));
            this.addOptionAndPosition(new ChoiceOption("perfectStun", makeOnOffLabels(), [true, false], "Shield Aim", "Targets the mob closest to cursor.", null));
            this.addOptionAndPosition(new ChoiceOption("inaccurate", makeOnOffLabels(), [true, false], "Inaccurate Ability Aim", "Look more legit by aiming inaccurately.", null));
            this.addOptionAndPosition(new ChoiceOption("autoAbil", makeOnOffLabels(), [true, false], "Auto Ability", "Automatically uses your ability on warrior, paladin and rogue. Activated by pressing space.", null));
            this.addOptionAndPosition(new ChoiceOption("palaSpam", makeOnOffLabels(), [true, false], "Spam Paladin Ability", "Uses paladin ability every 0.5 seconds if auto ability is enabled", null));
            this.addOptionAndPosition(new ChoiceOption("spellVoid", makeOnOffLabels(), [true, false], "Unsafe Prism Use", "Allows using prism through walls. If you land on void you will get disconnected.", null));
            this.addOptionAndPosition(new KeyMapper("maxPrism", "Teleport Max Distance", "Always teleports the maximum distance on Trickster. You will have to stand still for this to work."));
            this.addOptionAndPosition(new ChoiceOption("ninjaTap", makeOnOffLabels(), [true, false], "One-Tap Ninja Ability", "Makes space toggle the state of the ability. Tap to turn on, tap to turn off.", null));
            this.addOptionAndPosition(new ChoiceOption("speedy", makeOnOffLabels(), [true, false], "Disable Speedy", "Makes your character unaffected by speedy. Helps with warrior helms.", null));
            this.addOptionAndPosition(new ChoiceOption("priestAA", makeOnOffLabels(), [true, false], "Prot Auto Ability", "Keeps you armored on a priest when using Tome of Holy Protection. For infinite boost, a level 79 magic heal pet is required.", null));
            this.addOptionAndPosition(new ChoiceOption("abilTimer", makeOnOffLabels(), [true, false], "Ability Timer", "Shows time remaining on abilities that give buffs.", null));
            this.pbOptions();
        }

        private function pbOptions():void
        {
            var _local_1:ChoiceOption;
            var _local_2:int;
            while (_local_2 < this.options_.length)
            {
                _local_1 = (this.options_[_local_2] as ChoiceOption);
                if (_local_1 != null)
                {
                    if (_local_1.paramName_ == "perfectQuiv")
                    {
                        _local_1.enable((!(Parameters.data_.perfectBomb)));
                    }
                    else
                    {
                        if (_local_1.paramName_ == "perfectStun")
                        {
                            _local_1.enable((!(Parameters.data_.perfectBomb)));
                        }
                        else
                        {
                            if (_local_1.paramName_ == "perfectLead")
                            {
                                _local_1.enable((!(Parameters.data_.perfectBomb)));
                            }
                            else
                            {
                                if (_local_1.paramName_ == "pbToggle")
                                {
                                    _local_1.enable((!(Parameters.data_.perfectBomb)));
                                };
                            };
                        };
                    };
                };
                _local_2++;
            };
        }

        private function addLootOptions():void
        {
            this.addOptionAndPosition(new ChoiceOption("LNAbility", this.ZeroSix(), [0, 1, 2, 3, 4, 5, 6], "Min Ability Tier", "Minimum tier at which notifications and auto loot will function for ability items.", this.updateWanted));
            this.addOptionAndPosition(new ChoiceOption("AutoLootOn", makeOnOffLabels(), [true, false], "Auto Loot", "Items looted depend on min ability, ring, weapon, and armor tier settings.", this.loot_options));
            this.addOptionAndPosition(new ChoiceOption("LNRing", this.ZeroSix(), [0, 1, 2, 3, 4, 5, 6], "Min Ring Tier", "Minimum tier at which notifications and auto loot will function for rings.", this.updateWanted));
            this.addOptionAndPosition(new ChoiceOption("showLootNotifs", makeOnOffLabels(), [true, false], "Show Loot Notifications", "Show text notifications that tells the user what's in loot bags.", this.loot_options));
            this.addOptionAndPosition(new ChoiceOption("LNWeap", this.ZeroTwelve(), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "Min Weapon Tier", "Minimum tier at which notifications and auto loot will function for weapons.", this.updateWanted));
            this.addOptionAndPosition(new ChoiceOption("lootPreview", makeOnOffLabels(), [true, false], "Loot Preview", "Shows previews of equipment over bags", null));
            this.addOptionAndPosition(new ChoiceOption("LNArmor", this.ZeroThirteen(), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], "Min Armor Tier", "Minimum tier at which notifications and auto loot will function for armor.", this.updateWanted));
            this.addOptionAndPosition(new NullOption());
            this.addOptionAndPosition(new ChoiceOption("potsMajor", makeOnOffLabels(), [true, false], "Loot LIFE/MANA/ATT/DEF", "High value potions.", this.updateWanted));
            this.addOptionAndPosition(new ChoiceOption("lootHP", makeOnOffLabels(), [true, false], "Loot HP Potions to Inventory", "Loots health potions from ground to inventory.", null));
            this.addOptionAndPosition(new ChoiceOption("potsMinor", makeOnOffLabels(), [true, false], "Loot SPD/DEX/VIT/WIS", "Low value potions.", this.updateWanted));
            this.addOptionAndPosition(new ChoiceOption("lootMP", makeOnOffLabels(), [true, false], "Loot MP Potions to Inventory", "Loots magic potions from ground to inventory.", null));
            this.addOptionAndPosition(new ChoiceOption("drinkPot", makeOnOffLabels(), [true, false], "Drink Excess Potions", "Drinks potions when an item is about to be looted on its slot.", null));
            this.addOptionAndPosition(new ChoiceOption("grandmaMode", makeOnOffLabels(), [true, false], "Large Loot Bags and Chests", "For those of you who are legally blind.", null));
            this.loot_options();
        }

        private function updateWanted():void
        {
            Player.wantedList = null;
            this.gs_.map.player_.genWantedList();
        }

        private function loot_options():void
        {
            var _local_1:ChoiceOption;
            var _local_2:int;
            while (_local_2 < this.options_.length)
            {
                _local_1 = (this.options_[_local_2] as ChoiceOption);
                if (_local_1 != null)
                {
                    if (((((((_local_1.paramName_ == "LNAbility") || (_local_1.paramName_ == "LNRing")) || (_local_1.paramName_ == "LNWeap")) || (_local_1.paramName_ == "LNArmor")) || (_local_1.paramName_ == "potsMajor")) || (_local_1.paramName_ == "potsMinor")))
                    {
                        _local_1.enable(((Parameters.data_.AutoLootOn == false) && (Parameters.data_.showLootNotifs == false)));
                    };
                };
                _local_2++;
            };
        }

        private function updateRotate():void
        {
            Parameters.PLAYER_ROTATE_SPEED = (Parameters.data_.rotateSpeed / 1000);
            Parameters.ALLOW_SCREENSHOT_MODE;
        }

        private function addReconnectOptions():void
        {
            this.addOptionAndPosition(new KeyMapper("ReconRealm", "Recon Realm", "Key that connects the user to the last realm in."));
            this.addOptionAndPosition(new KeyMapper("ReconDung", "Recon Dungeon", "Key that connects the user to the last dungeon in. Only works when used within three minutes of connecting to the dungeon."));
            this.addOptionAndPosition(new KeyMapper("ReconVault", "Recon Vault", "Key that connects the user to their vault."));
            this.addOptionAndPosition(new KeyMapper("ReconRandom", "Connect to Random Realm", "Key that connects the user to a random realm on the server."));
            this.addOptionAndPosition(new ChoiceOption("autoRecon", makeOnOffLabels(), [true, false], "Auto Reconnect", "Automatically reconnect to last realm if HP full.", null));
        }

        private function addVisualOptions():void
        {
            this.addOptionAndPosition(new ChoiceOption("stageScale", makeOnOffLabels(), [StageScaleMode.NO_SCALE, StageScaleMode.EXACT_FIT], "Fullscreen v3", "Extends viewing area at a cost of lower fps.", this.fsv3));
            this.addOptionAndPosition(new ChoiceOption("uiscale", makeOnOffLabels(), [true, false], "Scale UI", "Scales the UI to fit the screen.", this.scaleui));
            this.fsv3_options();
            this.addOptionAndPosition(new ChoiceOption("STDamage", makeOnOffLabels(), [true, false], "Show Damage", "Show damage done to players and enemies.", null));
            this.addOptionAndPosition(new ChoiceOption("showSkins", makeOnOffLabels(), [true, false], "Show Skins", "Forces default skin to everyone when turned off.", null));
            this.addOptionAndPosition(new ChoiceOption("STHealth", makeOnOffLabels(), [true, false], "Show Health", "Show total health points of players and enemies as they take damage.", null));
            this.addOptionAndPosition(new ChoiceOption("showPests", makeOnOffLabels(), [true, false], "Show Pets", "Animal abuse.", null));
            this.addOptionAndPosition(new ChoiceOption("STColor", makeOnOffLabels(), [true, false], "Dynamic Color", "Changes the status text color based on the percentage of health the player or enemy has.", null));
            this.addOptionAndPosition(new ChoiceOption("showDyes", makeOnOffLabels(), [true, false], "Show Dyes", "Makes every player use the default dye.", null));
            this.addOptionAndPosition(new ChoiceOption("InvViewer", makeOnOffLabels(), [true, false], "Inventory Viewer", "See the inventory items of other players.", null));
            this.addOptionAndPosition(new ChoiceOption("StatsViewer", makeOnOffLabels(), [true, false], "Stat Viewer", "See the stats of other players.", null));
            this.addOptionAndPosition(new ChoiceOption("lockHighlight", makeOnOffLabels(), [true, false], "Highlight Locked Players", "Highlights locked players name and minimap dot. Requires reloading of area for changes to take effect.", null));
            this.addOptionAndPosition(new ChoiceOption("HidePlayerFilter", makeOnOffLabels(), [true, false], "Star Requirement (Hide)", "Hide players in nexus that are filtered by the star requirement option.", null));
            this.addOptionAndPosition(new ChoiceOption("AntiLag", makeOnOffLabels(), [true, false], "Anti Lag", "Aggressively disables particles.", null));
            this.addOptionAndPosition(new ChoiceOption("showMobInfo", makeOnOffLabels(), [true, false], "Display Mob Info", "Display mob name and id. Useful for finding ids for use with auto aim exception and ignore list.", this.showMobInfo_));
            this.addOptionAndPosition(new ChoiceOption("questClosest", makeOnOffLabels(), [true, false], "Show Closest Player to Quest", "Extends the quest bar to show closest player to quest and the distance from it.", null));
            this.addOptionAndPosition(new ChoiceOption("clientSwap", makeOnOffLabels(), [true, false], "Responsive Inventory", "Prevents items from teleporting out of your inventory or moving back after switching positions.", null));
            this.addOptionAndPosition(new ChoiceOption("sizer", makeOnOffLabels(), [true, false], "Shrink Large Objects", "Makes more efficient use of screen space. Hitboxes are unaffected.", null));
            this.addOptionAndPosition(new ChoiceOption("normalUI", makeOnOffLabels(), [true, false], "Normal UI", "tba", this.onToggleUI));
            this.addOptionAndPosition(new ChoiceOption("uiShadow", makeOnOffLabels(), [true, false], "UI Shadow", "tba", null));
        }

        private function addOtherOptions():void
        {
            this.addOptionAndPosition(new ChoiceOption("AutoNexus", this.AutoNexusValues(), [0, 15, 20, 25, 30], "Auto Nexus", "Will attempt to Nexus the player when health drops below the given percentage. You can still die with this on.", null));
            this.addOptionAndPosition(new ChoiceOption("autoHealP", this.AutoHealValues(), [0, 50, 55, 60, 65, 70, 75, 80], "Auto Heal", "Heals you once your HP drops low enough on priest or paladin.", null));
            this.addOptionAndPosition(new ChoiceOption("autoPot", this.AutoPotValues(), [0, 50, 55, 60, 65, 70, 75, 80], "Auto Pot", "Automatically drink a potion if your hp falls below a certain percentage.", null));
            this.addOptionAndPosition(new ChoiceOption("bestServ", this.ServerPrefValues(), ["Default", "USWest", "USMidWest", "EUWest", "USEast", "AsiaSouthEast", "USSouth", "USSouthWest", "EUEast", "EUNorth", "EUSouthWest", "USEast3", "USWest2", "USMidWest2", "USEast2", "USNorthWest", "AsiaEast", "USSouth3", "EUNorth2", "EUWest2", "EUSouth", "USSouth2", "USWest3"], "Best Server", "Select your best server.", null));
            this.addOptionAndPosition(new ChoiceOption("TradeDelay", makeOnOffLabels(), [true, false], "Disable Trade Delay", "Removes trade delay. Indicator still shows.", null));
            this.addOptionAndPosition(new ChoiceOption("SafeWalk", makeOnOffLabels(), [true, false], "Safe Walk", "Block movement onto tiles that cause damage. Click and hold left mouse to walk over these tiles.", null));
            this.addOptionAndPosition(new ChoiceOption("slideOnIce", makeOnOffLabels(), [true, false], "Slide on Ice", "Toggles sliding on ice.", null));
            this.addOptionAndPosition(new KeyMapper("incFinder", "Inc Finder", "Goes through everyone's inventory and backpack then reports if they have an incantation."));
            this.addOptionAndPosition(new ChoiceOption("rclickTp", makeOnOffLabels(), [true, false], "Right-click Chat Teleport", "Right click a chat name to teleport. No menu will be shown.", null));
            this.addOptionAndPosition(new ChoiceOption("autoTp", makeOnOffLabels(), [true, false], "Teleport Queue", "Automatically teleports after teleport cooldown if you have tried to teleport to someone during the cooldown.", null));
            this.addOptionAndPosition(new KeyMapper("QuestTeleport", "Closest Player to Quest Teleport", "Teleports to the player that is closest to your quest."));
            this.addOptionAndPosition(new KeyMapper("tpto", "Teleport to Caller", ("Teleport to a person calling a dungeon. Current keywords: " + Parameters.data_.tptoList)));
            this.addOptionAndPosition(new KeyMapper("resetCHP", "Reset Client HP", "Use this hotkey if your CL bar doesn't match your HP bar."));
            this.addOptionAndPosition(new ChoiceOption("autoCorrCHP", makeOnOffLabels(), [true, false], "Auto Correct Client HP", "Automatically corrects your health. Increases your chance of dying when turned on.", null, ((Parameters.data_.autoCorrCHP) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new KeyMapper("Cam45DegInc", "Rotate Left (90�)", "Turns your camera by 90 degrees to the left."));
            this.addOptionAndPosition(new KeyMapper("Cam45DegDec", "Rotate Right (90�)", "Turns your camera by 90 degrees to the right."));
            this.addOptionAndPosition(new KeyMapper("cam2quest", "Point Camera to Quest", "Turns your camera so that the quest is to your north."));
            this.addOptionAndPosition(new KeyMapper("enterPortal", "Portal Enter", "Enters nearest portal."));
            this.addOptionAndPosition(new ChoiceOption("instaSelect", makeOnOffLabels(), [true, false], "Instantly Select All Items", "When turned on, a right click on the trade window will select all your items instantly. When turned off, selects only items of the same type, smoothly, like an actual player.", null));
            this.addOptionAndPosition(new ChoiceOption("mapHack", makeOnOffLabels(), [true, false], "Map Hack", "Shows entire map when entering a realm. Loading in for the first time will take longer.", null));
        }

        private function addMessageOptions():void
        {
            this.addOptionAndPosition(new KeyMapper("msg1key", "Custom Message 1", (('Currently set to "' + Parameters.data_.msg1) + '". Use /setmsg 1 <message> to replace this message.')));
            this.addOptionAndPosition(new ChoiceOption("wMenu", makeOnOffLabels(), [true, false], "Show Whisper Menu Option", "Makes whisper appear under trade on player menu.", null));
            this.addOptionAndPosition(new KeyMapper("msg2key", "Custom Message 2", (('Currently set to "' + Parameters.data_.msg2) + '". Use /setmsg 2 <message> to replace this message.')));
            this.addOptionAndPosition(new ChoiceOption("conCom", makeOnOffLabels(), ["/conn", "/con"], "Replace /con with /conn", "Helps proxy users who want to use said proxy's built-in connect command.", null));
            this.addOptionAndPosition(new KeyMapper("msg3key", "Custom Message 3", (('Currently set to "' + Parameters.data_.msg3) + '". Use /setmsg 3 <message> to replace this message.')));
            this.addOptionAndPosition(new ChoiceOption("AutoReply", makeOnOffLabels(), [true, false], "Auto Reply", "Automatically replies to monster questions", null));
            this.addOptionAndPosition(new NullOption());
        }

        private function AutoNexusValues():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder(((Parameters.data_.AutoNexus == 0) ? "Off" : (Parameters.data_.AutoNexus + "%"))), new StaticStringBuilder("15%"), new StaticStringBuilder("20%"), new StaticStringBuilder("25%"), new StaticStringBuilder("30%")]);
        }

        private function AutoHealValues():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder(((Parameters.data_.autoHealP == 0) ? "Off" : (Parameters.data_.autoHealP + "%"))), new StaticStringBuilder("50%"), new StaticStringBuilder("55%"), new StaticStringBuilder("60%"), new StaticStringBuilder("65%"), new StaticStringBuilder("70%"), new StaticStringBuilder("75%"), new StaticStringBuilder("80%")]);
        }

        private function AutoPotValues():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder(((Parameters.data_.autoPot == 0) ? "Off" : (Parameters.data_.autoPot + "%"))), new StaticStringBuilder("50%"), new StaticStringBuilder("55%"), new StaticStringBuilder("60%"), new StaticStringBuilder("65%"), new StaticStringBuilder("70%"), new StaticStringBuilder("75%"), new StaticStringBuilder("80%")]);
        }

        private function AutoManaValues():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder(((Parameters.data_.autoMana == 0) ? "Off" : (Parameters.data_.autoMana + "%"))), new StaticStringBuilder("20%"), new StaticStringBuilder("30%"), new StaticStringBuilder("40%"), new StaticStringBuilder("50%"), new StaticStringBuilder("60%"), new StaticStringBuilder("70%"), new StaticStringBuilder("80%")]);
        }

        private function ServerPrefValues():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("Default"), new StaticStringBuilder("USW"), new StaticStringBuilder("USMW"), new StaticStringBuilder("EUW"), new StaticStringBuilder("USE"), new StaticStringBuilder("ASE"), new StaticStringBuilder("USS"), new StaticStringBuilder("USSW"), new StaticStringBuilder("EUE"), new StaticStringBuilder("EUN"), new StaticStringBuilder("EUSW"), new StaticStringBuilder("USE3"), new StaticStringBuilder("USW2"), new StaticStringBuilder("USMW2"), new StaticStringBuilder("USE2"), new StaticStringBuilder("USNW"), new StaticStringBuilder("AE"), new StaticStringBuilder("USS3"), new StaticStringBuilder("EUN2"), new StaticStringBuilder("EUW2"), new StaticStringBuilder("EUS"), new StaticStringBuilder("USS2"), new StaticStringBuilder("USW3")]);
        }

        private function addExtraOptions():void
        {
            this.addOptionAndPosition(new ChoiceOption("curBoss", this.bossNames(), [3368, 3366, 3367], "Current Boss", "You will only be able to hit the current boss.", null));
            this.addOptionAndPosition(new ChoiceOption("etheriteDisable", makeOnOffLabels(), [true, false], "Offset Etherite", "Offsets your firing angle if you have an Etherite equipped to make it so your shots are in a straight line", null));
            this.addOptionAndPosition(new ChoiceOption("tombHack", makeOnOffLabels(), [true, false], "Tomb Hack", "Tomb hack allows you to only damage the selected boss, leaving others unharmed even if you shoot them.", this.tombDeactivate));
            this.addOptionAndPosition(new ChoiceOption("cultistStaffDisable", makeOnOffLabels(), [true, false], "Reverse Cultist Staff", "Reverses the angle of the Staff of Unholy Sacrifice (which normally shoots backwards) to make it so you shoot forwards", null));
            this.addOptionAndPosition(new KeyMapper("tombCycle", "Next Boss", "Selects the next boss.", (!(Parameters.data_.tombHack))));
            this.addOptionAndPosition(new ChoiceOption("offsetColossus", makeOnOffLabels(), [true, false], "Offset Colossus Sword", "Attempts to shoot straight, try /colo 0.4 and /colo 0.2", null));
            this.tombDeactivate();
        }

        private function tombDeactivate():void
        {
            var _local_1:ChoiceOption;
            var _local_2:KeyMapper;
            var _local_3:int;
            while (_local_3 < this.options_.length)
            {
                _local_1 = (this.options_[_local_3] as ChoiceOption);
                if (_local_1 != null)
                {
                    if (_local_1.paramName_ == "curBoss")
                    {
                        _local_1.enable((!(Parameters.data_.tombHack)));
                    };
                };
                _local_2 = (this.options_[_local_3] as KeyMapper);
                if (_local_2 != null)
                {
                    if (_local_2.paramName_ == "tombCycle")
                    {
                        _local_2.setDisabled((!(Parameters.data_.tombHack)));
                    };
                };
                _local_3++;
            };
        }

        private function bossNames():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("Bes"), new StaticStringBuilder("Nut"), new StaticStringBuilder("Geb")]);
        }

        private function makeAllowCameraRotation():ChoiceOption
        {
            return (new ChoiceOption("allowRotation", makeOnOffLabels(), [true, false], TextKey.OPTIONS_ALLOW_ROTATION, TextKey.OPTIONS_ALLOW_ROTATION_DESC, this.onAllowRotationChange));
        }

        private function makeAllowMiniMapRotation():ChoiceOption
        {
            return (new ChoiceOption("allowMiniMapRotation", makeOnOffLabels(), [true, false], "Allow Minimap Rotation", TextKey.OPTIONS_ALLOW_MINIMAP_ROTATION_DESC, null));
        }

        private function onAllowRotationChange():void
        {
            var _local_1:KeyMapper;
            var _local_2:int;
            while (_local_2 < this.options_.length)
            {
                _local_1 = (this.options_[_local_2] as KeyMapper);
                if (_local_1 != null)
                {
                    if (((_local_1.paramName_ == "rotateLeft") || (_local_1.paramName_ == "rotateRight")))
                    {
                        _local_1.setDisabled((!(Parameters.data_.allowRotation)));
                    };
                };
                _local_2++;
            };
        }

        private function addHotKeysOptions():void
        {
            this.addOptionAndPosition(new KeyMapper("useHealthPotion", TextKey.OPTIONS_USE_BUY_HEALTH, TextKey.OPTIONS_USE_BUY_HEALTH_DESC));
            this.addOptionAndPosition(new KeyMapper("useMagicPotion", TextKey.OPTIONS_USE_BUY_MAGIC, TextKey.OPTIONS_USE_BUY_MAGIC_DESC));
            this.addInventoryOptions();
            this.addOptionAndPosition(new KeyMapper("miniMapZoomIn", TextKey.OPTIONS_MINI_MAP_ZOOM_IN, TextKey.OPTIONS_MINI_MAP_ZOOM_IN_DESC));
            this.addOptionAndPosition(new KeyMapper("miniMapZoomOut", TextKey.OPTIONS_MINI_MAP_ZOOM_OUT, TextKey.OPTIONS_MINI_MAP_ZOOM_OUT_DESC));
            this.addOptionAndPosition(new KeyMapper("escapeToNexus", TextKey.OPTIONS_ESCAPE_TO_NEXUS, TextKey.OPTIONS_ESCAPE_TO_NEXUS_DESC));
            this.addOptionAndPosition(new KeyMapper("options", TextKey.OPTIONS_SHOW_OPTIONS, TextKey.OPTIONS_SHOW_OPTIONS_DESC));
            this.addOptionAndPosition(new KeyMapper("switchTabs", TextKey.OPTIONS_SWITCH_TABS, TextKey.OPTIONS_SWITCH_TABS_DESC));
            this.addOptionAndPosition(new KeyMapper("GPURenderToggle", TextKey.OPTIONS_HARDWARE_ACC_HOTKEY_TITLE, TextKey.OPTIONS_HARDWARE_ACC_HOTKEY_DESC));
            this.addOptionsChoiceOption();
            this.addOptionAndPosition(new KeyMapper("SkipRenderKey", "Toggle Rendering", "Stops rendering the playfield. Minimap and the rest of the HUD is still updated."));
        }

        public function isAirApplication():Boolean
        {
            return (Capabilities.playerType == "Desktop");
        }

        public function addOptionsChoiceOption():void
        {
            var _local_1:String = ((Capabilities.os.split(" ")[0] == "Mac") ? "Command" : "Ctrl");
            var _local_2:ChoiceOption = new ChoiceOption("inventorySwap", makeOnOffLabels(), [true, false], "Switch Items from/to Backpack", "", null);
            _local_2.setTooltipText(new LineBuilder().setParams(TextKey.OPTIONS_SWITCH_ITEM_IN_BACKPACK_DESC, {"key":_local_1}));
            this.addOptionAndPosition(_local_2);
        }

        public function addInventoryOptions():void
        {
            var _local_1:KeyMapper;
            var _local_2:int = 1;
            while (_local_2 <= 8)
            {
                _local_1 = new KeyMapper(("useInvSlot" + _local_2), "", "");
                _local_1.setDescription(new LineBuilder().setParams(TextKey.OPTIONS_INVENTORY_SLOT_N, {"n":_local_2}));
                _local_1.setTooltipText(new LineBuilder().setParams(TextKey.OPTIONS_INVENTORY_SLOT_N_DESC, {"n":_local_2}));
                this.addOptionAndPosition(_local_1);
                _local_2++;
            };
        }

        private function addChatOptions():void
        {
            this.addOptionAndPosition(new KeyMapper(CHAT, TextKey.OPTIONS_ACTIVATE_CHAT, TextKey.OPTIONS_ACTIVATE_CHAT_DESC));
            this.addOptionAndPosition(new KeyMapper(CHAT_COMMAND, TextKey.OPTIONS_START_CHAT, TextKey.OPTIONS_START_CHAT_DESC));
            this.addOptionAndPosition(new KeyMapper(TELL, TextKey.OPTIONS_BEGIN_TELL, TextKey.OPTIONS_BEGIN_TELL_DESC));
            this.addOptionAndPosition(new KeyMapper(GUILD_CHAT, TextKey.OPTIONS_BEGIN_GUILD_CHAT, TextKey.OPTIONS_BEGIN_GUILD_CHAT_DESC));
            this.addOptionAndPosition(new KeyMapper(SCROLL_CHAT_UP, TextKey.OPTIONS_SCROLL_CHAT_UP, TextKey.OPTIONS_SCROLL_CHAT_UP_DESC));
            this.addOptionAndPosition(new KeyMapper(SCROLL_CHAT_DOWN, TextKey.OPTIONS_SCROLL_CHAT_DOWN, TextKey.OPTIONS_SCROLL_CHAT_DOWN_DESC));
            this.addOptionAndPosition(new ChoiceOption("forceChatQuality", makeOnOffLabels(), [true, false], TextKey.OPTIONS_FORCE_CHAT_QUALITY, TextKey.OPTIONS_FORCE_CHAT_QUALITY_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("hidePlayerChat", makeOnOffLabels(), [true, false], TextKey.OPTIONS_HIDE_PLAYER_CHAT, TextKey.OPTIONS_HIDE_PLAYER_CHAT_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("chatAll", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_ALL, TextKey.OPTIONS_CHAT_ALL_DESC, this.onAllChatEnabled));
            this.addOptionAndPosition(new ChoiceOption("chatWhisper", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_WHISPER, TextKey.OPTIONS_CHAT_WHISPER_DESC, this.onAllChatDisabled));
            this.addOptionAndPosition(new ChoiceOption("chatGuild", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_GUILD, TextKey.OPTIONS_CHAT_GUILD_DESC, this.onAllChatDisabled));
            this.addOptionAndPosition(new ChoiceOption("chatTrade", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_TRADE, TextKey.OPTIONS_CHAT_TRADE_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("chatStarRequirement", makeStarSelectLabels(), [0, 13, 27, 41, 55, 69, 70], TextKey.OPTIONS_STAR_REQ, "Blocks messages from players of this rank and below.", null));
        }

        private function onAllChatDisabled():void
        {
            var _local_1:ChoiceOption;
            var _local_2:int;
            Parameters.data_.chatAll = false;
            while (_local_2 < this.options_.length)
            {
                _local_1 = (this.options_[_local_2] as ChoiceOption);
                if (_local_1 != null)
                {
                    switch (_local_1.paramName_)
                    {
                        case "chatAll":
                            _local_1.refreshNoCallback();
                            break;
                    };
                };
                _local_2++;
            };
        }

        private function onAllChatEnabled():void
        {
            var _local_1:ChoiceOption;
            var _local_2:int;
            Parameters.data_.hidePlayerChat = false;
            Parameters.data_.chatWhisper = true;
            Parameters.data_.chatGuild = true;
            Parameters.data_.chatFriend = false;
            while (_local_2 < this.options_.length)
            {
                _local_1 = (this.options_[_local_2] as ChoiceOption);
                if (_local_1 != null)
                {
                    switch (_local_1.paramName_)
                    {
                        case "hidePlayerChat":
                        case "chatWhisper":
                        case "chatGuild":
                        case "chatFriend":
                            _local_1.refreshNoCallback();
                            break;
                    };
                };
                _local_2++;
            };
        }

        private function addExperimentalOptions():void
        {
            this.addOptionAndPosition(new ChoiceOption("disableEnemyParticles", makeOnOffLabels(), [true, false], "Disable Enemy Particles", "Disable enemy hit and death particles.", null));
            this.addOptionAndPosition(new ChoiceOption("disableAllyParticles", makeOnOffLabels(), [true, false], "Disable Ally Projectiles", "Disable showing projectiles shot by allies.", null));
            this.addOptionAndPosition(new ChoiceOption("disablePlayersHitParticles", makeOnOffLabels(), [true, false], "Disable Players Hit Particles", "Disable player and ally hit particles.", null));
            this.addOptionAndPosition(new ChoiceOption("toggleToMaxText", makeOnOffLabels(), [true, false], TextKey.OPTIONS_TOGGLE_TOMAXTEXT, TextKey.OPTIONS_TOGGLE_TOMAXTEXT_DESC, onToMaxTextToggle));
            this.addOptionAndPosition(new ChoiceOption("noParticlesMaster", makeOnOffLabels(), [true, false], "Disable Particles Master", "Disable all nonessential particles besides enemy and ally hits. Throw, Area and certain other effects will remain.", null));
            this.addOptionAndPosition(new ChoiceOption("noAllyNotifications", makeOnOffLabels(), [true, false], "Disable Ally Notifications", "Disable text notifications above allies.", null));
            this.addOptionAndPosition(new ChoiceOption("noEnemyDamage", makeOnOffLabels(), [true, false], "Disable Enemy Damage Text", "Disable damage from other players above enemies.", null));
            this.addOptionAndPosition(new ChoiceOption("noAllyDamage", makeOnOffLabels(), [true, false], "Disable Ally Damage Text", "Disable damage above allies.", null));
            this.addOptionAndPosition(new ChoiceOption("forceEXP", makeOnOffLabels(), [true, false], "Always Show EXP", "Show EXP notifications even when level 20.", null));
            this.addOptionAndPosition(new ChoiceOption("showFameGain", makeOnOffLabels(), [true, false], "Show Fame Gain", "Shows notifications for each fame gained.", null));
            this.addOptionAndPosition(new ChoiceOption("rotateSpeed", this.OneTen(), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], "Rotate Speed", "Change how fast your camera rotates. ( default is 3 )", this.updateRotate));
            this.addOptionAndPosition(new ChoiceOption("autoMana", this.AutoManaValues(), [0, 20, 30, 40, 50, 60, 70, 80], "Auto Mana", "Automatically drinks your mana.", null));
            this.addOptionAndPosition(new KeyMapper("Beekey", "Finder", "set it with /setfinder itemname , then when you hit the key it searches everyone for that item and tells you who has em"));
            this.addOptionAndPosition(new ChoiceOption("eventnotify", makeOnOffLabels(), [true, false], "Event Notifier", "notifies you overhead when oryx calls out a new event", null));
            this.addOptionAndPosition(new ChoiceOption("keynoti", makeOnOffLabels(), [true, false], "Key Notifier", "notifies you with a sound when a key is popped!", null));
        }

        private function addGraphicsOptions():void
        {
            var _local_1:String;
            var _local_2:Number;
            this.addOptionAndPosition(new ChoiceOption("defaultCameraAngle", makeDegreeOptions(), [((7 * Math.PI) / 4), 0], TextKey.OPTIONS_DEFAULT_CAMERA_ANGLE, TextKey.OPTIONS_DEFAULT_CAMERA_ANGLE_DESC, onDefaultCameraAngleChange));
            this.addOptionAndPosition(new ChoiceOption("centerOnPlayer", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CENTER_ON_PLAYER, TextKey.OPTIONS_CENTER_ON_PLAYER_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("showQuestPortraits", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_QUEST_PORTRAITS, TextKey.OPTIONS_SHOW_QUEST_PORTRAITS_DESC, this.onShowQuestPortraitsChange));
            this.addOptionAndPosition(new ChoiceOption("showProtips", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_TIPS, TextKey.OPTIONS_SHOW_TIPS_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("drawShadows", makeOnOffLabels(), [true, false], TextKey.OPTIONS_DRAW_SHADOWS, TextKey.OPTIONS_DRAW_SHADOWS_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("textBubbles", makeOnOffLabels(), [true, false], TextKey.OPTIONS_DRAW_TEXT_BUBBLES, TextKey.OPTIONS_DRAW_TEXT_BUBBLES_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("showTradePopup", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_TRADE_REQUEST_PANEL, TextKey.OPTIONS_SHOW_TRADE_REQUEST_PANEL_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("showGuildInvitePopup", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_GUILD_INVITE_PANEL, TextKey.OPTIONS_SHOW_GUILD_INVITE_PANEL_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("cursorSelect", makeCursorSelectLabels(), [MouseCursor.AUTO, "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"], "Custom Cursor", "Click here to change the mouse cursor. May help with aiming.", refreshCursor));
            if (!Parameters.GPURenderError)
            {
                _local_1 = TextKey.OPTIONS_HARDWARE_ACC_DESC;
                _local_2 = 0xFFFFFF;
            }
            else
            {
                _local_1 = TextKey.OPTIONS_HARDWARE_ACC_DESC_ERROR;
                _local_2 = 16724787;
            };
            this.addOptionAndPosition(new ChoiceOption("GPURender", makeOnOffLabels(), [true, false], TextKey.OPTIONS_HARDWARE_ACC_TITLE, _local_1, null, _local_2));
            this.addOptionAndPosition(new ChoiceOption("toggleBarText", makeOnOffLabels(), [true, false], TextKey.OPTIONS_TOGGLE_BARTEXT, TextKey.OPTIONS_TOGGLE_BARTEXT_DESC, onBarTextToggle));
            this.addOptionAndPosition(new ChoiceOption("particleEffect", makeHighLowLabels(), [true, false], TextKey.OPTIONS_TOGGLE_PARTICLE_EFFECT, TextKey.OPTIONS_TOGGLE_PARTICLE_EFFECT_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("uiQuality", makeHighLowLabels(), [true, false], TextKey.OPTIONS_TOGGLE_UI_QUALITY, TextKey.OPTIONS_TOGGLE_UI_QUALITY_DESC, onUIQualityToggle));
            this.addOptionAndPosition(new ChoiceOption("HPBar", makeOnOffLabels(), [true, false], TextKey.OPTIONS_HPBAR, TextKey.OPTIONS_HPBAR_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("disableEnemyParticles", makeOnOffLabels(), [true, false], "Disable Enemy Particles", "Disable particles when hit enemy and when enemy is dying.", null));
            this.addOptionAndPosition(new ChoiceOption("disableAllyParticles", makeOnOffLabels(), [true, false], "Disable Ally Particles", "Disable particles produces by shooting ally.", null));
            this.addOptionAndPosition(new ChoiceOption("disablePlayersHitParticles", makeOnOffLabels(), [true, false], "Disable Players Hit Particles", "Disable particles when player or ally is hit.", null));
        }

        private function onShowQuestPortraitsChange():void
        {
            if (((((!(this.gs_ == null)) && (!(this.gs_.map == null))) && (!(this.gs_.map.partyOverlay_ == null))) && (!(this.gs_.map.partyOverlay_.questArrow_ == null))))
            {
                this.gs_.map.partyOverlay_.questArrow_.refreshToolTip();
            };
        }

        private function onFullscreenChange():void
        {
            stage.displayState = ((Parameters.data_.fullscreenMode) ? "fullScreenInteractive" : StageDisplayState.NORMAL);
        }

        private function addSoundOptions():void
        {
            this.addOptionAndPosition(new ChoiceOption("playMusic", makeOnOffLabels(), [true, false], TextKey.OPTIONS_PLAY_MUSIC, TextKey.OPTIONS_PLAY_MUSIC_DESC, this.onPlayMusicChange));
            this.addOptionAndPosition(new SliderOption("musicVolume", this.onMusicVolumeChange), -120, 15);
            this.addOptionAndPosition(new ChoiceOption("playSFX", makeOnOffLabels(), [true, false], TextKey.OPTIONS_PLAY_SOUND_EFFECTS, TextKey.OPTIONS_PLAY_SOUND_EFFECTS_DESC, this.onPlaySoundEffectsChange));
            this.addOptionAndPosition(new SliderOption("SFXVolume", this.onSoundEffectsVolumeChange), -120, 34);
            this.addOptionAndPosition(new ChoiceOption("playPewPew", makeOnOffLabels(), [true, false], TextKey.OPTIONS_PLAY_WEAPON_SOUNDS, TextKey.OPTIONS_PLAY_WEAPON_SOUNDS_DESC, null));
        }

        private function addFriendOptions():void
        {
            this.addOptionAndPosition(new ChoiceOption("tradeWithFriends", makeOnOffLabels(), [true, false], TextKey.OPTIONS_TRADE_FRIEND, TextKey.OPTIONS_TRADE_FRIEND_DESC, this.onPlaySoundEffectsChange));
            this.addOptionAndPosition(new KeyMapper("friendList", TextKey.OPTIONS_SHOW_FRIEND_LIST, TextKey.OPTIONS_SHOW_FRIEND_LIST_DESC));
            this.addOptionAndPosition(new ChoiceOption("chatFriend", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_FRIEND, TextKey.OPTIONS_CHAT_FRIEND_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("friendStarRequirement", makeStarSelectLabels(), [0, 13, 27, 41, 55, 69, 70], TextKey.OPTIONS_STAR_REQ, TextKey.OPTIONS_FRIEND_STAR_REQ_DESC, null));
        }

        private function onPlayMusicChange():void
        {
            Music.setPlayMusic(Parameters.data_.playMusic);
            if (Parameters.data_.playMusic)
            {
                Music.setMusicVolume(1);
            }
            else
            {
                Music.setMusicVolume(0);
            };
            this.refresh();
        }

        private function onPlaySoundEffectsChange():void
        {
            SFX.setPlaySFX(Parameters.data_.playSFX);
            if (((Parameters.data_.playSFX) || (Parameters.data_.playPewPew)))
            {
                SFX.setSFXVolume(1);
            }
            else
            {
                SFX.setSFXVolume(0);
            };
            this.refresh();
        }

        private function onMusicVolumeChange(_arg_1:Number):void
        {
            Music.setMusicVolume(_arg_1);
        }

        private function onSoundEffectsVolumeChange(_arg_1:Number):void
        {
            SFX.setSFXVolume(_arg_1);
        }

        private function addOptionAndPosition(option:Option, offsetX:Number=0, offsetY:Number=0):void
        {
            var positionOption:Function;
            positionOption = function ():void
            {
                option.x = ((((options_.length % 2) == 0) ? 20 : 415) + offsetX);
                option.y = (((int((options_.length / 2)) * 41) + 110) + offsetY);
            };
            option.textChanged.addOnce(positionOption);
            this.addOption(option);
        }

        private function addOption(_arg_1:Option):void
        {
            addChild(_arg_1);
            _arg_1.addEventListener(Event.CHANGE, this.onChange);
            this.options_.push(_arg_1);
        }

        private function onChange(_arg_1:Event):void
        {
            this.refresh();
        }

        private function refresh():void
        {
            var _local_1:BaseOption;
            var _local_2:int;
            while (_local_2 < this.options_.length)
            {
                _local_1 = (this.options_[_local_2] as BaseOption);
                if (_local_1 != null)
                {
                    _local_1.refresh();
                };
                _local_2++;
            };
        }


    }
}//package com.company.assembleegameclient.ui.options

