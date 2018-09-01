//io.decagames.rotmg.pets.config.PetsConfig

package io.decagames.rotmg.pets.config
{
import com.company.assembleegameclient.ui.dialogs.DialogCloser;
import com.company.assembleegameclient.ui.dialogs.DialogCloserMediator;

import io.decagames.rotmg.pets.commands.ActivatePetCommand;
import io.decagames.rotmg.pets.commands.AddPetsConsoleActionsCommand;
import io.decagames.rotmg.pets.commands.DeactivatePetCommand;
import io.decagames.rotmg.pets.commands.DeletePetCommand;
import io.decagames.rotmg.pets.commands.EvolvePetCommand;
import io.decagames.rotmg.pets.commands.HatchPetCommand;
import io.decagames.rotmg.pets.commands.NewAbilityCommand;
import io.decagames.rotmg.pets.commands.OpenCaretakerQueryDialogCommand;
import io.decagames.rotmg.pets.commands.ReleasePetCommand;
import io.decagames.rotmg.pets.commands.UpdateActivePetCommand;
import io.decagames.rotmg.pets.commands.UpdatePetYardCommand;
import io.decagames.rotmg.pets.commands.UpgradePetCommand;
import io.decagames.rotmg.pets.components.caretaker.CaretakerQueryDialog;
import io.decagames.rotmg.pets.components.caretaker.CaretakerQueryDialogMediator;
import io.decagames.rotmg.pets.components.guiTab.PetsTabContentMediator;
import io.decagames.rotmg.pets.components.guiTab.PetsTabContentView;
import io.decagames.rotmg.pets.components.petInfoSlot.PetInfoSlot;
import io.decagames.rotmg.pets.components.petInfoSlot.PetInfoSlotMediator;
import io.decagames.rotmg.pets.components.petPortrait.PetPortrait;
import io.decagames.rotmg.pets.components.petPortrait.PetPortraitMediator;
import io.decagames.rotmg.pets.components.petSkinSlot.PetSkinSlot;
import io.decagames.rotmg.pets.components.petSkinSlot.PetSkinSlotMediator;
import io.decagames.rotmg.pets.components.petSkinsCollection.PetSkinsCollection;
import io.decagames.rotmg.pets.components.petSkinsCollection.PetSkinsCollectionMediator;
import io.decagames.rotmg.pets.components.petStatsGrid.PetStatsGrid;
import io.decagames.rotmg.pets.components.petStatsGrid.PetStatsGridMediator;
import io.decagames.rotmg.pets.components.selectedPetSkinInfo.SelectedPetSkinInfo;
import io.decagames.rotmg.pets.components.selectedPetSkinInfo.SelectedPetSkinInfoMediator;
import io.decagames.rotmg.pets.components.tooltip.PetTooltip;
import io.decagames.rotmg.pets.components.tooltip.PetTooltipMediator;
import io.decagames.rotmg.pets.data.PetsModel;
import io.decagames.rotmg.pets.panels.PetInteractionPanel;
import io.decagames.rotmg.pets.panels.PetInteractionPanelMediator;
import io.decagames.rotmg.pets.panels.PetPanel;
import io.decagames.rotmg.pets.panels.PetPanelMediator;
import io.decagames.rotmg.pets.panels.YardUpgraderPanel;
import io.decagames.rotmg.pets.panels.YardUpgraderPanelMediator;
import io.decagames.rotmg.pets.popup.ability.NewAbilityUnlockedDialog;
import io.decagames.rotmg.pets.popup.ability.NewAbilityUnlockedDialogMediator;
import io.decagames.rotmg.pets.popup.choosePet.ChoosePetPopup;
import io.decagames.rotmg.pets.popup.choosePet.ChoosePetPopupMediator;
import io.decagames.rotmg.pets.popup.evolving.PetEvolvingDialog;
import io.decagames.rotmg.pets.popup.evolving.PetEvolvingDialogMediator;
import io.decagames.rotmg.pets.popup.hatching.PetHatchingDialog;
import io.decagames.rotmg.pets.popup.hatching.PetHatchingDialogMediator;
import io.decagames.rotmg.pets.popup.info.PetInfoDialog;
import io.decagames.rotmg.pets.popup.info.PetInfoDialogMediator;
import io.decagames.rotmg.pets.popup.info.PetInfoItem;
import io.decagames.rotmg.pets.popup.info.PetInfoItemMediator;
import io.decagames.rotmg.pets.popup.leaveYard.LeavePetYardDialog;
import io.decagames.rotmg.pets.popup.leaveYard.LeavePetYardDialogMediator;
import io.decagames.rotmg.pets.popup.releasePet.ReleasePetDialog;
import io.decagames.rotmg.pets.popup.releasePet.ReleasePetDialogMediator;
import io.decagames.rotmg.pets.popup.upgradeYard.PetYardUpgradeDialog;
import io.decagames.rotmg.pets.popup.upgradeYard.PetYardUpgradeDialogMediator;
import io.decagames.rotmg.pets.signals.ActivatePet;
import io.decagames.rotmg.pets.signals.AddPetsConsoleActionsSignal;
import io.decagames.rotmg.pets.signals.ChangePetSkinSignal;
import io.decagames.rotmg.pets.signals.DeactivatePet;
import io.decagames.rotmg.pets.signals.DeletePetSignal;
import io.decagames.rotmg.pets.signals.EvolvePetSignal;
import io.decagames.rotmg.pets.signals.HatchPetSignal;
import io.decagames.rotmg.pets.signals.NewAbilitySignal;
import io.decagames.rotmg.pets.signals.NotifyActivePetUpdated;
import io.decagames.rotmg.pets.signals.OpenCaretakerQueryDialogSignal;
import io.decagames.rotmg.pets.signals.PetFeedResultSignal;
import io.decagames.rotmg.pets.signals.ReleasePetSignal;
import io.decagames.rotmg.pets.signals.SelectFeedItemSignal;
import io.decagames.rotmg.pets.signals.SelectFusePetSignal;
import io.decagames.rotmg.pets.signals.SelectPetSignal;
import io.decagames.rotmg.pets.signals.SelectPetSkinSignal;
import io.decagames.rotmg.pets.signals.ShowPetTooltip;
import io.decagames.rotmg.pets.signals.SimulateFeedSignal;
import io.decagames.rotmg.pets.signals.UpdateActivePet;
import io.decagames.rotmg.pets.signals.UpdatePetYardSignal;
import io.decagames.rotmg.pets.signals.UpgradePetSignal;
import io.decagames.rotmg.pets.utils.FeedFuseCostModel;
import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
import io.decagames.rotmg.pets.windows.wardrobe.PetWardrobeWindow;
import io.decagames.rotmg.pets.windows.wardrobe.PetWardrobeWindowMediator;
import io.decagames.rotmg.pets.windows.yard.InteractionInfo;
import io.decagames.rotmg.pets.windows.yard.InteractionInfoMediator;
import io.decagames.rotmg.pets.windows.yard.PetYardWindow;
import io.decagames.rotmg.pets.windows.yard.PetYardWindowMediator;
import io.decagames.rotmg.pets.windows.yard.feed.FeedTab;
import io.decagames.rotmg.pets.windows.yard.feed.FeedTabMediator;
import io.decagames.rotmg.pets.windows.yard.feed.items.FeedItem;
import io.decagames.rotmg.pets.windows.yard.feed.items.FeedItemMediator;
import io.decagames.rotmg.pets.windows.yard.fuse.FuseTab;
import io.decagames.rotmg.pets.windows.yard.fuse.FuseTabMediator;
import io.decagames.rotmg.pets.windows.yard.list.PetYardList;
import io.decagames.rotmg.pets.windows.yard.list.PetYardListMediator;

import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.DialogCloseButtonMediator;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class PetsConfig implements IConfig
{

	[Inject]
	public var injector:Injector;
	[Inject]
	public var mediatorMap:IMediatorMap;
	[Inject]
	public var commandMap:ISignalCommandMap;
	[Inject]
	public var commandCenter:ICommandCenter;


	public function configure():void
	{
		this.injector.map(ShowPetTooltip).asSingleton();
		this.injector.map(NotifyActivePetUpdated).asSingleton();
		this.injector.map(PetsViewAssetFactory).asSingleton();
		this.injector.map(PetFeedResultSignal).asSingleton();
		this.injector.map(FeedFuseCostModel).asSingleton();
		this.injector.map(SelectPetSignal).asSingleton();
		this.injector.map(ChangePetSkinSignal).asSingleton();
		this.injector.map(SelectFusePetSignal).asSingleton();
		this.injector.map(SelectFeedItemSignal).asSingleton();
		this.injector.map(SimulateFeedSignal).asSingleton();
		this.mediatorMap.map(PetsTabContentView).toMediator(PetsTabContentMediator);
		this.mediatorMap.map(PetPanel).toMediator(PetPanelMediator);
		this.mediatorMap.map(PetInteractionPanel).toMediator(PetInteractionPanelMediator);
		this.mediatorMap.map(YardUpgraderPanel).toMediator(YardUpgraderPanelMediator);
		this.mediatorMap.map(DialogCloseButton).toMediator(DialogCloseButtonMediator);
		this.mediatorMap.map(PetTooltip).toMediator(PetTooltipMediator);
		this.mediatorMap.map(CaretakerQueryDialog).toMediator(CaretakerQueryDialogMediator);
		this.mediatorMap.map(DialogCloser).toMediator(DialogCloserMediator);
		this.commandMap.map(UpdateActivePet).toCommand(UpdateActivePetCommand);
		this.commandMap.map(UpdatePetYardSignal).toCommand(UpdatePetYardCommand);
		this.commandMap.map(UpgradePetSignal).toCommand(UpgradePetCommand);
		this.commandMap.map(DeactivatePet).toCommand(DeactivatePetCommand);
		this.commandMap.map(ActivatePet).toCommand(ActivatePetCommand);
		this.commandMap.map(AddPetsConsoleActionsSignal).toCommand(AddPetsConsoleActionsCommand);
		this.commandMap.map(OpenCaretakerQueryDialogSignal).toCommand(OpenCaretakerQueryDialogCommand);
		this.commandMap.map(EvolvePetSignal).toCommand(EvolvePetCommand);
		this.commandMap.map(NewAbilitySignal).toCommand(NewAbilityCommand);
		this.commandMap.map(DeletePetSignal).toCommand(DeletePetCommand);
		this.commandMap.map(HatchPetSignal).toCommand(HatchPetCommand);
		this.commandMap.map(ReleasePetSignal).toCommand(ReleasePetCommand);
		this.mediatorMap.map(PetWardrobeWindow).toMediator(PetWardrobeWindowMediator);
		this.mediatorMap.map(PetInfoSlot).toMediator(PetInfoSlotMediator);
		this.mediatorMap.map(SelectedPetSkinInfo).toMediator(SelectedPetSkinInfoMediator);
		this.mediatorMap.map(PetSkinsCollection).toMediator(PetSkinsCollectionMediator);
		this.mediatorMap.map(ChoosePetPopup).toMediator(ChoosePetPopupMediator);
		this.mediatorMap.map(PetPortrait).toMediator(PetPortraitMediator);
		this.mediatorMap.map(PetStatsGrid).toMediator(PetStatsGridMediator);
		this.mediatorMap.map(PetSkinSlot).toMediator(PetSkinSlotMediator);
		this.injector.map(SelectPetSkinSignal).asSingleton();
		this.mediatorMap.map(PetYardWindow).toMediator(PetYardWindowMediator);
		this.mediatorMap.map(InteractionInfo).toMediator(InteractionInfoMediator);
		this.mediatorMap.map(PetYardList).toMediator(PetYardListMediator);
		this.mediatorMap.map(FuseTab).toMediator(FuseTabMediator);
		this.mediatorMap.map(FeedTab).toMediator(FeedTabMediator);
		this.mediatorMap.map(FeedItem).toMediator(FeedItemMediator);
		this.mediatorMap.map(PetYardUpgradeDialog).toMediator(PetYardUpgradeDialogMediator);
		this.mediatorMap.map(LeavePetYardDialog).toMediator(LeavePetYardDialogMediator);
		this.mediatorMap.map(NewAbilityUnlockedDialog).toMediator(NewAbilityUnlockedDialogMediator);
		this.mediatorMap.map(PetHatchingDialog).toMediator(PetHatchingDialogMediator);
		this.mediatorMap.map(PetInfoDialog).toMediator(PetInfoDialogMediator);
		this.mediatorMap.map(PetInfoItem).toMediator(PetInfoItemMediator);
		this.mediatorMap.map(ReleasePetDialog).toMediator(ReleasePetDialogMediator);
		this.mediatorMap.map(PetEvolvingDialog).toMediator(PetEvolvingDialogMediator);
		this.injector.map(PetsModel).asSingleton();
		this.injector.getInstance(AddPetsConsoleActionsSignal).dispatch();
	}


}
}//package io.decagames.rotmg.pets.config

