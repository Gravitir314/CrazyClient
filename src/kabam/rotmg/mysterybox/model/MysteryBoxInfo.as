// Decompiled by AS3 Sorcerer 5.64
// www.as3sorcerer.com

//kabam.rotmg.mysterybox.model.MysteryBoxInfo

package kabam.rotmg.mysterybox.model{
import io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo;
import flash.display.DisplayObject;
import kabam.display.Loader.LoaderProxy;
import kabam.display.Loader.LoaderProxyConcrete;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;
import flash.utils.Dictionary;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import com.company.assembleegameclient.util.TimeUtil;

public class MysteryBoxInfo extends GenericBoxInfo {

    public static var chestImageEmbed:Class = MysteryBoxInfo_chestImageEmbed;

    public var _iconImageUrl:String;
    private var _iconImage:DisplayObject;
    public var _infoImageUrl:String;
    private var _infoImage:DisplayObject;
    private var _loader:LoaderProxy = new LoaderProxyConcrete();
    private var _infoImageLoader:LoaderProxy = new LoaderProxyConcrete();
    public var _rollsWithContents:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
    public var _rollsWithContentsUnique:Vector.<int> = new Vector.<int>();
    private var _rollsContents:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
    private var _rolls:int;
    private var _jackpots:String = "";
    private var _displayedItems:String = "";


    public function get iconImageUrl():*{
        return (this._iconImageUrl);
    }

    public function set iconImageUrl(_arg_1:String):void{
        this._iconImageUrl = _arg_1;
        this.loadIconImageFromUrl(this._iconImageUrl);
    }

    private function loadIconImageFromUrl(_arg_1:String):void{
        ((this._loader) && (this._loader.unload()));
        this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
        this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
        this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.DISK_ERROR, this.onError);
        this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, this.onError);
        this._loader.load(new URLRequest(_arg_1));
    }

    private function onError(_arg_1:IOErrorEvent):void{
        this._iconImage = new chestImageEmbed();
    }

    private function onComplete(_arg_1:Event):void{
        this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onComplete);
        this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
        this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.DISK_ERROR, this.onError);
        this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.NETWORK_ERROR, this.onError);
        this._iconImage = DisplayObject(this._loader);
    }

    public function get iconImage():DisplayObject{
        return (this._iconImage);
    }

    public function get infoImageUrl():*{
        return (this._infoImageUrl);
    }

    public function set infoImageUrl(_arg_1:String):void{
        this._infoImageUrl = _arg_1;
        this.loadInfomageFromUrl(this._infoImageUrl);
    }

    private function loadInfomageFromUrl(_arg_1:String):void{
        this.loadImageFromUrl(_arg_1, this._infoImageLoader);
    }

    private function loadImageFromUrl(_arg_1:String, _arg_2:LoaderProxy):void{
        ((_arg_2) && (_arg_2.unload()));
        _arg_2.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onInfoComplete);
        _arg_2.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onInfoError);
        _arg_2.contentLoaderInfo.addEventListener(IOErrorEvent.DISK_ERROR, this.onInfoError);
        _arg_2.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, this.onInfoError);
        _arg_2.load(new URLRequest(_arg_1));
    }

    private function onInfoError(_arg_1:IOErrorEvent):void{
    }

    private function onInfoComplete(_arg_1:Event):void{
        this._infoImageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onInfoComplete);
        this._infoImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onInfoError);
        this._infoImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.DISK_ERROR, this.onInfoError);
        this._infoImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.NETWORK_ERROR, this.onInfoError);
        this._infoImage = DisplayObject(this._infoImageLoader);
    }

    public function parseContents():void{
        var _local_4:String;
        var _local_5:Vector.<int>;
        var _local_6:Array;
        var _local_7:String;
        var _local_1:Array = _contents.split(";");
        var _local_2:Dictionary = new Dictionary();
        var _local_3:int;
        for each (_local_4 in _local_1) {
            _local_5 = new Vector.<int>();
            _local_6 = _local_4.split(",");
            for each (_local_7 in _local_6) {
                if (_local_2[int(_local_7)] == null){
                    _local_2[int(_local_7)] = true;
                    this._rollsWithContentsUnique.push(int(_local_7));
                };
                _local_5.push(int(_local_7));
            };
            this._rollsWithContents.push(_local_5);
            this._rollsContents[_local_3] = _local_5;
            _local_3++;
        };
    }

    public function getSaleTimeLeftStringBuilder():LineBuilder{
        var _local_1:Date = new Date();
        var _local_2:* = "";
        var _local_3:Number = ((_saleEnd.time - _local_1.time) / 1000);
        var _local_4:LineBuilder = new LineBuilder();
        if (_local_3 > TimeUtil.DAY_IN_S){
            _local_4.setParams("MysteryBoxInfo.saleEndStringDays", {"amount":String(Math.ceil(TimeUtil.secondsToDays(_local_3)))});
        } else {
            if (_local_3 > TimeUtil.HOUR_IN_S){
                _local_4.setParams("MysteryBoxInfo.saleEndStringHours", {"amount":String(Math.ceil(TimeUtil.secondsToHours(_local_3)))});
            } else {
                _local_4.setParams("MysteryBoxInfo.saleEndStringMinutes", {"amount":String(Math.ceil(TimeUtil.secondsToMins(_local_3)))});
            };
        };
        return (_local_4);
    }

    public function get currencyName():String{
        switch (_priceCurrency){
            case "0":
                return (LineBuilder.getLocalizedStringFromKey("Currency.gold").toLowerCase());
            case "1":
                return (LineBuilder.getLocalizedStringFromKey("Currency.fame").toLowerCase());
        };
        return ("");
    }

    public function get infoImage():DisplayObject{
        return (this._infoImage);
    }

    public function set infoImage(_arg_1:DisplayObject):void{
        this._infoImage = _arg_1;
    }

    public function get loader():LoaderProxy{
        return (this._loader);
    }

    public function set loader(_arg_1:LoaderProxy):void{
        this._loader = _arg_1;
    }

    public function get infoImageLoader():LoaderProxy{
        return (this._infoImageLoader);
    }

    public function set infoImageLoader(_arg_1:LoaderProxy):void{
        this._infoImageLoader = _arg_1;
    }

    public function get jackpots():String{
        return (this._jackpots);
    }

    public function set jackpots(_arg_1:String):void{
        this._jackpots = _arg_1;
    }

    public function get rolls():int{
        return (this._rolls);
    }

    public function set rolls(_arg_1:int):void{
        this._rolls = _arg_1;
    }

    public function get rollsContents():Vector.<Vector.<int>>{
        return (this._rollsContents);
    }

    public function get displayedItems():String{
        return (this._displayedItems);
    }

    public function set displayedItems(_arg_1:String):void{
        this._displayedItems = _arg_1;
    }


}
}//package kabam.rotmg.mysterybox.model

