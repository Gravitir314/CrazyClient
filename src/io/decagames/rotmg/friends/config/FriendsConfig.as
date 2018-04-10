// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.friends.config.FriendsConfig

package io.decagames.rotmg.friends.config{
import io.decagames.rotmg.friends.FriendsPopupMediator;
import io.decagames.rotmg.friends.FriendsPopupView;
import io.decagames.rotmg.friends.commands.FriendActionCommand;
import io.decagames.rotmg.friends.model.FriendModel;
import io.decagames.rotmg.friends.popups.InviteFriendPopup;
import io.decagames.rotmg.friends.popups.InviteFriendPopupMediator;
import io.decagames.rotmg.friends.signals.FriendActionSignal;
import io.decagames.rotmg.friends.signals.RefreshFriendsListSignal;
import io.decagames.rotmg.friends.tasks.FriendDataRequestTask;
import io.decagames.rotmg.friends.widgets.FriendListItem;
import io.decagames.rotmg.friends.widgets.FriendListItemMediator;

import kabam.rotmg.friends.view.FriendListMediator;
import kabam.rotmg.friends.view.FriendListView;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class FriendsConfig implements IConfig {

        public static const MAX_FRIENDS:int = 100;

        [Inject]
        public var injector:Injector;
        [Inject]
        public var mediatorMap:IMediatorMap;
        [Inject]
        public var commandMap:ISignalCommandMap;


        public function configure():void{
            this.injector.map(RefreshFriendsListSignal).asSingleton();
            this.injector.map(FriendDataRequestTask).asSingleton();
            this.mediatorMap.map(FriendsPopupView).toMediator(FriendsPopupMediator);
            this.mediatorMap.map(FriendListItem).toMediator(FriendListItemMediator);
            this.mediatorMap.map(InviteFriendPopup).toMediator(InviteFriendPopupMediator);
            this.injector.map(FriendDataRequestTask);
            this.injector.map(FriendModel).asSingleton();
            this.mediatorMap.map(FriendListView).toMediator(FriendListMediator);
            this.commandMap.map(FriendActionSignal).toCommand(FriendActionCommand);
        }


    }
}//package io.decagames.rotmg.friends.config

