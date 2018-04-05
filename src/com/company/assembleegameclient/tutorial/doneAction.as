// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.tutorial.doneAction

package com.company.assembleegameclient.tutorial
{
import com.company.assembleegameclient.game.AGameSprite;

public function doneAction(_arg_1:AGameSprite, _arg_2:String):void
    {
        if (_arg_1.tutorial_ == null)
        {
            return;
        }
        _arg_1.tutorial_.doneAction(_arg_2);
    }

}//package com.company.assembleegameclient.tutorial

