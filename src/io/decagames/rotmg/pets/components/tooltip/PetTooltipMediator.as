//io.decagames.rotmg.pets.components.tooltip.PetTooltipMediator

package io.decagames.rotmg.pets.components.tooltip
{
import robotlegs.bender.bundles.mvcs.Mediator;

public class PetTooltipMediator extends Mediator
{

	[Inject]
	public var view:PetTooltip;


	override public function initialize():void
	{
		this.view.init();
	}


}
}//package io.decagames.rotmg.pets.components.tooltip

