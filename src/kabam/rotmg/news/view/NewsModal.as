// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.news.view.NewsModal

package kabam.rotmg.news.view
{
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.util.AssetLibrary;
import com.company.util.KeyCodes;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.geom.ColorTransform;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.account.core.view.EmptyFrame;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.news.model.NewsModel;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class NewsModal extends EmptyFrame
    {

        public static var backgroundImageEmbed:Class = NewsModal_backgroundImageEmbed;
        public static var foregroundImageEmbed:Class = NewsModal_foregroundImageEmbed;
        public static const MODAL_WIDTH:int = 440;
        public static const MODAL_HEIGHT:int = 400;
        public static var modalWidth:int = MODAL_WIDTH;//440
        public static var modalHeight:int = MODAL_HEIGHT;//400
        private static const OVER_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1, (220 / 0xFF), (133 / 0xFF));
        private static const DROP_SHADOW_FILTER:DropShadowFilter = new DropShadowFilter(0, 0, 0);
        private static const GLOW_FILTER:GlowFilter = new GlowFilter(0xFF0000, 1, 11, 5);
        private static const filterWithGlow:Array = [DROP_SHADOW_FILTER, GLOW_FILTER];
        private static const filterNoGlow:Array = [DROP_SHADOW_FILTER];

        private var currentPage:NewsModalPage;
        private var currentPageNum:int = -1;
        private var pageOneNav:TextField;
        private var pageTwoNav:TextField;
        private var pageThreeNav:TextField;
        private var pageFourNav:TextField;
        private var pageNavs:Vector.<TextField>;
        private var pageIndicator:TextField;
        private var fontModel:FontModel;
        private var leftNavSprite:Sprite;
        private var rightNavSprite:Sprite;
        private var newsModel:NewsModel;
        private var currentPageNumber:int = 1;
        private var triggeredOnStartup:Boolean;

        public function NewsModal(_arg_1:Boolean=false)
        {
            this.triggeredOnStartup = _arg_1;
            this.newsModel = StaticInjectorContext.getInjector().getInstance(NewsModel);
            this.fontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
            protected::modalWidth = MODAL_WIDTH;
            protected::modalHeight = MODAL_HEIGHT;
            super(protected::modalWidth, protected::modalHeight);
            this.setCloseButton(true);
            this.pageIndicator = new TextField();
            this.initNavButtons();
            this.setPage(this.currentPageNumber);
            WebMain.STAGE.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDownListener);
            addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
            addEventListener(Event.REMOVED_FROM_STAGE, this.destroy);
            closeButton.clicked.add(this.onCloseButtonClicked);
        }

        public static function getText(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Boolean):TextFieldDisplayConcrete
        {
            var _local_5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setTextWidth(((NewsModal.modalWidth - (TEXT_MARGIN * 2)) - 10));
            _local_5.setBold(true);
            if (_arg_4)
            {
                _local_5.setStringBuilder(new StaticStringBuilder(_arg_1));
            }
            else
            {
                _local_5.setStringBuilder(new LineBuilder().setParams(_arg_1));
            }
            _local_5.setWordWrap(true);
            _local_5.setMultiLine(true);
            _local_5.setAutoSize(TextFieldAutoSize.CENTER);
            _local_5.setHorizontalAlign(TextFormatAlign.CENTER);
            _local_5.filters = [new DropShadowFilter(0, 0, 0)];
            _local_5.x = _arg_2;
            _local_5.y = _arg_3;
            return (_local_5);
        }


        public function onCloseButtonClicked():*
        {
        }

        private function onAdded(_arg_1:Event):*
        {
            this.newsModel.markAsRead();
            this.refreshNewsButton();
        }

        private function updateIndicator():*
        {
            this.fontModel.apply(this.pageIndicator, 24, 0xFFFFFF, true);
            this.pageIndicator.text = ((this.currentPageNumber + " / ") + this.newsModel.numberOfNews);
            addChild(this.pageIndicator);
            this.pageIndicator.y = (protected::modalHeight - 33);
            this.pageIndicator.x = ((protected::modalWidth / 2) - (this.pageIndicator.textWidth / 2));
            this.pageIndicator.width = (this.pageIndicator.textWidth + 4);
        }

        private function initNavButtons():void
        {
            this.updateIndicator();
            this.leftNavSprite = this.makeLeftNav();
            this.rightNavSprite = this.makeRightNav();
            this.leftNavSprite.x = (((protected::modalWidth * 4) / 11) - (this.rightNavSprite.width / 2));
            this.leftNavSprite.y = (protected::modalHeight - 4);
            addChild(this.leftNavSprite);
            this.rightNavSprite.x = (((protected::modalWidth * 7) / 11) - (this.rightNavSprite.width / 2));
            this.rightNavSprite.y = (protected::modalHeight - 4);
            addChild(this.rightNavSprite);
        }

        public function onClick(_arg_1:MouseEvent):void
        {
            switch (_arg_1.currentTarget)
            {
                case this.rightNavSprite:
                    if ((this.currentPageNumber + 1) <= this.newsModel.numberOfNews)
                    {
                        this.setPage((this.currentPageNumber + 1));
                    }
                    return;
                case this.leftNavSprite:
                    if ((this.currentPageNumber - 1) >= 1)
                    {
                        this.setPage((this.currentPageNumber - 1));
                    }
            }
        }

        private function destroy(_arg_1:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAdded);
            WebMain.STAGE.removeEventListener(KeyboardEvent.KEY_DOWN, this.keyDownListener);
            removeEventListener(Event.REMOVED_FROM_STAGE, this.destroy);
            this.leftNavSprite.removeEventListener(MouseEvent.CLICK, this.onClick);
            this.leftNavSprite.removeEventListener(MouseEvent.MOUSE_OVER, this.onArrowHover);
            this.leftNavSprite.removeEventListener(MouseEvent.MOUSE_OUT, this.onArrowHoverOut);
            this.rightNavSprite.removeEventListener(MouseEvent.CLICK, this.onClick);
            this.rightNavSprite.removeEventListener(MouseEvent.MOUSE_OVER, this.onArrowHover);
            this.rightNavSprite.removeEventListener(MouseEvent.MOUSE_OUT, this.onArrowHoverOut);
        }

        private function setPage(_arg_1:int):void
        {
            this.currentPageNumber = _arg_1;
            if (((this.currentPage) && (this.currentPage.parent)))
            {
                removeChild(this.currentPage);
            }
            this.currentPage = this.newsModel.getModalPage(_arg_1);
            addChild(this.currentPage);
            this.updateIndicator();
        }

        private function refreshNewsButton():void
        {
        }

        override protected function makeModalBackground():Sprite
        {
            var _local_1:Sprite;
            _local_1 = new Sprite();
            var _local_2:DisplayObject = new backgroundImageEmbed();
            _local_2.width = (protected::modalWidth + 1);
            _local_2.height = (protected::modalHeight - 25);
            _local_2.y = 27;
            _local_2.alpha = 0.95;
            var _local_3:DisplayObject = new foregroundImageEmbed();
            _local_3.width = (protected::modalWidth + 1);
            _local_3.height = (protected::modalHeight - 67);
            _local_3.y = 27;
            _local_3.alpha = 1;
            var _local_4:PopupWindowBackground = new PopupWindowBackground();
            _local_4.draw(protected::modalWidth, protected::modalHeight, PopupWindowBackground.TYPE_TRANSPARENT_WITH_HEADER);
            _local_1.addChild(_local_2);
            _local_1.addChild(_local_3);
            _local_1.addChild(_local_4);
            return (_local_1);
        }

        private function keyDownListener(_arg_1:KeyboardEvent):void
        {
            if (_arg_1.keyCode == KeyCodes.RIGHT)
            {
                if ((this.currentPageNumber + 1) <= this.newsModel.numberOfNews)
                {
                    this.setPage((this.currentPageNumber + 1));
                }
            }
            else
            {
                if (_arg_1.keyCode == KeyCodes.LEFT)
                {
                    if ((this.currentPageNumber - 1) >= 1)
                    {
                        this.setPage((this.currentPageNumber - 1));
                    }
                }
            }
        }

        private function makeLeftNav():Sprite
        {
            var _local_1:BitmapData = AssetLibrary.getImageFromSet("lofiInterface", 54);
            var _local_2:Bitmap = new Bitmap(_local_1);
            _local_2.scaleX = 4;
            _local_2.scaleY = 4;
            _local_2.rotation = -90;
            var _local_3:Sprite = new Sprite();
            _local_3.addChild(_local_2);
            _local_3.addEventListener(MouseEvent.MOUSE_OVER, this.onArrowHover);
            _local_3.addEventListener(MouseEvent.MOUSE_OUT, this.onArrowHoverOut);
            _local_3.addEventListener(MouseEvent.CLICK, this.onClick);
            return (_local_3);
        }

        private function makeRightNav():Sprite
        {
            var _local_1:BitmapData = AssetLibrary.getImageFromSet("lofiInterface", 55);
            var _local_2:Bitmap = new Bitmap(_local_1);
            _local_2.scaleX = 4;
            _local_2.scaleY = 4;
            _local_2.rotation = -90;
            var _local_3:Sprite = new Sprite();
            _local_3.addChild(_local_2);
            _local_3.addEventListener(MouseEvent.MOUSE_OVER, this.onArrowHover);
            _local_3.addEventListener(MouseEvent.MOUSE_OUT, this.onArrowHoverOut);
            _local_3.addEventListener(MouseEvent.CLICK, this.onClick);
            return (_local_3);
        }

        private function onArrowHover(_arg_1:MouseEvent):void
        {
            _arg_1.currentTarget.transform.colorTransform = OVER_COLOR_TRANSFORM;
        }

        private function onArrowHoverOut(_arg_1:MouseEvent):void
        {
            _arg_1.currentTarget.transform.colorTransform = MoreColorUtil.identity;
        }

        override public function onCloseClick(_arg_1:MouseEvent):void
        {
            SoundEffectLibrary.play("button_click");
        }


    }
}//package kabam.rotmg.news.view

