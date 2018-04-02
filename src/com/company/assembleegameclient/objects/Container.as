// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.objects.Container

package com.company.assembleegameclient.objects
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.panels.itemgrids.ContainerGrid;
import com.company.util.PointUtil;

public class Container extends GameObject implements IInteractiveObject
    {

        public var isLoot_:Boolean;
        public var ownerId_:String;
        public var canHaveSoulbound_:Boolean;

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
                        };
                    };
                };
                if (_local_3 != null)
                {
                    map_.player_.lootNotif(_local_3, this);
                };
            };
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
            };
            if (map_.player_ == null)
            {
                return (true);
            };
            var _local_4:Number = PointUtil.distanceXY(map_.player_.x_, map_.player_.y_, _arg_2, _arg_3);
            if (((this.isLoot_) && (_local_4 < 10)))
            {
                SoundEffectLibrary.play("loot_appears");
            };
            return (true);
        }

        public function getPanel(_arg_1:GameSprite):Panel
        {
            var _local_2:Player = (((_arg_1) && (_arg_1.map)) ? _arg_1.map.player_ : null);
            return (new ContainerGrid(this, _local_2));
        }


    }
}//package com.company.assembleegameclient.objects

