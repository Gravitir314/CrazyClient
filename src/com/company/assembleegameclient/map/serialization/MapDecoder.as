//com.company.assembleegameclient.map.serialization.MapDecoder

package com.company.assembleegameclient.map.serialization
{
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.objects.BasicObject;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.IntPoint;
import com.hurlant.util.Base64;

import flash.utils.ByteArray;

import kabam.lib.json.JsonParser;
import kabam.rotmg.core.StaticInjectorContext;

public class MapDecoder
    {


        private static function get json():JsonParser
        {
            return (StaticInjectorContext.getInjector().getInstance(JsonParser));
        }

        public static function decodeMap(_arg_1:String):Map
        {
            var _local_2:Object = json.parse(_arg_1);
            var _local_3:Map = new Map(null);
            _local_3.setProps(_local_2["width"], _local_2["height"], _local_2["name"], _local_2["back"], false, false);
            _local_3.initialize();
            writeMapInternal(_local_2, _local_3, 0, 0);
            return (_local_3);
        }

        public static function writeMap(_arg_1:String, _arg_2:Map, _arg_3:int, _arg_4:int):void
        {
            var _local_5:Object = json.parse(_arg_1);
            writeMapInternal(_local_5, _arg_2, _arg_3, _arg_4);
        }

        public static function getSize(_arg_1:String):IntPoint
        {
            var _local_2:Object = json.parse(_arg_1);
            return (new IntPoint(_local_2["width"], _local_2["height"]));
        }

        private static function writeMapInternal(_arg_1:Object, _arg_2:Map, _arg_3:int, _arg_4:int):void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:Object;
            var _local_8:Array;
            var _local_9:int;
            var _local_10:Object;
            var _local_11:GameObject;
            var _local_12:ByteArray = Base64.decodeToByteArray(_arg_1["data"]);
            _local_12.uncompress();
            var _local_13:Array = _arg_1["dict"];
            _local_5 = _arg_4;
            while (_local_5 < (_arg_4 + _arg_1["height"]))
            {
                _local_6 = _arg_3;
                while (_local_6 < (_arg_3 + _arg_1["width"]))
                {
                    _local_7 = _local_13[_local_12.readShort()];
                    if (!((((_local_6 < 0) || (_local_6 >= _arg_2.width_)) || (_local_5 < 0)) || (_local_5 >= _arg_2.height_)))
                    {
                        if (_local_7.hasOwnProperty("ground"))
                        {
                            _local_9 = GroundLibrary.idToType_[_local_7["ground"]];
                            _arg_2.setGroundTile(_local_6, _local_5, _local_9);
                        }
                        _local_8 = _local_7["objs"];
                        if (_local_8 != null)
                        {
                            for each (_local_10 in _local_8)
                            {
                                _local_11 = getGameObject(_local_10);
                                _local_11.objectId_ = BasicObject.getNextFakeObjectId();
                                _arg_2.addObj(_local_11, (_local_6 + 0.5), (_local_5 + 0.5));
                            }
                        }
                    }
                    _local_6++;
                }
                _local_5++;
            }
        }

        public static function getGameObject(_arg_1:Object):GameObject
        {
            var _local_2:int = ObjectLibrary.idToType_[_arg_1["id"]];
            var _local_3:XML = ObjectLibrary.xmlLibrary_[_local_2];
            var _local_4:GameObject = ObjectLibrary.getObjectFromType(_local_2);
            _local_4.size_ = ((_arg_1.hasOwnProperty("size")) ? _arg_1["size"] : _local_4.props_.getSize());
            return (_local_4);
        }


    }
}//package com.company.assembleegameclient.map.serialization

