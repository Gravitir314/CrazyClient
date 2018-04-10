// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.AllObjectChooser

package com.company.assembleegameclient.mapeditor{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;

import flash.utils.Dictionary;

internal class AllObjectChooser extends Chooser {

    public static const GROUP_NAME_MAP_OBJECTS:String = "All Map Objects";
    public static const GROUP_NAME_GAME_OBJECTS:String = "All Game Objects";

    private var cache:Dictionary;
    private var lastSearch:String = "";

    public function AllObjectChooser(){
        super(Layer.OBJECT);
        this.cache = new Dictionary();
    }

    public function getLastSearch():String{
        return (this.lastSearch);
    }

    public function reloadObjects(_arg_1:String="", _arg_2:String="All Map Objects"):void{
        var _local_4:RegExp;
        var _local_6:String;
        var _local_7:int;
        var _local_8:XML;
        var _local_9:int;
        var _local_10:ObjectElement;
        removeElements();
        this.lastSearch = _arg_1;
        var _local_3:Vector.<String> = new Vector.<String>();
        if (_arg_1 != ""){
            _local_4 = new RegExp(_arg_1, "gix");
        }
        var _local_5:Dictionary = GroupDivider.GROUPS[_arg_2];
        for each (_local_8 in _local_5) {
            _local_6 = String(_local_8.@id);
            _local_7 = int(_local_8.@type);
            if ((((_local_4 == null) || (_local_6.search(_local_4) >= 0)) || (_local_7 == int(_arg_1)))){
                _local_3.push(_local_6);
            }
        }
        _local_3.sort(MoreStringUtil.cmp);
        for each (_local_6 in _local_3) {
            _local_9 = ObjectLibrary.idToType_[_local_6];
            _local_8 = ObjectLibrary.xmlLibrary_[_local_9];
            if (!this.cache[_local_9]){
                _local_10 = new ObjectElement(_local_8);
                if (_arg_2 == GROUP_NAME_GAME_OBJECTS){
                    _local_10.downloadOnly = true;
                }
                this.cache[_local_9] = _local_10;
            } else {
                _local_10 = this.cache[_local_9];
            }
            addElement(_local_10);
        }
        hasBeenLoaded = true;
        scrollBar_.setIndicatorSize(HEIGHT, elementContainer_.height, true);
    }


}
}//package com.company.assembleegameclient.mapeditor

