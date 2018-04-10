// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.RegionChooser

package com.company.assembleegameclient.mapeditor
{
    public class RegionChooser extends Chooser 
    {

        public function RegionChooser()
        {
            var _local_1:XML;
            var _local_2:RegionElement;
            super(Layer.REGION);
            for each (_local_1 in GroupDivider.GROUPS["Regions"])
            {
                _local_2 = new RegionElement(_local_1);
                addElement(_local_2);
            }
            hasBeenLoaded = true;
        }

    }
}//package com.company.assembleegameclient.mapeditor

