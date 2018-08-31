//io.decagames.rotmg.pets.components.petItem.PetItemBackground

package io.decagames.rotmg.pets.components.petItem
{
import com.company.util.GraphicsUtil;

import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;

public class PetItemBackground extends Sprite 
    {

        public function PetItemBackground(_arg_1:int, _arg_2:Array, _arg_3:uint, _arg_4:Number)
        {
            var _local_5:GraphicsSolidFill = new GraphicsSolidFill(_arg_3, _arg_4);
            var _local_6:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
            var _local_7:Vector.<IGraphicsData> = new <IGraphicsData>[_local_5, _local_6, GraphicsUtil.END_FILL];
            GraphicsUtil.drawCutEdgeRect(0, 0, _arg_1, _arg_1, (_arg_1 / 12), _arg_2, _local_6);
            graphics.drawGraphicsData(_local_7);
        }

    }
}//package io.decagames.rotmg.pets.components.petItem

