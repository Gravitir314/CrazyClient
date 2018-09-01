﻿//com.company.assembleegameclient.objects.Projectile

package com.company.assembleegameclient.objects
{
import com.company.assembleegameclient.engine3d.Point3D;
import com.company.assembleegameclient.game.MapUserInput;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.objects.particles.HitEffect;
import com.company.assembleegameclient.objects.particles.SparkParticle;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.BloodComposition;
import com.company.assembleegameclient.util.FreeList;
import com.company.assembleegameclient.util.RandomUtil;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.GraphicsUtil;
import com.company.util.Trig;

import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.GraphicsGradientFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.utils.Dictionary;

public class Projectile extends BasicObject
{

	private static var objBullIdToObjId_:Dictionary = new Dictionary();

	public var props_:ObjectProperties;
	public var containerProps_:ObjectProperties;
	public var projProps_:ProjectileProperties;
	public var texture_:BitmapData;
	public var bulletId_:uint;
	public var ownerId_:int;
	public var containerType_:int;
	public var bulletType_:uint;
	public var damagesEnemies_:Boolean;
	public var damagesPlayers_:Boolean;
	public var damage_:int;
	public var sound_:String;
	public var startX_:Number;
	public var startY_:Number;
	public var startTime_:int;
	public var angle_:Number = 0;
	public var multiHitDict_:Dictionary;
	public var p_:Point3D = new Point3D(100);
	private var staticPoint_:Point = new Point();
	private var staticVector3D_:Vector3D = new Vector3D();
	protected var shadowGradientFill_:GraphicsGradientFill = new GraphicsGradientFill(GradientType.RADIAL, [0, 0], [0.5, 0], null, new Matrix());
	protected var shadowPath_:GraphicsPath = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());


	public static function findObjId(_arg_1:int, _arg_2:uint):int
	{
		return (objBullIdToObjId_[((_arg_2 << 24) | _arg_1)]);
	}

	public static function removeObjId(_arg_1:int, _arg_2:uint):void
	{
		delete objBullIdToObjId_[((_arg_2 << 24) | _arg_1)];
	}

	public static function dispose():void
	{
		objBullIdToObjId_ = new Dictionary();
	}

	public static function getNewObjId(_arg_1:int, _arg_2:uint):int
	{
		var _local_3:int = getNextFakeObjectId();
		objBullIdToObjId_[((_arg_2 << 24) | _arg_1)] = _local_3;
		return (_local_3);
	}


	public function reset(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Number, _arg_6:int, _arg_7:String = "", _arg_8:String = ""):void
	{
		var _local_9:Number;
		clear();
		this.containerType_ = _arg_1;
		this.bulletType_ = _arg_2;
		this.ownerId_ = _arg_3;
		this.bulletId_ = _arg_4;
		this.angle_ = Trig.boundToPI(_arg_5);
		this.startTime_ = _arg_6;
		objectId_ = getNewObjId(this.ownerId_, this.bulletId_);
		z_ = 0.5;
		this.containerProps_ = ObjectLibrary.propsLibrary_[this.containerType_];
		this.projProps_ = this.containerProps_.projectiles_[_arg_2];
		var _local_10:String = (((!(_arg_7 == "")) && (this.projProps_.objectId_ == _arg_8)) ? _arg_7 : this.projProps_.objectId_);
		this.props_ = ObjectLibrary.getPropsFromId(_local_10);
		hasShadow_ = (this.props_.shadowSize_ > 0);
		var _local_11:TextureData = ObjectLibrary.typeToTextureData_[this.props_.type_];
		this.texture_ = _local_11.getTexture(objectId_);
		this.damagesPlayers_ = this.containerProps_.isEnemy_;
		this.damagesEnemies_ = (!(this.damagesPlayers_));
		this.sound_ = this.containerProps_.oldSound_;
		this.multiHitDict_ = ((this.projProps_.multiHit_) ? new Dictionary() : null);
		if (this.projProps_.size_ >= 0)
		{
			_local_9 = this.projProps_.size_;
		}
		else
		{
			_local_9 = ObjectLibrary.getSizeFromType(this.containerType_);
		}
		this.p_.setSize((8 * (_local_9 / 100)));
		this.damage_ = 0;
	}

	public function setDamage(_arg_1:int):void
	{
		this.damage_ = _arg_1;
	}

	override public function addTo(_arg_1:Map, _arg_2:Number, _arg_3:Number):Boolean
	{
		var _local_4:Player;
		this.startX_ = _arg_2;
		this.startY_ = _arg_3;
		if (!super.addTo(_arg_1, _arg_2, _arg_3))
		{
			return (false);
		}
		if (((!(this.containerProps_.flying_)) && (square_.sink_)))
		{
			z_ = 0.1;
		}
		else
		{
			_local_4 = (_arg_1.goDict_[this.ownerId_] as Player);
			if (((!(_local_4 == null)) && (_local_4.sinkLevel_ > 0)))
			{
				z_ = (0.5 - (0.4 * (_local_4.sinkLevel_ / Parameters.MAX_SINK_LEVEL)));
			}
		}
		return (true);
	}

	public function moveTo(_arg_1:Number, _arg_2:Number):Boolean
	{
		var _local_3:Square;
		_local_3 = map_.getSquare(_arg_1, _arg_2);
		if (_local_3 == null)
		{
			return (false);
		}
		x_ = _arg_1;
		y_ = _arg_2;
		square_ = _local_3;
		return (true);
	}

	override public function removeFromMap():void
	{
		super.removeFromMap();
		removeObjId(this.ownerId_, this.bulletId_);
		this.multiHitDict_ = null;
		FreeList.deleteObject(this);
	}

	private function positionAt(_arg_1:int, _arg_2:Point):void
	{
		var _local_3:Number;
		var _local_4:Number;
		var _local_5:Number;
		var _local_6:Number;
		var _local_7:Number;
		var _local_8:Number;
		var _local_9:Number;
		var _local_10:Number;
		var _local_11:Number;
		var _local_12:Number;
		_arg_2.x = this.startX_;
		_arg_2.y = this.startY_;
		var _local_13:Number = (_arg_1 * (this.projProps_.speed_ / 10000));
		var _local_14:Number = (((this.bulletId_ % 2) == 0) ? 0 : Math.PI);
		if (this.projProps_.wavy_)
		{
			_local_3 = (6 * Math.PI);
			_local_4 = (Math.PI / 64);
			_local_5 = (this.angle_ + (_local_4 * Math.sin((_local_14 + ((_local_3 * _arg_1) / 1000)))));
			_arg_2.x = (_arg_2.x + (_local_13 * Math.cos(_local_5)));
			_arg_2.y = (_arg_2.y + (_local_13 * Math.sin(_local_5)));
		}
		else
		{
			if (this.projProps_.parametric_)
			{
				_local_6 = (((_arg_1 / this.projProps_.lifetime_) * 2) * Math.PI);
				_local_7 = (Math.sin(_local_6) * ((this.bulletId_ % 2) ? 1 : -1));
				_local_8 = (Math.sin((2 * _local_6)) * (((this.bulletId_ % 4) < 2) ? 1 : -1));
				_local_9 = Math.sin(this.angle_);
				_local_10 = Math.cos(this.angle_);
				_arg_2.x = (_arg_2.x + (((_local_7 * _local_10) - (_local_8 * _local_9)) * this.projProps_.magnitude_));
				_arg_2.y = (_arg_2.y + (((_local_7 * _local_9) + (_local_8 * _local_10)) * this.projProps_.magnitude_));
			}
			else
			{
				if (this.projProps_.boomerang_)
				{
					_local_11 = ((this.projProps_.lifetime_ * (this.projProps_.speed_ / 10000)) / 2);
					if (_local_13 > _local_11)
					{
						_local_13 = (_local_11 - (_local_13 - _local_11));
					}
				}
				_arg_2.x = (_arg_2.x + (_local_13 * Math.cos(this.angle_)));
				_arg_2.y = (_arg_2.y + (_local_13 * Math.sin(this.angle_)));
				if (this.projProps_.amplitude_ != 0)
				{
					_local_12 = (this.projProps_.amplitude_ * Math.sin((_local_14 + ((((_arg_1 / this.projProps_.lifetime_) * this.projProps_.frequency_) * 2) * Math.PI))));
					_arg_2.x = (_arg_2.x + (_local_12 * Math.cos((this.angle_ + (Math.PI / 2)))));
					_arg_2.y = (_arg_2.y + (_local_12 * Math.sin((this.angle_ + (Math.PI / 2)))));
				}
			}
		}
	}

	override public function update(_arg_1:int, _arg_2:int):Boolean
	{
		var _local_3:Vector.<uint>;
		var _local_4:Player;
		var _local_5:Boolean;
		var _local_6:Boolean;
		var _local_7:Boolean;
		var _local_8:int;
		var _local_9:Boolean;
		var _local_10:String;
		var _local_11:int = (_arg_1 - this.startTime_);
		if (_local_11 > this.projProps_.lifetime_)
		{
			return (false);
		}
		var _local_12:Point = this.staticPoint_;
		this.positionAt(_local_11, _local_12);
		if (((!(this.moveTo(_local_12.x, _local_12.y))) || (square_.tileType_ == 0xFFFF)))
		{
			if (this.damagesPlayers_)
			{
				map_.gs_.gsc_.squareHit(_arg_1, this.bulletId_, this.ownerId_);
			}
			else
			{
				if (square_.obj_ != null)
				{
					if (!Parameters.data_.noParticlesMaster)
					{
						_local_3 = BloodComposition.getColors(this.texture_);
						map_.addObj(new HitEffect(_local_3, 100, 3, this.angle_, this.projProps_.speed_), _local_12.x, _local_12.y);
					}
				}
			}
			return (false);
		}
		if ((((!(square_.obj_ == null)) && ((!(square_.obj_.props_.isEnemy_)) || (!(this.damagesEnemies_)))) && ((square_.obj_.props_.enemyOccupySquare_) || ((!(this.projProps_.passesCover_)) && (square_.obj_.props_.occupySquare_)))))
		{
			if (this.damagesPlayers_)
			{
				map_.gs_.gsc_.otherHit(_arg_1, this.bulletId_, this.ownerId_, square_.obj_.objectId_);
			}
			else
			{
				if (!Parameters.data_.noParticlesMaster)
				{
					_local_3 = BloodComposition.getColors(this.texture_);
					map_.addObj(new HitEffect(_local_3, 100, 3, this.angle_, this.projProps_.speed_), _local_12.x, _local_12.y);
				}
			}
			if (!((Parameters.data_.PassesCover) && (this.ownerId_ == map_.player_.objectId_)))
			{
				return (false);
			}
		}
		var _local_13:GameObject = this.getHit(_local_12.x, _local_12.y);
		if (_local_13 != null)
		{
			_local_4 = map_.player_;
			_local_5 = (!(_local_4 == null));
			_local_6 = _local_13.props_.isEnemy_;
			_local_7 = (((_local_5) && (!(_local_4.isPaused()))) && ((this.damagesPlayers_) || ((_local_6) && (this.ownerId_ == _local_4.objectId_))));
			if (_local_7)
			{
				_local_8 = GameObject.damageWithDefense(this.damage_, _local_13.defense_, this.projProps_.armorPiercing_, _local_13.condition_);
				_local_9 = false;
				if (_local_13.hp_ < _local_8)
				{
					_local_9 = true;
				}
				if (_local_13 == _local_4)
				{
					_local_10 = this.statEffHit(this.projProps_.effects_);
					if (_local_10.substr(0, 7) == "Unknown")
					{
						_local_4.notifyPlayer(_local_10, 0xFF00, 1500);
						_local_10 = "";
					}
					if (_local_10 == "")
					{
						_local_13.damage(true, _local_8, this.projProps_.effects_, false, this);
						map_.gs_.gsc_.playerHit(this.bulletId_, this.ownerId_);
					}
					else
					{
						_local_4.notifyPlayer(_local_10, 0xFF00, 1500);
						if (_local_8 > 0)
						{
							_local_4.damageWithoutAck(_local_8);
						}
						return (false);
					}
				}
				else
				{
					if (_local_13.props_.isEnemy_)
					{
						if (((!(this.damageIgnored(_local_13))) || (((_local_13.isInvulnerable()) && (!(this.isStun()))) && (Parameters.data_.PassesCover))))
						{
							return (true);
						}
						if (((Parameters.data_.tombHack) && (((_local_13.objectType_ >= 3366) && (_local_13.objectType_ <= 3368)) || ((_local_13.objectType_ >= 32692) && (_local_13.objectType_ <= 32694)))))
						{
							if (((!(_local_13.objectType_ == Parameters.data_.curBoss)) && (!(_local_13.objectType_ == (Parameters.data_.curBoss + 29326)))))
							{
								return (true);
							}
						}
						if ((((_local_13.props_.isCube_) && (Parameters.data_.blockCubes)) || ((!(_local_13.props_.isGod_)) && (Parameters.data_.onlyGods))))
						{
							return (true);
						}
						map_.gs_.gsc_.enemyHit(_arg_1, this.bulletId_, _local_13.objectId_, _local_9);
						_local_13.damage(true, _local_8, this.projProps_.effects_, _local_9, this);
						if (isNaN(Parameters.dmgCounter[_local_13.objectId_]))
						{
							Parameters.dmgCounter[_local_13.objectId_] = 0;
						}
						Parameters.dmgCounter[_local_13.objectId_] = (Parameters.dmgCounter[_local_13.objectId_] + _local_8);
					}
					else
					{
						if (!this.projProps_.multiHit_)
						{
							map_.gs_.gsc_.otherHit(_arg_1, this.bulletId_, this.ownerId_, _local_13.objectId_);
						}
					}
				}
			}
			if (this.projProps_.multiHit_)
			{
				this.multiHitDict_[_local_13] = true;
			}
			else
			{
				return (false);
			}
		}
		return (true);
	}

	private function statEffHit(_arg_1:Vector.<uint>):String
	{
		var _local_2:int;
		for each (_local_2 in _arg_1)
		{
			switch (_local_2)
			{
				case 2:
					if (!Parameters.data_.dbQuiet)
					{
						if (((map_.name_ == "Oryx's Castle") && (Parameters.data_.dbQuietCastle)))
						{
							return ("");
						}
						return ("Quiet");
					}
					break;
				case 3:
					if (!Parameters.data_.dbWeak)
					{
						return ("Weak");
					}
					break;
				case 4:
					if (!Parameters.data_.dbSlowed)
					{
						if (map_.name_ == "Oryx's Castle")
						{
							return ("");
						}
						return ("Slowed");
					}
					break;
				case 5:
					if (!Parameters.data_.dbSick)
					{
						return ("Sick");
					}
					break;
				case 6:
					if (!Parameters.data_.dbDazed)
					{
						return ("Dazed");
					}
					break;
				case 7:
					if (!Parameters.data_.dbStunned)
					{
						return ("Stunned");
					}
					break;
				case 14:
					if (!Parameters.data_.dbParalyzed)
					{
						return ("Paralyzed");
					}
					break;
				case 16:
					if (!Parameters.data_.dbBleeding)
					{
						return ("Bleeding");
					}
					break;
				case 22:
					if (!Parameters.data_.dbPetStasis)
					{
						return ("Pet Stasis");
					}
					break;
				case 27:
					if (!Parameters.data_.dbArmorBroken)
					{
						return ("Armor Broken");
					}
					break;
				case 35:
					if (!Parameters.data_.dbPetrify)
					{
						return ("Petrify");
					}
					break;
				case 8:
				case 9:
				case 10:
				case 11:
				case 30:
				case 31:
					break;
				default:
					return ("Unknown: " + _local_2);
			}
		}
		return ("");
	}

	private function isStun():Boolean
	{
		if (((this.containerType_ > 2567) && (this.containerType_ < 2573)))
		{
			return (true);
		}
		if (((this.containerType_ > 2656) && (this.containerType_ < 2662)))
		{
			return (true);
		}
		switch (this.containerType_)
		{
			case 2767:
			case 2850:
			case 2624:
			case 9017:
			case 3395:
			case 3087:
			case 3079:
			case 2856:
			case 2782:
			case 2326:
				return (true);
		}
		return (false);
	}

	public function damageIgnored(_arg_1:GameObject):Boolean
	{
		var _local_2:int;
		for each (_local_2 in Parameters.data_.AAIgnore)
		{
			if (_local_2 == _arg_1.props_.type_)
			{
				if (!Parameters.data_.damageIgnored)
				{
					return (false);
				}
				break;
			}
		}
		return (true);
	}

	public function getHit(_arg_1:Number, _arg_2:Number):GameObject
	{
		var _local_3:GameObject;
		var _local_4:Number;
		var _local_5:Number;
		var _local_6:Number;
		var _local_7:GameObject;
		var _local_8:Number = Number.MAX_VALUE;
		for each (_local_3 in map_.goDict_)
		{
			if (((!(_local_3.isInvincible())) && (!(_local_3.isStasis()))))
			{
				if ((((this.damagesEnemies_) && (_local_3.props_.isEnemy_)) || ((this.damagesPlayers_) && (_local_3.props_.isPlayer_))))
				{
					if (!((_local_3.dead_) || (_local_3.isPaused())))
					{
						if (this.damagesEnemies_)
						{
							if ((((_local_3.props_.isCube_) && (Parameters.data_.blockCubes)) || ((!(_local_3.props_.isGod_)) && (Parameters.data_.onlyGods)))) continue;
						}
						_local_4 = ((_local_3.x_ > _arg_1) ? (_local_3.x_ - _arg_1) : (_arg_1 - _local_3.x_));
						_local_5 = ((_local_3.y_ > _arg_2) ? (_local_3.y_ - _arg_2) : (_arg_2 - _local_3.y_));
						if (!((_local_4 > 0.5) || (_local_5 > 0.5)))
						{
							if (!((this.projProps_.multiHit_) && (!(this.multiHitDict_[_local_3] == null))))
							{
								if (_local_3 == map_.player_)
								{
									return (_local_3);
								}
								_local_6 = ((_local_4 * _local_4) + (_local_5 * _local_5));
								if (_local_6 < _local_8)
								{
									_local_8 = _local_6;
									_local_7 = _local_3;
								}
							}
						}
					}
				}
			}
		}
		return (_local_7);
	}

	override public function draw(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void
	{
		var _local_4:uint;
		var _local_5:uint;
		var _local_6:int;
		var _local_7:int;
		if (MapUserInput.skipRender == true)
		{
			return;
		}
		if (!Parameters.drawProj_)
		{
			return;
		}
		var _local_8:BitmapData = this.texture_;
		if (Parameters.projColorType_ != 0)
		{
			switch (Parameters.projColorType_)
			{
				case 1:
					_local_4 = 16777100;
					_local_5 = 0xFFFFFF;
					break;
				case 2:
					_local_4 = 16777100;
					_local_5 = 16777100;
					break;
				case 3:
					_local_4 = 0xFF0000;
					_local_5 = 0xFF0000;
					break;
				case 4:
					_local_4 = 0xFF;
					_local_5 = 0xFF;
					break;
				case 5:
					_local_4 = 0xFFFFFF;
					_local_5 = 0xFFFFFF;
					break;
				case 6:
					_local_4 = 0;
					_local_5 = 0;
					break;
			}
			_local_8 = TextureRedrawer.redraw(_local_8, 120, true, _local_5);
		}
		var _local_9:Number = ((this.props_.rotation_ == 0) ? 0 : (_arg_3 / this.props_.rotation_));
		this.staticVector3D_.x = x_;
		this.staticVector3D_.y = y_;
		this.staticVector3D_.z = z_;
		this.p_.draw(_arg_1, this.staticVector3D_, (((this.angle_ - _arg_2.angleRad_) + this.props_.angleCorrection_) + _local_9), _arg_2.wToS_, _arg_2, _local_8);
		if ((((this.projProps_.particleTrail_) && (!(Parameters.data_.AntiLag))) || ((this.projProps_.particleTrail_) && (!(Parameters.data_.noParticlesMaster)))))
		{
			_local_6 = ((this.projProps_.particleTrailLifetimeMS != -1) ? this.projProps_.particleTrailLifetimeMS : 600);
			_local_7 = 0;
			while (_local_7 < 3)
			{
				if (((!((!(map_ == null)) && (!(map_.player_.objectId_ == this.ownerId_)))) || (!((this.projProps_.particleTrailIntensity_ == -1) && ((Math.random() * 100) > this.projProps_.particleTrailIntensity_)))))
				{
					map_.addObj(new SparkParticle(100, this.projProps_.particleTrailColor_, _local_6, 0.5, RandomUtil.plusMinus(3), RandomUtil.plusMinus(3)), x_, y_);
				}
				_local_7++;
			}
		}
	}

	override public function drawShadow(_arg_1:Vector.<IGraphicsData>, _arg_2:Camera, _arg_3:int):void
	{
		if (!Parameters.drawProj_)
		{
			return;
		}
		var _local_4:Number = (this.props_.shadowSize_ / 400);
		var _local_5:Number = (30 * _local_4);
		var _local_6:Number = (15 * _local_4);
		this.shadowGradientFill_.matrix.createGradientBox((_local_5 * 2), (_local_6 * 2), 0, (posS_[0] - _local_5), (posS_[1] - _local_6));
		_arg_1.push(this.shadowGradientFill_);
		this.shadowPath_.data.length = 0;
		Vector.<Number>(this.shadowPath_.data).push((posS_[0] - _local_5), (posS_[1] - _local_6), (posS_[0] + _local_5), (posS_[1] - _local_6), (posS_[0] + _local_5), (posS_[1] + _local_6), (posS_[0] - _local_5), (posS_[1] + _local_6));
		_arg_1.push(this.shadowPath_);
		_arg_1.push(GraphicsUtil.END_FILL);
	}


}
}//package com.company.assembleegameclient.objects

