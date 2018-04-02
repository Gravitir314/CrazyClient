// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.map.partyoverlay.GameObjectArrow

package com.company.assembleegameclient.map.partyoverlay
{
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.menu.Menu;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.util.RectangleUtil;
import com.company.util.Trig;

import flash.display.DisplayObjectContainer;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.StageScaleMode;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.geom.Rectangle;

public class GameObjectArrow extends Sprite
    {

        public static const SMALL_SIZE:int = 8;
        public static const BIG_SIZE:int = 11;
        public static const DIST:int = 3;
        private static var menu_:Menu = null;

        public var menuLayer:DisplayObjectContainer;
        public var lineColor_:uint;
        public var fillColor_:uint;
        public var go_:GameObject = null;
        public var extraGOs_:Vector.<GameObject> = new Vector.<GameObject>();
        public var mouseOver_:Boolean = false;
        private var big_:Boolean;
        private var arrow_:Shape = new Shape();
        protected var tooltip_:ToolTip = null;
        private var tempPoint:Point = new Point();

        public function GameObjectArrow(_arg_1:uint, _arg_2:uint, _arg_3:Boolean)
        {
            this.lineColor_ = _arg_1;
            this.fillColor_ = _arg_2;
            this.big_ = _arg_3;
            addChild(this.arrow_);
            this.drawArrow();
            addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            addEventListener(MouseEvent.RIGHT_CLICK, this.onRightClick);
            filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
            visible = false;
        }

        public static function withDummy(_arg_1:Number, _arg_2:Number, _arg_3:String):GameObjectArrow
        {
            var _local_4:GameObjectArrow;
            _local_4 = new GameObjectArrow(6185471, 4145919, false);
            _local_4.go_ = new GameObject(null);
            _local_4.go_.x_ = _arg_1;
            _local_4.go_.y_ = _arg_2;
            _local_4.go_.name_ = _arg_3;
            return (_local_4);
        }

        public static function removeMenu():void
        {
            if (menu_ != null)
            {
                if (menu_.parent != null)
                {
                    menu_.parent.removeChild(menu_);
                };
                menu_ = null;
            };
        }


        protected function onRightClick(_arg_1:MouseEvent):void
        {
            var _local_2:int;
            var _local_3:String;
            var _local_4:GameObject;
            var _local_5:int;
            if ((this.go_ is Player))
            {
                this.go_.map_.gs_.gsc_.teleport(this.go_.name_);
            }
            else
            {
                _local_2 = int.MAX_VALUE;
                _local_3 = "";
                for each (_local_4 in this.go_.map_.goDict_)
                {
                    if ((_local_4 is Player))
                    {
                        _local_5 = (((_local_4.x_ - this.go_.x_) * (_local_4.x_ - this.go_.x_)) + ((_local_4.y_ - this.go_.y_) * (_local_4.y_ - this.go_.y_)));
                        if (_local_5 < _local_2)
                        {
                            _local_2 = _local_5;
                            _local_3 = _local_4.name_;
                        };
                    };
                };
                if (_local_3 == this.go_.map_.player_.name_)
                {
                    this.go_.map_.player_.notifyPlayer("You are the closest!", 0xFF00, 1500);
                    return;
                };
                this.go_.map_.gs_.gsc_.teleport(_local_3);
            };
        }

        protected function onMouseOver(_arg_1:MouseEvent):void
        {
            this.mouseOver_ = true;
            this.drawArrow();
        }

        protected function onMouseOut(_arg_1:MouseEvent):void
        {
            this.mouseOver_ = false;
            this.drawArrow();
        }

        protected function onMouseDown(_arg_1:MouseEvent):void
        {
            _arg_1.stopImmediatePropagation();
        }

        protected function setToolTip(_arg_1:ToolTip):void
        {
            this.removeTooltip();
            this.tooltip_ = _arg_1;
            if (this.tooltip_ != null)
            {
                addChild(this.tooltip_);
                this.positionTooltip(this.tooltip_);
            };
        }

        protected function removeTooltip():void
        {
            if (this.tooltip_ != null)
            {
                if (this.tooltip_.parent != null)
                {
                    this.tooltip_.parent.removeChild(this.tooltip_);
                };
                this.tooltip_ = null;
            };
        }

        protected function setMenu(_arg_1:Menu):void
        {
            this.removeTooltip();
            menu_ = _arg_1;
            this.menuLayer.addChild(menu_);
        }

        public function setGameObject(_arg_1:GameObject):void
        {
            if (this.go_ != _arg_1)
            {
                this.go_ = _arg_1;
            };
            this.extraGOs_.length = 0;
            if (this.go_ == null)
            {
                visible = false;
            };
        }

        public function addGameObject(_arg_1:GameObject):void
        {
            this.extraGOs_.push(_arg_1);
        }

        public function correctQuestNote(_arg_1:Rectangle):Rectangle
        {
            var _local_2:Rectangle = _arg_1.clone();
            if (((stage.scaleMode == StageScaleMode.NO_SCALE) && (Parameters.data_.uiscale)))
            {
                this.scaleY = (this.scaleX = ((((stage.stageWidth < stage.stageHeight) ? stage.stageWidth : stage.stageHeight) / Parameters.data_.mscale) / 600));
            }
            else
            {
                this.scaleX = 1;
                this.scaleY = 1;
            };
            _local_2.right = (_local_2.right - ((((800 - this.go_.map_.gs_.hudView.x) * stage.stageWidth) / Parameters.data_.mscale) / 800));
            return (_local_2);
        }

        public function draw(_arg_1:int, _arg_2:Camera):void
        {
            var _local_3:Rectangle;
            var _local_4:Number;
            var _local_5:Number;
            if (this.go_ == null)
            {
                visible = false;
                return;
            };
            this.go_.computeSortVal(_arg_2);
            _local_3 = this.correctQuestNote(_arg_2.clipRect_);
            _local_4 = this.go_.posS_[0];
            _local_5 = this.go_.posS_[1];
            if (!RectangleUtil.lineSegmentIntersectXY(_local_3, 0, 0, _local_4, _local_5, this.tempPoint))
            {
                this.go_ = null;
                visible = false;
                return;
            };
            x = this.tempPoint.x;
            y = this.tempPoint.y;
            var _local_6:Number = Trig.boundTo180((270 - (Trig.toDegrees * Math.atan2(_local_4, _local_5))));
            if (this.tempPoint.x < (_local_3.left + 5))
            {
                if (_local_6 > 45)
                {
                    _local_6 = 45;
                };
                if (_local_6 < -45)
                {
                    _local_6 = -45;
                };
            }
            else
            {
                if (this.tempPoint.x > (_local_3.right - 5))
                {
                    if (_local_6 > 0)
                    {
                        if (_local_6 < 135)
                        {
                            _local_6 = 135;
                        };
                    }
                    else
                    {
                        if (_local_6 > -135)
                        {
                            _local_6 = -135;
                        };
                    };
                };
            };
            if (this.tempPoint.y < (_local_3.top + 5))
            {
                if (_local_6 < 45)
                {
                    _local_6 = 45;
                };
                if (_local_6 > 135)
                {
                    _local_6 = 135;
                };
            }
            else
            {
                if (this.tempPoint.y > (_local_3.bottom - 5))
                {
                    if (_local_6 > -45)
                    {
                        _local_6 = -45;
                    };
                    if (_local_6 < -135)
                    {
                        _local_6 = -135;
                    };
                };
            };
            this.arrow_.rotation = _local_6;
            if (this.tooltip_ != null)
            {
                this.positionTooltip(this.tooltip_);
            };
            visible = true;
        }

        private function positionTooltip(_arg_1:ToolTip):void
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number = this.arrow_.rotation;
            var _local_6:int = ((DIST + BIG_SIZE) + 12);
            var _local_7:Number = (_local_6 * Math.cos((_local_5 * Trig.toRadians)));
            _local_2 = (_local_6 * Math.sin((_local_5 * Trig.toRadians)));
            var _local_8:Number = _arg_1.contentWidth_;
            var _local_9:Number = _arg_1.contentHeight_;
            if (((_local_5 >= 45) && (_local_5 <= 135)))
            {
                _local_3 = (_local_7 + (_local_8 / Math.tan((_local_5 * Trig.toRadians))));
                _arg_1.x = (((_local_7 + _local_3) / 2) - (_local_8 / 2));
                _arg_1.y = _local_2;
            }
            else
            {
                if (((_local_5 <= -45) && (_local_5 >= -135)))
                {
                    _local_3 = (_local_7 - (_local_8 / Math.tan((_local_5 * Trig.toRadians))));
                    _arg_1.x = (((_local_7 + _local_3) / 2) - (_local_8 / 2));
                    _arg_1.y = (_local_2 - _local_9);
                }
                else
                {
                    if (((_local_5 < 45) && (_local_5 > -45)))
                    {
                        _arg_1.x = _local_7;
                        _local_4 = (_local_2 + (_local_9 * Math.tan((_local_5 * Trig.toRadians))));
                        _arg_1.y = (((_local_2 + _local_4) / 2) - (_local_9 / 2));
                    }
                    else
                    {
                        _arg_1.x = (_local_7 - _local_8);
                        _local_4 = (_local_2 - (_local_9 * Math.tan((_local_5 * Trig.toRadians))));
                        _arg_1.y = (((_local_2 + _local_4) / 2) - (_local_9 / 2));
                    };
                };
            };
        }

        private function drawArrow():void
        {
            var _local_1:Graphics = this.arrow_.graphics;
            _local_1.clear();
            var _local_2:int = (((this.big_) || (this.mouseOver_)) ? BIG_SIZE : SMALL_SIZE);
            _local_1.lineStyle(1, this.lineColor_);
            _local_1.beginFill(this.fillColor_);
            _local_1.moveTo(DIST, 0);
            _local_1.lineTo((_local_2 + DIST), _local_2);
            _local_1.lineTo((_local_2 + DIST), -(_local_2));
            _local_1.lineTo(DIST, 0);
            _local_1.endFill();
            _local_1.lineStyle();
        }


    }
}//package com.company.assembleegameclient.map.partyoverlay

