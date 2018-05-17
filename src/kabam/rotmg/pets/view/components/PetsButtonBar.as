//kabam.rotmg.pets.view.components.PetsButtonBar

package kabam.rotmg.pets.view.components
{
import com.company.assembleegameclient.ui.DeprecatedTextButton;

import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.pets.util.PetsConstants;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.natives.NativeSignal;

public class PetsButtonBar extends Sprite
    {

        public var buttonOne:DeprecatedTextButton = new DeprecatedTextButton(14, "buttonOne", 70);
        public var buttonTwo:DeprecatedTextButton = new DeprecatedTextButton(14, "buttonTwo", 70);
        public var buttonOneSignal:NativeSignal = new NativeSignal(buttonOne, MouseEvent.CLICK);
        public var buttonTwoSignal:NativeSignal = new NativeSignal(buttonTwo, MouseEvent.CLICK);

        public function PetsButtonBar()
        {
            this.addTextChangedWaiter();
            this.addButtons();
        }

        private function addButtons():void
        {
            addChild(this.buttonOne);
            addChild(this.buttonTwo);
        }

        private function addTextChangedWaiter():void
        {
            var _local_1:DeprecatedTextButton;
            var _local_2:Array = [this.buttonOne, this.buttonTwo];
            var _local_3:SignalWaiter = new SignalWaiter();
            for each (_local_1 in _local_2)
            {
                _local_3.push(_local_1.textChanged);
            }
            _local_3.complete.addOnce(this.positionButtons);
        }

        private function positionButtons():void
        {
            this.buttonOne.x = PetsConstants.BUTTON_BAR_SPACING;
            this.buttonTwo.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.buttonTwo.width) - PetsConstants.BUTTON_BAR_SPACING);
        }


    }
}//package kabam.rotmg.pets.view.components

