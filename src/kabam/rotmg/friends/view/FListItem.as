// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.friends.view.FListItem

package kabam.rotmg.friends.view
{
import flash.display.Sprite;

import io.decagames.rotmg.friends.model.FriendVO;

import org.osflash.signals.Signal;

public class FListItem extends Sprite
    {

        public var actionSignal:Signal = new Signal(String, String);


        protected function init(_arg_1:Number, _arg_2:Number):void
        {
        }

        public function update(_arg_1:FriendVO, _arg_2:String):void
        {
        }

        public function destroy():void
        {
        }


    }
}//package kabam.rotmg.friends.view

