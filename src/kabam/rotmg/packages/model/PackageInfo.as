// Decompiled by AS3 Sorcerer 5.64
// www.as3sorcerer.com

//kabam.rotmg.packages.model.PackageInfo

package kabam.rotmg.packages.model{
import io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo;
import org.osflash.signals.Signal;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLRequest;

public class PackageInfo extends GenericBoxInfo {

    public static const PURCHASE_TYPE_MIXED:String = "PURCHASE_TYPE_MIXED";
    public static const PURCHASE_TYPE_SLOTS_ONLY:String = "PURCHASE_TYPE_SLOTS_ONLY";
    public static const PURCHASE_TYPE_CONTENTS_ONLY:String = "PURCHASE_TYPE_CONTENTS_ONLY";

    protected var _image:String;
    protected var _popupImage:String = "";
    private var _showOnLogin:Boolean;
    private var _charSlot:int;
    private var _vaultSlot:int;
    public var imageLoadedSignal:Signal = new Signal();
    public var popupImageLoadedSignal:Signal = new Signal();
    private var _loader:Loader;
    private var _popupLoader:Loader;


    public function get image():String{
        return (this._image);
    }

    public function get purchaseType():String{
        if (contents != ""){
            if (((this._charSlot > 0) || (this._vaultSlot > 0))){
                return (PURCHASE_TYPE_MIXED);
            };
            return (PURCHASE_TYPE_CONTENTS_ONLY);
        };
        return (PURCHASE_TYPE_SLOTS_ONLY);
    }

    public function set image(_arg_1:String):void{
        this._image = _arg_1;
        this._loader = new Loader();
        this.loadImage(this._image, this._loader, this.onComplete);
    }

    private function loadImage(_arg_1:String, _arg_2:Loader, _arg_3:Function):void{
        _arg_2.contentLoaderInfo.addEventListener(Event.COMPLETE, _arg_3);
        _arg_2.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
        _arg_2.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityEventError);
        try {
            _arg_2.load(new URLRequest(_arg_1));
        } catch(error:SecurityError) {
        };
    }

    private function unbindLoaderEvents(_arg_1:Loader, _arg_2:Function):void{
        if (((_arg_1) && (_arg_1.contentLoaderInfo))){
            _arg_1.contentLoaderInfo.removeEventListener(Event.COMPLETE, _arg_2);
            _arg_1.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            _arg_1.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityEventError);
        };
    }

    private function onIOError(_arg_1:IOErrorEvent):void{
    }

    private function onSecurityEventError(_arg_1:SecurityErrorEvent):void{
    }

    private function onComplete(_arg_1:Event):void{
        this.imageLoadedSignal.dispatch();
        this.unbindLoaderEvents(this._loader, this.onComplete);
    }

    private function onCompletePopup(_arg_1:Event):void{
        this.popupImageLoadedSignal.dispatch();
        this.unbindLoaderEvents(this._popupLoader, this.onCompletePopup);
    }

    public function dispose():void{
    }

    public function get loader():Loader{
        return (this._loader);
    }

    public function get popupImage():String{
        return (this._popupImage);
    }

    public function set popupImage(_arg_1:String):void{
        this._popupImage = _arg_1;
        this._popupLoader = new Loader();
        this.loadImage(this._popupImage, this._popupLoader, this.onCompletePopup);
    }

    public function get popupLoader():Loader{
        return (this._popupLoader);
    }

    public function get showOnLogin():Boolean{
        return (this._showOnLogin);
    }

    public function set showOnLogin(_arg_1:Boolean):void{
        this._showOnLogin = _arg_1;
    }

    public function get charSlot():int{
        return (this._charSlot);
    }

    public function set charSlot(_arg_1:int):void{
        this._charSlot = _arg_1;
    }

    public function get vaultSlot():int{
        return (this._vaultSlot);
    }

    public function set vaultSlot(_arg_1:int):void{
        this._vaultSlot = _arg_1;
    }


}
}//package kabam.rotmg.packages.model

