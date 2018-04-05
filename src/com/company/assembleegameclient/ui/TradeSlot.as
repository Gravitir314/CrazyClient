// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.TradeSlot

package com.company.assembleegameclient.ui
{
import com.company.assembleegameclient.constants.InventoryOwnerTypes;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.util.GraphicsUtil;
import com.company.util.MoreColorUtil;
import com.company.util.SpriteUtil;

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
import flash.geom.Matrix;
import flash.geom.Point;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;

public class TradeSlot extends Slot implements TooltipAble
    {

        private static const IDENTITY_MATRIX:Matrix = new Matrix();
        public static const EMPTY:int = -1;
        private static const DOSE_MATRIX:Matrix = makeDoseMatrix();

        public const hoverTooltipDelegate:HoverTooltipDelegate = new HoverTooltipDelegate();

        public var included_:Boolean;
        public var equipmentToolTipFactory:EquipmentToolTipFactory = new EquipmentToolTipFactory();
        private var id:uint;
        public var item_:int;
        private var overlay_:Shape;
        private var overlayFill_:GraphicsSolidFill = new GraphicsSolidFill(16711310, 1);
        private var lineStyle_:GraphicsStroke = new GraphicsStroke(2, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, overlayFill_);
        private var overlayPath_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        private var graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_, overlayPath_, GraphicsUtil.END_STROKE];
        private var bitmapFactory:BitmapTextFactory;

        public function TradeSlot(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean, _arg_4:int, _arg_5:int, _arg_6:Array, _arg_7:uint)
        {
            super(_arg_4, _arg_5, _arg_6);
            this.id = _arg_7;
            this.item_ = _arg_1;
            this.included_ = _arg_3;
            this.drawItemIfAvailable();
            if (!_arg_2)
            {
                transform.colorTransform = MoreColorUtil.veryDarkCT;
            }
            this.overlay_ = this.getOverlay();
            addChild(this.overlay_);
            this.setIncluded(_arg_3);
            this.hoverTooltipDelegate.setDisplayObject(this);
        }

        private static function makeDoseMatrix():Matrix
        {
            var _local_1:Matrix = new Matrix();
            _local_1.translate(10, 5);
            return (_local_1);
        }


        private function drawItemIfAvailable():void
        {
            if (!this.isEmpty())
            {
                this.drawItem();
            }
        }

        private function drawItem():void
        {
            var _local_1:Bitmap;
            var _local_2:BitmapData;
            SpriteUtil.safeRemoveChild(this, backgroundImage_);
            var _local_3:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this.item_, 80, true);
            var _local_4:XML = ObjectLibrary.xmlLibrary_[this.item_];
            if (((_local_4.hasOwnProperty("Doses")) && (this.bitmapFactory)))
            {
                _local_3 = _local_3.clone();
                _local_2 = this.bitmapFactory.make(new StaticStringBuilder(String(_local_4.Doses)), 12, 0xFFFFFF, false, IDENTITY_MATRIX, false);
                _local_3.draw(_local_2, DOSE_MATRIX);
            }
            if (((_local_4.hasOwnProperty("Quantity")) && (this.bitmapFactory)))
            {
                _local_3 = _local_3.clone();
                _local_2 = this.bitmapFactory.make(new StaticStringBuilder(String(_local_4.Quantity)), 12, 0xFFFFFF, false, IDENTITY_MATRIX, false);
                _local_3.draw(_local_2, DOSE_MATRIX);
            }
            var _local_5:Point = offsets(this.item_, type_, false);
            _local_1 = new Bitmap(_local_3);
            _local_1.x = (((WIDTH / 2) - (_local_1.width / 2)) + _local_5.x);
            _local_1.y = (((HEIGHT / 2) - (_local_1.height / 2)) + _local_5.y);
            SpriteUtil.safeAddChild(this, _local_1);
        }

        public function setIncluded(_arg_1:Boolean):void
        {
            this.included_ = _arg_1;
            this.overlay_.visible = this.included_;
            if (this.included_)
            {
                fill_.color = 16764247;
            }
            else
            {
                fill_.color = 0x545454;
            }
            drawBackground();
        }

        public function setBitmapFactory(_arg_1:BitmapTextFactory):void
        {
            this.bitmapFactory = _arg_1;
            this.drawItemIfAvailable();
        }

        private function getOverlay():Shape
        {
            var _local_1:Shape = new Shape();
            GraphicsUtil.clearPath(this.overlayPath_);
            GraphicsUtil.drawCutEdgeRect(0, 0, WIDTH, HEIGHT, 4, cuts_, this.overlayPath_);
            _local_1.graphics.drawGraphicsData(this.graphicsData_);
            return (_local_1);
        }

        public function setShowToolTipSignal(_arg_1:ShowTooltipSignal):void
        {
            this.hoverTooltipDelegate.setShowToolTipSignal(_arg_1);
        }

        public function getShowToolTip():ShowTooltipSignal
        {
            return (this.hoverTooltipDelegate.getShowToolTip());
        }

        public function setHideToolTipsSignal(_arg_1:HideTooltipsSignal):void
        {
            this.hoverTooltipDelegate.setHideToolTipsSignal(_arg_1);
        }

        public function getHideToolTips():HideTooltipsSignal
        {
            return (this.hoverTooltipDelegate.getHideToolTips());
        }

        public function setPlayer(_arg_1:Player):void
        {
            if (!this.isEmpty())
            {
                this.hoverTooltipDelegate.tooltip = this.equipmentToolTipFactory.make(this.item_, _arg_1, -1, InventoryOwnerTypes.OTHER_PLAYER, this.id);
            }
        }

        public function isEmpty():Boolean
        {
            return (this.item_ == EMPTY);
        }


    }
}//package com.company.assembleegameclient.ui

