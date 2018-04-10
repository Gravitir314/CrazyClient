// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.DungeonChooser

package com.company.assembleegameclient.mapeditor{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;

import flash.utils.Dictionary;

public class DungeonChooser extends Chooser {

    public var currentDungon:String = "";
    private var cache:Dictionary;
    private var lastSearch:String = "";

    public function DungeonChooser(){
        super(Layer.OBJECT);
        this.cache = new Dictionary();
    }

    public function getLastSearch():String{
        return (this.lastSearch);
    }

    public function reloadObjects(_arg_1:String, _arg_2:String):void{
        var _local_4:RegExp;
        var _local_6:String;
        var _local_7:XML;
        var _local_8:int;
        var _local_9:ObjectElement;
        this.currentDungon = _arg_1;
        removeElements();
        this.lastSearch = _arg_2;
        var _local_3:Vector.<String> = new Vector.<String>();
        if (_arg_2 != ""){
            _local_4 = new RegExp(_arg_2, "gix");
        }
        var _local_5:Dictionary = GroupDivider.getDungeonsXML(this.currentDungon);
        for each (_local_7 in _local_5) {
            _local_6 = String(_local_7.@id);
            if (((_local_4 == null) || (_local_6.search(_local_4) >= 0))){
                _local_3.push(_local_6);
            }
        }
        _local_3.sort(MoreStringUtil.cmp);
        for each (_local_6 in _local_3) {
            _local_8 = ObjectLibrary.idToType_[_local_6];
            _local_7 = _local_5[_local_8];
            if (!this.cache[_local_8]){
                _local_9 = new ObjectElement(_local_7);
                this.cache[_local_8] = _local_9;
            } else {
                _local_9 = this.cache[_local_8];
            }
            addElement(_local_9);
        }
        hasBeenLoaded = true;
        scrollBar_.setIndicatorSize(HEIGHT, elementContainer_.height, true);
    }


}
}//package com.company.assembleegameclient.mapeditor

