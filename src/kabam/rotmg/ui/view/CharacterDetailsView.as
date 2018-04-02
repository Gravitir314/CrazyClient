// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.ui.view.CharacterDetailsView

package kabam.rotmg.ui.view
{
import com.company.assembleegameclient.objects.ImageFactory;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.BoostPanelButton;
import com.company.assembleegameclient.ui.ExperienceBoostTimerPopup;
import com.company.assembleegameclient.ui.icons.IconButton;
import com.company.assembleegameclient.ui.icons.IconButtonFactory;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeSignal;

public class CharacterDetailsView extends Sprite
    {

        public static const NEXUS_BUTTON:String = "NEXUS_BUTTON";
        public static const OPTIONS_BUTTON:String = "OPTIONS_BUTTON";
        public static const IMAGE_SET_NAME:String = "lofiInterfaceBig";
        public static const NEXUS_IMAGE_ID:int = 6;
        public static const OPTIONS_IMAGE_ID:int = 5;

        public var iconButtonFactory:IconButtonFactory;
        public var imageFactory:ImageFactory;
        private var boostPanelButton:BoostPanelButton;
        private var expTimer:ExperienceBoostTimerPopup;
        private var button:IconButton;
        private var portrait_:Bitmap = new Bitmap(null);
        private var nameText_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(20).setColor(0xB3B3B3);
        public var gotoNexus:Signal = new Signal();
        public var gotoOptions:Signal = new Signal();
        private var nexusClicked:NativeSignal = new NativeSignal(button, MouseEvent.CLICK);
        private var optionsClicked:NativeSignal = new NativeSignal(button, MouseEvent.CLICK);


        public function init(_arg_1:String, _arg_2:String):void
        {
            this.createPortrait();
            this.createNameText(_arg_1);
            this.createButton(_arg_2);
        }

        private function createButton(_arg_1:String):void
        {
            if (_arg_1 == NEXUS_BUTTON)
            {
                this.button = this.iconButtonFactory.create(this.imageFactory.getImageFromSet(IMAGE_SET_NAME, NEXUS_IMAGE_ID), "", TextKey.CHARACTER_DETAILS_VIEW_NEXUS, "escapeToNexus");
                this.nexusClicked = new NativeSignal(this.button, MouseEvent.CLICK, MouseEvent);
                this.nexusClicked.add(this.onNexusClick);
            }
            else
            {
                if (_arg_1 == OPTIONS_BUTTON)
                {
                    this.button = this.iconButtonFactory.create(this.imageFactory.getImageFromSet(IMAGE_SET_NAME, OPTIONS_IMAGE_ID), "", TextKey.CHARACTER_DETAILS_VIEW_OPTIONS, "options");
                    this.optionsClicked = new NativeSignal(this.button, MouseEvent.CLICK, MouseEvent);
                    this.optionsClicked.add(this.onOptionsClick);
                };
            };
            this.button.x = 172;
            this.button.y = 4;
            addChild(this.button);
        }

        private function createPortrait():void
        {
            this.portrait_.x = -2;
            this.portrait_.y = -8;
            addChild(this.portrait_);
        }

        private function createNameText(_arg_1:String):void
        {
            this.nameText_.setBold(true);
            this.nameText_.x = 36;
            this.nameText_.y = 3;
            this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
            this.setName(_arg_1);
            addChild(this.nameText_);
        }

        public function update(_arg_1:Player):void
        {
            this.portrait_.bitmapData = _arg_1.getPortrait();
        }

        public function draw(_arg_1:Player):void
        {
            if (this.expTimer)
            {
                this.expTimer.update(_arg_1.xpTimer);
            };
            if (((_arg_1.tierBoost) || (_arg_1.dropBoost)))
            {
                this.boostPanelButton = ((this.boostPanelButton) || (new BoostPanelButton(_arg_1)));
                if (this.portrait_)
                {
                    this.portrait_.x = 13;
                };
                if (this.nameText_)
                {
                    this.nameText_.x = 47;
                };
                this.boostPanelButton.x = 6;
                this.boostPanelButton.y = 5;
                addChild(this.boostPanelButton);
            }
            else
            {
                if (this.boostPanelButton)
                {
                    removeChild(this.boostPanelButton);
                    this.boostPanelButton = null;
                    this.portrait_.x = -2;
                    this.nameText_.x = 36;
                };
            };
        }

        private function onNexusClick(_arg_1:MouseEvent):void
        {
            this.gotoNexus.dispatch();
        }

        private function onOptionsClick(_arg_1:MouseEvent):void
        {
            this.gotoOptions.dispatch();
        }

        public function setName(_arg_1:String):void
        {
            var _local_2:String = Parameters.data_.fakeName;
            if (_local_2 != null)
            {
                _arg_1 = _local_2;
            };
            this.nameText_.setStringBuilder(new StaticStringBuilder(_arg_1));
        }


    }
}//package kabam.rotmg.ui.view

