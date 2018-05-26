// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.social.config.SocialConfig

package io.decagames.rotmg.social.config{
import io.decagames.rotmg.social.SocialPopupMediator;
import io.decagames.rotmg.social.SocialPopupView;
import io.decagames.rotmg.social.commands.FriendActionCommand;
import io.decagames.rotmg.social.model.SocialModel;
import io.decagames.rotmg.social.popups.InviteFriendPopup;
import io.decagames.rotmg.social.popups.InviteFriendPopupMediator;
import io.decagames.rotmg.social.signals.FriendActionSignal;
import io.decagames.rotmg.social.signals.RefreshListSignal;
import io.decagames.rotmg.social.tasks.FriendDataRequestTask;
import io.decagames.rotmg.social.tasks.GuildDataRequestTask;
import io.decagames.rotmg.social.widgets.FriendListItem;
import io.decagames.rotmg.social.widgets.FriendListItemMediator;
import io.decagames.rotmg.social.widgets.GuildListItem;
import io.decagames.rotmg.social.widgets.GuildListItemMediator;

import kabam.rotmg.friends.view.FriendListMediator;
import kabam.rotmg.friends.view.FriendListView;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class SocialConfig implements IConfig {

        public static const MAX_FRIENDS:int = 100;

        [Inject]
        public var injector:Injector;
        [Inject]
        public var mediatorMap:IMediatorMap;
        [Inject]
        public var commandMap:ISignalCommandMap;


        public function configure():void{
            this.injector.map(RefreshListSignal).asSingleton();
            this.injector.map(FriendDataRequestTask).asSingleton();
            this.injector.map(GuildDataRequestTask).asSingleton();
            this.injector.map(SocialModel).asSingleton();
            this.mediatorMap.map(SocialPopupView).toMediator(SocialPopupMediator);
            this.mediatorMap.map(FriendListItem).toMediator(FriendListItemMediator);
            this.mediatorMap.map(GuildListItem).toMediator(GuildListItemMediator);
            this.mediatorMap.map(InviteFriendPopup).toMediator(InviteFriendPopupMediator);
            this.mediatorMap.map(FriendListView).toMediator(FriendListMediator);
            this.commandMap.map(FriendActionSignal).toCommand(FriendActionCommand);
        }


    }
}//package io.decagames.rotmg.social.config

