// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.objects.GuildRegister

package com.company.assembleegameclient.objects
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.GuildRegisterPanel;
import com.company.assembleegameclient.ui.panels.Panel;

public class GuildRegister extends GameObject implements IInteractiveObject
    {

        public function GuildRegister(_arg_1:XML)
        {
            super(_arg_1);
            isInteractive_ = true;
        }

        public function getPanel(_arg_1:GameSprite):Panel
        {
            return (new GuildRegisterPanel(_arg_1));
        }


    }
}//package com.company.assembleegameclient.objects

