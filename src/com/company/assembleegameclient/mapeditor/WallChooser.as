// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.WallChooser

package com.company.assembleegameclient.mapeditor{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;

import flash.utils.Dictionary;

public class WallChooser extends Chooser {

    private var cache:Dictionary;
    private var lastSearch:String = "";

    public function WallChooser(){
        super(Layer.OBJECT);
        this.cache = new Dictionary();
    }

    public function getLastSearch():String{
        return (this.lastSearch);
    }

    public function reloadObjects(_arg_1:String=""):void{
        var _local_3:RegExp;
        var _local_5:String;
        var _local_6:XML;
        var _local_7:int;
        var _local_8:ObjectElement;
        removeElements();
        this.lastSearch = _arg_1;
        var _local_2:Vector.<String> = new Vector.<String>();
        if (_arg_1 != ""){
            _local_3 = new RegExp(_arg_1, "gix");
        }
        var _local_4:Dictionary = GroupDivider.GROUPS["Walls"];
        for each (_local_6 in _local_4) {
            _local_5 = String(_local_6.@id);
            if (((_local_3 == null) || (_local_5.search(_local_3) >= 0))){
                _local_2.push(_local_5);
            }
        }
        _local_2.sort(MoreStringUtil.cmp);
        for each (_local_5 in _local_2) {
            _local_7 = ObjectLibrary.idToType_[_local_5];
            _local_6 = ObjectLibrary.xmlLibrary_[_local_7];
            if (!this.cache[_local_7]){
                _local_8 = new ObjectElement(_local_6);
                this.cache[_local_7] = _local_8;
            } else {
                _local_8 = this.cache[_local_7];
            }
            addElement(_local_8);
        }
        hasBeenLoaded = true;
        scrollBar_.setIndicatorSize(HEIGHT, elementContainer_.height, true);
    }


}
}//package com.company.assembleegameclient.mapeditor

