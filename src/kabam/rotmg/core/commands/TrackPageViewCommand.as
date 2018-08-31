//kabam.rotmg.core.commands.TrackPageViewCommand

package kabam.rotmg.core.commands
{
import kabam.rotmg.core.service.GoogleAnalytics;

public class TrackPageViewCommand 
    {

        [Inject]
        public var analytics:GoogleAnalytics;
        [Inject]
        public var pageURL:String;


        public function execute():void
        {
            this.analytics.trackPageView(this.pageURL);
        }


    }
}//package kabam.rotmg.core.commands

