//kabam.rotmg.core.service.GoogleAnalytics

package kabam.rotmg.core.service
{
import flash.system.Capabilities;

import io.decagames.rotmg.service.tracking.GoogleAnalyticsTracker;

import robotlegs.bender.framework.api.ILogger;

public class GoogleAnalytics
    {

        private var tracker:GoogleAnalyticsTracker;
        [Inject]
        public var logger:ILogger;


        public function init(_arg_1:String, _arg_2:String):void
        {
            this.logger.debug(((("GA setup: " + _arg_1) + ", type:") + Capabilities.playerType));
            this.tracker = new GoogleAnalyticsTracker(_arg_1, this.logger, _arg_2);
        }

        public function trackEvent(_arg_1:String, _arg_2:String, _arg_3:String="", _arg_4:Number=NaN):void
        {
            this.tracker.trackEvent(_arg_1, _arg_2, _arg_3, _arg_4);
            this.logger.debug(((((((("Track event - category: " + _arg_1) + ", action:") + _arg_2) + ", label: ") + _arg_3) + ", value:") + _arg_4));
        }

        public function trackPageView(_arg_1:String):void
        {
        }


    }
}//package kabam.rotmg.core.service

