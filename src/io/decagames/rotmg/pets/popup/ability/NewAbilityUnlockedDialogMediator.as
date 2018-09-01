//io.decagames.rotmg.pets.popup.ability.NewAbilityUnlockedDialogMediator

package io.decagames.rotmg.pets.popup.ability
{
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.popups.header.PopupHeader;
import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
import io.decagames.rotmg.ui.texture.TextureParser;

import robotlegs.bender.bundles.mvcs.Mediator;

public class NewAbilityUnlockedDialogMediator extends Mediator
{

	[Inject]
	public var view:NewAbilityUnlockedDialog;
	[Inject]
	public var closePopupSignal:ClosePopupSignal;
	private var closeButton:SliceScalingButton;


	override public function initialize():void
	{
		this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
		this.closeButton.clickSignal.addOnce(this.onClose);
		this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
		this.view.okButton.clickSignal.addOnce(this.onClose);
	}

	override public function destroy():void
	{
		this.closeButton.clickSignal.remove(this.onClose);
		this.closeButton.dispose();
		this.view.okButton.clickSignal.remove(this.onClose);
	}

	private function onClose(_arg_1:BaseButton):void
	{
		this.closePopupSignal.dispatch(this.view);
	}


}
}//package io.decagames.rotmg.pets.popup.ability

