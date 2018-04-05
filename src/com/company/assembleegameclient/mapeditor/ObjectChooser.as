// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.ObjectChooser

package com.company.assembleegameclient.mapeditor
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;

import flash.utils.Dictionary;

public class ObjectChooser extends Chooser 
    {

        private var cache:Dictionary;
        private var lastSearch:String = "";

        public function ObjectChooser(_arg_1:String="")
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
            var _local_3:RegExp;
            var _local_4:String;
            var _local_5:XML;
            var _local_6:int;
            var _local_7:ObjectElement;
            if (!_arg_2)
            {
                removeElements();
            }
            this.lastSearch = _arg_1;
            var _local_8:Vector.<String> = new Vector.<String>();
            if (_arg_1 != "")
            {
                _local_3 = new RegExp(_arg_1, "gix");
            }
            var _local_9:Dictionary = GroupDivider.GROUPS["Basic Objects"];
            for each (_local_5 in _local_9)
            {
                _local_4 = String(_local_5.@id);
                if (((_local_3 == null) || (_local_4.search(_local_3) >= 0)))
                {
                    _local_8.push(_local_4);
                }
            }
            _local_8.sort(MoreStringUtil.cmp);
            for each (_local_4 in _local_8)
            {
                _local_6 = ObjectLibrary.idToType_[_local_4];
                _local_5 = ObjectLibrary.xmlLibrary_[_local_6];
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

