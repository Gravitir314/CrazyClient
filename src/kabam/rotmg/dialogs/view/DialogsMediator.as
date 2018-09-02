//kabam.rotmg.dialogs.view.DialogsMediator

package kabam.rotmg.dialogs.view
{
import flash.display.Sprite;

import kabam.rotmg.dialogs.control.AddPopupToStartupQueueSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
import kabam.rotmg.dialogs.control.OpenDialogNoModalSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.dialogs.control.PopDialogSignal;
import kabam.rotmg.dialogs.control.PushDialogSignal;
import kabam.rotmg.dialogs.control.ShowDialogBackgroundSignal;
import kabam.rotmg.dialogs.model.DialogsModel;
import kabam.rotmg.dialogs.model.PopupQueueEntry;

import org.osflash.signals.Signal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class DialogsMediator extends Mediator
{

	[Inject]
	public var view:DialogsView;
	[Inject]
	public var openDialogNoModal:OpenDialogNoModalSignal;
	[Inject]
	public var openDialog:OpenDialogSignal;
	[Inject]
	public var closeDialog:CloseDialogsSignal;
	[Inject]
	public var showDialogBackground:ShowDialogBackgroundSignal;
	[Inject]
	public var pushDialogSignal:PushDialogSignal;
	[Inject]
	public var popDialogSignal:PopDialogSignal;
	[Inject]
	public var addToQueueSignal:AddPopupToStartupQueueSignal;
	[Inject]
	public var flushStartupQueue:FlushPopupStartupQueueSignal;
	[Inject]
	public var dialogsModel:DialogsModel;


	override public function initialize():void
	{
		this.showDialogBackground.add(this.onShowDialogBackground);
		this.openDialog.add(this.onOpenDialog);
		this.openDialogNoModal.add(this.onOpenDialogNoModal);
		this.closeDialog.add(this.onCloseDialog);
		this.pushDialogSignal.add(this.onPushDialog);
		this.popDialogSignal.add(this.onPopDialog);
		this.addToQueueSignal.add(this.onAddToQueue);
		this.flushStartupQueue.add(this.onFlushQueue);
	}

	private function onFlushQueue():void
	{
		var _local_1:PopupQueueEntry = this.dialogsModel.flushStartupQueue();
		if (_local_1 != null)
		{
			if (_local_1.paramObject)
			{
				_local_1.signal.dispatch(_local_1.paramObject);
			}
			else
			{
				_local_1.signal.dispatch();
			}
		}
	}

	private function onAddToQueue(_arg_1:String, _arg_2:Signal, _arg_3:int, _arg_4:Object):void
	{
		this.dialogsModel.addPopupToStartupQueue(_arg_1, _arg_2, _arg_3, _arg_4);
	}

	private function onPushDialog(_arg_1:Sprite):void
	{
		this.view.push(_arg_1);
	}

	private function onPopDialog():void
	{
		this.view.pop();
	}

	override public function destroy():void
	{
		this.showDialogBackground.remove(this.onShowDialogBackground);
		this.openDialog.remove(this.onOpenDialog);
		this.openDialogNoModal.remove(this.onOpenDialogNoModal);
		this.closeDialog.remove(this.onCloseDialog);
		this.pushDialogSignal.remove(this.onPushDialog);
		this.popDialogSignal.remove(this.onPopDialog);
	}

	private function onShowDialogBackground(_arg_1:int = 0x151515):void
	{
		this.view.showBackground(_arg_1);
	}

	private function onOpenDialog(_arg_1:Sprite):void
	{
		this.view.show(_arg_1, true);
	}

	private function onOpenDialogNoModal(_arg_1:Sprite):void
	{
		this.view.show(_arg_1, false);
	}

	private function onCloseDialog():void
	{
		this.view.stage.focus = null;
		this.view.hideAll();
	}


}
}//package kabam.rotmg.dialogs.view

