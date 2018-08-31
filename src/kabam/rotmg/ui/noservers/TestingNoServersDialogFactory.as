﻿//kabam.rotmg.ui.noservers.TestingNoServersDialogFactory

package kabam.rotmg.ui.noservers
{
import com.company.assembleegameclient.ui.dialogs.Dialog;

public class TestingNoServersDialogFactory implements NoServersDialogFactory 
    {

        private static const BODY:String = 'There are currently no testing servers available. Please play on <font color="#7777EE"><a href="http://www.realmofthemadgod.com/">www.realmofthemadgod.com</a></font>.';
        private static const TITLE:String = "No Testing Servers";
        private static const TRACKING:String = "/noTestingServers";


        public function makeDialog():Dialog
        {
            return (new Dialog(TITLE, BODY, null, null, TRACKING));
        }


    }
}//package kabam.rotmg.ui.noservers

