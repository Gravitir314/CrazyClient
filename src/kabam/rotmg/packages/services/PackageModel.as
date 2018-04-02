// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.packages.services.PackageModel

package kabam.rotmg.packages.services
{
import kabam.rotmg.packages.model.PackageInfo;

import org.osflash.signals.Signal;

public class PackageModel
    {

        public var numSpammed:int = 0;
        public var dataChanged:Signal = new Signal();
        private var models:Object;
        private var initialized:Boolean;
        private var maxSlots:int = 4;


        public function getBoxesForGrid():Vector.<PackageInfo>
        {
            var _local_1:PackageInfo;
            var _local_2:Vector.<PackageInfo> = new Vector.<PackageInfo>(this.maxSlots);
            for each (_local_1 in this.models)
            {
                if (_local_1.slot != 0)
                {
                    _local_2[(_local_1.slot - 1)] = _local_1;
                };
            };
            return (_local_2);
        }

        public function startupPackage():PackageInfo
        {
            var _local_1:PackageInfo;
            for each (_local_1 in this.models)
            {
                if (_local_1.popupImage != "")
                {
                    return (_local_1);
                };
            };
            return (null);
        }

        public function getInitialized():Boolean
        {
            return (this.initialized);
        }

        public function getPackageById(_arg_1:int):PackageInfo
        {
            return (this.models[_arg_1]);
        }

        public function hasPackage(_arg_1:int):Boolean
        {
            return (_arg_1 in this.models);
        }

        public function setPackages(_arg_1:Array):void
        {
            var _local_2:PackageInfo;
            this.models = {};
            for each (_local_2 in _arg_1)
            {
                this.models[_local_2.id] = _local_2;
            };
            this.initialized = true;
            this.dataChanged.dispatch();
        }

        private function onDataChanged():void
        {
            this.dataChanged.dispatch();
        }

        public function canPurchasePackage(_arg_1:int):Boolean
        {
            return (this.models[_arg_1]);
        }

        public function getPriorityPackage():PackageInfo
        {
            return (null);
        }

        public function hasPackages():Boolean
        {
            var _local_1:Object;
            for each (_local_1 in this.models)
            {
                return (true);
            };
            return (false);
        }


    }
}//package kabam.rotmg.packages.services

