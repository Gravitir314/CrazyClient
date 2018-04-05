// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.news.view.NewsModalPage

package kabam.rotmg.news.view
{
import com.company.assembleegameclient.ui.Scrollbar;

import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;
import flash.text.TextField;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class NewsModalPage extends Sprite
    {

        public static const TEXT_MARGIN:int = 22;
        public static const TEXT_MARGIN_HTML:int = 26;
        public static const TEXT_TOP_MARGIN_HTML:int = 40;
        private static const SCROLLBAR_WIDTH:int = 10;
        public static const WIDTH:int = 136;
        public static const HEIGHT:int = 310;

        protected var scrollBar_:Scrollbar;
        private var innerModalWidth:int;
        private var htmlText:TextField;

        public function NewsModalPage(_arg_1:String, _arg_2:String)
        {
            var _local_3:Sprite;
            var _local_4:Sprite;
            _local_3 = null;
            super();
            this.doubleClickEnabled = false;
            this.mouseEnabled = false;
            this.innerModalWidth = ((NewsModal.MODAL_WIDTH - 2) - (TEXT_MARGIN_HTML * 2));
            this.htmlText = new TextField();
            var _local_5:FontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
            _local_5.apply(this.htmlText, 16, 15792127, false, false);
            this.htmlText.width = this.innerModalWidth;
            this.htmlText.multiline = true;
            this.htmlText.wordWrap = true;
            this.htmlText.htmlText = _arg_2;
            this.htmlText.filters = [new DropShadowFilter(0, 0, 0)];
            this.htmlText.height = (this.htmlText.textHeight + 8);
            _local_3 = new Sprite();
            _local_3.addChild(this.htmlText);
            _local_3.y = TEXT_TOP_MARGIN_HTML;
            _local_3.x = TEXT_MARGIN_HTML;
            _local_4 = new Sprite();
            _local_4.graphics.beginFill(0xFF0000);
            _local_4.graphics.drawRect(0, 0, this.innerModalWidth, HEIGHT);
            _local_4.x = TEXT_MARGIN_HTML;
            _local_4.y = TEXT_TOP_MARGIN_HTML;
            addChild(_local_4);
            _local_3.mask = _local_4;
            disableMouseOnText(this.htmlText);
            addChild(_local_3);
            var _local_6:TextFieldDisplayConcrete = NewsModal.getText(_arg_1, TEXT_MARGIN, 6, true);
            addChild(_local_6);
            if (this.htmlText.height >= HEIGHT)
            {
                this.scrollBar_ = new Scrollbar(SCROLLBAR_WIDTH, HEIGHT, 0.1, _local_3);
                this.scrollBar_.x = ((NewsModal.MODAL_WIDTH - SCROLLBAR_WIDTH) - 10);
                this.scrollBar_.y = TEXT_TOP_MARGIN_HTML;
                this.scrollBar_.setIndicatorSize(HEIGHT, _local_3.height);
                addChild(this.scrollBar_);
            }
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedHandler);
        }

        private static function disableMouseOnText(_arg_1:TextField):void
        {
            _arg_1.mouseWheelEnabled = false;
        }


        protected function onScrollBarChange(_arg_1:Event):void
        {
            this.htmlText.y = (-(this.scrollBar_.pos()) * (this.htmlText.height - HEIGHT));
        }

        private function onAddedHandler(_arg_1:Event):void
        {
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (this.scrollBar_)
            {
                this.scrollBar_.addEventListener(Event.CHANGE, this.onScrollBarChange);
            }
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            this.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedHandler);
            if (this.scrollBar_)
            {
                this.scrollBar_.removeEventListener(Event.CHANGE, this.onScrollBarChange);
            }
        }


    }
}//package kabam.rotmg.news.view

