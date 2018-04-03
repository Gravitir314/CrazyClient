// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.ui.scrollbar.DailyQuestListScrollbarMediator

package io.decagames.rotmg.dailyQuests.ui.scrollbar
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class DailyQuestListScrollbarMediator extends Mediator 
    {

        [Inject]
        public var view:DailyQuestListScrollbar;
        private var startDragging:Boolean;
        private var startY:Number;


        override public function initialize():void
        {
            this.view.addEventListener(Event.ENTER_FRAME, this.onUpdateHandler);
            this.view.slider.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            WebMain.STAGE.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }

        private function onMouseDown(_arg_1:Event):void
        {
            this.startDragging = true;
            this.startY = WebMain.STAGE.mouseY;
        }

        private function onMouseUp(_arg_1:Event):void
        {
            this.startDragging = false;
        }

        override public function destroy():void
        {
            this.view.removeEventListener(Event.ENTER_FRAME, this.onUpdateHandler);
            this.view.slider.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            WebMain.STAGE.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }

        private function onUpdateHandler(_arg_1:Event):void
        {
            if (this.startDragging)
            {
                this.view.updatePosition((WebMain.STAGE.mouseY - this.startY));
                this.startY = WebMain.STAGE.mouseY;
            };
        }


    }
}//package io.decagames.rotmg.dailyQuests.ui.scrollbar

