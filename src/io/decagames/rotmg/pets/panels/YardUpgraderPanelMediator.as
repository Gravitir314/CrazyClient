//io.decagames.rotmg.pets.panels.YardUpgraderPanelMediator

package io.decagames.rotmg.pets.panels
{
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.StageProxy;

import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import io.decagames.rotmg.pets.data.PetsModel;
import io.decagames.rotmg.pets.popup.info.PetInfoDialog;
import io.decagames.rotmg.pets.windows.yard.PetYardWindow;
import io.decagames.rotmg.ui.popups.signals.ClosePopupByClassSignal;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import kabam.rotmg.account.core.Account;

import robotlegs.bender.bundles.mvcs.Mediator;

public class YardUpgraderPanelMediator extends Mediator
{

	[Inject]
	public var view:YardUpgraderPanel;
	[Inject]
	public var petModel:PetsModel;
	[Inject]
	public var account:Account;
	[Inject]
	public var showPopupSignal:ShowPopupSignal;
	[Inject]
	public var closePopupByClassSignal:ClosePopupByClassSignal;
	private var stageProxy:StageProxy;
	private var open:Boolean;


	override public function initialize():void
	{
		this.open = false;
		this.view.init(false);
		this.stageProxy = new StageProxy(this.view);
		this.setEventListeners();
	}

	private function setEventListeners():void
	{
		this.view.petsButton.addEventListener(MouseEvent.CLICK, this.onPets);
		this.stageProxy.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
		this.view.infoButton.addEventListener(MouseEvent.CLICK, this.onButtonRightClick);
	}

	override public function destroy():void
	{
		this.view.petsButton.removeEventListener(MouseEvent.CLICK, this.onPets);
		this.stageProxy.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
		this.view.infoButton.removeEventListener(MouseEvent.CLICK, this.onButtonRightClick);
		this.closePopupByClassSignal.dispatch(PetYardWindow);
		super.destroy();
	}

	protected function onButtonRightClick(_arg_1:MouseEvent):void
	{
		this.showPopupSignal.dispatch(new PetInfoDialog());
	}

	protected function onPets(_arg_1:MouseEvent):void
	{
		this.openPets();
	}

	private function onKeyDown(_arg_1:KeyboardEvent):void
	{
		if (((_arg_1.keyCode == Parameters.data_.interact) && (this.view.stage.focus == null)))
		{
			this.openPets();
		}
	}

	private function openPets():void
	{
		this.showPopupSignal.dispatch(new PetYardWindow());
	}


}
}//package io.decagames.rotmg.pets.panels

