﻿//kabam.rotmg.ui.view.NewCharacterMediator

package kabam.rotmg.ui.view
{
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
import com.company.assembleegameclient.screens.NewCharacterScreen;

import flash.display.Sprite;

import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsModel;
import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsInfoDialog;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.classes.view.CharacterSkinView;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.BuyCharacterPendingSignal;
import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.core.signals.UpdateNewCharacterScreenSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.game.signals.PlayGameSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class NewCharacterMediator extends Mediator
{

	[Inject]
	public var view:NewCharacterScreen;
	[Inject]
	public var playerModel:PlayerModel;
	[Inject]
	public var setScreen:SetScreenSignal;
	[Inject]
	public var playGame:PlayGameSignal;
	[Inject]
	public var showTooltip:ShowTooltipSignal;
	[Inject]
	public var hideTooltips:HideTooltipsSignal;
	[Inject]
	public var updateNewCharacterScreen:UpdateNewCharacterScreenSignal;
	[Inject]
	public var buyCharacterPending:BuyCharacterPendingSignal;
	[Inject]
	public var classesModel:ClassesModel;
	[Inject]
	public var openDialog:OpenDialogSignal;
	[Inject]
	public var securityQuestionsModel:SecurityQuestionsModel;


	override public function initialize():void
	{
		this.view.selected.add(this.onSelected);
		this.view.close.add(this.onClose);
		this.view.tooltip.add(this.onTooltip);
		this.updateNewCharacterScreen.add(this.onUpdate);
		this.buyCharacterPending.add(this.onBuyCharacterPending);
		this.view.initialize(this.playerModel);
		if (this.securityQuestionsModel.showSecurityQuestionsOnStartup)
		{
			this.openDialog.dispatch(new SecurityQuestionsInfoDialog());
		}
	}

	private function onBuyCharacterPending(_arg_1:int):void
	{
		this.view.updateCreditsAndFame(this.playerModel.getCredits(), this.playerModel.getFame());
	}

	override public function destroy():void
	{
		this.view.selected.remove(this.onSelected);
		this.view.close.remove(this.onClose);
		this.view.tooltip.remove(this.onTooltip);
		this.buyCharacterPending.remove(this.onBuyCharacterPending);
		this.updateNewCharacterScreen.remove(this.onUpdate);
	}

	private function onClose():void
	{
		this.setScreen.dispatch(new CharacterSelectionAndNewsScreen());
	}

	private function onSelected(_arg_1:int):void
	{
		this.classesModel.getCharacterClass(_arg_1).setIsSelected(true);
		this.setScreen.dispatch(new CharacterSkinView());
	}

	private function onTooltip(_arg_1:Sprite):void
	{
		if (_arg_1)
		{
			this.showTooltip.dispatch(_arg_1);
		}
		else
		{
			this.hideTooltips.dispatch();
		}
	}

	private function onUpdate():void
	{
		this.view.update(this.playerModel);
	}


}
}//package kabam.rotmg.ui.view

