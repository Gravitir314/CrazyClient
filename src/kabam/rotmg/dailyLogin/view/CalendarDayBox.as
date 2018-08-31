//kabam.rotmg.dailyLogin.view.CalendarDayBox

package kabam.rotmg.dailyLogin.view
{
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.GraphicsUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.assets.services.IconFactory;
import kabam.rotmg.dailyLogin.config.CalendarSettings;
import kabam.rotmg.dailyLogin.model.CalendarDayModel;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class CalendarDayBox extends Sprite 
    {

        private var fill_:GraphicsSolidFill = new GraphicsSolidFill(0x363636, 1);
        private var fillCurrent_:GraphicsSolidFill = new GraphicsSolidFill(4889165, 1);
        private var fillBlack_:GraphicsSolidFill = new GraphicsSolidFill(0, 0.7);
        private var lineStyle_:GraphicsStroke = new GraphicsStroke(CalendarSettings.BOX_BORDER, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, new GraphicsSolidFill(0xFFFFFF));
        private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        private var graphicsDataBackground:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_, fill_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];
        private var graphicsDataBackgroundCurrent:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_, fillCurrent_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];
        private var graphicsDataClaimedOverlay:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_, fillBlack_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];
        public var day:CalendarDayModel;
        private var redDot:Bitmap;
        private var boxCuts:Array;

        public function CalendarDayBox(_arg_1:CalendarDayModel, _arg_2:int, _arg_3:Boolean)
        {
            var _local_6:ItemTileRenderer;
            var _local_7:Bitmap;
            var _local_8:BitmapData;
            var _local_9:TextFieldDisplayConcrete;
            super();
            this.day = _arg_1;
            var _local_4:int = int(Math.ceil((_arg_1.dayNumber / CalendarSettings.NUMBER_OF_COLUMNS)));
            var _local_5:int = int(Math.ceil((_arg_2 / CalendarSettings.NUMBER_OF_COLUMNS)));
            if (_arg_1.dayNumber == 1)
            {
                if (_local_5 == 1)
                {
                    this.boxCuts = [1, 0, 0, 1];
                }
                else
                {
                    this.boxCuts = [1, 0, 0, 0];
                }
            }
            else
            {
                if (_arg_1.dayNumber == _arg_2)
                {
                    if (_local_5 == 1)
                    {
                        this.boxCuts = [0, 1, 1, 0];
                    }
                    else
                    {
                        this.boxCuts = [0, 0, 1, 0];
                    }
                }
                else
                {
                    if (((_local_4 == 1) && ((_arg_1.dayNumber % CalendarSettings.NUMBER_OF_COLUMNS) == 0)))
                    {
                        this.boxCuts = [0, 1, 0, 0];
                    }
                    else
                    {
                        if (((_local_4 == _local_5) && (((_arg_1.dayNumber - 1) % CalendarSettings.NUMBER_OF_COLUMNS) == 0)))
                        {
                            this.boxCuts = [0, 0, 0, 1];
                        }
                        else
                        {
                            this.boxCuts = [0, 0, 0, 0];
                        }
                    }
                }
            }
            this.drawBackground(this.boxCuts, _arg_3);
            if (((_arg_1.gold == 0) && (_arg_1.itemID > 0)))
            {
                _local_6 = new ItemTileRenderer(_arg_1.itemID);
                addChild(_local_6);
                _local_6.x = Math.round((CalendarSettings.BOX_WIDTH / 2));
                _local_6.y = Math.round((CalendarSettings.BOX_HEIGHT / 2));
            }
            if (_arg_1.gold > 0)
            {
                _local_7 = new Bitmap();
                _local_7.bitmapData = IconFactory.makeCoin(80);
                addChild(_local_7);
                _local_7.x = Math.round(((CalendarSettings.BOX_WIDTH / 2) - (_local_7.width / 2)));
                _local_7.y = Math.round(((CalendarSettings.BOX_HEIGHT / 2) - (_local_7.height / 2)));
            }
            this.displayDayNumber(_arg_1.dayNumber);
            if (_arg_1.claimKey != "")
            {
                _local_8 = AssetLibrary.getImageFromSet("lofiInterface", 52);
                _local_8.colorTransform(new Rectangle(0, 0, _local_8.width, _local_8.height), CalendarSettings.GREEN_COLOR_TRANSFORM);
                _local_8 = TextureRedrawer.redraw(_local_8, 40, true, 0);
                this.redDot = new Bitmap(_local_8);
                this.redDot.x = ((CalendarSettings.BOX_WIDTH - Math.round((this.redDot.width / 2))) - 10);
                this.redDot.y = (-(Math.round((this.redDot.width / 2))) + 10);
                addChild(this.redDot);
            }
            if (((_arg_1.quantity > 1) || (_arg_1.gold > 0)))
            {
                _local_9 = new TextFieldDisplayConcrete().setSize(14).setColor(0xFFFFFF).setTextWidth(CalendarSettings.BOX_WIDTH).setAutoSize(TextFieldAutoSize.RIGHT);
                _local_9.setStringBuilder(new StaticStringBuilder(("x" + ((_arg_1.gold > 0) ? _arg_1.gold.toString() : _arg_1.quantity.toString()))));
                _local_9.y = (CalendarSettings.BOX_HEIGHT - 18);
                _local_9.x = -2;
                addChild(_local_9);
            }
            if (_arg_1.isClaimed)
            {
                this.markAsClaimed();
            }
        }

        public static function drawRectangleWithCuts(_arg_1:Array, _arg_2:int, _arg_3:int, _arg_4:uint, _arg_5:Number, _arg_6:Vector.<IGraphicsData>, _arg_7:GraphicsPath):Sprite
        {
            var _local_8:Shape = new Shape();
            var _local_9:Shape = new Shape();
            var _local_10:Sprite = new Sprite();
            _local_10.addChild(_local_8);
            _local_10.addChild(_local_9);
            GraphicsUtil.clearPath(_arg_7);
            GraphicsUtil.drawCutEdgeRect(0, 0, _arg_2, _arg_3, 4, _arg_1, _arg_7);
            _local_8.graphics.clear();
            _local_8.graphics.drawGraphicsData(_arg_6);
            var _local_11:GraphicsSolidFill = new GraphicsSolidFill(_arg_4, _arg_5);
            GraphicsUtil.clearPath(_arg_7);
            var _local_12:Vector.<IGraphicsData> = new <IGraphicsData>[_local_11, _arg_7, GraphicsUtil.END_FILL];
            GraphicsUtil.drawCutEdgeRect(0, 0, _arg_2, _arg_3, 4, _arg_1, _arg_7);
            _local_9.graphics.drawGraphicsData(_local_12);
            _local_9.cacheAsBitmap = true;
            _local_9.visible = false;
            return (_local_10);
        }


        public function getDay():CalendarDayModel
        {
            return (this.day);
        }

        public function markAsClaimed():void
        {
            if (((this.redDot) && (this.redDot.parent)))
            {
                removeChild(this.redDot);
            }
            var _local_1:BitmapData = AssetLibrary.getImageFromSet("lofiInterfaceBig", 11);
            _local_1 = TextureRedrawer.redraw(_local_1, 60, true, 2997032);
            var _local_2:Bitmap = new Bitmap(_local_1);
            _local_2.x = Math.round(((CalendarSettings.BOX_WIDTH - _local_2.width) / 2));
            _local_2.y = Math.round(((CalendarSettings.BOX_HEIGHT - _local_2.height) / 2));
            var _local_3:Sprite = drawRectangleWithCuts(this.boxCuts, CalendarSettings.BOX_WIDTH, CalendarSettings.BOX_HEIGHT, 0, 1, this.graphicsDataClaimedOverlay, this.path_);
            addChild(_local_3);
            addChild(_local_2);
        }

        private function displayDayNumber(_arg_1:int):void
        {
            var _local_2:TextFieldDisplayConcrete;
            _local_2 = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth(CalendarSettings.BOX_WIDTH);
            _local_2.setBold(true);
            _local_2.setStringBuilder(new StaticStringBuilder(_arg_1.toString()));
            _local_2.x = 4;
            _local_2.y = 4;
            addChild(_local_2);
        }

        public function drawBackground(_arg_1:Array, _arg_2:Boolean):void
        {
            addChild(drawRectangleWithCuts(_arg_1, CalendarSettings.BOX_WIDTH, CalendarSettings.BOX_HEIGHT, 0x363636, 1, ((_arg_2) ? this.graphicsDataBackgroundCurrent : this.graphicsDataBackground), this.path_));
        }


    }
}//package kabam.rotmg.dailyLogin.view

