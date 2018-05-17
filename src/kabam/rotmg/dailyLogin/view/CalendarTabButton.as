//kabam.rotmg.dailyLogin.view.CalendarTabButton

package kabam.rotmg.dailyLogin.view
{
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.dailyLogin.config.CalendarSettings;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class CalendarTabButton extends Sprite
    {

        public static const STATE_SELECTED:String = "selected";
        public static const STATE_IDLE:String = "idle";

        private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        private var fill_:GraphicsSolidFill = new GraphicsSolidFill(0x363636, 1);
        private var fillIdle_:GraphicsSolidFill = new GraphicsSolidFill(0x222222, 1);
        private var lineStyle_:GraphicsStroke = new GraphicsStroke(CalendarSettings.BOX_BORDER, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, new GraphicsSolidFill(0xFFFFFF));
        private var graphicsDataBackground:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_, fill_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];
        private var graphicsDataBackgroundIdle:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_, fillIdle_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];
        private var _calendarType:String;
        private var state_:String = "idle";
        private var tabNameTxt:TextFieldDisplayConcrete;
        private var background:Sprite;
        private var tabName:String;
        private var hintText:String;
        private var tooltip:DailyCalendarInfoIcon;

        public function CalendarTabButton(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:int)
        {
            this._calendarType = _arg_3;
            this.tabName = _arg_1;
            this.hintText = _arg_2;
            this.drawTab();
            this.addEventListener(Event.ADDED, this.onAddedHandler);
        }

        private function onAddedHandler(_arg_1:Event):void
        {
            this.removeEventListener(Event.ADDED, this.onAddedHandler);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            this.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        private function drawTab():void
        {
            if (this.background)
            {
                removeChild(this.background);
            }
            if (this.tooltip)
            {
                removeChild(this.tooltip);
            }
            this.background = CalendarDayBox.drawRectangleWithCuts([1, 1, 0, 0], CalendarSettings.TABS_WIDTH, CalendarSettings.TABS_HEIGHT, 0x363636, 1, ((this.state_ == STATE_IDLE) ? this.graphicsDataBackgroundIdle : this.graphicsDataBackground), this.path_);
            this.addChild(this.background);
            if (this.tabNameTxt)
            {
                removeChild(this.tabNameTxt);
            }
            this.tabNameTxt = new TextFieldDisplayConcrete().setSize(CalendarSettings.TABS_FONT_SIZE).setColor(((this.state_ == STATE_IDLE) ? uint(0xFFFFFF) : uint(0xFFDE00))).setTextWidth(CalendarSettings.TABS_WIDTH).setAutoSize(TextFieldAutoSize.CENTER);
            this.tabNameTxt.setStringBuilder(new StaticStringBuilder(this.tabName));
            this.tabNameTxt.y = ((CalendarSettings.TABS_HEIGHT - CalendarSettings.TABS_FONT_SIZE) / 2);
            this.tooltip = new DailyCalendarInfoIcon(this.tabName, this.hintText);
            this.tooltip.x = (CalendarSettings.TABS_WIDTH - 15);
            this.tooltip.y = 5;
            addChild(this.tooltip);
            if (this.state_ == STATE_IDLE)
            {
                this.tabNameTxt.alpha = 0.5;
            }
            this.addChild(this.tabNameTxt);
        }

        public function set state(_arg_1:String):void
        {
            if (_arg_1 != this.state_)
            {
                this.state_ = _arg_1;
                this.drawTab();
            }
        }

        public function get calendarType():String
        {
            return (this._calendarType);
        }


    }
}//package kabam.rotmg.dailyLogin.view

