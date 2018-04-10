// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.ui.gird.UIGrid

package io.decagames.rotmg.ui.gird
{
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;

import io.decagames.rotmg.ui.scroll.UIScrollbar;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class UIGrid extends Sprite
    {

        private var elements:Vector.<UIGridElement>;
        private var decors:Vector.<SliceScalingBitmap>;
        private var gridMargin:int;
        private var gridWidth:int;
        private var numberOfColumns:int;
        private var scrollHeight:int;
        private var scroll:UIScrollbar;
        private var gridContent:Sprite;
        private var gridMask:Sprite;
        private var _centerLastRow:Boolean;
        private var lastRenderedItemsNumber:int = 0;
        private var elementWidth:int;
        private var _decorBitmap:String = "";

        public function UIGrid(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int=-1, _arg_5:int=0, _arg_6:DisplayObject=null)
        {
            this.elements = new Vector.<UIGridElement>();
            this.decors = new Vector.<SliceScalingBitmap>();
            this.gridMargin = _arg_3;
            this.gridWidth = _arg_1;
            this.gridContent = new Sprite();
            this.addChild(this.gridContent);
            this.scrollHeight = _arg_4;
            if (_arg_4 > 0)
            {
                this.scroll = new UIScrollbar(_arg_4);
                this.scroll.x = (_arg_1 + _arg_5);
                addChild(this.scroll);
                this.scroll.content = this.gridContent;
                this.scroll.scrollObject = _arg_6;
                this.gridMask = new Sprite();
            }
            this.numberOfColumns = _arg_2;
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedHandler);
        }

        override public function set width(_arg_1:Number):void
        {
            this.gridWidth = _arg_1;
            this.render();
        }

        public function get numberOfElements():int
        {
            return (this.elements.length);
        }

        private function onAddedHandler(_arg_1:Event):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedHandler);
            this.addEventListener(Event.ENTER_FRAME, this.onUpdate);
            this.render();
        }

        public function addGridElement(_arg_1:UIGridElement):void
        {
            this.elements.push(_arg_1);
            this.gridContent.addChild(_arg_1);
            if (this.stage)
            {
                this.render();
            }
        }

        private function addDecorToRow(_arg_1:int, _arg_2:int, _arg_3:int):void{
            var _local_5:SliceScalingBitmap;
            _arg_3--;
            if (_arg_3 == 0){
                _arg_3 = 1;
            }
            var _local_4:int;
            while (_local_4 < _arg_3) {
                _local_5 = TextureParser.instance.getSliceScalingBitmap("UI", this._decorBitmap);
                _local_5.x = Math.round((((_local_4 * (this.gridMargin / 2)) + ((_local_4 + 1) * (this.elementWidth + (this.gridMargin / 2)))) - (_local_5.width / 2)));
                _local_5.y = Math.round((((_arg_1 + _arg_2) - (_local_5.height / 2)) + (this.gridMargin / 2)));
                this.gridContent.addChild(_local_5);
                this.decors.push(_local_5);
                _local_4++;
            }
        }

        public function clearGrid():void
        {
            var _local_1:UIGridElement;
            for each (_local_1 in this.elements)
            {
                this.gridContent.removeChild(_local_1);
            }
            this.elements.length = 0;
        }

        public function render():void
        {
            var _local_8:UIGridElement;
            var _local_9:int;
            if (this.lastRenderedItemsNumber == this.elements.length)
            {
                return;
            }
            this.elementWidth = ((this.gridWidth - ((this.numberOfColumns - 1) * this.gridMargin)) / this.numberOfColumns);
            var _local_1:int = 1;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int = int(Math.ceil((this.elements.length / this.numberOfColumns)));
            var _local_6:int = 1;
            var _local_7:int;
            for each (_local_8 in this.elements) {
                _local_8.resize(this.elementWidth);
                if (_local_8.height > _local_4){
                    _local_4 = _local_8.height;
                }
                _local_8.x = _local_2;
                _local_8.y = _local_3;
                if (++_local_1 > this.numberOfColumns){
                    if (this._decorBitmap != ""){
                        _local_7 = _local_6;
                        this.addDecorToRow(_local_3, _local_4, (_local_1 - 1));
                    }
                    _local_6++;
                    _local_2 = 0;
                    if (((_local_6 == _local_5) && (this._centerLastRow))){
                        _local_9 = ((_local_6 * this.numberOfColumns) - this.elements.length);
                        _local_2 = int(Math.round((((_local_9 * this.elementWidth) + ((_local_9 - 1) * this.gridMargin)) / 2)));
                    }
                    _local_3 = (_local_3 + (_local_4 + this.gridMargin));
                    _local_4 = 0;
                    _local_1 = 1;
                } else {
                    _local_2 = (_local_2 + (this.elementWidth + this.gridMargin));
                }
                if (((!(this._decorBitmap == "")) && (!(_local_7 == _local_6)))){
                    this.addDecorToRow(_local_3, _local_4, (_local_1 - 1));
                }
            }
            if (this.scrollHeight != -1){
                this.gridMask.graphics.clear();
                this.gridMask.graphics.beginFill(0xFF0000);
                this.gridMask.graphics.drawRect(0, 0, this.gridWidth, this.scrollHeight);
                this.gridContent.mask = this.gridMask;
                addChild(this.gridMask);
            }
            this.lastRenderedItemsNumber = this.elements.length;
        }

        public function dispose():void
        {
            var _local_1:UIGridElement;
            var _local_2:SliceScalingBitmap;
            this.removeEventListener(Event.ENTER_FRAME, this.onUpdate);
            for each (_local_1 in this.elements)
            {
                _local_1.dispose();
            }
            for each (_local_2 in this.decors)
            {
                _local_2.dispose();
            }
            this.elements = null;
        }

        private function onUpdate(_arg_1:Event):void
        {
            var _local_2:UIGridElement;
            for each (_local_2 in this.elements)
            {
                _local_2.update();
            }
        }

        public function get centerLastRow():Boolean
        {
            return (this._centerLastRow);
        }

        public function set centerLastRow(_arg_1:Boolean):void
        {
            this._centerLastRow = _arg_1;
        }

        public function get decorBitmap():String{
            return (this._decorBitmap);
        }

        public function set decorBitmap(_arg_1:String):void{
            this._decorBitmap = _arg_1;
        }


    }
}//package io.decagames.rotmg.ui.gird

