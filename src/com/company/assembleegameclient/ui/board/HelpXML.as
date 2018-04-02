// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.board.HelpXML

package com.company.assembleegameclient.ui.board
{
public class HelpXML
    {

        public static var protipsXML:Class = EmbeddedHelp;

        public var commands:Vector.<String> = new Vector.<String>(0);
        public var explanations:Vector.<String> = new Vector.<String>(0);

        public function HelpXML()
        {
            this.makeTipsVector();
        }

        private function makeTipsVector():void
        {
            var _local_1:String;
            var _local_2:XML = XML(new protipsXML());
            for (_local_1 in _local_2.Article)
            {
                this.commands.push(_local_2.Article.Command[_local_1]);
                this.explanations.push(_local_2.Article.Explanation[_local_1]);
            };
        }


    }
}//package com.company.assembleegameclient.ui.board

