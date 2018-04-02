// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.account.web.commands.WebSetPaymentDataCommand

package kabam.rotmg.account.web.commands
{
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.web.WebAccount;

public class WebSetPaymentDataCommand
    {

        [Inject]
        public var characterListData:XML;
        [Inject]
        public var account:Account;


        public function execute():void
        {
            var _local_1:XML;
            var _local_2:WebAccount = (this.account as WebAccount);
            if (this.characterListData.hasOwnProperty("KabamPaymentInfo"))
            {
                _local_1 = XML(this.characterListData.KabamPaymentInfo);
                _local_2.signedRequest = _local_1.signedRequest;
                _local_2.kabamId = _local_1.naid;
            };
        }


    }
}//package kabam.rotmg.account.web.commands

