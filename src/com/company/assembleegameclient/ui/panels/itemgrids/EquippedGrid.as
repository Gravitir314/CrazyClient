// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid

package com.company.assembleegameclient.ui.panels.itemgrids
{
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.EquipmentTile;
import com.company.util.ArrayIterator;
import com.company.util.IIterator;

import kabam.lib.util.VectorAS3Util;

public class EquippedGrid extends ItemGrid
    {

        public static const NUM_SLOTS:uint = 4;

        private var tiles:Vector.<EquipmentTile>;

        public function EquippedGrid(_arg_1:GameObject, _arg_2:Vector.<int>, _arg_3:Player, _arg_4:int=0, _arg_5:Boolean=false)
        {
            var _local_6:EquipmentTile;
            var _local_7:int;
            var _local_8:int = 1;
            var _local_9:uint = NUM_SLOTS;
            if (((_arg_5) && (Parameters.data_["InvViewer"])))
            {
                _local_8 = ((_arg_3.hasBackpack_) ? 4 : 3);
                _local_9 = ((_arg_3.hasBackpack_) ? 20 : 12);
            }
            super(_arg_1, _arg_3, _arg_4);
            this.tiles = new Vector.<EquipmentTile>(_local_9);
            while (_local_7 < _local_9)
            {
                _local_6 = new EquipmentTile(_local_7, this, interactive);
                addToGrid(_local_6, _local_8, _local_7);
                _local_6.setType(_arg_2[_local_7]);
                this.tiles[_local_7] = _local_6;
                _local_7++;
            }
        }

        public function createInteractiveItemTileIterator():IIterator
        {
            return (new ArrayIterator(VectorAS3Util.toArray(this.tiles)));
        }

        override public function setItems(_arg_1:Vector.<int>, _arg_2:int=0):void
        {
            var _local_3:int;
            var _local_4:int;
            if (_arg_1)
            {
                _local_3 = _arg_1.length;
                _local_4 = 0;
                while (_local_4 < this.tiles.length)
                {
                    if ((_local_4 + _arg_2) < _local_3)
                    {
                        this.tiles[_local_4].setItem(_arg_1[(_local_4 + _arg_2)]);
                    }
                    else
                    {
                        this.tiles[_local_4].setItem(-1);
                    }
                    this.tiles[_local_4].updateDim(curPlayer);
                    _local_4++;
                }
            }
        }


    }
}//package com.company.assembleegameclient.ui.panels.itemgrids

