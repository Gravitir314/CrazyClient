// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.ui.view.components.ScreenBase

package kabam.rotmg.ui.view.components
{
import com.company.assembleegameclient.ui.SoundIcon;

import flash.display.Sprite;

public class ScreenBase extends Sprite
    {
        internal static var TitleScreenBackground:Class = ScreenBase_TitleScreenBackground;

        public function ScreenBase()
        {
            addChild(new TitleScreenBackground());
            addChild(new DarkLayer());
            addChild(new SoundIcon());
        }

    }
}//package kabam.rotmg.ui.view.components

