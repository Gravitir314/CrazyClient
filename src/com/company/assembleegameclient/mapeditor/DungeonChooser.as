// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.DungeonChooser

package com.company.assembleegameclient.mapeditor
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;

import flash.utils.Dictionary;

public class DungeonChooser extends Chooser 
    {

        public var currentDungon:String = "";
        private var cache:Dictionary;
        private var lastSearch:String = "";

        public function DungeonChooser(_arg_1:String="")
        {
            super(Layer.OBJECT);
            this.cache = new Dictionary();
            this.reloadObjects(GroupDivider.DEFAULT_DUNGEON, _arg_1, true);
        }

        public function getLastSearch():String
        {
            return (this.lastSearch);
        }

        public function reloadObjects(_arg_1:String, _arg_2:String, _arg_3:Boolean=false):void
        {
            var _local_4:String;
            var _local_5:XML;
            var _local_6:int;
            var _local_7:ObjectElement;
            var _local_8:RegExp;
            this.currentDungon = _arg_1;
            if (!_arg_3)
            {
                removeElements();
            }
            this.lastSearch = _arg_2;
            var _local_9:Vector.<String> = new Vector.<String>();
            if (_arg_2 != "")
            {
                _local_8 = new RegExp(_arg_2, "gix");
            }
            var _local_10:Dictionary = GroupDivider.getDungeonsXML(this.currentDungon);
            for each (_local_5 in _local_10)
            {
                _local_4 = String(_local_5.@id);
                if (((_local_8 == null) || (_local_4.search(_local_8) >= 0)))
                {
                    _local_9.push(_local_4);
                }
            }
            _local_9.sort(MoreStringUtil.cmp);
            for each (_local_4 in _local_9)
            {
                _local_6 = ObjectLibrary.idToType_[_local_4];
                _local_5 = _local_10[_local_6];
                if (!this.cache[_local_6])
                {
                    _local_7 = new ObjectElement(_local_5);
                    this.cache[_local_6] = _local_7;
                }
                else
                {
                    _local_7 = this.cache[_local_6];
                }
                addElement(_local_7);
            }
            scrollBar_.setIndicatorSize(HEIGHT, elementSprite_.height, true);
        }


    }
}//package com.company.assembleegameclient.mapeditor

