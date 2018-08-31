//io.decagames.rotmg.service.tracking.GoogleAnalyticsTracker

package io.decagames.rotmg.service.tracking
{
import flash.crypto.generateRandomBytes;
import flash.display.Loader;
import flash.net.SharedObject;
import flash.net.URLRequest;
import flash.utils.ByteArray;

import robotlegs.bender.framework.api.ILogger;

public class GoogleAnalyticsTracker
    {

        public static const VERSION:String = "1";

        private var _debug:Boolean = false;
        private var trackingURL:String = "https://www.google-analytics.com/collect";
        private var account:String;
        private var logger:ILogger;
        private var clientID:String;

        public function GoogleAnalyticsTracker(_arg_1:String, _arg_2:ILogger, _arg_3:String, _arg_4:Boolean=false)
        {
            this.account = _arg_1;
            this.logger = _arg_2;
            this._debug = _arg_4;
            if (_arg_4)
            {
                this.trackingURL = "http://www.google-analytics.com/debug/collect";
            }
            this.clientID = this.getClientID();
        }

        private function getClientID():String
        {
            var cid:String;
            var so:SharedObject = SharedObject.getLocal("_ga2");
            if (!so.data.clientid)
            {
                this.logger.debug("CID not found, generate Client ID");
                cid = this._generateUUID();
                so.data.clientid = cid;
                try
                {
                    so.flush(0x0400);
                }
                catch(e:Error)
                {
                    logger.debug(("Could not write SharedObject to disk: " + e.message));
                }
            }
            else
            {
                this.logger.debug(("CID found, restore from SharedObject: " + so.data.clientid));
                cid = so.data.clientid;
            }
            return (cid);
        }

        private function _generateUUID():String
        {
            var i:uint;
            var b:uint;
            var randomBytes:ByteArray = generateRandomBytes(16);
            randomBytes[6] = (randomBytes[6] & 0x0F);
            randomBytes[6] = (randomBytes[6] | 0x40);
            randomBytes[8] = (randomBytes[8] & 0x3F);
            randomBytes[8] = (randomBytes[8] | 0x80);
            var toHex:Function = function (_arg_1:uint):String
            {
                var _local_2:String = _arg_1.toString(16);
                return ((_local_2.length > 1) ? _local_2 : ("0" + _local_2));
            };
            var str:String = "";
            var l:uint = randomBytes.length;
            randomBytes.position = 0;
            i = 0;
            while (i < l)
            {
                b = randomBytes[i];
                str = (str + toHex(b));
                i++;
            }
            var uuid:String = "";
            uuid = (uuid + str.substr(0, 8));
            uuid = (uuid + "-");
            uuid = (uuid + str.substr(8, 4));
            uuid = (uuid + "-");
            uuid = (uuid + str.substr(12, 4));
            uuid = (uuid + "-");
            uuid = (uuid + str.substr(16, 4));
            uuid = (uuid + "-");
            uuid = (uuid + str.substr(20, 12));
            return (uuid);
        }

        public function trackEvent(_arg_1:String, _arg_2:String, _arg_3:String="", _arg_4:Number=NaN):void
        {
            this.triggerEvent((((((("&t=event" + "&ec=") + _arg_1) + "&ea=") + _arg_2) + ((_arg_3 != "") ? ("&el=" + _arg_3) : "")) + ((isNaN(_arg_4)) ? "" : ("&ev=" + _arg_4))));
        }

        public function trackPageView(_arg_1:String):void
        {
            this.triggerEvent((("&t=pageview" + "&dp=") + _arg_1));
        }

        private function prepareURL(_arg_1:String):String
        {
            return (((((((this.trackingURL + "?v=") + VERSION) + "&tid=") + this.account) + "&cid=") + this.clientID) + _arg_1);
        }

        private function triggerEvent(url:String):void
        {
            var urlLoader:Loader;
            var request:URLRequest;
            url = this.prepareURL(url);
            if (this._debug)
            {
                this.logger.debug(("DEBUGGING GA:" + url));
                return;
            }
            try
            {
                urlLoader = new Loader();
                request = new URLRequest(url);
                urlLoader.load(request);
            }
            catch(e:Error)
            {
                logger.error(((((("Tracking Error:" + e.message) + ", ") + e.name) + ", ") + e.getStackTrace()));
            }
        }

        public function get debug():Boolean
        {
            return (this._debug);
        }


    }
}//package io.decagames.rotmg.service.tracking

