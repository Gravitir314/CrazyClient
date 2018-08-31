//kabam.rotmg.dailyLogin.view.CalendarTabsView

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
import flash.geom.Rectangle;

import kabam.rotmg.dailyLogin.config.CalendarSettings;

public class CalendarTabsView extends Sprite 
    {

        private var fill_:GraphicsSolidFill = new GraphicsSolidFill(0x363636, 1);
        private var fillTransparent_:GraphicsSolidFill = new GraphicsSolidFill(0x363636, 0);
        private var lineStyle_:GraphicsStroke = new GraphicsStroke(CalendarSettings.BOX_BORDER, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, new GraphicsSolidFill(0xFFFFFF));
        private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        private var graphicsDataBackgroundTransparent:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_, fillTransparent_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];
        private var modalRectangle:Rectangle;
        private var tabs:Vector.<CalendarTabButton>;
        private var calendar:CalendarView;


        public function init(_arg_1:Rectangle):void
        {
            this.modalRectangle = _arg_1;
            this.tabs = new Vector.<CalendarTabButton>();
        }

        public function addCalendar(_arg_1:String, _arg_2:String, _arg_3:String):CalendarTabButton
        {
            var _local_4:CalendarTabButton;
            _local_4 = new CalendarTabButton(_arg_1, _arg_3, _arg_2, CalendarTabButton.STATE_IDLE, this.tabs.length);
            this.addChild(_local_4);
            _local_4.x = ((CalendarSettings.TABS_WIDTH - 1) * this.tabs.length);
            this.tabs.push(_local_4);
            return (_local_4);
        }

        public function selectTab(_arg_1:String):void
        {
            var _local_2:CalendarTabButton;
            for each (_local_2 in this.tabs)
            {
                if (_local_2.calendarType == _arg_1)
                {
                    _local_2.state = CalendarTabButton.STATE_SELECTED;
                }
                else
                {
                    _local_2.state = CalendarTabButton.STATE_IDLE;
                }
            }
            if (this.calendar)
            {
                removeChild(this.calendar);
            }
            this.calendar = new CalendarView();
            addChild(this.calendar);
            this.calendar.x = CalendarSettings.DAILY_LOGIN_TABS_PADDING;
        }

        public function drawTabs():void
        {
            this.drawBorder();
        }

        private function drawBorder():void
        {
            var _local_1:Sprite = new Sprite();
            this.drawRectangle(_local_1, this.modalRectangle.width, this.modalRectangle.height);
            addChild(_local_1);
            _local_1.y = CalendarSettings.TABS_HEIGHT;
        }

        private function drawRectangle(_arg_1:Sprite, _arg_2:int, _arg_3:int):void
        {
            _arg_1.addChild(CalendarDayBox.drawRectangleWithCuts([0, 0, 1, 1], _arg_2, _arg_3, 0x363636, 1, this.graphicsDataBackgroundTransparent, this.path_));
        }


    }
}//package kabam.rotmg.dailyLogin.view

