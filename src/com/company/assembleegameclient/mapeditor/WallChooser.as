// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.WallChooser

package com.company.assembleegameclient.mapeditor
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;

import flash.utils.Dictionary;

public class WallChooser extends Chooser 
    {

        private var cache:Dictionary;
        private var lastSearch:String = "";

        public function WallChooser(_arg_1:String="")
        {
            super(Layer.OBJECT);
            this.cache = new Dictionary();
            this.reloadObjects(_arg_1, true);
        }

        public function getLastSearch():String
        {
            return (this.lastSearch);
        }

        public function reloadObjects(_arg_1:String="", _arg_2:Boolean=false):void
        {
            var _local_3:String;
            var _local_4:XML;
            var _local_5:int;
            var _local_6:ObjectElement;
            var _local_7:RegExp;
            if (!_arg_2)
            {
                removeElements();
            }
            this.lastSearch = _arg_1;
            var _local_8:Vector.<String> = new Vector.<String>();
            if (_arg_1 != "")
            {
                _local_7 = new RegExp(_arg_1, "gix");
            }
            var _local_9:Dictionary = GroupDivider.GROUPS["Walls"];
            for each (_local_4 in _local_9)
            {
                _local_3 = String(_local_4.@id);
                if (((_local_7 == null) || (_local_3.search(_local_7) >= 0)))
                {
                    _local_8.push(_local_3);
                }
            }
            _local_8.sort(MoreStringUtil.cmp);
            for each (_local_3 in _local_8)
            {
                _local_5 = ObjectLibrary.idToType_[_local_3];
                _local_4 = ObjectLibrary.xmlLibrary_[_local_5];
                if (!this.cache[_local_5])
                {
                    _local_6 = new ObjectElement(_local_4);
                    this.cache[_local_5] = _local_6;
                }
                else
                {
                    _local_6 = this.cache[_local_5];
                }
                addElement(_local_6);
            }
            scrollBar_.setIndicatorSize(HEIGHT, elementSprite_.height, true);
        }


    }
}//package com.company.assembleegameclient.mapeditor

