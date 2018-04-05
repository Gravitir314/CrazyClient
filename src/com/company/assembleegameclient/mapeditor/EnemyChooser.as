// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.EnemyChooser

package com.company.assembleegameclient.mapeditor
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;

import flash.utils.Dictionary;

public class EnemyChooser extends Chooser 
    {

        private var cache:Dictionary;
        private var lastSearch:String = "";
        private var filterTypes:Dictionary = new Dictionary(true);

        public function EnemyChooser(_arg_1:String="")
        {
            super(Layer.OBJECT);
            this.cache = new Dictionary();
            this.reloadObjects(_arg_1, "", 0, -1, true);
            this.filterTypes[ObjectLibrary.ENEMY_FILTER_LIST[0]] = "";
            this.filterTypes[ObjectLibrary.ENEMY_FILTER_LIST[1]] = "MaxHitPoints";
            this.filterTypes[ObjectLibrary.ENEMY_FILTER_LIST[2]] = ObjectLibrary.ENEMY_FILTER_LIST[2];
        }

        public function getLastSearch():String
        {
            return (this.lastSearch);
        }

        public function reloadObjects(_arg_1:String, _arg_2:String="", _arg_3:Number=0, _arg_4:Number=-1, _arg_5:Boolean=false):void
        {
            var _local_6:XML;
            var _local_7:String;
            var _local_8:int;
            var _local_9:ObjectElement;
            var _local_10:RegExp;
            if (!_arg_5)
            {
                removeElements();
            }
            this.lastSearch = _arg_1;
            var _local_11:Boolean = true;
            var _local_12:Boolean = true;
            var _local_13:Number = -1;
            var _local_14:Vector.<String> = new Vector.<String>();
            if (_arg_1 != "")
            {
                _local_10 = new RegExp(_arg_1, "gix");
            }
            if (_arg_2 != "")
            {
                _arg_2 = this.filterTypes[_arg_2];
            }
            var _local_15:Dictionary = GroupDivider.GROUPS["Enemies"];
            for each (_local_6 in _local_15)
            {
                _local_7 = String(_local_6.@id);
                if (!((!(_local_10 == null)) && (_local_7.search(_local_10) < 0)))
                {
                    if (_arg_2 != "")
                    {
                        _local_13 = ((_local_6.hasOwnProperty(_arg_2)) ? Number(Number(_local_6.elements(_arg_2))) : Number(-1));
                        if (_local_13 < 0) continue;
                        _local_11 = (_local_13 >= _arg_3);
                        _local_12 = (!((_arg_4 > 0) && (_local_13 > _arg_4)));
                    }
                    if (((_local_11) && (_local_12)))
                    {
                        _local_14.push(_local_7);
                    }
                }
            }
            _local_14.sort(MoreStringUtil.cmp);
            for each (_local_7 in _local_14)
            {
                _local_8 = ObjectLibrary.idToType_[_local_7];
                if (!this.cache[_local_8])
                {
                    _local_9 = new ObjectElement(ObjectLibrary.xmlLibrary_[_local_8]);
                    this.cache[_local_8] = _local_9;
                }
                else
                {
                    _local_9 = this.cache[_local_8];
                }
                addElement(_local_9);
            }
            scrollBar_.setIndicatorSize(HEIGHT, elementSprite_.height, true);
        }


    }
}//package com.company.assembleegameclient.mapeditor

