// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//kabam.rotmg.account.web.services.WebLoadAccountTask

package kabam.rotmg.account.web.services{
import com.company.assembleegameclient.util.GUID;

import flash.net.SharedObject;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.LoadAccountTask;
import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.appengine.api.AppEngineClient;

public class WebLoadAccountTask extends BaseTask implements LoadAccountTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var client:AppEngineClient;
    private var data:AccountData;


    override protected function startTask():void{
        this.getAccountData();
        if (this.data.username){
            this.setAccountDataThenComplete();
        } else {
            this.setGuestPasswordAndComplete();
        }
    }

    private function getAccountData():void{
        var _local_1:SharedObject;
        this.data = new AccountData();
        try {
            _local_1 = SharedObject.getLocal("RotMG", "/");
            ((_local_1.data["GUID"]) && (this.data.username = _local_1.data["GUID"]));
            ((_local_1.data["Password"]) && (this.data.password = _local_1.data["Password"]));
            ((_local_1.data["Token"]) && (this.data.token = _local_1.data["Token"]));
            ((_local_1.data["Secret"]) && (this.data.secret = _local_1.data["Secret"]));
            if (("Name" in _local_1.data)){
                this.data.name = _local_1.data["Name"];
            }
        } catch(error:Error) {
            (trace(error.message));
            data.username = null;
            data.password = null;
            data.secret = null;
        }
    }

    private function setAccountDataThenComplete():void{
        this.account.updateUser(this.data.username, this.data.password, this.data.token, this.data.secret);
        this.account.verify(false);
        completeTask(true);
    }

    private function setGuestPasswordAndComplete():void{
        this.account.updateUser(GUID.create(), null, "", "");
        completeTask(true);
    }


}
}//package kabam.rotmg.account.web.services

