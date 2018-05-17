//kabam.rotmg.ui.PlayerGroupMenuMediator

package kabam.rotmg.ui
{
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.menu.PlayerGroupMenu;

import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.signals.AddTextLineSignal;

import org.swiftsuspenders.Injector;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PlayerGroupMenuMediator extends Mediator
    {

        [Inject]
        public var view:PlayerGroupMenu;
        [Inject]
        private var addTextLine:AddTextLineSignal;


        override public function initialize():void
        {
            this.view.unableToTeleport.add(this.onUnableToTeleport);
        }

        override public function destroy():void
        {
            this.view.unableToTeleport.remove(this.onUnableToTeleport);
        }

        private function onUnableToTeleport():void
        {
            var _local_1:Injector = StaticInjectorContext.getInjector();
            var _local_2:AddTextLineSignal = _local_1.getInstance(AddTextLineSignal);
            _local_2.dispatch(ChatMessage.make(Parameters.ERROR_CHAT_NAME, "No players are eligible for teleporting."));
        }


    }
}//package kabam.rotmg.ui

