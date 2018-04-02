// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.dailyLogin.view.DailyLoginModal

package kabam.rotmg.dailyLogin.view
{
import com.company.assembleegameclient.ui.DeprecatedTextButtonStatic;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.geom.Rectangle;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.dailyLogin.config.CalendarSettings;
import kabam.rotmg.dailyLogin.model.DailyLoginModel;
import kabam.rotmg.mysterybox.components.MysteryBoxSelectModal;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class DailyLoginModal extends Sprite
    {

        private var content:Sprite;
        private var calendarView:CalendarView = new CalendarView();
        private var titleTxt:TextFieldDisplayConcrete;
        private var serverTimeTxt:TextFieldDisplayConcrete;
        public var closeButton:DialogCloseButton = new DialogCloseButton();
        private var modalRectangle:Rectangle;
        private var daysLeft:int = 300;
        public var claimButton:DeprecatedTextButtonStatic;
        private var tabs:CalendarTabsView;


        public function init(_arg_1:DailyLoginModel):void
        {
            this.daysLeft = _arg_1.daysLeftToCalendarEnd;
            this.modalRectangle = CalendarSettings.getCalendarModalRectangle(_arg_1.overallMaxDays, (this.daysLeft < CalendarSettings.CLAIM_WARNING_BEFORE_DAYS));
            this.content = new Sprite();
            addChild(this.content);
            this.createModalBox();
            this.tabs = new CalendarTabsView();
            addChild(this.tabs);
            this.tabs.y = CalendarSettings.TABS_Y_POSITION;
            if (this.daysLeft < CalendarSettings.CLAIM_WARNING_BEFORE_DAYS)
            {
                this.tabs.y = (this.tabs.y + 20);
            };
            this.centerModal();
        }

        private function addClaimButton():*
        {
            this.claimButton = new DeprecatedTextButtonStatic(16, "Go & Claim");
            this.claimButton.textChanged.addOnce(this.alignClaimButton);
            addChild(this.claimButton);
        }

        public function showLegend(_arg_1:Boolean):*
        {
            var _local_2:TextFieldDisplayConcrete;
            var _local_3:TextFieldDisplayConcrete;
            var _local_4:Sprite;
            var _local_5:Bitmap;
            var _local_6:Bitmap;
            _local_4 = new Sprite();
            _local_4.y = (this.modalRectangle.height - 55);
            _local_2 = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth(this.modalRectangle.width).setHorizontalAlign(TextFormatAlign.LEFT);
            _local_2.setStringBuilder(new StaticStringBuilder(((_arg_1) ? "- Reward ready to claim. Click on day to claim reward." : "- Reward ready to claim.")));
            _local_3 = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth(this.modalRectangle.width).setHorizontalAlign(TextFormatAlign.LEFT);
            _local_3.setStringBuilder(new StaticStringBuilder("- Item claimed already."));
            _local_2.x = 20;
            _local_2.y = 0;
            _local_3.x = 20;
            _local_3.y = 20;
            var _local_7:BitmapData = AssetLibrary.getImageFromSet("lofiInterface", 52);
            _local_7.colorTransform(new Rectangle(0, 0, _local_7.width, _local_7.height), CalendarSettings.GREEN_COLOR_TRANSFORM);
            _local_7 = TextureRedrawer.redraw(_local_7, 40, true, 0);
            _local_5 = new Bitmap(_local_7);
            _local_5.x = (-(Math.round((_local_5.width / 2))) + 10);
            _local_5.y = (-(Math.round((_local_5.height / 2))) + 9);
            _local_4.addChild(_local_5);
            _local_7 = AssetLibrary.getImageFromSet("lofiInterfaceBig", 11);
            _local_7 = TextureRedrawer.redraw(_local_7, 20, true, 0);
            _local_6 = new Bitmap(_local_7);
            _local_6.x = (-(Math.round((_local_6.width / 2))) + 10);
            _local_6.y = (-(Math.round((_local_6.height / 2))) + 30);
            _local_4.addChild(_local_6);
            _local_4.addChild(_local_2);
            _local_4.addChild(_local_3);
            if (!_arg_1)
            {
                this.addClaimButton();
                _local_4.x = ((CalendarSettings.DAILY_LOGIN_MODAL_PADDING + this.claimButton.width) + 10);
            }
            else
            {
                _local_4.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
            };
            addChild(_local_4);
        }

        private function alignClaimButton():void
        {
            this.claimButton.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
            this.claimButton.y = ((this.modalRectangle.height - this.claimButton.height) - CalendarSettings.DAILY_LOGIN_MODAL_PADDING);
            if (this.daysLeft < CalendarSettings.CLAIM_WARNING_BEFORE_DAYS)
            {
            };
        }

        private function createModalBox():*
        {
            var _local_1:DisplayObject;
            _local_1 = new MysteryBoxSelectModal.backgroundImageEmbed();
            this.modalRectangle.width--;
            _local_1.height = (this.modalRectangle.height - 27);
            _local_1.y = 27;
            _local_1.alpha = 0.95;
            this.content.addChild(_local_1);
            this.content.addChild(this.makeModalBackground(this.modalRectangle.width, this.modalRectangle.height));
        }

        private function makeModalBackground(_arg_1:int, _arg_2:int):PopupWindowBackground
        {
            var _local_3:PopupWindowBackground = new PopupWindowBackground();
            _local_3.draw(_arg_1, _arg_2, PopupWindowBackground.TYPE_TRANSPARENT_WITH_HEADER);
            return (_local_3);
        }

        public function addCloseButton():void
        {
            this.closeButton.y = 4;
            this.closeButton.x = ((this.modalRectangle.width - this.closeButton.width) - 5);
            addChild(this.closeButton);
        }

        public function addTitle(_arg_1:String):void
        {
            this.titleTxt = this.getText(_arg_1, 0, 6, true).setSize(18);
            this.titleTxt.setColor(0xFFDE00);
            addChild(this.titleTxt);
        }

        public function showServerTime(_arg_1:String, _arg_2:String):void
        {
            var _local_3:TextFieldDisplayConcrete;
            _local_3 = null;
            this.serverTimeTxt = new TextFieldDisplayConcrete().setSize(14).setColor(0xFFFFFF).setTextWidth(this.modalRectangle.width);
            this.serverTimeTxt.setStringBuilder(new StaticStringBuilder(((("Server time: " + _arg_1) + ", ends on: ") + _arg_2)));
            this.serverTimeTxt.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
            if (this.daysLeft < CalendarSettings.CLAIM_WARNING_BEFORE_DAYS)
            {
                _local_3 = new TextFieldDisplayConcrete().setSize(14).setColor(0xFF0000).setTextWidth(this.modalRectangle.width);
                _local_3.setStringBuilder(new StaticStringBuilder("Calendar will soon end, remember to claim before it ends."));
                _local_3.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
                _local_3.y = 40;
                this.serverTimeTxt.y = 60;
                this.calendarView.y = 90;
                addChild(_local_3);
            }
            else
            {
                this.calendarView.y = 70;
                this.serverTimeTxt.y = 40;
            };
            addChild(this.serverTimeTxt);
        }

        public function getText(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Boolean=false):TextFieldDisplayConcrete
        {
            var _local_5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth(this.modalRectangle.width);
            _local_5.setBold(true);
            if (_arg_4)
            {
                _local_5.setStringBuilder(new StaticStringBuilder(_arg_1));
            }
            else
            {
                _local_5.setStringBuilder(new LineBuilder().setParams(_arg_1));
            };
            _local_5.setWordWrap(true);
            _local_5.setMultiLine(true);
            _local_5.setAutoSize(TextFieldAutoSize.CENTER);
            _local_5.setHorizontalAlign(TextFormatAlign.CENTER);
            _local_5.filters = [new DropShadowFilter(0, 0, 0)];
            _local_5.x = _arg_2;
            _local_5.y = _arg_3;
            return (_local_5);
        }

        private function centerModal():void
        {
            this.x = (400 - (this.width / 2));
            this.y = (300 - (this.height / 2));
            this.tabs.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
        }


    }
}//package kabam.rotmg.dailyLogin.view

