// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.social.tasks.FriendDataRequestTask

package io.decagames.rotmg.social.tasks{
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;

public class FriendDataRequestTask extends BaseTask implements ISocialTask {

        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        private var _requestURL:String;
        private var _xml:XML;


        override protected function startTask():void{
            this.client.setMaxRetries(8);
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest(this._requestURL, this.account.getCredentials());
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void{
            if (_arg_1){
                this._xml = new XML(_arg_2);
                completeTask(true);
            } else {
                completeTask(false, _arg_2);
            }
        }

        public function get requestURL():String{
            return (this._requestURL);
        }

        public function set requestURL(_arg_1:String):void{
            this._requestURL = _arg_1;
        }

        public function get xml():XML{
            return (this._xml);
        }

        public function set xml(_arg_1:XML):void{
            this._xml = _arg_1;
        }


    }
}//package io.decagames.rotmg.social.tasks

