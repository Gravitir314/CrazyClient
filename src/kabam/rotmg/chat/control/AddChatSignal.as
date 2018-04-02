// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.chat.control.AddChatSignal

package kabam.rotmg.chat.control
{
import kabam.lib.signals.DeferredQueueSignal;
import kabam.rotmg.chat.model.ChatMessage;

public class AddChatSignal extends DeferredQueueSignal 
    {

        public function AddChatSignal()
        {
            super(ChatMessage);
        }

    }
}//package kabam.rotmg.chat.control

