//kabam.rotmg.game.view.CreditDisplayMediator

package kabam.rotmg.game.view
{
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;

import flash.events.MouseEvent;

import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.tooltips.HoverTooltipDelegate;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CreditDisplayMediator extends Mediator
{

	[Inject]
	public var view:CreditDisplay;
	[Inject]
	public var model:PlayerModel;
	[Inject]
	public var openMoneyWindow:OpenMoneyWindowSignal;
	[Inject]
	public var showTooltipSignal:ShowTooltipSignal;
	[Inject]
	public var hideTooltipSignal:HideTooltipsSignal;
	private var toolTip:TextToolTip = null;
	private var hoverTooltipDelegate:HoverTooltipDelegate;


	override public function initialize():void
	{
		this.model.creditsChanged.add(this.onCreditsChanged);
		this.model.fameChanged.add(this.onFameChanged);
		this.model.tokensChanged.add(this.onTokensChanged);
		this.view.openAccountDialog.add(this.onOpenAccountDialog);
		if (this.view.gs != null && this.view.gs.map.name_ == Map.NEXUS)
		{
			this.view.addResourceButtons();
		}
		else
		{
			this.view.removeResourceButtons();
		}
		if (this.view.creditsButton && this.view.gs != null && this.view.gs.map.name_ == Map.NEXUS)
		{
			this.view.creditsButton.addEventListener(MouseEvent.CLICK, this.view.onCreditsClick, false, 0, true);
			this.toolTip = new TextToolTip(0x363636, 0x9B9B9B, "Buy Gold", "Click to buy more Realm Gold!", 190);
			this.hoverTooltipDelegate = new HoverTooltipDelegate();
			this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
			this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
			this.hoverTooltipDelegate.setDisplayObject(this.view.creditsButton);
			this.hoverTooltipDelegate.tooltip = this.toolTip;
		}
		if (this.view.fameButton && this.view.gs != null && this.view.gs.map.name_ == Map.NEXUS)
		{
			this.view.fameButton.addEventListener(MouseEvent.CLICK, this.view.onFameClick);
			this.toolTip = new TextToolTip(0x363636, 0x9B9B9B, "Fame", "Click to get an Overview!", 160);
			this.hoverTooltipDelegate = new HoverTooltipDelegate();
			this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
			this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
			this.hoverTooltipDelegate.setDisplayObject(this.view.fameButton);
			this.hoverTooltipDelegate.tooltip = this.toolTip;
		}
		this.view.displayFameTooltip.add(this.forceShowingTooltip);
	}

	private function forceShowingTooltip():void
	{
		if (this.toolTip)
		{
			this.hoverTooltipDelegate.getDisplayObject().dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER, true));
			this.toolTip.x = 267;
			this.toolTip.y = 41;
		}
	}

	override public function destroy():void
	{
		this.model.creditsChanged.remove(this.onCreditsChanged);
		this.model.fameChanged.remove(this.onFameChanged);
		this.view.openAccountDialog.remove(this.onOpenAccountDialog);
		if (this.view.fameButton && this.view.gs != null && this.view.gs.map.name_ == Map.NEXUS)
		{
			this.view.fameButton.removeEventListener(MouseEvent.CLICK, this.view.onFameClick);
		}
		if (this.view.creditsButton && this.view.gs != null && this.view.gs.map.name_ == Map.NEXUS)
		{
			this.view.creditsButton.removeEventListener(MouseEvent.CLICK, this.view.onCreditsClick);
		}
		this.view.displayFameTooltip.remove(this.forceShowingTooltip);
	}

	private function onCreditsChanged(_arg_1:int):void
	{
		this.view.draw(_arg_1, this.model.getFame());
	}

	private function onFameChanged(_arg_1:int):void
	{
		this.view.draw(this.model.getCredits(), _arg_1);
	}

	private function onTokensChanged(_arg_1:int):void
	{
		this.view.draw(this.model.getCredits(), this.model.getFame(), _arg_1);
	}

	private function onOpenAccountDialog():void
	{
		this.openMoneyWindow.dispatch();
	}


}
}//package kabam.rotmg.game.view

