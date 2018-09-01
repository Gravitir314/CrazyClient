﻿//kabam.rotmg.ui.view.CharacterDetailsMediator

package kabam.rotmg.ui.view
{
import com.company.assembleegameclient.objects.ImageFactory;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.icons.IconButtonFactory;
import com.company.assembleegameclient.ui.options.Options;

import flash.events.MouseEvent;

import io.decagames.rotmg.social.SocialPopupView;
import io.decagames.rotmg.social.model.SocialModel;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.chat.model.TellModel;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.friends.view.FriendListView;
import kabam.rotmg.ui.model.HUDModel;
import kabam.rotmg.ui.signals.HUDModelInitialized;
import kabam.rotmg.ui.signals.NameChangedSignal;
import kabam.rotmg.ui.signals.UpdateHUDSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CharacterDetailsMediator extends Mediator
{

	[Inject]
	public var view:CharacterDetailsView;
	[Inject]
	public var hudModel:HUDModel;
	[Inject]
	public var initHUDModelSignal:HUDModelInitialized;
	[Inject]
	public var updateHUD:UpdateHUDSignal;
	[Inject]
	public var nameChanged:NameChangedSignal;
	[Inject]
	public var iconButtonFactory:IconButtonFactory;
	[Inject]
	public var imageFactory:ImageFactory;
	[Inject]
	public var tellModel:TellModel;
	[Inject]
	public var socialModel:SocialModel;
	[Inject]
	public var showPopupSignal:ShowPopupSignal;
	[Inject]
	public var openDialog:OpenDialogSignal;


	override public function initialize():void
	{
		this.injectFactories();
		this.view.init(this.hudModel.getPlayerName(), this.hudModel.getButtonType());
		this.updateHUD.addOnce(this.onUpdateHUD);
		this.updateHUD.add(this.onDraw);
		this.nameChanged.add(this.onNameChange);
		this.view.gotoNexus.add(this.onGotoNexus);
		this.view.gotoOptions.add(this.onGotoOptions);
		if (Parameters.USE_NEW_FRIENDS_UI)
		{
			this.socialModel.noInvitationSignal.add(this.clearFriendsIndicator);
			this.socialModel.socialDataSignal.add(this.onFriendsData);
		}
		this.view.initFriendList(this.imageFactory, this.iconButtonFactory, this.onFriendsBtnClicked, ((Parameters.USE_NEW_FRIENDS_UI) && (this.socialModel.hasInvitations)));
	}

	private function clearFriendsIndicator():void
	{
		this.view.clearInvitationIndicator();
	}

	private function onFriendsBtnClicked(_arg_1:MouseEvent):void
	{
		if (Parameters.USE_NEW_FRIENDS_UI)
		{
			this.showPopupSignal.dispatch(new SocialPopupView());
		}
		else
		{
			this.openDialog.dispatch(new FriendListView());
		}
	}

	private function onFriendsData(_arg_1:String, _arg_2:Boolean, _arg_3:String):void
	{
		if (_arg_2)
		{
			if (this.socialModel.hasInvitations)
			{
				this.view.addInvitationIndicator();
			}
			else
			{
				this.view.clearInvitationIndicator();
			}
		}
	}

	private function injectFactories():void
	{
		this.view.iconButtonFactory = this.iconButtonFactory;
		this.view.imageFactory = this.imageFactory;
	}

	override public function destroy():void
	{
		this.updateHUD.remove(this.onDraw);
		this.nameChanged.remove(this.onNameChange);
		this.view.gotoNexus.remove(this.onGotoNexus);
		this.view.gotoOptions.remove(this.onGotoOptions);
		this.view.friendsBtn.removeEventListener(MouseEvent.CLICK, this.onFriendsBtnClicked);
		if (Parameters.USE_NEW_FRIENDS_UI)
		{
			this.socialModel.noInvitationSignal.remove(this.clearFriendsIndicator);
			this.socialModel.socialDataSignal.remove(this.onFriendsData);
		}
	}

	private function onGotoNexus():void
	{
		this.tellModel.clearRecipients();
		this.hudModel.gameSprite.gsc_.escape();
		Parameters.data_.needsRandomRealm = false;
		Parameters.save();
	}

	private function onGotoOptions():void
	{
		this.hudModel.gameSprite.mui_.clearInput();
		this.hudModel.gameSprite.addChild(new Options(this.hudModel.gameSprite));
	}

	private function onUpdateHUD(_arg_1:Player):void
	{
		this.view.update(_arg_1);
	}

	private function onDraw(_arg_1:Player):void
	{
		this.view.draw(_arg_1);
	}

	private function onNameChange(_arg_1:String):void
	{
		this.view.setName(_arg_1);
	}


}
}//package kabam.rotmg.ui.view

