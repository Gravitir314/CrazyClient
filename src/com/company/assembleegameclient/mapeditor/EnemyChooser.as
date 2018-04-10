// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.EnemyChooser

package com.company.assembleegameclient.mapeditor{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;

import flash.utils.Dictionary;

internal class EnemyChooser extends Chooser {

    private var cache:Dictionary;
    private var lastSearch:String = "";
    private var filterTypes:Dictionary = new Dictionary(true);

    public function EnemyChooser(){
        super(Layer.OBJECT);
        this.cache = new Dictionary();
        this.filterTypes[ObjectLibrary.ENEMY_FILTER_LIST[0]] = "";
        this.filterTypes[ObjectLibrary.ENEMY_FILTER_LIST[1]] = "MaxHitPoints";
        this.filterTypes[ObjectLibrary.ENEMY_FILTER_LIST[2]] = ObjectLibrary.ENEMY_FILTER_LIST[2];
    }

    public function getLastSearch():String{
        return (this.lastSearch);
    }

    public function reloadObjects(_arg_1:String, _arg_2:String="", _arg_3:Number=0, _arg_4:Number=-1):void{
        var _local_7:XML;
        var _local_10:RegExp;
        var _local_12:String;
        var _local_13:int;
        var _local_14:ObjectElement;
        removeElements();
        this.lastSearch = _arg_1;
        var _local_5:Boolean = true;
        var _local_6:Boolean = true;
        var _local_8:Number = -1;
        var _local_9:Vector.<String> = new Vector.<String>();
        if (_arg_1 != ""){
            _local_10 = new RegExp(_arg_1, "gix");
        }
        if (_arg_2 != ""){
            _arg_2 = this.filterTypes[_arg_2];
        }
        var _local_11:Dictionary = GroupDivider.GROUPS["Enemies"];
        for each (_local_7 in _local_11) {
            _local_12 = String(_local_7.@id);
            if (!((!(_local_10 == null)) && (_local_12.search(_local_10) < 0))){
                if (_arg_2 != ""){
                    _local_8 = ((_local_7.hasOwnProperty(_arg_2)) ? Number(_local_7.elements(_arg_2)) : -1);
                    if (_local_8 < 0) continue;
                    _local_5 = (_local_8 >= _arg_3);
                    _local_6 = (!((_arg_4 > 0) && (_local_8 > _arg_4)));
                }
                if (((_local_5) && (_local_6))){
                    _local_9.push(_local_12);
                }
            }
        }
        _local_9.sort(MoreStringUtil.cmp);
        for each (_local_12 in _local_9) {
            _local_13 = ObjectLibrary.idToType_[_local_12];
            if (!this.cache[_local_13]){
                _local_14 = new ObjectElement(ObjectLibrary.xmlLibrary_[_local_13]);
                this.cache[_local_13] = _local_14;
            } else {
                _local_14 = this.cache[_local_13];
            }
            addElement(_local_14);
        }
        hasBeenLoaded = true;
        scrollBar_.setIndicatorSize(HEIGHT, elementContainer_.height, true);
    }


}
}//package com.company.assembleegameclient.mapeditor

