// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.DailyQuestWindow

package io.decagames.rotmg.dailyQuests.view
{
import com.company.assembleegameclient.map.ParticleModalMap;

import flash.display.Sprite;

import io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfo;
import io.decagames.rotmg.dailyQuests.view.list.DailyQuestsList;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.popups.UIPopup;

public class DailyQuestWindow extends UIPopup
    {

        public static const MODAL_WIDTH:int = 600;
        public static const MODAL_FULL_WIDTH:int = 800;
        public static const MODAL_HEIGHT:int = 600;

        private var fade:Sprite;
        private var _closeButton:Sprite;
        private var _infoButton:Sprite;
        private var questList:DailyQuestsList;
        private var questInfo:DailyQuestInfo;
        private var questRefreshText:UILabel;
        private var completedCounter:UILabel;
        private var completedTxt:UILabel;
        private var particleLayer:ParticleModalMap;
        private var _contentContainer:Sprite;

        public function DailyQuestWindow()
        {
            super(MODAL_WIDTH, MODAL_HEIGHT);
            this._contentContainer = new Sprite();
            this._contentContainer.y = 120;
            this._contentContainer.x = 10;
            addChild(this._contentContainer);
            this.questRefreshText = new UILabel();
            DefaultLabelFormat.questRefreshLabel(this.questRefreshText);
            this.questRefreshText.y = 426;
            this.questRefreshText.x = 10;
            this.questRefreshText.width = 230;
            this.questRefreshText.wordWrap = true;
            this._contentContainer.addChild(this.questRefreshText);
            this.renderQuestInfo();
            this.renderList();
        }

        public function setCompletedCounter(_arg_1:int, _arg_2:int):void
        {
            if (_arg_1 == _arg_2)
            {
                DefaultLabelFormat.questCompletedLabel(this.completedTxt, true, false);
                DefaultLabelFormat.questCompletedLabel(this.completedCounter, true, true);
            }
            this.completedCounter.text = ((_arg_1 + "/") + _arg_2);
            this.completedCounter.x = (this.completedCounter.x - this.completedCounter.textWidth);
        }

        public function setQuestRefreshHeader(_arg_1:String):void
        {
            this.questRefreshText.text = _arg_1;
        }

        public function renderQuestInfo():void
        {
            if (((this.questInfo) && (this.questInfo.parent)))
            {
                this.questInfo.parent.removeChild(this.questInfo);
            }
            this.questInfo = new DailyQuestInfo();
            this.questInfo.x = 0x0101;
            this.questInfo.y = 130;
            addChild(this.questInfo);
        }

        public function renderList():void
        {
            if (((this.questList) && (this.questList.parent)))
            {
                removeChild(this.questList);
            }
            this.questList = new DailyQuestsList();
            this.questList.x = 20;
            this.questList.y = 130;
            addChild(this.questList);
        }

        public function showFade(_arg_1:int=0x151515, _arg_2:Boolean=false):void{
            if (_arg_2){
                this.particleLayer = new ParticleModalMap(1);
                addChild(this.particleLayer);
            } else {
                this.fade = new Sprite();
                this.fade.graphics.clear();
                this.fade.graphics.beginFill(_arg_1, 0.8);
                this.fade.graphics.drawRect(0, 0, MODAL_FULL_WIDTH, MODAL_HEIGHT);
                addChild(this.fade);
            }
        }

        public function hideFade():void
        {
            if (((this.fade) && (this.fade.parent)))
            {
                removeChild(this.fade);
            }
            if (((this.particleLayer) && (this.particleLayer.parent)))
            {
                removeChild(this.particleLayer);
            }
        }

        public function get closeButton():Sprite
        {
            return (this._closeButton);
        }

        public function get infoButton():Sprite
        {
            return (this._infoButton);
        }

        public function get contentContainer():Sprite{
            return (this._contentContainer);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view

