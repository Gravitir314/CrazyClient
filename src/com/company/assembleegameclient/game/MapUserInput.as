//com.company.assembleegameclient.game.MapUserInput

package com.company.assembleegameclient.game
{
import com.company.assembleegameclient.game.events.ReconnectEvent;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.GuildHallPortal;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.Portal;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.options.Options;
import com.company.util.KeyCodes;

import flash.display.Stage;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.utils.getTimer;

import io.decagames.rotmg.social.SocialPopupView;
import io.decagames.rotmg.ui.popups.signals.CloseAllPopupsSignal;
import io.decagames.rotmg.ui.popups.signals.ClosePopupByClassSignal;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.chat.control.ParseChatMessageSignal;
import kabam.rotmg.chat.control.TextHandler;
import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.constants.UseType;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.friends.view.FriendListView;
import kabam.rotmg.game.model.PotionInventoryModel;
import kabam.rotmg.game.model.UseBuyPotionVO;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.game.signals.ExitGameSignal;
import kabam.rotmg.game.signals.GiftStatusUpdateSignal;
import kabam.rotmg.game.signals.SetTextBoxVisibilitySignal;
import kabam.rotmg.game.signals.UseBuyPotionSignal;
import kabam.rotmg.game.view.components.StatsTabHotKeyInputSignal;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.minimap.control.MiniMapZoomSignal;
import kabam.rotmg.pets.controller.reskin.ReskinPetFlowStartSignal;
import kabam.rotmg.servers.api.Server;
import kabam.rotmg.ui.model.TabStripModel;

import net.hires.debug.Stats;

import org.swiftsuspenders.Injector;

public class MapUserInput
    {
        private static var stats_:Stats = new Stats();
        public static var reconRealm:ReconnectEvent;
        public static var reconVault:ReconnectEvent;
        public static var reconRandom:ReconnectEvent;
        public static var reconDaily:ReconnectEvent;
        public static var reconDung:ReconnectEvent;
        public static var dungTime:uint = 0;
        public static var skipRender:Boolean = false;
        public static var optionsOpen:Boolean = false;
        public static var inputting:Boolean = false;

        public var ninjaTapped:Boolean = false;
        public var gs_:GameSprite;
        public var mouseDown_:Boolean = false;
        public var autofire_:Boolean = false;
        public var specialKeyDown_:Boolean = false;
        public var held:Boolean = false;
        public var heldX:int = 0;
        public var heldY:int = 0;
        public var heldAngle:Number = 0;
        private var maxprism:Boolean = false;
        private var spaceSpam:int = 0;
        private var tabStripModel:TabStripModel;
        private var moveLeft_:int = 0;
        private var moveRight_:int = 0;
        private var moveUp_:int = 0;
        private var moveDown_:int = 0;
        private var rotateLeft_:int = 0;
        private var rotateRight_:int = 0;
        private var currentString:String = "";
        private var enablePlayerInput_:Boolean = true;
        private var giftStatusUpdateSignal:GiftStatusUpdateSignal;
        private var addTextLine:AddTextLineSignal;
        private var setTextBoxVisibility:SetTextBoxVisibilitySignal;
        private var statsTabHotKeyInputSignal:StatsTabHotKeyInputSignal;
        private var miniMapZoom:MiniMapZoomSignal;
        private var useBuyPotionSignal:UseBuyPotionSignal;
        private var potionInventoryModel:PotionInventoryModel;
        private var openDialogSignal:OpenDialogSignal;
        private var closeDialogSignal:CloseDialogsSignal;
        private var closePopupByClassSignal:ClosePopupByClassSignal;
        private var layers:Layers;
        private var exitGame:ExitGameSignal;
        private var areFKeysAvailable:Boolean;
        private var reskinPetFlowStart:ReskinPetFlowStartSignal;
        private var isFriendsListOpen:Boolean;
        private var parseChatMessage:ParseChatMessageSignal;

        public function MapUserInput(_arg_1:GameSprite)
        {
            this.gs_ = _arg_1;
            this.gs_.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.gs_.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            var _local_2:Injector = StaticInjectorContext.getInjector();
            this.giftStatusUpdateSignal = _local_2.getInstance(GiftStatusUpdateSignal);
            this.reskinPetFlowStart = _local_2.getInstance(ReskinPetFlowStartSignal);
            this.addTextLine = _local_2.getInstance(AddTextLineSignal);
            this.tabStripModel = _local_2.getInstance(TabStripModel);
            this.setTextBoxVisibility = _local_2.getInstance(SetTextBoxVisibilitySignal);
            this.miniMapZoom = _local_2.getInstance(MiniMapZoomSignal);
            this.useBuyPotionSignal = _local_2.getInstance(UseBuyPotionSignal);
            this.potionInventoryModel = _local_2.getInstance(PotionInventoryModel);
            this.layers = _local_2.getInstance(Layers);
            this.statsTabHotKeyInputSignal = _local_2.getInstance(StatsTabHotKeyInputSignal);
            this.exitGame = _local_2.getInstance(ExitGameSignal);
            this.openDialogSignal = _local_2.getInstance(OpenDialogSignal);
            this.closeDialogSignal = _local_2.getInstance(CloseDialogsSignal);
            this.closePopupByClassSignal = _local_2.getInstance(ClosePopupByClassSignal);
            this.parseChatMessage = _local_2.getInstance(ParseChatMessageSignal);
            var _local_3:ApplicationSetup = _local_2.getInstance(ApplicationSetup);
            this.areFKeysAvailable = _local_3.areDeveloperHotkeysEnabled();
            this.gs_.map.signalRenderSwitch.add(this.onRenderSwitch);
        }

        public function onRenderSwitch(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                this.gs_.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                this.gs_.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
                this.gs_.map.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                this.gs_.map.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            }
            else
            {
                this.gs_.map.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                this.gs_.map.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
                this.gs_.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                this.gs_.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            }
        }

        public function clearInput():void
        {
            this.moveLeft_ = 0;
            this.moveRight_ = 0;
            this.moveUp_ = 0;
            this.moveDown_ = 0;
            this.rotateLeft_ = 0;
            this.rotateRight_ = 0;
            this.mouseDown_ = false;
            this.autofire_ = false;
            this.maxprism = false;
            this.setPlayerMovement();
        }

        public function setEnablePlayerInput(_arg_1:Boolean):void
        {
            if (this.enablePlayerInput_ != _arg_1)
            {
                this.enablePlayerInput_ = _arg_1;
                this.clearInput();
            }
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            var _local_2:Stage = this.gs_.stage;
            _local_2.addEventListener(Event.ACTIVATE, this.onActivate);
            _local_2.addEventListener(Event.DEACTIVATE, this.onDeactivate);
            _local_2.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            _local_2.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            _local_2.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            _local_2.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            _local_2.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            _local_2.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            _local_2.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onRightMouseDown_forWorld);
            _local_2.addEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onRightMouseUp_forWorld);
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            var _local_2:Stage = this.gs_.stage;
            _local_2.removeEventListener(Event.ACTIVATE, this.onActivate);
            _local_2.removeEventListener(Event.DEACTIVATE, this.onDeactivate);
            _local_2.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            _local_2.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            _local_2.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            _local_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            _local_2.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            _local_2.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            _local_2.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onRightMouseDown_forWorld);
            _local_2.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onRightMouseUp_forWorld);
        }

        private function onActivate(_arg_1:Event):void
        {
        }

        private function onDeactivate(_arg_1:Event):void
        {
            this.clearInput();
        }

        public function onMouseDown(_arg_1:MouseEvent):void
        {
            var _local_2:Number;
            var _local_3:int;
            var _local_4:XML;
            var _local_5:Number;
            var _local_6:Number;
            if (((!(this.gs_.hudView == null)) && (this.gs_.mouseX >= this.gs_.hudView.x)))
            {
                return;
            }
            if (optionsOpen)
            {
                return;
            }
            this.mouseDown_ = true;
            var _local_7:Player = this.gs_.map.player_;
            if (_local_7 == null)
            {
                return;
            }
            if (!this.enablePlayerInput_)
            {
                return;
            }
            if (_arg_1.shiftKey)
            {
                _local_3 = _local_7.equipment_[1];
                if (_local_3 == -1)
                {
                    return;
                }
                _local_4 = ObjectLibrary.xmlLibrary_[_local_3];
                if (((_local_4 == null) || (_local_4.hasOwnProperty("EndMpCost"))))
                {
                    return;
                }
                if (_local_7.isUnstable())
                {
                    _local_5 = ((Math.random() * 600) - 300);
                    _local_6 = ((Math.random() * 600) - 325);
                }
                else
                {
                    _local_5 = this.gs_.map.mouseX;
                    _local_6 = this.gs_.map.mouseY;
                }
                if (Parameters.isGpuRender())
                {
                    if ((((_arg_1.currentTarget == _arg_1.target) || (_arg_1.target == this.gs_.map)) || (_arg_1.target == this.gs_)))
                    {
                        _local_7.useAltWeapon(_local_5, _local_6, UseType.START_USE);
                    }
                }
                else
                {
                    _local_7.useAltWeapon(_local_5, _local_6, UseType.START_USE);
                }
                return;
            }
            if (Parameters.isGpuRender())
            {
                if (((((_arg_1.currentTarget == _arg_1.target) || (_arg_1.target == this.gs_.map)) || (_arg_1.target == this.gs_)) || (_arg_1.currentTarget == this.gs_.chatBox_.list)))
                {
                    _local_2 = Math.atan2(this.gs_.map.mouseY, this.gs_.map.mouseX);
                }
                else
                {
                    return;
                }
            }
            else
            {
                _local_2 = Math.atan2(this.gs_.map.mouseY, this.gs_.map.mouseX);
            }
            if (_local_7.isUnstable())
            {
                _local_7.attemptAttackAngle((Math.random() * 360));
            }
            else
            {
                _local_7.attemptAttackAngle(_local_2);
            }
        }

        public function onMouseUp(_arg_1:MouseEvent):void
        {
            this.mouseDown_ = false;
            var _local_2:Player = this.gs_.map.player_;
            if (_local_2 == null)
            {
                return;
            }
            _local_2.isShooting = false;
        }

        private function onMouseWheel(_arg_1:MouseEvent):void
        {
            if (_arg_1.delta > 0)
            {
                this.miniMapZoom.dispatch(MiniMapZoomSignal.IN);
            }
            else
            {
                this.miniMapZoom.dispatch(MiniMapZoomSignal.OUT);
            }
        }

        private function onEnterFrame(_arg_1:Event):void
        {
            var _local_2:Player;
            var _local_3:Number;
            if ((((this.enablePlayerInput_) && ((this.mouseDown_) || (this.autofire_))) || (Parameters.data_.AAOn)))
            {
                _local_2 = this.gs_.map.player_;
                if (_local_2 != null)
                {
                    if (_local_2.isUnstable())
                    {
                        _local_2.attemptAttackAngle((Math.random() * 360));
                    }
                    else
                    {
                        _local_3 = Math.atan2(this.gs_.map.mouseY, this.gs_.map.mouseX);
                        _local_2.attemptAttackAngle(_local_3);
                    }
                }
            }
        }

        private function handleAutoAbil(_arg_1:Player):Boolean
        {
            if (!((((_arg_1.objectType_ == 0x0300) || (_arg_1.objectType_ == 797)) || (_arg_1.objectType_ == 799)) || ((_arg_1.objectType_ == 784) && (Parameters.data_.priestAA))))
            {
                return (false);
            }
            if (this.spaceSpam >= getTimer())
            {
                if (_arg_1.mapAutoAbil)
                {
                    _arg_1.mapAutoAbil = false;
                    _arg_1.notifyPlayer("Auto Ability: Disabled", 0xFF00, 1500);
                }
                return (true);
            }
            this.spaceSpam = (getTimer() + 500);
            switch (_arg_1.equipment_[1])
            {
                case 2855:
                case 2785:
                case 8333:
                case 2857:
                case 8335:
                case 2667:
                case 3080:
                case 2225:
                case 2854:
                case 2645:
                case 8344:
                case 8610:
                case 3102:
                case 5854:
                    _arg_1.mapAutoAbil = (!(_arg_1.mapAutoAbil));
                    _arg_1.notifyPlayer(((_arg_1.mapAutoAbil) ? "Auto Ability: Enabled" : "Auto Ability: Disabled"), 0xFF00, 1500);
                    return (true);
                case 2642:
                case 2777:
                case 2643:
                case 2778:
                case 2644:
                case 2611:
                case 2651:
                case 2853:
                case 3081:
                case 8342:
                    if (Parameters.data_.palaSpam)
                    {
                        _arg_1.mapAutoAbil = (!(_arg_1.mapAutoAbil));
                        _arg_1.notifyPlayer(((_arg_1.mapAutoAbil) ? "Auto Ability: Enabled" : "Auto Ability: Disabled"), 0xFF00, 1500);
                        return (true);
                    }
            }
            return (false);
        }

        private function isIgnored(_arg_1:int):Boolean
        {
            var _local_2:int;
            for each (_local_2 in Parameters.data_.AAIgnore)
            {
                if (_arg_1 == _local_2)
                {
                    return (true);
                }
            }
            if ((((Parameters.data_.tombHack) && (_arg_1 >= 3366)) && (_arg_1 <= 3368)))
            {
                if (_arg_1 != Parameters.data_.curBoss)
                {
                    return (true);
                }
            }
            return (false);
        }

        private function handlePerfectAim(_arg_1:Player):void
        {
            var _local_2:GameObject;
            var _local_3:GameObject;
            var _local_4:int;
            var _local_5:Point = _arg_1.sToW(this.gs_.map.mouseX, this.gs_.map.mouseY);
            var _local_6:int = int.MAX_VALUE;
            var _local_7:Number = 0.015;
            for each (_local_3 in this.gs_.map.goDict_)
            {
                if ((((_local_3.props_.isEnemy_) && (_local_3.maxHP_ >= 1000)) && (!(this.isIgnored(_local_3.objectType_)))))
                {
                    _local_4 = (((_local_3.x_ - _local_5.x) * (_local_3.x_ - _local_5.x)) + ((_local_3.y_ - _local_5.y) * (_local_3.y_ - _local_5.y)));
                    if (_local_4 < _local_6)
                    {
                        _local_6 = _local_4;
                        _local_2 = _local_3;
                    }
                }
            }
            if (_local_2 == null)
            {
                _arg_1.notifyPlayer("No targets nearby!", 0xFF00, 1500);
            }
            else
            {
                _arg_1.notifyPlayer(ObjectLibrary.typeToDisplayId_[_local_2.objectType_], 0xFF00, 1500);
                if (!Parameters.data_.perfectLead)
                {
                    this.aimAt(_arg_1, new Vector3D(_local_2.x_, _local_2.y_));
                }
                else
                {
                    if (((_arg_1.objectType_ == 798) || (_arg_1.equipment_[1] == 5139)))
                    {
                        _local_7 = 0.016;
                    }
                    if (_arg_1.equipment_[1] == 3395)
                    {
                        _local_7 = 0.014;
                    }
                    this.aimAt(_arg_1, _arg_1.leadPos(new Vector3D(_arg_1.x_, _arg_1.y_), new Vector3D(_local_2.x_, _local_2.y_), new Vector3D(_local_2.moveVec_.x, _local_2.moveVec_.y), _local_7));
                }
            }
        }

        private function aimAt(_arg_1:Player, _arg_2:Vector3D):void
        {
            if (Parameters.data_.inaccurate)
            {
                _arg_2.x = (int(_arg_2.x) + 0.5);
                _arg_2.y = (int(_arg_2.y) + 0.5);
            }
            this.gs_.gsc_.useItem(getTimer(), _arg_1.objectId_, 1, _arg_1.equipment_[1], _arg_2.x, _arg_2.y, UseType.START_USE);
            _arg_1.doShoot(getTimer(), _arg_1.equipment_[1], ObjectLibrary.xmlLibrary_[_arg_1.equipment_[1]], Math.atan2((_arg_2.y - _arg_1.y_), (_arg_2.x - _arg_1.x_)), false);
        }

        private function handlePerfectBomb(_arg_1:Player):Boolean
        {
            var _local_2:GameObject;
            var _local_3:GameObject;
            var _local_4:int;
            if ((((Parameters.data_.perfectQuiv) && (_arg_1.objectType_ == 775)) || ((Parameters.data_.perfectStun) && (_arg_1.objectType_ == 798))))
            {
                this.handlePerfectAim(_arg_1);
                return (true);
            }
            if (!((_arg_1.objectType_ == 782) || (_arg_1.objectType_ == 800)))
            {
                return (false);
            }
            for each (_local_3 in this.gs_.map.goDict_)
            {
                if ((((_local_3.props_.isEnemy_) && (_local_3.maxHP_ >= Parameters.data_.spellThreshold)) && (!(this.isIgnored(_local_3.objectType_)))))
                {
                    _local_4 = (((_local_3.x_ - _arg_1.x_) * (_local_3.x_ - _arg_1.x_)) + ((_local_3.y_ - _arg_1.y_) * (_local_3.y_ - _arg_1.y_)));
                    if (_local_4 < 225)
                    {
                        if (((_local_2 == null) || (_local_3.maxHP_ > _local_2.maxHP_)))
                        {
                            _local_2 = _local_3;
                        }
                    }
                }
            }
            if (_local_2 == null)
            {
                _arg_1.notifyPlayer("No targets nearby!", 0xFF00, 1500);
            }
            else
            {
                if ((((_local_2.isInvincible()) || (_local_2.isInvulnerable())) || (_local_2.isStasis())))
                {
                    _arg_1.notifyPlayer((ObjectLibrary.typeToDisplayId_[_local_2.objectType_] + ": Invulnerable"), 0xFF00, 1500);
                }
                else
                {
                    _arg_1.notifyPlayer(ObjectLibrary.typeToDisplayId_[_local_2.objectType_], 0xFF00, 1500);
                    if (Parameters.data_.inaccurate)
                    {
                        this.gs_.gsc_.useItem(getTimer(), _arg_1.objectId_, 1, _arg_1.equipment_[1], (int(_local_2.x_) + (1 / 2)), (int(_local_2.y_) + (1 / 2)), UseType.START_USE);
                    }
                    else
                    {
                        this.gs_.gsc_.useItem(getTimer(), _arg_1.objectId_, 1, _arg_1.equipment_[1], _local_2.x_, _local_2.y_, UseType.START_USE);
                    }
                }
            }
            return (true);
        }

        private function handleCooldown(_arg_1:Player, _arg_2:XML):void
        {
            var _local_3:Number = 500;
            if (_arg_2.hasOwnProperty("Cooldown"))
            {
                _local_3 = (Number(_arg_2.Cooldown) * 1000);
            }
            _arg_1.lastAltAttack_ = getTimer();
            _arg_1.nextAltAttack_ = (getTimer() + _local_3);
        }

        private function ninjaTap(_arg_1:Player):Boolean
        {
            if (_arg_1.objectType_ != 806)
            {
                return (false);
            }
            this.ninjaTapped = (!(this.ninjaTapped));
            if (this.ninjaTapped)
            {
                _arg_1.useAltWeapon(this.gs_.map.mouseX, this.gs_.map.mouseY, UseType.START_USE);
            }
            else
            {
                _arg_1.useAltWeapon(this.gs_.map.mouseX, this.gs_.map.mouseY, UseType.END_USE);
            }
            return (true);
        }

        private function abilityUsed(_arg_1:Player, _arg_2:XML):void
        {
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            this.specialKeyDown_ = true;
            if (_arg_1 == null)
            {
                return;
            }
            if (((Parameters.data_.autoAbil) && (this.handleAutoAbil(_arg_1))))
            {
                return;
            }
            if (_arg_1.nextAltAttack_ >= getTimer())
            {
                return;
            }
            if (int(_arg_2.MpCost) > _arg_1.mp_)
            {
                return;
            }
            if (((Parameters.data_.perfectBomb) && (this.handlePerfectBomb(_arg_1))))
            {
                this.handleCooldown(_arg_1, _arg_2);
                return;
            }
            if (((Parameters.data_.ninjaTap) && (this.ninjaTap(_arg_1))))
            {
                return;
            }
            if (((this.maxprism) && ((_arg_1.objectType_ == 804) || (_arg_1.equipment_[1] == 2650))))
            {
                _local_3 = Math.atan2(this.gs_.map.mouseX, this.gs_.map.mouseY);
                if (_local_3 < 0)
                {
                    _local_3 = (_local_3 + (Math.PI * 2));
                }
                _local_4 = ((13 * 50) * Math.sin(_local_3));
                _local_5 = ((13 * 50) * Math.cos(_local_3));
                _arg_1.useAltWeapon(_local_4, _local_5, UseType.START_USE);
                return;
            }
            if (((_arg_1.isUnstable()) && (Parameters.data_.dbUnstableAbil)))
            {
                _arg_1.useAltWeapon(((Math.random() * 600) - 300), ((Math.random() * 600) - 325), UseType.START_USE);
            }
            else
            {
                _arg_1.useAltWeapon(this.gs_.map.mouseX, this.gs_.map.mouseY, UseType.START_USE);
            }
        }

        private function onKeyDown(_arg_1:KeyboardEvent):void
        {
            var _local_2:GameObject;
            var _local_3:int;
            var _local_4:GameObject;
            var _local_5:int;
            var _local_6:Array;
            var _local_7:Point;
            var _local_8:String;
            var _local_9:int;
            var _local_10:int;
            var _local_11:Player;
            var _local_12:int;
            var _local_13:int;
            var _local_14:String;
            var _local_15:String;
            var _local_16:Server;
            var _local_17:ReconnectEvent;
            var _local_18:Server;
            var _local_19:ReconnectEvent;
            var _local_20:CloseAllPopupsSignal;
            var _local_21:Player = this.gs_.map.player_;
            var _local_22:ShowPopupSignal;
            var _local_23:Square;
            var _local_24:OpenDialogSignal;
            switch (_arg_1.keyCode)
            {
                case KeyCodes.F1:
                case KeyCodes.F2:
                case KeyCodes.F3:
                case KeyCodes.F4:
                case KeyCodes.F5:
                case KeyCodes.F6:
                case KeyCodes.F7:
                case KeyCodes.F8:
                case KeyCodes.F9:
                case KeyCodes.F10:
                case KeyCodes.F11:
                case KeyCodes.F12:
                case KeyCodes.INSERT:
                case KeyCodes.ALTERNATE:
                    break;
                default:
                    if (this.gs_.stage.focus != null)
                    {
                        return;
                    }
            }
            switch (_arg_1.keyCode)
            {
                case Parameters.data_.moveUp:
                    this.moveUp_ = 1;
                    break;
                case Parameters.data_.moveDown:
                    this.moveDown_ = 1;
                    break;
                case Parameters.data_.moveLeft:
                    this.moveLeft_ = 1;
                    break;
                case Parameters.data_.moveRight:
                    this.moveRight_ = 1;
                    break;
                case Parameters.data_.useSpecial:
                    this.abilityUsed(_local_21, ObjectLibrary.xmlLibrary_[_local_21.equipment_[1]]);
                    break;
                case Parameters.data_.QuestTeleport:
                    _local_4 = this.gs_.map.quest_.getObject(1);
                    if (_local_4 != null)
                    {
                        _local_3 = int.MAX_VALUE;
                        _local_8 = "";
                        for each (_local_2 in this.gs_.map.goDict_)
                        {
                            if ((_local_2 is Player))
                            {
                                _local_9 = (((_local_2.x_ - _local_4.x_) * (_local_2.x_ - _local_4.x_)) + ((_local_2.y_ - _local_4.y_) * (_local_2.y_ - _local_4.y_)));
                                if (_local_9 < _local_3)
                                {
                                    _local_3 = _local_9;
                                    _local_8 = _local_2.name_;
                                }
                            }
                        }
                        if (_local_8 == _local_21.name_)
                        {
                            _local_21.notifyPlayer("You are the closest!", 0xFF00, 1500);
                            break;
                        }
                        this.gs_.gsc_.teleport(_local_8);
                    }
                    else
                    {
                        _local_21.notifyPlayer("You have no quest!", 0xFF00, 1500);
                    }
                    break;
                case Parameters.data_.enterPortal:
                    _local_3 = int.MAX_VALUE;
                    _local_5 = -1;
                    for each (_local_2 in this.gs_.map.goDict_)
                    {
                        if (((_local_2 is Portal) || (_local_2 is GuildHallPortal)))
                        {
                            _local_10 = (((_local_2.x_ - _local_21.x_) * (_local_2.x_ - _local_21.x_)) + ((_local_2.y_ - _local_21.y_) * (_local_2.y_ - _local_21.y_)));
                            if (_local_10 < _local_3)
                            {
                                _local_3 = _local_10;
                                _local_5 = _local_2.objectId_;
                            }
                        }
                    }
                    if (_local_5 == -1)
                    {
                        _local_21.notifyPlayer("No portals to enter!", 0xFF00, 1500);
                        break;
                    }
                    this.gs_.gsc_.usePortal(_local_5);
                    break;
                case Parameters.data_.rotateLeft:
                    if (!Parameters.data_.allowRotation) break;
                    this.rotateLeft_ = 1;
                    break;
                case Parameters.data_.rotateRight:
                    if (!Parameters.data_.allowRotation) break;
                    this.rotateRight_ = 1;
                    break;
                case Parameters.data_.resetToDefaultCameraAngle:
                    Parameters.data_.cameraAngle = Parameters.data_.defaultCameraAngle;
                    Parameters.save();
                    break;
                case Parameters.data_.autofireToggle:
                    _local_21.isShooting = (this.autofire_ = (!(this.autofire_)));
                    break;
                case Parameters.data_.toggleHPBar:
                    Parameters.data_.HPBar = ((Parameters.data_.HPBar != 0) ? 0 : 1);
                    break;
                case Parameters.data_.toggleProjectiles:
                    Parameters.data_.disableAllyParticles = (!(Parameters.data_.disableAllyParticles));
                    break;
                case Parameters.data_.toggleMasterParticles:
                    Parameters.data_.noParticlesMaster = (!(Parameters.data_.noParticlesMaster));
                    break;
                case Parameters.data_.useInvSlot1:
                    this.useItem(4);
                    break;
                case Parameters.data_.useInvSlot2:
                    this.useItem(5);
                    break;
                case Parameters.data_.useInvSlot3:
                    this.useItem(6);
                    break;
                case Parameters.data_.useInvSlot4:
                    this.useItem(7);
                    break;
                case Parameters.data_.useInvSlot5:
                    this.useItem(8);
                    break;
                case Parameters.data_.useInvSlot6:
                    this.useItem(9);
                    break;
                case Parameters.data_.useInvSlot7:
                    this.useItem(10);
                    break;
                case Parameters.data_.useInvSlot8:
                    this.useItem(11);
                    break;
                case Parameters.data_.useHealthPotion:
                    if (this.potionInventoryModel.getPotionModel(PotionInventoryModel.HEALTH_POTION_ID).available)
                    {
                        this.useBuyPotionSignal.dispatch(new UseBuyPotionVO(PotionInventoryModel.HEALTH_POTION_ID, UseBuyPotionVO.CONTEXTBUY));
                    }
                    break;
                case Parameters.data_.useMagicPotion:
                    if (this.potionInventoryModel.getPotionModel(PotionInventoryModel.MAGIC_POTION_ID).available)
                    {
                        this.useBuyPotionSignal.dispatch(new UseBuyPotionVO(PotionInventoryModel.MAGIC_POTION_ID, UseBuyPotionVO.CONTEXTBUY));
                    }
                    break;
                case Parameters.data_.miniMapZoomOut:
                    this.miniMapZoom.dispatch(MiniMapZoomSignal.OUT);
                    break;
                case Parameters.data_.miniMapZoomIn:
                    this.miniMapZoom.dispatch(MiniMapZoomSignal.IN);
                    break;
                case Parameters.data_.togglePerformanceStats:
                    this.togglePerformanceStats();
                    break;
                case Parameters.data_.escapeToNexus:
                case Parameters.data_.escapeToNexus2:
                    _local_20 = StaticInjectorContext.getInjector().getInstance(CloseAllPopupsSignal);
                    _local_20.dispatch();
                    this.exitGame.dispatch();
                    this.gs_.gsc_.escape();
                    break;
                case Parameters.data_.friendList:
                    this.isFriendsListOpen = (!(this.isFriendsListOpen));
                    if (this.isFriendsListOpen){
                        if (Parameters.USE_NEW_FRIENDS_UI){
                            _local_22 = StaticInjectorContext.getInjector().getInstance(ShowPopupSignal);
                            _local_22.dispatch(new SocialPopupView());
                        } else {
                            _local_24 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
                            _local_24.dispatch(new FriendListView());
                        }
                    } else {
                        this.closeDialogSignal.dispatch();
                        this.closePopupByClassSignal.dispatch(SocialPopupView);
                    }
                    break;
                case Parameters.data_.options:
                    _local_20 = StaticInjectorContext.getInjector().getInstance(CloseAllPopupsSignal);
                    _local_20.dispatch();
                    this.openOptions();
                    break;
                case Parameters.data_.toggleCentering:
                    Parameters.data_.centerOnPlayer = (!(Parameters.data_.centerOnPlayer));
                    Parameters.save();
                    break;
                case Parameters.data_.switchTabs:
                    _local_20 = StaticInjectorContext.getInjector().getInstance(CloseAllPopupsSignal);
                    _local_20.dispatch();
                    if (Parameters.data_.normalUI || Options.hidden)
                    {
                        this.statsTabHotKeyInputSignal.dispatch();
                    }
                    else
                    {
                        this.gs_.hudView.toggleStats();
                    }
                    break;
                case Parameters.data_.ReconRealm:
                    if (reconRealm != null)
                    {
                        reconRealm.charId_ = this.gs_.gsc_.charId_;
                        this.gs_.dispatchEvent(reconRealm);
                    }
                    else
                    {
                        _local_16 = new Server();
                        _local_16.setName(Parameters.data_.servName);
                        _local_16.setAddress(Parameters.data_.servAddr);
                        _local_16.setPort(2050);
                        _local_17 = new ReconnectEvent(_local_16, Parameters.data_.reconGID, false, this.gs_.gsc_.charId_, Parameters.data_.reconTime, Parameters.data_.reconKey, false);
                        this.gs_.dispatchEvent(_local_17);
                    }
                    break;
                case Parameters.data_.ReconRandom:
                    if (reconVault != null)
                    {
                        reconRandom = reconVault;
                        reconRandom.charId_ = this.gs_.gsc_.charId_;
                        reconRandom.server_.name = "Random";
                        reconRandom.gameId_ = Parameters.RANDOM_REALM_GAMEID;
                        this.gs_.dispatchEvent(reconRandom);
                    }
                case Parameters.data_.ReconDung:
                    if (reconDung != null)
                    {
                        if ((getTimer() - dungTime) < 180000)
                        {
                            reconDung.charId_ = this.gs_.gsc_.charId_;
                            this.gs_.dispatchEvent(reconDung);
                        }
                    }
                    else
                    {
                        if ((getTimer() - Parameters.data_.dreconTime) < 180000)
                        {
                            _local_18 = new Server();
                            _local_18.setName(Parameters.data_.dservName);
                            _local_18.setAddress(Parameters.data_.dservAddr);
                            _local_18.setPort(2050);
                            _local_19 = new ReconnectEvent(_local_18, Parameters.data_.dreconGID, false, this.gs_.gsc_.charId_, Parameters.data_.dreconTime, Parameters.data_.dreconKey, false);
                            this.gs_.dispatchEvent(_local_19);
                        }
                    }
                    break;
                case Parameters.data_.ReconVault:
                    if (reconVault != null)
                    {
                        reconVault.charId_ = this.gs_.gsc_.charId_;
                        this.gs_.dispatchEvent(reconVault);
                    }
                    break;
                case Parameters.data_.ReconDaily:
                    if (reconDaily != null)
                    {
                        reconDaily.charId_ = this.gs_.gsc_.charId_;
                        this.gs_.dispatchEvent(reconDaily);
                    }
                    break;
                case Parameters.data_.tpto:
                    this.gs_.gsc_.teleport(TextHandler.caller);
                    break;
                case Parameters.data_.msg1key:
                    if (Parameters.data_.msg1 == null) break;
                    this.parseChatMessage.dispatch(Parameters.data_.msg1);
                    break;
                case Parameters.data_.msg2key:
                    if (Parameters.data_.msg2 == null) break;
                    this.parseChatMessage.dispatch(Parameters.data_.msg2);
                    break;
                case Parameters.data_.msg3key:
                    if (Parameters.data_.msg3 == null) break;
                    this.parseChatMessage.dispatch(Parameters.data_.msg3);
                    break;
                case Parameters.data_.msg4key:
                    if (Parameters.data_.msg4 == null) break;
                    this.parseChatMessage.dispatch(Parameters.data_.msg4);
                    break;
                case Parameters.data_.msg5key:
                    if (Parameters.data_.msg5 == null) break;
                    this.parseChatMessage.dispatch(Parameters.data_.msg5);
                    break;
                case Parameters.data_.msg6key:
                    if (Parameters.data_.msg6 == null) break;
                    this.parseChatMessage.dispatch(Parameters.data_.msg6);
                    break;
                case Parameters.data_.msg7key:
                    if (Parameters.data_.msg7 == null) break;
                    this.parseChatMessage.dispatch(Parameters.data_.msg7);
                    break;
                case Parameters.data_.msg8key:
                    if (Parameters.data_.msg8 == null) break;
                    this.parseChatMessage.dispatch(Parameters.data_.msg8);
                    break;
                case Parameters.data_.msg9key:
                    if (Parameters.data_.msg9 == null) break;
                    this.parseChatMessage.dispatch(Parameters.data_.msg9);
                    break;
                case Parameters.data_.SkipRenderKey:
                    MapUserInput.skipRender = (!(MapUserInput.skipRender));
                    break;
                case Parameters.data_.maxPrism:
                    this.maxprism = (!(this.maxprism));
                    _local_21.notifyPlayer(((this.maxprism) ? "Max Prism: Enabled" : "Max Prism: Disabled"), 0xFF00, 1500);
                    break;
                case Parameters.data_.Cam90DegInc:
                    Parameters.data_.cameraAngle = (Parameters.data_.cameraAngle - (0.785398163397448 * 2));
                    Parameters.save();
                    break;
                case Parameters.data_.Cam90DegDec:
                    Parameters.data_.cameraAngle = (Parameters.data_.cameraAngle + (0.785398163397448 * 2));
                    Parameters.save();
                    break;
                case Parameters.data_.cam2quest:
                    _local_7 = this.gs_.map.quest_.getLoc();
                    Parameters.data_.cameraAngle = (Math.atan2((_local_21.y_ - _local_7.y), (_local_21.x_ - _local_7.x)) - 1.57079632679);
                    Parameters.save();
                    break;
                case Parameters.data_.AAHotkey:
                    Parameters.data_.AAOn = (!(Parameters.data_.AAOn));
                    _local_21.levelUpEffect(((Parameters.data_.AAOn) ? "Auto Aim: On" : "Auto Aim: Off"));
                    break;
                case Parameters.data_.AAModeHotkey:
                    this.selectAimMode();
                    break;
                case Parameters.data_.tombCycle:
                    Parameters.data_.curBoss++;
                    if (Parameters.data_.curBoss > 3368)
                    {
                        Parameters.data_.curBoss = 3366;
                    }
                    Parameters.save();
                    _local_21.notifyPlayer(("Active boss: " + ObjectLibrary.typeToDisplayId_[Parameters.data_.curBoss]), 0xFF00, 1500);
                    break;
                case Parameters.data_.kdbPetrify:
                    Parameters.data_.dbPetrify = (!(Parameters.data_.dbPetrify));
                    Parameters.save();
                    _local_21.notifyPlayer(((Parameters.data_.dbPetrify) ? "Petrify: On" : "Petrify: Off"), ((Parameters.data_.dbPetrify) ? 0xFF0000 : 0xFF00), 1500);
                    break;
                case Parameters.data_.kdbArmorBroken:
                    Parameters.data_.dbArmorBroken = (!(Parameters.data_.dbArmorBroken));
                    Parameters.save();
                    _local_21.notifyPlayer(((Parameters.data_.dbArmorBroken) ? "Armor Broken: On" : "Armor Broken: Off"), ((Parameters.data_.dbArmorBroken) ? 0xFF0000 : 0xFF00), 1500);
                    break;
                case Parameters.data_.kdbBleeding:
                    Parameters.data_.dbBleeding = (!(Parameters.data_.dbBleeding));
                    Parameters.save();
                    _local_21.notifyPlayer(((Parameters.data_.dbBleeding) ? "Bleeding: On" : "Bleeding: Off"), ((Parameters.data_.dbBleeding) ? 0xFF0000 : 0xFF00), 1500);
                    break;
                case Parameters.data_.kdbDazed:
                    Parameters.data_.dbDazed = (!(Parameters.data_.dbDazed));
                    Parameters.save();
                    _local_21.notifyPlayer(((Parameters.data_.dbDazed) ? "Dazed: On" : "Dazed: Off"), ((Parameters.data_.dbDazed) ? 0xFF0000 : 0xFF00), 1500);
                    break;
                case Parameters.data_.kdbParalyzed:
                    Parameters.data_.dbParalyzed = (!(Parameters.data_.dbParalyzed));
                    Parameters.save();
                    _local_21.notifyPlayer(((Parameters.data_.dbParalyzed) ? "Paralyzed: On" : "Paralyzed: Off"), ((Parameters.data_.dbParalyzed) ? 0xFF0000 : 0xFF00), 1500);
                    break;
                case Parameters.data_.kdbSick:
                    Parameters.data_.dbSick = (!(Parameters.data_.dbSick));
                    Parameters.save();
                    _local_21.notifyPlayer(((Parameters.data_.dbSick) ? "Sick: On" : "Sick: Off"), ((Parameters.data_.dbSick) ? 0xFF0000 : 0xFF00), 1500);
                    break;
                case Parameters.data_.kdbSlowed:
                    Parameters.data_.dbSlowed = (!(Parameters.data_.dbSlowed));
                    Parameters.save();
                    _local_21.notifyPlayer(((Parameters.data_.dbSlowed) ? "Slowed: On" : "Slowed: Off"), ((Parameters.data_.dbSlowed) ? 0xFF0000 : 0xFF00), 1500);
                    break;
                case Parameters.data_.kdbStunned:
                    Parameters.data_.dbStunned = (!(Parameters.data_.dbStunned));
                    Parameters.save();
                    _local_21.notifyPlayer(((Parameters.data_.dbStunned) ? "Stunned: On" : "Stunned: Off"), ((Parameters.data_.dbStunned) ? 0xFF0000 : 0xFF00), 1500);
                    break;
                case Parameters.data_.kdbWeak:
                    Parameters.data_.dbWeak = (!(Parameters.data_.dbWeak));
                    Parameters.save();
                    _local_21.notifyPlayer(((Parameters.data_.dbWeak) ? "Weak: On" : "Weak: Off"), ((Parameters.data_.dbWeak) ? 0xFF0000 : 0xFF00), 1500);
                    break;
                case Parameters.data_.kdbQuiet:
                    Parameters.data_.dbQuiet = (!(Parameters.data_.dbQuiet));
                    Parameters.save();
                    _local_21.notifyPlayer(((Parameters.data_.dbQuiet) ? "Quiet: On" : "Quiet: Off"), ((Parameters.data_.dbQuiet) ? 0xFF0000 : 0xFF00), 1500);
                    break;
                case Parameters.data_.kdbPetStasis:
                    Parameters.data_.dbPetStasis = (!(Parameters.data_.dbPetStasis));
                    Parameters.save();
                    _local_21.notifyPlayer(((Parameters.data_.dbPetStasis) ? "Pet Stasis: On" : "Pet Stasis: Off"), ((Parameters.data_.dbPetStasis) ? 0xFF0000 : 0xFF00), 1500);
                    break;
                case Parameters.data_.kdbAll:
                    Parameters.data_.dbAll = (!(Parameters.data_.dbAll));
                    Parameters.data_.dbPetrify = Parameters.data_.dbAll;
                    Parameters.data_.dbArmorBroken = Parameters.data_.dbAll;
                    Parameters.data_.dbBleeding = Parameters.data_.dbAll;
                    Parameters.data_.dbDazed = Parameters.data_.dbAll;
                    Parameters.data_.dbParalyzed = Parameters.data_.dbAll;
                    Parameters.data_.dbSick = Parameters.data_.dbAll;
                    Parameters.data_.dbSlowed = Parameters.data_.dbAll;
                    Parameters.data_.dbStunned = Parameters.data_.dbAll;
                    Parameters.data_.dbWeak = Parameters.data_.dbAll;
                    Parameters.data_.dbQuiet = Parameters.data_.dbAll;
                    Parameters.data_.dbPetStasis = Parameters.data_.dbAll;
                    Parameters.save();
                    _local_21.notifyPlayer(((Parameters.data_.dbAll) ? "All: On" : "All: Off"), ((Parameters.data_.dbAll) ? 0xFF0000 : 0xFF00), 1500);
                    break;
                case Parameters.data_.kdbPre1:
                    this.activatePreset(1);
                    break;
                case Parameters.data_.kdbPre2:
                    this.activatePreset(2);
                    break;
                case Parameters.data_.kdbPre3:
                    this.activatePreset(3);
                    break;
                case Parameters.data_.resetCHP:
                    _local_21.chp = _local_21.hp_;
                    _local_21.cmaxhp = _local_21.maxHP_;
                    _local_21.cmaxhpboost = _local_21.maxHPBoost_;
                    break;
                case Parameters.data_.pbToggle:
                    Parameters.data_.perfectBomb = (!(Parameters.data_.perfectBomb));
                    Parameters.save();
                    _local_21.notifyPlayer(((Parameters.data_.perfectBomb) ? "Spell Bomb Aim: On" : "Spell Bomb Aim: Off"), 0xFF00, 1500);
                    break;
                case Parameters.data_.tPassCover:
                    Parameters.data_.PassesCover = (!(Parameters.data_.PassesCover));
                    Parameters.save();
                    _local_21.notifyPlayer(((Parameters.data_.PassesCover) ? "Proj No-Clip: On" : "Proj No-Clip: Off"), 0xFF00, 1500);
                    break;
                case Parameters.data_.panicKey:
                    Options.toggleHax();
                    this.gs_.hudView.toggle();
                    break;
                case Parameters.data_.SafeWalkKey:
                    Parameters.data_.SafeWalk = (!Parameters.data_.SafeWalk);
                    Parameters.save();
                    _local_21.notifyPlayer(((Parameters.data_.SafeWalk) ? "Safe Walk: On" : "Safe Walk: Off"), 0xFF00, 1500);
                    break;
                case Parameters.data_.SelfTPHotkey:
                    this.gs_.gsc_.teleportId(_local_21.objectId_);
                    break;
                case Parameters.data_.autoAbilKey:
                    Parameters.data_.autoAbil = !Parameters.data_.autoAbil;
                    _local_21.notifyPlayer((Parameters.data_.autoAbil) ? "Auto Ability enabled" : "Auto Ability disabled", 0xFF00, 1500);
                    break;
                case Parameters.data_.LowCPUModeHotKey:
                    Parameters.lowCPUMode = !Parameters.lowCPUMode;
                    _local_21.notifyPlayer((Parameters.lowCPUMode) ? "Low CPU enabled" : "Low CPU disabled", 0xFF00, 1500);
                    break;
            }
            this.setPlayerMovement();
        }

        public function onRightMouseDown_forWorld(_arg_1:MouseEvent):void{
            if (Parameters.data_.rightClickOption == "Ability")
            {
                this.gs_.map.player_.sbAssist(this.gs_.map.mouseX, this.gs_.map.mouseY);
            } else {
                if (Parameters.data_.rightClickOption == "Camera")
                {
                    held = true;
                    heldX = WebMain.STAGE.mouseX;
                    heldY = WebMain.STAGE.mouseY;
                    heldAngle = Parameters.data_.cameraAngle;
                }
            }
        }

        public function onRightMouseUp_forWorld(_arg_1:MouseEvent):void
        {
            held = false;
        }

        public function openOptions():void
        {
            this.closeDialogSignal.dispatch();
            this.clearInput();
            GameSprite.hidePreloader();
            this.layers.overlay.addChild(new Options(this.gs_));
        }

        public function activatePreset(_arg_1:int, _arg_2:int=-1):void
        {
            var _local_3:int;
            var _local_4:Boolean;
            var _local_5:String;
            var _local_6:int;
            switch (_arg_1)
            {
                case 1:
                    _local_5 = Parameters.data_.dbPre1[0];
                    _local_3 = Parameters.data_.dbPre1[1];
                    break;
                case 2:
                    _local_5 = Parameters.data_.dbPre2[0];
                    _local_3 = Parameters.data_.dbPre2[1];
                    break;
                case 3:
                    _local_5 = Parameters.data_.dbPre3[0];
                    _local_3 = Parameters.data_.dbPre3[1];
                    break;
            }
            if (_local_3 == 0)
            {
                return;
            }
            if (_arg_2 == -1)
            {
                switch (_arg_1)
                {
                    case 1:
                        Parameters.data_.dbPre1[2] = (!(Parameters.data_.dbPre1[2]));
                        _local_4 = Parameters.data_.dbPre1[2];
                        break;
                    case 2:
                        Parameters.data_.dbPre2[2] = (!(Parameters.data_.dbPre2[2]));
                        _local_4 = Parameters.data_.dbPre2[2];
                        break;
                    case 3:
                        Parameters.data_.dbPre3[2] = (!(Parameters.data_.dbPre3[2]));
                        _local_4 = Parameters.data_.dbPre3[2];
                        break;
                }
            }
            else
            {
                if (_arg_2 == 0)
                {
                    switch (_arg_1)
                    {
                        case 1:
                            Parameters.data_.dbPre1[2] = false;
                            _local_4 = Parameters.data_.dbPre1[2];
                            break;
                        case 2:
                            Parameters.data_.dbPre2[2] = false;
                            _local_4 = Parameters.data_.dbPre2[2];
                            break;
                        case 3:
                            Parameters.data_.dbPre3[2] = false;
                            _local_4 = Parameters.data_.dbPre3[2];
                            break;
                    }
                }
                else
                {
                    if (_arg_2 == 1)
                    {
                        switch (_arg_1)
                        {
                            case 1:
                                Parameters.data_.dbPre1[2] = true;
                                _local_4 = Parameters.data_.dbPre1[2];
                                break;
                            case 2:
                                Parameters.data_.dbPre2[2] = true;
                                _local_4 = Parameters.data_.dbPre2[2];
                                break;
                            case 3:
                                Parameters.data_.dbPre3[2] = true;
                                _local_4 = Parameters.data_.dbPre3[2];
                                break;
                        }
                    }
                }
            }
            while (_local_6 < 11)
            {
                if ((_local_3 & (1 << _local_6)) != 0)
                {
                    switch (_local_6)
                    {
                        case 0:
                            Parameters.data_.dbArmorBroken = _local_4;
                            break;
                        case 1:
                            Parameters.data_.dbBleeding = _local_4;
                            break;
                        case 2:
                            Parameters.data_.dbDazed = _local_4;
                            break;
                        case 3:
                            Parameters.data_.dbParalyzed = _local_4;
                            break;
                        case 4:
                            Parameters.data_.dbSick = _local_4;
                            break;
                        case 5:
                            Parameters.data_.dbSlowed = _local_4;
                            break;
                        case 6:
                            Parameters.data_.dbStunned = _local_4;
                            break;
                        case 7:
                            Parameters.data_.dbWeak = _local_4;
                            break;
                        case 8:
                            Parameters.data_.dbQuiet = _local_4;
                            break;
                        case 9:
                            Parameters.data_.dbPetStasis = _local_4;
                            break;
                        case 10:
                            Parameters.data_.dbPetrify = _local_4;
                            break;
                    }
                }
                _local_6++;
            }
            Parameters.save();
            if (_arg_2 != 0)
            {
                this.gs_.map.player_.notifyPlayer(((_local_4) ? (_local_5 + ": On") : (_local_5 + ": Off")), ((_local_4) ? 0xFF0000 : 0xFF00), 1500);
            }
        }

        private function selectAimMode():void
        {
            var _local_1:int;
            var _local_2:* = "";
            if (Parameters.data_.aimMode == undefined)
            {
                _local_1 = 1;
            }
            else
            {
                _local_1 = ((Parameters.data_.aimMode + 1) % 3);
            }
            switch (_local_1)
            {
                case 1:
                    _local_2 = "Aim Assist Mode: Highest HP";
                    break;
                case 2:
                    _local_2 = "Aim Assist Mode: Closest";
                    break;
                case 0:
                    _local_2 = "Aim Assist Mode: Closest to Cursor";
            }
            this.gs_.map.player_.levelUpEffect(_local_2);
            Parameters.data_.aimMode = _local_1;
        }

        private function onKeyUp(_arg_1:KeyboardEvent):void
        {
            var _local_2:Number;
            var _local_3:Number;
            switch (_arg_1.keyCode)
            {
                case Parameters.data_.moveUp:
                    this.moveUp_ = 0;
                    break;
                case Parameters.data_.moveDown:
                    this.moveDown_ = 0;
                    break;
                case Parameters.data_.moveLeft:
                    this.moveLeft_ = 0;
                    break;
                case Parameters.data_.moveRight:
                    this.moveRight_ = 0;
                    break;
                case Parameters.data_.rotateLeft:
                    this.rotateLeft_ = 0;
                    break;
                case Parameters.data_.rotateRight:
                    this.rotateRight_ = 0;
                    break;
                case Parameters.data_.useSpecial:
                    this.specialKeyDown_ = false;
                    if (((!(Parameters.data_.ninjaTap)) && (!(inputting))))
                    {
                        this.gs_.map.player_.useAltWeapon(this.gs_.map.mouseX, this.gs_.map.mouseY, UseType.END_USE);
                    }
                    break;
            }
            this.setPlayerMovement();
        }

        private function setPlayerMovement():void
        {
            var _local_1:Player = this.gs_.map.player_;
            if (_local_1 != null)
            {
                if (this.enablePlayerInput_)
                {
                    _local_1.setRelativeMovement((this.rotateRight_ - this.rotateLeft_), (this.moveRight_ - this.moveLeft_), (this.moveDown_ - this.moveUp_));
                }
                else
                {
                    _local_1.setRelativeMovement(0, 0, 0);
                }
            }
        }

        private function useItem(_arg_1:int):void
        {
            if (this.tabStripModel.currentSelection == TabStripModel.BACKPACK)
            {
                _arg_1 = (_arg_1 + GeneralConstants.NUM_INVENTORY_SLOTS);
            }
            GameServerConnection.instance.useItem_new(this.gs_.map.player_, _arg_1);
        }

        private function togglePerformanceStats():void
        {
            if (this.gs_.contains(stats_))
            {
                this.gs_.removeChild(stats_);
                this.gs_.removeChild(this.gs_.gsc_.jitterWatcher_);
                this.gs_.gsc_.disableJitterWatcher();
            }
            else
            {
                this.gs_.addChild(stats_);
                this.gs_.gsc_.enableJitterWatcher();
                this.gs_.gsc_.jitterWatcher_.y = stats_.height;
                this.gs_.addChild(this.gs_.gsc_.jitterWatcher_);
            }
        }

        private function toggleScreenShotMode():void
        {
            Parameters.screenShotMode_ = (!(Parameters.screenShotMode_));
            if (Parameters.screenShotMode_)
            {
                this.gs_.hudView.visible = false;
                this.setTextBoxVisibility.dispatch(false);
            }
            else
            {
                this.gs_.hudView.visible = true;
                this.setTextBoxVisibility.dispatch(true);
            }
        }


    }
}//package com.company.assembleegameclient.game

