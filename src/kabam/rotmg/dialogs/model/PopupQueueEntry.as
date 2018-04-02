// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.dialogs.model.PopupQueueEntry

package kabam.rotmg.dialogs.model
{
import org.osflash.signals.Signal;

public class PopupQueueEntry 
    {

        private var _name:String;
        private var _signal:Signal;
        private var _showingPerDay:int;
        private var _paramObject:Object;

        public function PopupQueueEntry(_arg_1:String, _arg_2:Signal, _arg_3:int, _arg_4:Object)
        {
            this._name = _arg_1;
            this._signal = _arg_2;
            this._showingPerDay = _arg_3;
            this._paramObject = _arg_4;
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }

        public function get signal():Signal
        {
            return (this._signal);
        }

        public function set signal(_arg_1:Signal):void
        {
            this._signal = _arg_1;
        }

        public function get showingPerDay():int
        {
            return (this._showingPerDay);
        }

        public function set showingPerDay(_arg_1:int):void
        {
            this._showingPerDay = _arg_1;
        }

        public function get paramObject():Object
        {
            return (this._paramObject);
        }

        public function set paramObject(_arg_1:Object):void
        {
            this._paramObject = _arg_1;
        }


    }
}//package kabam.rotmg.dialogs.model

