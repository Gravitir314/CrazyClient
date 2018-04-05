// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.board.HelpContainer

package com.company.assembleegameclient.ui.board
{
import flash.display.Sprite;

public class HelpContainer extends Sprite
    {

        private var articles:HelpXML = new HelpXML();

        public function HelpContainer()
        {
            this.makeContent();
        }

        private function makeContent():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:HelpElement;
            var _local_4:int = 32;
            _local_1 = 0;
            while (_local_1 < this.articles.commands.length)
            {
                _local_2 = this.count(this.articles.explanations[_local_1], "\n");
                _local_3 = new HelpElement(this.articles.commands[_local_1], this.articles.explanations[_local_1], _local_2);
                _local_3.y = _local_4;
                addChild(_local_3);
                _local_4 = (_local_4 + (42 + (_local_2 * 12)));
                _local_1++;
            }
        }

        private function count(_arg_1:String, _arg_2:String):int
        {
            return (_arg_1.match(new RegExp(_arg_2, "g")).length);
        }

        public function setPos(_arg_1:Number):void
        {
            this.y = _arg_1;
        }


    }
}//package com.company.assembleegameclient.ui.board

