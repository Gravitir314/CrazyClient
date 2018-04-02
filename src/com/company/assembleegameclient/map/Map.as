// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.map.Map

package com.company.assembleegameclient.map
{
import com.company.assembleegameclient.background.Background;
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.game.MapUserInput;
import com.company.assembleegameclient.map.mapoverlay.MapOverlay;
import com.company.assembleegameclient.map.partyoverlay.PartyOverlay;
import com.company.assembleegameclient.objects.BasicObject;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Party;
import com.company.assembleegameclient.objects.particles.ParticleEffect;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.ConditionEffect;

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.StageScaleMode;
import flash.filters.BlurFilter;
import flash.filters.ColorMatrixFilter;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

import kabam.rotmg.assets.EmbeddedAssets;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.logging.RollingMeanLoopMonitor;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.stage3D.GraphicsFillExtra;
import kabam.rotmg.stage3D.Object3D.Object3DStage3D;
import kabam.rotmg.stage3D.Render3D;
import kabam.rotmg.stage3D.Renderer;
import kabam.rotmg.stage3D.graphic3D.Program3DFactory;
import kabam.rotmg.stage3D.graphic3D.TextureFactory;

import org.swiftsuspenders.Injector;

public class Map extends AbstractMap
    {

        public static const CLOTH_BAZAAR:String = "Cloth Bazaar";
        public static const NEXUS:String = "Nexus";
        public static const DAILY_QUEST_ROOM:String = "Daily Quest Room";
        public static const PET_YARD_1:String = "Pet Yard";
        public static const PET_YARD_2:String = "Pet Yard 2";
        public static const PET_YARD_3:String = "Pet Yard 3";
        public static const PET_YARD_4:String = "Pet Yard 4";
        public static const PET_YARD_5:String = "Pet Yard 5";
        public static const GUILD_HALL:String = "Guild Hall";
        public static const NEXUS_EXPLANATION:String = "Nexus_Explanation";
        public static const VAULT:String = "Vault";
        public static var forceSoftwareRender:Boolean = false;
        private static const VISIBLE_SORT_FIELDS:Array = ["sortVal_", "objectId_"];
        private static const VISIBLE_SORT_PARAMS:Array = [Array.NUMERIC, Array.NUMERIC];
        protected static const BLIND_FILTER:ColorMatrixFilter = new ColorMatrixFilter([0.05, 0.05, 0.05, 0, 0, 0.05, 0.05, 0.05, 0, 0, 0.05, 0.05, 0.05, 0, 0, 0.05, 0.05, 0.05, 1, 0]);
        protected static var BREATH_CT:ColorTransform = new ColorTransform((0xFF / 0xFF), (55 / 0xFF), (0 / 0xFF), 0);
        public static var texture:BitmapData;

        public var ifDrawEffectFlag:Boolean = true;
        private var loopMonitor:RollingMeanLoopMonitor;
        private var inUpdate_:Boolean = false;
        private var objsToAdd_:Vector.<BasicObject> = new Vector.<BasicObject>();
        private var idsToRemove_:Vector.<int> = new Vector.<int>();
        private var forceSoftwareMap:Dictionary = new Dictionary();
        private var lastSoftwareClear:Boolean = false;
        private var darkness:DisplayObject = new EmbeddedAssets.DarknessBackground();
        private var graphicsData_:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
        private var graphicsDataStageSoftware_:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
        private var graphicsData3d_:Vector.<Object3DStage3D> = new Vector.<Object3DStage3D>();
        public var visible_:Array = [];
        public var visibleUnder_:Array = [];
        public var visibleSquares_:Vector.<Square> = new Vector.<Square>();
        public var topSquares_:Vector.<Square> = new Vector.<Square>();
        private var addTextLine:AddTextLineSignal;

        public function Map(_arg_1:AGameSprite)
        {
            var _local_2:Injector = StaticInjectorContext.getInjector();
            super();
            gs_ = _arg_1;
            hurtOverlay_ = new HurtOverlay();
            gradientOverlay_ = new GradientOverlay();
            mapOverlay_ = new MapOverlay();
            partyOverlay_ = new PartyOverlay(this);
            party_ = new Party(this);
            quest_ = new Quest(this);
            this.loopMonitor = StaticInjectorContext.getInjector().getInstance(RollingMeanLoopMonitor);
            _local_2.getInstance(GameModel).gameObjects = goDict_;
            this.addTextLine = _local_2.getInstance(AddTextLineSignal);
            wasLastFrameGpu = Parameters.isGpuRender();
        }

        override public function setProps(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:Boolean, _arg_6:Boolean):void
        {
            width_ = _arg_1;
            height_ = _arg_2;
            name_ = _arg_3;
            back_ = _arg_4;
            allowPlayerTeleport_ = _arg_5;
            showDisplays_ = _arg_6;
            this.forceSoftwareRenderCheck(name_);
        }

        private function forceSoftwareRenderCheck(_arg_1:String):void
        {
            forceSoftwareRender = true;
        }

        override public function initialize():void
        {
            squares_.length = (width_ * height_);
            background_ = Background.getBackground(back_);
            if (background_ != null)
            {
                addChild(background_);
            };
            addChild(map_);
            addChild(hurtOverlay_);
            addChild(gradientOverlay_);
            addChild(mapOverlay_);
            addChild(partyOverlay_);
            isPetYard = (name_.substr(0, 8) == "Pet Yard");
        }

        override public function dispose():void
        {
            var _local_1:Square;
            var _local_2:GameObject;
            var _local_3:BasicObject;
            gs_ = null;
            background_ = null;
            map_ = null;
            hurtOverlay_ = null;
            gradientOverlay_ = null;
            mapOverlay_ = null;
            partyOverlay_ = null;
            for each (_local_1 in squareList_)
            {
                _local_1.dispose();
            };
            squareList_.length = 0;
            squareList_ = null;
            squares_.length = 0;
            squares_ = null;
            for each (_local_2 in goDict_)
            {
                _local_2.dispose();
            };
            goDict_ = null;
            for each (_local_3 in boDict_)
            {
                _local_3.dispose();
            };
            boDict_ = null;
            merchLookup_ = null;
            player_ = null;
            party_ = null;
            quest_ = null;
            this.objsToAdd_ = null;
            this.idsToRemove_ = null;
            TextureFactory.disposeTextures();
            GraphicsFillExtra.dispose();
            Program3DFactory.getInstance().dispose();
        }

        override public function update(_arg_1:int, _arg_2:int):void
        {
            var _local_3:BasicObject;
            var _local_4:int;
            this.inUpdate_ = true;
            for each (_local_3 in goDict_)
            {
                if (!_local_3.update(_arg_1, _arg_2))
                {
                    this.idsToRemove_.push(_local_3.objectId_);
                };
            };
            for each (_local_3 in boDict_)
            {
                if (!_local_3.update(_arg_1, _arg_2))
                {
                    this.idsToRemove_.push(_local_3.objectId_);
                };
            };
            this.inUpdate_ = false;
            for each (_local_3 in this.objsToAdd_)
            {
                this.internalAddObj(_local_3);
            };
            this.objsToAdd_.length = 0;
            for each (_local_4 in this.idsToRemove_)
            {
                this.internalRemoveObj(_local_4);
            };
            this.idsToRemove_.length = 0;
            party_.update(_arg_1, _arg_2);
        }

        override public function pSTopW(_arg_1:Number, _arg_2:Number):Point
        {
            var _local_3:Square;
            for each (_local_3 in this.visibleSquares_)
            {
                if (((!(_local_3.faces_.length == 0)) && (_local_3.faces_[0].face_.contains(_arg_1, _arg_2))))
                {
                    return (new Point(_local_3.center_.x, _local_3.center_.y));
                };
            };
            return (null);
        }

        override public function setGroundTile(_arg_1:int, _arg_2:int, _arg_3:uint):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:Square;
            var _local_7:Square = this.getSquare(_arg_1, _arg_2);
            _local_7.setTileType(_arg_3);
            var _local_8:int = ((_arg_1 < (width_ - 1)) ? int((_arg_1 + 1)) : int(_arg_1));
            var _local_9:int = ((_arg_2 < (height_ - 1)) ? int((_arg_2 + 1)) : int(_arg_2));
            var _local_10:int = ((_arg_1 > 0) ? int((_arg_1 - 1)) : int(_arg_1));
            while (_local_10 <= _local_8)
            {
                _local_4 = ((_arg_2 > 0) ? int((_arg_2 - 1)) : int(_arg_2));
                while (_local_4 <= _local_9)
                {
                    _local_5 = (_local_10 + (_local_4 * width_));
                    _local_6 = squares_[_local_5];
                    if (((!(_local_6 == null)) && ((_local_6.props_.hasEdge_) || (!(_local_6.tileType_ == _arg_3)))))
                    {
                        _local_6.faces_.length = 0;
                    };
                    _local_4++;
                };
                _local_10++;
            };
        }

        override public function addObj(_arg_1:BasicObject, _arg_2:Number, _arg_3:Number):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.x_ = _arg_2;
            _arg_1.y_ = _arg_3;
            if ((_arg_1 is ParticleEffect))
            {
                (_arg_1 as ParticleEffect).reducedDrawEnabled = (!(Parameters.data_.particleEffect));
            };
            if (this.inUpdate_)
            {
                this.objsToAdd_.push(_arg_1);
            }
            else
            {
                this.internalAddObj(_arg_1);
            };
        }

        public function internalAddObj(_arg_1:BasicObject):void
        {
            if (!_arg_1.addTo(this, _arg_1.x_, _arg_1.y_))
            {
                return;
            };
            var _local_2:Dictionary = ((_arg_1 is GameObject) ? goDict_ : boDict_);
            if (_local_2[_arg_1.objectId_] != null)
            {
                if (!isPetYard)
                {
                    return;
                };
            };
            _local_2[_arg_1.objectId_] = _arg_1;
        }

        override public function removeObj(_arg_1:int):void
        {
            if (this.inUpdate_)
            {
                this.idsToRemove_.push(_arg_1);
            }
            else
            {
                this.internalRemoveObj(_arg_1);
            };
        }

        public function internalRemoveObj(_arg_1:int):void
        {
            var _local_2:Dictionary = goDict_;
            var _local_3:BasicObject = _local_2[_arg_1];
            if (_local_3 == null)
            {
                _local_2 = boDict_;
                _local_3 = _local_2[_arg_1];
                if (_local_3 == null)
                {
                    return;
                };
            };
            _local_3.removeFromMap();
            delete _local_2[_arg_1];
        }

        public function getSquare(_arg_1:Number, _arg_2:Number):Square
        {
            if (((((_arg_1 < 0) || (_arg_1 >= width_)) || (_arg_2 < 0)) || (_arg_2 >= height_)))
            {
                return (null);
            };
            var _local_3:int = (int(_arg_1) + (int(_arg_2) * width_));
            var _local_4:Square = squares_[_local_3];
            if (_local_4 == null)
            {
                _local_4 = new Square(this, int(_arg_1), int(_arg_2));
                squares_[_local_3] = _local_4;
                squareList_.push(_local_4);
            };
            return (_local_4);
        }

        public function lookupSquare(_arg_1:int, _arg_2:int):Square
        {
            if (((((_arg_1 < 0) || (_arg_1 >= width_)) || (_arg_2 < 0)) || (_arg_2 >= height_)))
            {
                return (null);
            };
            return (squares_[(_arg_1 + (_arg_2 * width_))]);
        }

        public function correctMapView(_arg_1:Camera):Point
        {
            var _local_2:Rectangle = _arg_1.clipRect_;
            if (stage.scaleMode == StageScaleMode.NO_SCALE)
            {
                x = ((-(_local_2.x) * 800) / (WebMain.sWidth / Parameters.data_.mscale));
                y = ((-(_local_2.y) * 600) / (WebMain.sHeight / Parameters.data_.mscale));
            }
            else
            {
                x = (-(_local_2.x) * Parameters.data_.mscale);
                y = (-(_local_2.y) * Parameters.data_.mscale);
            };
            var _local_3:Number = ((-(_local_2.x) - (_local_2.width / 2)) / 50);
            var _local_4:Number = ((-(_local_2.y) - (_local_2.height / 2)) / 50);
            var _local_5:Number = Math.sqrt(((_local_3 * _local_3) + (_local_4 * _local_4)));
            var _local_6:Number = ((_arg_1.angleRad_ - (Math.PI / 2)) - Math.atan2(_local_3, _local_4));
            return (new Point((_arg_1.x_ + (_local_5 * Math.cos(_local_6))), (_arg_1.y_ + (_local_5 * Math.sin(_local_6)))));
        }

        override public function draw(_arg_1:Camera, _arg_2:int):void
        {
            var _local_3:Square;
            var _local_4:GameObject;
            var _local_5:BasicObject;
            var _local_6:int;
            var _local_12:uint;
            var _local_13:Render3D;
            var _local_14:int;
            var _local_15:Array;
            var _local_7:Number = NaN;
            var _local_8:Number = NaN;
            var _local_9:Number = NaN;
            var _local_10:Number = NaN;
            var _local_11:Number = NaN;
            var _local_16:Number = NaN;
            if (MapUserInput.skipRender)
            {
                return;
            };
            if (wasLastFrameGpu != Parameters.isGpuRender())
            {
                if ((((wasLastFrameGpu == true) && (!(WebMain.STAGE.stage3Ds[0].context3D == null))) && (!((!(WebMain.STAGE.stage3Ds[0].context3D == null)) && (!(WebMain.STAGE.stage3Ds[0].context3D.driverInfo.toLowerCase().indexOf("disposed") == -1))))))
                {
                    WebMain.STAGE.stage3Ds[0].context3D.clear();
                    WebMain.STAGE.stage3Ds[0].context3D.present();
                }
                else
                {
                    map_.graphics.clear();
                };
                signalRenderSwitch.dispatch(wasLastFrameGpu);
                wasLastFrameGpu = Parameters.isGpuRender();
            };
            var _local_17:Rectangle = _arg_1.clipRect_;
            x = -(_local_17.x);
            y = -(_local_17.y);
            var _local_18:Number = ((-(_local_17.y) - (_local_17.height / 2)) / 50);
            var _local_19:Point = this.correctMapView(_arg_1);
            this.visible_.length = 0;
            this.visibleUnder_.length = 0;
            this.visibleSquares_.length = 0;
            this.topSquares_.length = 0;
            var _local_20:int = _arg_1.maxDist_;
            var _local_21:int = Math.max(0, (_local_19.x - _local_20));
            var _local_22:int = Math.min((width_ - 1), (_local_19.x + _local_20));
            var _local_23:int = Math.max(0, (_local_19.y - _local_20));
            var _local_24:int = Math.min((height_ - 1), (_local_19.y + _local_20));
            this.graphicsData_.length = 0;
            this.graphicsDataStageSoftware_.length = 0;
            this.graphicsData3d_.length = 0;
            var _local_25:int = _local_21;
            while (_local_25 <= _local_22)
            {
                _local_6 = _local_23;
                while (_local_6 <= _local_24)
                {
                    _local_3 = squares_[(_local_25 + (_local_6 * width_))];
                    if (_local_3 != null)
                    {
                        _local_7 = (_local_19.x - _local_3.center_.x);
                        _local_8 = (_local_19.y - _local_3.center_.y);
                        _local_9 = ((_local_7 * _local_7) + (_local_8 * _local_8));
                        if (_local_9 <= _arg_1.maxDistSq_)
                        {
                            _local_3.lastVisible_ = _arg_2;
                            _local_3.draw(this.graphicsData_, _arg_1, _arg_2);
                            this.visibleSquares_.push(_local_3);
                            if (_local_3.topFace_ != null)
                            {
                                this.topSquares_.push(_local_3);
                            };
                        };
                    };
                    _local_6++;
                };
                _local_25++;
            };
            for each (_local_4 in goDict_)
            {
                _local_4.drawn_ = false;
                if (!_local_4.dead_)
                {
                    _local_3 = _local_4.square_;
                    if (!((_local_3 == null) || (!(_local_3.lastVisible_ == _arg_2))))
                    {
                        _local_4.drawn_ = true;
                        _local_4.computeSortVal(_arg_1);
                        if (_local_4.props_.drawUnder_)
                        {
                            if (_local_4.props_.drawOnGround_)
                            {
                                _local_4.draw(this.graphicsData_, _arg_1, _arg_2);
                            }
                            else
                            {
                                this.visibleUnder_.push(_local_4);
                            };
                        }
                        else
                        {
                            this.visible_.push(_local_4);
                        };
                    };
                };
            };
            for each (_local_5 in boDict_)
            {
                _local_5.drawn_ = false;
                _local_3 = _local_5.square_;
                if (!((_local_3 == null) || (!(_local_3.lastVisible_ == _arg_2))))
                {
                    _local_5.drawn_ = true;
                    _local_5.computeSortVal(_arg_1);
                    this.visible_.push(_local_5);
                };
            };
            if (this.visibleUnder_.length > 0)
            {
                this.visibleUnder_.sortOn(VISIBLE_SORT_FIELDS, VISIBLE_SORT_PARAMS);
                for each (_local_5 in this.visibleUnder_)
                {
                    _local_5.draw(this.graphicsData_, _arg_1, _arg_2);
                };
            };
            this.visible_.sortOn(VISIBLE_SORT_FIELDS, VISIBLE_SORT_PARAMS);
            if (Parameters.data_.drawShadows)
            {
                for each (_local_5 in this.visible_)
                {
                    if (_local_5.hasShadow_)
                    {
                        _local_5.drawShadow(this.graphicsData_, _arg_1, _arg_2);
                    };
                };
            };
            for each (_local_5 in this.visible_)
            {
                _local_5.draw(this.graphicsData_, _arg_1, _arg_2);
                if (Parameters.isGpuRender())
                {
                    _local_5.draw3d(this.graphicsData3d_);
                };
            };
            if (this.topSquares_.length > 0)
            {
                for each (_local_3 in this.topSquares_)
                {
                    _local_3.drawTop(this.graphicsData_, _arg_1, _arg_2);
                };
            };
            if ((((!(player_ == null)) && (player_.breath_ >= 0)) && (player_.breath_ < Parameters.BREATH_THRESH)))
            {
                _local_10 = ((Parameters.BREATH_THRESH - player_.breath_) / Parameters.BREATH_THRESH);
                _local_11 = (Math.abs(Math.sin((_arg_2 / 300))) * 0.75);
                BREATH_CT.alphaMultiplier = (_local_10 * _local_11);
                hurtOverlay_.transform.colorTransform = BREATH_CT;
                hurtOverlay_.visible = true;
                hurtOverlay_.x = _local_17.left;
                hurtOverlay_.y = _local_17.top;
            }
            else
            {
                hurtOverlay_.visible = false;
            };
            if (((!(player_ == null)) && (!(Parameters.screenShotMode_))))
            {
                gradientOverlay_.visible = true;
                gradientOverlay_.x = (_local_17.right - 10);
                gradientOverlay_.y = _local_17.top;
            }
            else
            {
                gradientOverlay_.visible = false;
            };
            if (((Parameters.isGpuRender()) && (Renderer.inGame)))
            {
                _local_12 = this.getFilterIndex();
                _local_13 = StaticInjectorContext.getInjector().getInstance(Render3D);
                _local_13.dispatch(this.graphicsData_, this.graphicsData3d_, width_, height_, _arg_1, _local_12);
                _local_14 = 0;
                while (_local_14 < this.graphicsData_.length)
                {
                    if (((this.graphicsData_[_local_14] is GraphicsBitmapFill) && (GraphicsFillExtra.isSoftwareDraw(GraphicsBitmapFill(this.graphicsData_[_local_14])))))
                    {
                        this.graphicsDataStageSoftware_.push(this.graphicsData_[_local_14]);
                        this.graphicsDataStageSoftware_.push(this.graphicsData_[(_local_14 + 1)]);
                        this.graphicsDataStageSoftware_.push(this.graphicsData_[(_local_14 + 2)]);
                    }
                    else
                    {
                        if (((this.graphicsData_[_local_14] is GraphicsSolidFill) && (GraphicsFillExtra.isSoftwareDrawSolid(GraphicsSolidFill(this.graphicsData_[_local_14])))))
                        {
                            this.graphicsDataStageSoftware_.push(this.graphicsData_[_local_14]);
                            this.graphicsDataStageSoftware_.push(this.graphicsData_[(_local_14 + 1)]);
                            this.graphicsDataStageSoftware_.push(this.graphicsData_[(_local_14 + 2)]);
                        };
                    };
                    _local_14++;
                };
                if (this.graphicsDataStageSoftware_.length > 0)
                {
                    map_.graphics.clear();
                    map_.graphics.drawGraphicsData(this.graphicsDataStageSoftware_);
                    if (this.lastSoftwareClear)
                    {
                        this.lastSoftwareClear = false;
                    };
                }
                else
                {
                    if (!this.lastSoftwareClear)
                    {
                        map_.graphics.clear();
                        this.lastSoftwareClear = true;
                    };
                };
                if ((_arg_2 % 149) == 0)
                {
                    GraphicsFillExtra.manageSize();
                };
            }
            else
            {
                map_.graphics.clear();
                map_.graphics.drawGraphicsData(this.graphicsData_);
            };
            map_.filters.length = 0;
            if (((!(player_ == null)) && (!((player_.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.MAP_FILTER_BITMASK) == 0))))
            {
                _local_15 = [];
                if (player_.isDrunk())
                {
                    _local_16 = (20 + (10 * Math.sin((_arg_2 / 1000))));
                    _local_15.push(new BlurFilter(_local_16, _local_16));
                };
                if (player_.isBlind())
                {
                    _local_15.push(BLIND_FILTER);
                };
                map_.filters = _local_15;
            }
            else
            {
                if (map_.filters.length > 0)
                {
                    map_.filters = [];
                };
            };
            mapOverlay_.draw(_arg_1, _arg_2);
            partyOverlay_.draw(_arg_1, _arg_2);
            if (((player_) && (player_.isDarkness())))
            {
                this.darkness.x = -300;
                this.darkness.y = ((Parameters.data_.centerOnPlayer) ? Number(-525) : Number(-515));
                this.darkness.alpha = 0.95;
                addChild(this.darkness);
            }
            else
            {
                if (contains(this.darkness))
                {
                    removeChild(this.darkness);
                };
            };
        }

        private function getFilterIndex():uint
        {
            var _local_1:uint;
            if (((!(player_ == null)) && (!((player_.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.MAP_FILTER_BITMASK) == 0))))
            {
                if (player_.isPaused())
                {
                    _local_1 = Renderer.STAGE3D_FILTER_PAUSE;
                }
                else
                {
                    if (player_.isBlind())
                    {
                        _local_1 = Renderer.STAGE3D_FILTER_BLIND;
                    }
                    else
                    {
                        if (player_.isDrunk())
                        {
                            _local_1 = Renderer.STAGE3D_FILTER_DRUNK;
                        };
                    };
                };
            };
            return (_local_1);
        }


    }
}//package com.company.assembleegameclient.map

