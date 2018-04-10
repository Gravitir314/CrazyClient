// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.tooltip.SlotComparisonFactory

package com.company.assembleegameclient.ui.tooltip
{
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.CloakComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.GeneralProjectileComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.GenericArmorComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.HelmetComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.OrbComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.SealComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.SlotComparison;
import com.company.assembleegameclient.ui.tooltip.slotcomparisons.TomeComparison;

import kabam.rotmg.constants.ItemConstants;

public class SlotComparisonFactory
    {

        private var hash:Object;

        public function SlotComparisonFactory()
        {
            var _local_1:GeneralProjectileComparison = new GeneralProjectileComparison();
            var _local_2:GenericArmorComparison = new GenericArmorComparison();
            this.hash = {};
            this.hash[ItemConstants.TOME_TYPE] = new TomeComparison();
            this.hash[ItemConstants.LEATHER_TYPE] = _local_2;
            this.hash[ItemConstants.PLATE_TYPE] = _local_2;
            this.hash[ItemConstants.SEAL_TYPE] = new SealComparison();
            this.hash[ItemConstants.CLOAK_TYPE] = new CloakComparison();
            this.hash[ItemConstants.ROBE_TYPE] = _local_2;
            this.hash[ItemConstants.HELM_TYPE] = new HelmetComparison();
            this.hash[ItemConstants.ORB_TYPE] = new OrbComparison();
        }

        public function getComparisonResults(_arg_1:XML, _arg_2:XML):SlotComparisonResult
        {
            var _local_3:int = int(_arg_1.SlotType);
            var _local_4:SlotComparison = this.hash[_local_3];
            var _local_5:SlotComparisonResult = new SlotComparisonResult();
            if (_local_4 != null)
            {
                _local_4.compare(_arg_1, _arg_2);
                _local_5.lineBuilder = _local_4.comparisonStringBuilder;
                _local_5.processedTags = _local_4.processedTags;
            }
            return (_local_5);
        }


    }
}//package com.company.assembleegameclient.ui.tooltip

