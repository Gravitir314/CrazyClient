// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.DailyQuestWindow

package io.decagames.rotmg.dailyQuests.view
{
import com.company.assembleegameclient.map.ParticleModalMap;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import flashx.textLayout.formats.TextAlign;

import io.decagames.rotmg.dailyQuests.assets.DailyQuestAssets;
import io.decagames.rotmg.dailyQuests.model.DailyQuest;
import io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfo;
import io.decagames.rotmg.dailyQuests.view.list.DailyQuestsList;
import io.decagames.rotmg.dailyQuests.view.popup.DailyQuestRedeemPopup;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class DailyQuestWindow extends Sprite 
    {

        public static var dailyQuestBanner:Class = DailyQuestWindow_dailyQuestBanner;
        public static const MODAL_WIDTH:int = 600;
        public static const MODAL_FULL_WIDTH:int = 800;
        public static const MODAL_HEIGHT:int = 600;

        private var fade:Sprite;
        private var rewardPopup:DailyQuestRedeemPopup;
        private var _closeButton:Sprite;
        private var _infoButton:Sprite;
        private var questList:DailyQuestsList;
        private var questInfo:DailyQuestInfo;
        private var questRefreshText:TextFieldDisplayConcrete;
        private var completedCounter:TextFieldDisplayConcrete;
        private var completedTxt:TextFieldDisplayConcrete;
        private var particleLayer:ParticleModalMap;

        public function DailyQuestWindow()
        {
            var _local_1:Bitmap;
            var _local_2:TextFieldDisplayConcrete;
            _local_1 = null;
            super();
            _local_1 = new DailyQuestAssets.DailyQuestsWindowBackground();
            _local_1.y = 1;
            addChild(_local_1);
            _local_2 = new TextFieldDisplayConcrete().setSize(32).setColor(0xEAEAEA).setBold(true).setTextWidth(270).setHorizontalAlign(TextAlign.CENTER);
            _local_2.x = 204;
            _local_2.y = 47;
            _local_2.setStringBuilder(new StaticStringBuilder("Daily Quests"));
            addChild(_local_2);
            this._closeButton = new Sprite();
            this._closeButton.addChild(new DailyQuestAssets.DailyQuestsCloseButton());
            this._closeButton.x = 546;
            this._closeButton.y = 46;
            addChild(this._closeButton);
            this._infoButton = new Sprite();
            this._infoButton.addChild(new DailyQuestAssets.DailyQuestsInfoButton());
            this._infoButton.x = 16;
            this._infoButton.y = this._closeButton.y;
            addChild(this._infoButton);
            this.renderQuestInfo();
            this.renderList();
            this.questRefreshText = new TextFieldDisplayConcrete().setSize(14).setColor(0xA3A3A3).setBold(true).setTextWidth(234).setAutoSize(TextFieldAutoSize.CENTER).setHorizontalAlign(TextFormatAlign.CENTER);
            this.questRefreshText.y = 503;
            this.questRefreshText.x = 10;
            addChild(this.questRefreshText);
            this.completedTxt = new TextFieldDisplayConcrete().setSize(16).setColor(13224136).setBold(true).setTextWidth(160).setHorizontalAlign(TextFormatAlign.LEFT);
            this.completedTxt.y = 533;
            this.completedTxt.x = 24;
            this.completedTxt.setStringBuilder(new StaticStringBuilder("Quests completed"));
            addChild(this.completedTxt);
            this.completedCounter = new TextFieldDisplayConcrete().setSize(16).setColor(13224136).setBold(true).setTextWidth(50).setHorizontalAlign(TextFormatAlign.RIGHT);
            this.completedCounter.y = 533;
            this.completedCounter.x = 207;
            addChild(this.completedCounter);
        }

        public function setCompletedCounter(_arg_1:int, _arg_2:int):void
        {
            if (_arg_1 == _arg_2)
            {
                this.completedCounter.setColor(3971635);
                this.completedTxt.setColor(3971635);
            };
            this.completedCounter.setStringBuilder(new StaticStringBuilder(((_arg_1 + "/") + _arg_2)));
        }

        public function setQuestRefreshHeader(_arg_1:String):void
        {
            this.questRefreshText.setStringBuilder(new StaticStringBuilder(_arg_1));
        }

        public function renderQuestInfo():void
        {
            if (((this.questInfo) && (this.questInfo.parent)))
            {
                removeChild(this.questInfo);
            };
            this.questInfo = new DailyQuestInfo();
            this.questInfo.x = 0x0100;
            this.questInfo.y = 121;
            addChild(this.questInfo);
        }

        public function renderList():void
        {
            if (((this.questList) && (this.questList.parent)))
            {
                removeChild(this.questList);
            };
            this.questList = new DailyQuestsList();
            this.questList.x = 18;
            this.questList.y = 134;
            addChild(this.questList);
        }

        public function showFade(_arg_1:int=0x151515, _arg_2:Boolean=false):void
        {
            this.fade = new Sprite();
            this.fade.graphics.clear();
            this.fade.graphics.beginFill(_arg_1, 0.8);
            this.fade.graphics.drawRect(0, 0, MODAL_FULL_WIDTH, MODAL_HEIGHT);
            addChild(this.fade);
            if (_arg_2)
            {
                this.particleLayer = new ParticleModalMap(1);
                addChild(this.particleLayer);
            };
        }

        public function hideFade():void
        {
            if (((this.fade) && (this.fade.parent)))
            {
                removeChild(this.fade);
            };
            if (((this.particleLayer) && (this.particleLayer.parent)))
            {
                removeChild(this.particleLayer);
            };
        }

        public function hideRewardsPopup():void
        {
            if (((this.rewardPopup) && (this.rewardPopup.parent)))
            {
                removeChild(this.rewardPopup);
            };
        }

        public function showRewardsPopup(_arg_1:DailyQuest):DailyQuestRedeemPopup
        {
            this.rewardPopup = new DailyQuestRedeemPopup(_arg_1);
            addChild(this.rewardPopup);
            this.rewardPopup.x = Math.round(((MODAL_FULL_WIDTH - this.rewardPopup.width) / 2));
            this.rewardPopup.y = Math.round(((MODAL_HEIGHT - this.rewardPopup.height) / 2));
            return (this.rewardPopup);
        }

        public function get closeButton():Sprite
        {
            return (this._closeButton);
        }

        public function get infoButton():Sprite
        {
            return (this._infoButton);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view

