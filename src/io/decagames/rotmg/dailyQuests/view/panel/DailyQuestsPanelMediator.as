//io.decagames.rotmg.dailyQuests.view.panel.DailyQuestsPanelMediator

package io.decagames.rotmg.dailyQuests.view.panel
{
import com.company.assembleegameclient.parameters.Parameters;

import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
import io.decagames.rotmg.dailyQuests.view.DailyQuestWindow;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class DailyQuestsPanelMediator extends Mediator 
    {

        [Inject]
        public var view:DailyQuestsPanel;
        [Inject]
        public var questModel:DailyQuestsModel;
        [Inject]
        public var openDialogSignal:ShowPopupSignal;


        override public function initialize():void
        {
            if (this.questModel.hasQuests())
            {
                this.view.feedButton.addEventListener(MouseEvent.CLICK, this.onButtonLeftClick);
                WebMain.STAGE.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            }
        }

        override public function destroy():void
        {
            this.view.feedButton.removeEventListener(MouseEvent.CLICK, this.onButtonLeftClick);
            WebMain.STAGE.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        }

        protected function onButtonLeftClick(_arg_1:MouseEvent):void
        {
            if (!this.questModel.isPopupOpened)
            {
                this.openDialogSignal.dispatch(new DailyQuestWindow());
            }
        }

        private function onKeyDown(_arg_1:KeyboardEvent):void
        {
            if (((_arg_1.keyCode == Parameters.data_.interact) && (WebMain.STAGE.focus == null)))
            {
                this.onButtonLeftClick(null);
            }
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.panel

