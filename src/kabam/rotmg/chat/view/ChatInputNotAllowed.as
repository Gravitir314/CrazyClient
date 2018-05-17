//kabam.rotmg.chat.view.ChatInputNotAllowed

package kabam.rotmg.chat.view
{
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import kabam.rotmg.chat.model.ChatModel;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class ChatInputNotAllowed extends Sprite 
    {

        public static const IMAGE_NAME:String = "lofiInterfaceBig";
        public static const IMADE_ID:int = 21;

        public function ChatInputNotAllowed()
        {
            this.makeTextField();
            this.makeSpeechBubble();
        }

        public function setup(_arg_1:ChatModel):void
        {
            x = 0;
            y = (_arg_1.bounds.height - _arg_1.lineHeight);
        }

        private function makeTextField():TextFieldDisplayConcrete
        {
            var _local_1:TextFieldDisplayConcrete;
            var _local_2:LineBuilder = new LineBuilder().setParams(TextKey.CHAT_REGISTER_TO_CHAT);
            _local_1 = new TextFieldDisplayConcrete();
            _local_1.setStringBuilder(_local_2);
            _local_1.x = 29;
            addChild(_local_1);
            return (_local_1);
        }

        private function makeSpeechBubble():Bitmap
        {
            var _local_1:Bitmap;
            var _local_2:BitmapData = AssetLibrary.getImageFromSet(IMAGE_NAME, IMADE_ID);
            _local_2 = TextureRedrawer.redraw(_local_2, 20, true, 0, false);
            _local_1 = new Bitmap(_local_2);
            _local_1.x = -5;
            _local_1.y = -10;
            addChild(_local_1);
            return (_local_1);
        }


    }
}//package kabam.rotmg.chat.view

