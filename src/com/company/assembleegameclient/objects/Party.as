// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.objects.Party

package com.company.assembleegameclient.objects
{
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.PointUtil;

import flash.utils.Dictionary;

import kabam.rotmg.messaging.impl.incoming.AccountList;

public class Party
    {

        public static const NUM_MEMBERS:int = 6;
        private static const SORT_ON_FIELDS:Array = ["starred_", "distSqFromThisPlayer_", "objectId_"];
        private static const SORT_ON_PARAMS:Array = [(Array.NUMERIC | Array.DESCENDING), Array.NUMERIC, Array.NUMERIC];
        private static const PARTY_DISTANCE_SQ:int = 2500;

        public var map_:Map;
        public var members_:Array = [];
        private var starred_:Dictionary = new Dictionary(true);
        private var ignored_:Dictionary = new Dictionary(true);
        private var lastUpdate_:int = -2147483648;

        public function Party(_arg_1:Map)
        {
            this.map_ = _arg_1;
        }

        public function update(_arg_1:int, _arg_2:int):void
        {
            var _local_3:GameObject;
            var _local_4:Player;
            if (_arg_1 < (this.lastUpdate_ + 500))
            {
                return;
            };
            this.lastUpdate_ = _arg_1;
            this.members_.length = 0;
            var _local_5:Player = this.map_.player_;
            if (_local_5 == null)
            {
                return;
            };
            for each (_local_3 in this.map_.goDict_)
            {
                _local_4 = (_local_3 as Player);
                if (!((_local_4 == null) || (_local_4 == _local_5)))
                {
                    _local_4.starred_ = (!(this.starred_[_local_4.accountId_] == undefined));
                    _local_4.ignored_ = (!(this.ignored_[_local_4.accountId_] == undefined));
                    _local_4.distSqFromThisPlayer_ = PointUtil.distanceSquaredXY(_local_5.x_, _local_5.y_, _local_4.x_, _local_4.y_);
                    if (((!((_local_4.distSqFromThisPlayer_ > PARTY_DISTANCE_SQ) && (!(_local_4.starred_)))) || (this.members_.length < 6)))
                    {
                        if (!(((this.map_.name_ == "Nexus") && (Parameters.data_.HidePlayerFilter)) && (_local_4.numStars_ <= Parameters.data_.chatStarRequirement)))
                        {
                            this.members_.push(_local_4);
                        };
                    };
                };
            };
            this.members_.sortOn(SORT_ON_FIELDS, SORT_ON_PARAMS);
            if (this.members_.length > NUM_MEMBERS)
            {
                this.members_.length = NUM_MEMBERS;
            };
        }

        public function lockPlayer(_arg_1:Player):void
        {
            this.starred_[_arg_1.accountId_] = 1;
            this.lastUpdate_ = int.MIN_VALUE;
            this.map_.gs_.gsc_.editAccountList(0, true, _arg_1.objectId_);
        }

        public function unlockPlayer(_arg_1:Player):void
        {
            delete this.starred_[_arg_1.accountId_];
            _arg_1.starred_ = false;
            this.lastUpdate_ = int.MIN_VALUE;
            this.map_.gs_.gsc_.editAccountList(0, false, _arg_1.objectId_);
        }

        public function setStars(_arg_1:AccountList):void
        {
            var _local_2:String;
            var _local_3:int;
            while (_local_3 < _arg_1.accountIds_.length)
            {
                _local_2 = _arg_1.accountIds_[_local_3];
                this.starred_[_local_2] = 1;
                this.lastUpdate_ = int.MIN_VALUE;
                _local_3++;
            };
        }

        public function removeStars(_arg_1:AccountList):void
        {
            var _local_2:String;
            var _local_3:int;
            while (_local_3 < _arg_1.accountIds_.length)
            {
                _local_2 = _arg_1.accountIds_[_local_3];
                delete this.starred_[_local_2];
                this.lastUpdate_ = int.MIN_VALUE;
                _local_3++;
            };
        }

        public function ignorePlayer(_arg_1:Player):void
        {
            this.ignored_[_arg_1.accountId_] = 1;
            this.lastUpdate_ = int.MIN_VALUE;
            this.map_.gs_.gsc_.editAccountList(1, true, _arg_1.objectId_);
        }

        public function unignorePlayer(_arg_1:Player):void
        {
            delete this.ignored_[_arg_1.accountId_];
            _arg_1.ignored_ = false;
            this.lastUpdate_ = int.MIN_VALUE;
            this.map_.gs_.gsc_.editAccountList(1, false, _arg_1.objectId_);
        }

        public function setIgnores(_arg_1:AccountList):void
        {
            var _local_2:String;
            var _local_3:int;
            this.ignored_ = new Dictionary(true);
            while (_local_3 < _arg_1.accountIds_.length)
            {
                _local_2 = _arg_1.accountIds_[_local_3];
                this.ignored_[_local_2] = 1;
                this.lastUpdate_ = int.MIN_VALUE;
                _local_3++;
            };
        }


    }
}//package com.company.assembleegameclient.objects

