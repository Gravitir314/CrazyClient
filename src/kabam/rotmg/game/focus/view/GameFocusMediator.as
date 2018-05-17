//kabam.rotmg.game.focus.view.GameFocusMediator

package kabam.rotmg.game.focus.view
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.GameObject;

import flash.utils.Dictionary;

import kabam.rotmg.game.focus.control.SetGameFocusSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class GameFocusMediator extends Mediator
    {

        [Inject]
        public var signal:SetGameFocusSignal;
        [Inject]
        public var view:GameSprite;


        override public function initialize():void
        {
            this.signal.add(this.onSetGameFocus);
        }

        override public function destroy():void
        {
            this.signal.remove(this.onSetGameFocus);
        }

        private function onSetGameFocus(_arg_1:String=""):void
        {
            this.view.setFocus(this.getFocusById(_arg_1));
        }

        private function getFocusById(_arg_1:String):GameObject
        {
            var _local_2:GameObject;
            if (_arg_1 == "")
            {
                return (this.view.map.player_);
            }
            var _local_3:Dictionary = this.view.map.goDict_;
            for each (_local_2 in _local_3)
            {
                if (_local_2.name_ == _arg_1)
                {
                    return (_local_2);
                }
            }
            return (this.view.map.player_);
        }


    }
}//package kabam.rotmg.game.focus.view

