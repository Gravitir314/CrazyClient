// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.appengine.api.AppEngineClient

package kabam.rotmg.appengine.api
{
import org.osflash.signals.OnceSignal;

public interface AppEngineClient
    {

        function get complete():OnceSignal;
        function setDataFormat(_arg_1:String):void;
        function setSendEncrypted(_arg_1:Boolean):void;
        function setMaxRetries(_arg_1:int):void;
        function sendRequest(_arg_1:String, _arg_2:Object):void;
        function requestInProgress():Boolean;

    }
}//package kabam.rotmg.appengine.api

