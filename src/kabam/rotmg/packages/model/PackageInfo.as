// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.packages.model.PackageInfo

package kabam.rotmg.packages.model
{
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLRequest;

import io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo;

import org.osflash.signals.Signal;

public class PackageInfo extends GenericBoxInfo
    {

        protected var _image:String;
        protected var _popupImage:String = "";
        public var imageLoadedSignal:Signal = new Signal();
        public var popupImageLoadedSignal:Signal = new Signal();
        private var _loader:Loader;
        private var _popupLoader:Loader;


        public function get image():String
        {
            return (this._image);
        }

        public function set image(_arg_1:String):void
        {
            this._image = _arg_1;
            this._loader = new Loader();
            this.loadImage(this._image, this._loader, this.onComplete);
        }

        private function loadImage(param1:String, param2:Loader, param3:Function):void
        {
            param2.contentLoaderInfo.addEventListener(Event.COMPLETE, param3);
            param2.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            param2.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityEventError);
            try
            {
                param2.load(new URLRequest(param1));
                return;
            }
            catch(error:SecurityError)
            {
                return;
            };
        }

        private function unbindLoaderEvents(_arg_1:Loader, _arg_2:Function):void
        {
            if (((_arg_1) && (_arg_1.contentLoaderInfo)))
            {
                _arg_1.contentLoaderInfo.removeEventListener(Event.COMPLETE, _arg_2);
                _arg_1.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
                _arg_1.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityEventError);
            };
        }

        private function onIOError(_arg_1:IOErrorEvent):void
        {
        }

        private function onSecurityEventError(_arg_1:SecurityErrorEvent):void
        {
        }

        private function onComplete(_arg_1:Event):void
        {
            this.imageLoadedSignal.dispatch();
            this.unbindLoaderEvents(this._loader, this.onComplete);
        }

        private function onCompletePopup(_arg_1:Event):void
        {
            this.popupImageLoadedSignal.dispatch();
            this.unbindLoaderEvents(this._popupLoader, this.onCompletePopup);
        }

        public function dispose():void
        {
        }

        public function get loader():Loader
        {
            return (this._loader);
        }

        public function get popupImage():String
        {
            return (this._popupImage);
        }

        public function set popupImage(_arg_1:String):void
        {
            this._popupImage = _arg_1;
            this._popupLoader = new Loader();
            this.loadImage(this._popupImage, this._popupLoader, this.onCompletePopup);
        }

        public function get popupLoader():Loader
        {
            return (this._popupLoader);
        }


    }
}//package kabam.rotmg.packages.model

