// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.objects.Container

package com.company.assembleegameclient.objects
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.ui.options.Options;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.panels.itemgrids.ContainerGrid;
import com.company.util.GraphicsUtil;
import com.company.util.PointUtil;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.geom.Matrix;

public class Container extends GameObject implements IInteractiveObject
    {

        public var isLoot_:Boolean;
        public var ownerId_:String;
        public var canHaveSoulbound_:Boolean;
        private var lastEquips:String = "rebuild";
        private var icons_:Vector.<BitmapData> = null;
        private var iconFills_:Vector.<GraphicsBitmapFill> = null;
        private var iconPaths_:Vector.<GraphicsPath> = null;

        public function Container(_arg_1:XML)
        {
            super(_arg_1);
            isInteractive_ = true;
            this.isLoot_ = _arg_1.hasOwnProperty("Loot");
            this.canHaveSoulbound_ = _arg_1.hasOwnProperty("CanPutSoulboundObjects");
            this.ownerId_ = "";
        }

        public function setOwnerId(_arg_1:String):void
        {
            this.ownerId_ = _arg_1;
            isInteractive_ = ((this.ownerId_ == "") || (this.isBoundToCurrentAccount()));
        }

        public function lootNotify():void
        {
            var _local_1:Boolean;
            var _local_2:int;
            var _local_3:String;
            if ((((isInteractive_) && (!(objectType_ == 1284))) && (!(objectType_ == 1860))))
            {
                for each (_local_2 in equipment_)
                {
                    if (map_.player_.isWantedItem(_local_2))
                    {
                        if (_local_3 == null)
                        {
                            _local_3 = ObjectLibrary.getIdFromType(_local_2);
                            _local_1 = false;
                        }
                        else
                        {
                            _local_3 = ((_local_3 + "\n") + ObjectLibrary.getIdFromType(_local_2));
                        }
                    }
                }
                if (_local_3 != null)
                {
                    map_.player_.lootNotif(_local_3, this);
                }
            }
        }

        public function isBoundToCurrentAccount():Boolean
        {
            return (map_.player_.accountId_ == this.ownerId_);
        }

        override public function addTo(_arg_1:Map, _arg_2:Number, _arg_3:Number):Boolean
        {
            if (!super.addTo(_arg_1, _arg_2, _arg_3))
            {
                return (false);
            }
            if (map_.player_ == null)
            {
                return (true);
            }
            var _local_4:Number = PointUtil.distanceXY(map_.player_.x_, map_.player_.y_, _arg_2, _arg_3);
            if (((this.isLoot_) && (_local_4 < 10)))
            {
                SoundEffectLibrary.play("loot_appears");
            }
            return (true);
        }

        public function getPanel(_arg_1:GameSprite):Panel
        {
            var _local_2:Player = (((_arg_1) && (_arg_1.map)) ? _arg_1.map.player_ : null);
            return (new ContainerGrid(this, _local_2));
        }

        override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void{
            super.draw(_arg_1, _arg_2, _arg_3);
            if (Parameters.data_.lootPreview){
                drawItems(_arg_1, _arg_2, _arg_3);
            }
        }

        public function updateItemSprites(_arg_1:Vector.<BitmapData>):void{
            var _local_5:uint;
            var _local_2:* = null;
            var _local_3:int = -1;
            var _local_4:uint = this.equipment_.length;
            _local_5 = 0;
            while (_local_5 < _local_4) {
                _local_3 = this.equipment_[_local_5];
                _local_2 = ObjectLibrary.getItemIcon(_local_3);
                _arg_1.push(_local_2);
                _local_5++;
            }
        }

        public function drawItems(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void{
            var _local_7:* = null;
            var _local_10:* = null;
            var _local_12:* = null;
            var _local_13:Number;
            var _local_14:Number;
            var _local_11:* = null;
            var _local_9:* = null;
            var _local_8:int;
            var _local_5:int;
            if (Options.hidden) {
                return;
            }
            if (this.icons_ == null){
                this.icons_ = new Vector.<BitmapData>();
                this.iconFills_ = new Vector.<GraphicsBitmapFill>();
                this.iconPaths_ = new Vector.<GraphicsPath>();
                this.icons_.length = 0;
                updateItemSprites(this.icons_);
            } else {
                _local_9 = String(this.equipment_);
                if (_local_9 != lastEquips){
                    this.icons_.length = 0;
                    lastEquips = _local_9;
                    updateItemSprites(this.icons_);
                }
            }
            var _local_6:Number = posS_[3];
            var _local_4:Number = this.vS_[1];
            _local_8 = 0;
            while (_local_8 < this.icons_.length) {
                _local_7 = this.icons_[_local_8];
                if (_local_8 >= this.iconFills_.length){
                    this.iconFills_.push(new GraphicsBitmapFill(null, new Matrix(), false, false));
                    this.iconPaths_.push(new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>()));
                }
                _local_10 = this.iconFills_[_local_8];
                _local_12 = this.iconPaths_[_local_8];
                _local_10.bitmapData = _local_7;
                _local_5 = (_local_8 * 0.25);
                _local_13 = ((_local_6 - (_local_7.width * 2)) + ((_local_8 % 4) * _local_7.width));
                _local_14 = (((_local_4 - (_local_7.height * 0.5)) + (_local_5 * (_local_7.height + 5))) - ((_local_5 * 5) + 20));
                _local_12.data.length = 0;
                _local_12.data.push(_local_13, _local_14, (_local_13 + _local_7.width), _local_14, (_local_13 + _local_7.width), (_local_14 + _local_7.height), _local_13, (_local_14 + _local_7.height));
                _local_11 = _local_10.matrix;
                _local_11.identity();
                _local_11.translate(_local_13, _local_14);
                _arg_1.push(_local_10);
                _arg_1.push(_local_12);
                _arg_1.push(GraphicsUtil.END_FILL);
                _local_8++;
            }
        }


    }
}//package com.company.assembleegameclient.objects

