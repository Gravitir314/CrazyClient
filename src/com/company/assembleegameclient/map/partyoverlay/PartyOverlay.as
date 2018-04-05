// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.map.partyoverlay.PartyOverlay

package com.company.assembleegameclient.map.partyoverlay
{
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.objects.Party;
import com.company.assembleegameclient.objects.Player;

import flash.display.Sprite;
import flash.events.Event;

public class PartyOverlay extends Sprite
    {

        public var map_:Map;
        public var partyMemberArrows_:Vector.<PlayerArrow> = null;
        public var questArrow_:QuestArrow;

        public function PartyOverlay(_arg_1:Map)
        {
            var _local_2:PlayerArrow;
            var _local_3:int;
            super();
            this.map_ = _arg_1;
            this.partyMemberArrows_ = new Vector.<PlayerArrow>(Party.NUM_MEMBERS, true);
            while (_local_3 < Party.NUM_MEMBERS)
            {
                _local_2 = new PlayerArrow();
                this.partyMemberArrows_[_local_3] = _local_2;
                addChild(_local_2);
                _local_3++;
            }
            this.questArrow_ = new QuestArrow(this.map_);
            addChild(this.questArrow_);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            GameObjectArrow.removeMenu();
        }

        public function draw(_arg_1:Camera, _arg_2:int):void
        {
            var _local_3:PlayerArrow;
            var _local_4:Player;
            var _local_5:int;
            var _local_6:PlayerArrow;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:int;
            if (this.map_.player_ == null)
            {
                return;
            }
            var _local_10:Party = this.map_.party_;
            var _local_11:Player = this.map_.player_;
            while (_local_9 < Party.NUM_MEMBERS)
            {
                _local_3 = this.partyMemberArrows_[_local_9];
                if (!_local_3.mouseOver_)
                {
                    if (_local_9 >= _local_10.members_.length)
                    {
                        _local_3.setGameObject(null);
                    }
                    else
                    {
                        _local_4 = _local_10.members_[_local_9];
                        if ((((_local_4.drawn_) || (_local_4.map_ == null)) || (_local_4.dead_)))
                        {
                            _local_3.setGameObject(null);
                        }
                        else
                        {
                            _local_3.setGameObject(_local_4);
                            _local_5 = 0;
                            while (_local_5 < _local_9)
                            {
                                _local_6 = this.partyMemberArrows_[_local_5];
                                _local_7 = (_local_3.x - _local_6.x);
                                _local_8 = (_local_3.y - _local_6.y);
                                if (((_local_7 * _local_7) + (_local_8 * _local_8)) < 64)
                                {
                                    if (!_local_6.mouseOver_)
                                    {
                                        _local_6.addGameObject(_local_4);
                                    }
                                    _local_3.setGameObject(null);
                                    break;
                                }
                                _local_5++;
                            }
                            _local_3.draw(_arg_2, _arg_1);
                        }
                    }
                }
                _local_9++;
            }
            if (!this.questArrow_.mouseOver_)
            {
                this.questArrow_.draw(_arg_2, _arg_1);
            }
        }


    }
}//package com.company.assembleegameclient.map.partyoverlay

