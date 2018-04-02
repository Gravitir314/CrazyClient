// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.tutorial.Tutorial

package com.company.assembleegameclient.tutorial
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.util.PointUtil;

import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.BlurFilter;
import flash.utils.getTimer;

import kabam.rotmg.assets.EmbeddedData;

public class Tutorial extends Sprite 
    {

        public static const NEXT_ACTION:String = "Next";
        public static const MOVE_FORWARD_ACTION:String = "MoveForward";
        public static const MOVE_BACKWARD_ACTION:String = "MoveBackward";
        public static const ROTATE_LEFT_ACTION:String = "RotateLeft";
        public static const ROTATE_RIGHT_ACTION:String = "RotateRight";
        public static const MOVE_LEFT_ACTION:String = "MoveLeft";
        public static const MOVE_RIGHT_ACTION:String = "MoveRight";
        public static const UPDATE_ACTION:String = "Update";
        public static const ATTACK_ACTION:String = "Attack";
        public static const DAMAGE_ACTION:String = "Damage";
        public static const KILL_ACTION:String = "Kill";
        public static const SHOW_LOOT_ACTION:String = "ShowLoot";
        public static const TEXT_ACTION:String = "Text";
        public static const SHOW_PORTAL_ACTION:String = "ShowPortal";
        public static const ENTER_PORTAL_ACTION:String = "EnterPortal";
        public static const NEAR_REQUIREMENT:String = "Near";
        public static const EQUIP_REQUIREMENT:String = "Equip";

        public var gs_:GameSprite;
        public var steps_:Vector.<Step> = new Vector.<Step>();
        public var currStepId_:int = 0;
        private var darkBox_:Sprite = new Sprite();
        private var boxesBack_:Shape = new Shape();
        private var boxes_:Shape = new Shape();
        private var tutorialMessage_:TutorialMessage = null;

        public function Tutorial(_arg_1:GameSprite)
        {
            var _local_2:XML;
            var _local_3:Graphics;
            super();
            this.gs_ = _arg_1;
            for each (_local_2 in EmbeddedData.tutorialXML.Step)
            {
                this.steps_.push(new Step(_local_2));
            };
            addChild(this.boxesBack_);
            addChild(this.boxes_);
            _local_3 = this.darkBox_.graphics;
            _local_3.clear();
            _local_3.beginFill(0, 0.1);
            _local_3.drawRect(0, 0, 800, 600);
            _local_3.endFill();
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.draw();
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }

        private function onEnterFrame(_arg_1:Event):void
        {
            var _local_2:Step;
            var _local_3:Boolean;
            var _local_4:Requirement;
            var _local_5:int;
            var _local_6:UIDrawBox;
            var _local_7:UIDrawArrow;
            var _local_8:Player;
            var _local_9:Boolean;
            var _local_10:GameObject;
            var _local_11:Number;
            var _local_12:int;
            var _local_13:Number = Math.abs(Math.sin((getTimer() / 300)));
            this.boxesBack_.filters = [new BlurFilter((5 + (_local_13 * 5)), (5 + (_local_13 * 5)))];
            this.boxes_.graphics.clear();
            this.boxesBack_.graphics.clear();
            while (_local_12 < this.steps_.length)
            {
                _local_2 = this.steps_[_local_12];
                _local_3 = true;
                for each (_local_4 in _local_2.reqs_)
                {
                    _local_8 = this.gs_.map.player_;
                    switch (_local_4.type_)
                    {
                        case NEAR_REQUIREMENT:
                            _local_9 = false;
                            for each (_local_10 in this.gs_.map.goDict_)
                            {
                                if (!((!(_local_10.objectType_ == _local_4.objectType_)) || ((!(_local_4.objectName_ == "")) && (!(_local_10.name_ == _local_4.objectName_)))))
                                {
                                    _local_11 = PointUtil.distanceXY(_local_10.x_, _local_10.y_, _local_8.x_, _local_8.y_);
                                    if (_local_11 <= _local_4.radius_)
                                    {
                                        _local_9 = true;
                                        break;
                                    };
                                };
                            };
                            if (!_local_9)
                            {
                                _local_3 = false;
                            };
                            break;
                    };
                };
                if (!_local_3)
                {
                    _local_2.satisfiedSince_ = 0;
                }
                else
                {
                    if (_local_2.satisfiedSince_ == 0)
                    {
                        _local_2.satisfiedSince_ = getTimer();
                    };
                    _local_5 = (getTimer() - _local_2.satisfiedSince_);
                    for each (_local_6 in _local_2.uiDrawBoxes_)
                    {
                        _local_6.draw((5 * _local_13), this.boxes_.graphics, _local_5);
                        _local_6.draw((6 * _local_13), this.boxesBack_.graphics, _local_5);
                    };
                    for each (_local_7 in _local_2.uiDrawArrows_)
                    {
                        _local_7.draw((5 * _local_13), this.boxes_.graphics, _local_5);
                        _local_7.draw((6 * _local_13), this.boxesBack_.graphics, _local_5);
                    };
                };
                _local_12++;
            };
        }

        public function doneAction(_arg_1:String):void
        {
            var _local_2:Requirement;
            var _local_3:Player;
            var _local_4:Boolean;
            var _local_5:GameObject;
            var _local_6:Number;
            if (this.currStepId_ >= this.steps_.length)
            {
                return;
            };
            var _local_7:Step = this.steps_[this.currStepId_];
            if (_arg_1 != _local_7.action_)
            {
                return;
            };
            for each (_local_2 in _local_7.reqs_)
            {
                _local_3 = this.gs_.map.player_;
                switch (_local_2.type_)
                {
                    case NEAR_REQUIREMENT:
                        _local_4 = false;
                        for each (_local_5 in this.gs_.map.goDict_)
                        {
                            if (_local_5.objectType_ == _local_2.objectType_)
                            {
                                _local_6 = PointUtil.distanceXY(_local_5.x_, _local_5.y_, _local_3.x_, _local_3.y_);
                                if (_local_6 <= _local_2.radius_)
                                {
                                    _local_4 = true;
                                    break;
                                };
                            };
                        };
                        if (!_local_4)
                        {
                            return;
                        };
                        break;
                    case EQUIP_REQUIREMENT:
                        if (_local_3.equipment_[_local_2.slot_] != _local_2.objectType_)
                        {
                            return;
                        };
                        break;
                };
            };
            this.currStepId_++;
            this.draw();
        }

        private function draw():void
        {
            var _local_1:UIDrawBox;
        }


    }
}//package com.company.assembleegameclient.tutorial

