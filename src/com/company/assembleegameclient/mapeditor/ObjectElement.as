// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.ObjectElement

package com.company.assembleegameclient.mapeditor
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.animation.Animations;
import com.company.assembleegameclient.objects.animation.AnimationsData;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Bitmap;
import flash.display.BitmapData;

public class ObjectElement extends Element 
    {

        public var objXML_:XML;

        public function ObjectElement(_arg_1:XML)
        {
            var _local_2:Animations;
            var _local_3:Bitmap;
            var _local_4:BitmapData;
            super(int(_arg_1.@type));
            this.objXML_ = _arg_1;
            var _local_5:BitmapData = ObjectLibrary.getRedrawnTextureFromType(type_, 100, true, false);
            var _local_6:AnimationsData = ObjectLibrary.typeToAnimationsData_[int(_arg_1.@type)];
            if (_local_6 != null)
            {
                _local_2 = new Animations(_local_6);
                _local_4 = _local_2.getTexture(0.4);
                if (_local_4 != null)
                {
                    _local_5 = _local_4;
                }
            }
            _local_3 = new Bitmap(_local_5);
            var _local_7:Number = ((WIDTH - 4) / Math.max(_local_3.width, _local_3.height));
            _local_3.scaleX = (_local_3.scaleY = _local_7);
            _local_3.x = ((WIDTH / 2) - (_local_3.width / 2));
            _local_3.y = ((HEIGHT / 2) - (_local_3.height / 2));
            addChild(_local_3);
        }

        override protected function getToolTip():ToolTip
        {
            return (new ObjectTypeToolTip(this.objXML_));
        }


    }
}//package com.company.assembleegameclient.mapeditor

