// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.dialogs.model.DialogsModel

package kabam.rotmg.dialogs.model
{
import com.company.assembleegameclient.parameters.Parameters;

import org.osflash.signals.Signal;

public class DialogsModel 
    {

        private var popupPriority:Array = [PopupNamesConfig.BEGINNERS_OFFER_POPUP, PopupNamesConfig.NEWS_POPUP, PopupNamesConfig.DAILY_LOGIN_POPUP, PopupNamesConfig.PACKAGES_OFFER_POPUP];
        private var queue:Vector.<PopupQueueEntry> = new Vector.<PopupQueueEntry>();


        public function addPopupToStartupQueue(_arg_1:String, _arg_2:Signal, _arg_3:int, _arg_4:Object):void
        {
            if (((_arg_3 == -1) || (this.canDisplayPopupToday(_arg_1))))
            {
                this.queue.push(new PopupQueueEntry(_arg_1, _arg_2, _arg_3, _arg_4));
                this.sortQueue();
            };
        }

        private function sortQueue():void
        {
            this.queue.sort(function (_arg_1:PopupQueueEntry, _arg_2:PopupQueueEntry):*
            {
                var _local_3:int = getPopupPriorityByName(_arg_1.name);
                var _local_4:int = getPopupPriorityByName(_arg_2.name);
                if (_local_3 < _local_4)
                {
                    return (-1);
                };
                return (1);
            });
        }

        public function flushStartupQueue():PopupQueueEntry
        {
            if (this.queue.length == 0)
            {
                return (null);
            };
            var _local_1:PopupQueueEntry = this.queue.shift();
            Parameters.data_[_local_1.name] = new Date().time;
            return (_local_1);
        }

        public function canDisplayPopupToday(_arg_1:String):Boolean
        {
            var _local_2:int;
            var _local_3:int;
            if (!Parameters.data_[_arg_1])
            {
                return (true);
            };
            _local_2 = int(Math.floor((Number(Parameters.data_[_arg_1]) / 86400000)));
            _local_3 = int(Math.floor((new Date().time / 86400000)));
            return (_local_3 > _local_2);
        }

        public function getPopupPriorityByName(_arg_1:String):int
        {
            var _local_2:int = this.popupPriority.indexOf(_arg_1);
            if (_local_2 < 0)
            {
                _local_2 = int.MAX_VALUE;
            };
            return (_local_2);
        }


    }
}//package kabam.rotmg.dialogs.model

