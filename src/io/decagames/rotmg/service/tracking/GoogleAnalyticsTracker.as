// Decompiled by AS3 Sorcerer 5.64
// www.as3sorcerer.com

//io.decagames.rotmg.service.tracking.GoogleAnalyticsTracker

package io.decagames.rotmg.service.tracking{
    import robotlegs.bender.framework.api.ILogger;
    import flash.net.SharedObject;
    import com.company.assembleegameclient.util.GUID;
    import flash.display.Loader;
    import flash.net.URLRequest;

    public class GoogleAnalyticsTracker {

        public static const VERSION:String = "1";

        private var _debug:Boolean = false;
        private var trackingURL:String = "http://www.google-analytics.com/collect";
        private var account:String;
        private var logger:ILogger;
        private var clientID:String;

        public function GoogleAnalyticsTracker(_arg_1:String, _arg_2:ILogger, _arg_3:String, _arg_4:Boolean=false){
            this.account = _arg_1;
            this.logger = _arg_2;
            this._debug = _arg_4;
            if (_arg_4){
                this.trackingURL = "http://www.google-analytics.com/debug/collect";
            };
            this.clientID = this.getClientID();
        }

        private function getClientID():String{
            var cid:String;
            var so:SharedObject = SharedObject.getLocal("_ga");
            if (!so.data.clientid){
                this.logger.debug("CID not found, generate Client ID");
                cid = GUID.create();
                so.data.clientid = cid;
                try {
                    so.flush(0x0400);
                } catch(e:Error) {
                    logger.debug(("Could not write SharedObject to disk: " + e.message));
                };
            } else {
                this.logger.debug("CID found, restore from SharedObject");
                cid = so.data.clientid;
            };
            return (cid);
        }

        public function trackEvent(_arg_1:String, _arg_2:String, _arg_3:String="", _arg_4:Number=NaN):void{
            this.triggerEvent((((((("&t=event" + "&ec=") + _arg_1) + "&ea=") + _arg_2) + ((_arg_3 != "") ? ("&el=" + _arg_3) : "")) + ((isNaN(_arg_4)) ? "" : ("&ev=" + _arg_4))));
        }

        public function trackPageView(_arg_1:String):void{
            this.triggerEvent((("&t=pageview" + "&dp=") + _arg_1));
        }

        private function prepareURL(_arg_1:String):String{
            return (((((((this.trackingURL + "?v=") + VERSION) + "&tid=") + this.account) + "&cid=") + this.clientID) + _arg_1);
        }

        private function triggerEvent(url:String):void{
            var urlLoader:Loader;
            var request:URLRequest;
            url = this.prepareURL(url);
            if (this._debug){
                this.logger.debug(("DEBUGGING GA:" + url));
                return;
            };
            try {
                urlLoader = new Loader();
                request = new URLRequest(url);
                urlLoader.load(request);
            } catch(e:Error) {
                logger.error(((((("Tracking Error:" + e.message) + ", ") + e.name) + ", ") + e.getStackTrace()));
            };
        }

        public function get debug():Boolean{
            return (this._debug);
        }


    }
}//package io.decagames.rotmg.service.tracking

