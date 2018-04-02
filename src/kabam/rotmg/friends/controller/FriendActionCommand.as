// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.friends.controller.FriendActionCommand

package kabam.rotmg.friends.controller
{
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.friends.model.FriendConstant;
import kabam.rotmg.friends.model.FriendRequestVO;
import kabam.rotmg.game.signals.AddTextLineSignal;

public class FriendActionCommand
    {

        [Inject]
        public var client:AppEngineClient;
        [Inject]
        public var account:Account;
        [Inject]
        public var vo:FriendRequestVO;
        [Inject]
        public var openDialog:OpenDialogSignal;


        public function execute():void
        {
            var _local_1:AddTextLineSignal;
            if (this.vo.request == FriendConstant.INVITE)
            {
                _local_1 = StaticInjectorContext.getInjector().getInstance(AddTextLineSignal);
                _local_1.dispatch(ChatMessage.make("", "Friend request sent"));
            };
            var _local_2:String = FriendConstant.getURL(this.vo.request);
            var _local_3:Object = this.account.getCredentials();
            _local_3["targetName"] = this.vo.target;
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest(_local_2, _local_3);
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            if (this.vo.callback())
            {
                this.vo.callback(_arg_1, _arg_2, this.vo.target);
            }
            else
            {
                if (!_arg_1)
                {
                    this.openDialog.dispatch(new ErrorDialog(_arg_2));
                };
            };
        }


    }
}//package kabam.rotmg.friends.controller

