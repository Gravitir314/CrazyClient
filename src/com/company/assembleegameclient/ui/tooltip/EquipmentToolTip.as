// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.tooltip.EquipmentToolTip

package com.company.assembleegameclient.ui.tooltip
{
import com.company.assembleegameclient.constants.InventoryOwnerTypes;
import com.company.assembleegameclient.game.events.KeyInfoResponseSignal;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.LineBreakDesign;
import com.company.assembleegameclient.util.MathUtil;
import com.company.util.BitmapUtil;
import com.company.util.KeyCodes;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.filters.DropShadowFilter;
import flash.utils.Dictionary;

import kabam.rotmg.constants.ActivationType;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.messaging.impl.data.StatData;
import kabam.rotmg.messaging.impl.incoming.KeyInfoResponse;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;
import kabam.rotmg.ui.model.HUDModel;

public class EquipmentToolTip extends ToolTip
    {

        private static const MAX_WIDTH:int = 230;
        public static var keyInfo:Dictionary = new Dictionary();

        private var icon:Bitmap;
        public var titleText:TextFieldDisplayConcrete;
        private var tierText:TextFieldDisplayConcrete;
        private var descText:TextFieldDisplayConcrete;
        private var line1:LineBreakDesign;
        private var effectsText:TextFieldDisplayConcrete;
        private var line2:LineBreakDesign;
        private var line3:LineBreakDesign;
        private var restrictionsText:TextFieldDisplayConcrete;
        private var setInfoText:TextFieldDisplayConcrete;
        private var player:Player;
        private var isEquippable:Boolean = false;
        private var objectType:int;
        private var titleOverride:String;
        private var descriptionOverride:String;
        private var curItemXML:XML = null;
        private var objectXML:XML = null;
        private var slotTypeToTextBuilder:SlotComparisonFactory;
        private var restrictions:Vector.<Restriction>;
        private var setInfo:Vector.<Effect>;
        private var effects:Vector.<Effect>;
        private var uniqueEffects:Vector.<Effect> = new Vector.<Effect>();
        private var itemSlotTypeId:int;
        private var invType:int;
        private var inventorySlotID:uint;
        private var inventoryOwnerType:String;
        private var isInventoryFull:Boolean;
        private var playerCanUse:Boolean;
        private var comparisonResults:SlotComparisonResult;
        private var powerText:TextFieldDisplayConcrete;
        private var keyInfoResponse:KeyInfoResponseSignal;
        private var originalObjectType:int;

        public function EquipmentToolTip(_arg_1:int, _arg_2:Player, _arg_3:int, _arg_4:String)
        {
            var _local_5:HUDModel;
            this.objectType = _arg_1;
            this.originalObjectType = this.objectType;
            this.player = _arg_2;
            this.invType = _arg_3;
            this.inventoryOwnerType = _arg_4;
            this.isInventoryFull = ((_arg_2) ? _arg_2.isInventoryFull() : false);
            if (((this.objectType >= 0x9000) && (this.objectType <= 0xF000)))
            {
                this.objectType = 36863;
            };
            this.playerCanUse = ((_arg_2) ? ObjectLibrary.isUsableByPlayer(this.objectType, _arg_2) : false);
            var _local_6:int = ((_arg_2) ? ObjectLibrary.getMatchingSlotIndex(this.objectType, _arg_2) : -1);
            var _local_7:uint = (((this.playerCanUse) || (this.player == null)) ? 0x363636 : 6036765);
            var _local_8:uint = (((this.playerCanUse) || (_arg_2 == null)) ? 0x9B9B9B : 10965039);
            super(_local_7, 1, _local_8, 1, true);
            this.slotTypeToTextBuilder = new SlotComparisonFactory();
            this.objectXML = ObjectLibrary.xmlLibrary_[this.objectType];
            this.isEquippable = (!(_local_6 == -1));
            this.setInfo = new Vector.<Effect>();
            this.effects = new Vector.<Effect>();
            this.itemSlotTypeId = int(this.objectXML.SlotType);
            if (this.player == null)
            {
                this.curItemXML = this.objectXML;
            }
            else
            {
                if (this.isEquippable)
                {
                    if (this.player.equipment_[_local_6] != -1)
                    {
                        this.curItemXML = ObjectLibrary.xmlLibrary_[this.player.equipment_[_local_6]];
                    };
                };
            };
            this.addIcon();
            if (((this.originalObjectType >= 0x9000) && (this.originalObjectType <= 0xF000)))
            {
                if (keyInfo[this.originalObjectType] == null)
                {
                    this.addTitle();
                    this.addDescriptionText();
                    this.keyInfoResponse = StaticInjectorContext.getInjector().getInstance(KeyInfoResponseSignal);
                    this.keyInfoResponse.add(this.onKeyInfoResponse);
                    _local_5 = StaticInjectorContext.getInjector().getInstance(HUDModel);
                    _local_5.gameSprite.gsc_.keyInfoRequest(this.originalObjectType);
                }
                else
                {
                    this.titleOverride = (keyInfo[this.originalObjectType][0] + " Key");
                    this.descriptionOverride = (((keyInfo[this.originalObjectType][1] + "\n") + "Created By: ") + keyInfo[this.originalObjectType][2]);
                    this.addTitle();
                    this.addDescriptionText();
                };
            }
            else
            {
                this.addTitle();
                this.addDescriptionText();
            };
            this.addTierText();
            this.handleWisMod();
            this.buildCategorySpecificText();
            this.addUniqueEffectsToList();
            this.addActivateTagsToEffectsList();
            this.addNumProjectiles();
            this.addProjectileTagsToEffectsList();
            this.addRateOfFire();
            this.addActivateOnEquipTagsToEffectsList();
            this.addDoseTagsToEffectsList();
            this.addMpCostTagToEffectsList();
            this.addFameBonusTagToEffectsList();
            this.addCooldown();
            this.addSetInfo();
            this.makeSetInfoText();
            this.makeEffectsList();
            this.makeLineTwo();
            this.makeRestrictionList();
            this.makeRestrictionText();
            this.makeItemPowerText();
        }

        private function addSetInfo():void
        {
            if (!this.objectXML.hasOwnProperty("@setType"))
            {
                return;
            };
            var _local_1:int = this.objectXML.attribute("setType");
            this.setInfo.push(new Effect("Part of {name}", {"name":(("<b>" + this.objectXML.attribute("setName")) + "</b>")}).setColor(TooltipHelper.SET_COLOR).setReplacementsColor(TooltipHelper.SET_COLOR));
            this.addSetActivateOnEquipTagsToEffectsList(_local_1);
        }

        private function addSetActivateOnEquipTagsToEffectsList(_arg_1:int):void
        {
            var _local_2:XML;
            var _local_3:uint = 8805920;
            var _local_4:XML = ObjectLibrary.getSetXMLFromType(_arg_1);
            if (!_local_4.hasOwnProperty("ActivateOnEquipAll"))
            {
                return;
            };
            for each (_local_2 in _local_4.ActivateOnEquipAll)
            {
                if (_local_2.toString() == "ChangeSkin")
                {
                    if (((!(this.player == null)) && (this.player.skinId == int(_local_2.@skinType))))
                    {
                        _local_3 = TooltipHelper.SET_COLOR;
                    };
                };
                if (_local_2.toString() == "IncrementStat")
                {
                    this.setInfo.push(new Effect(TextKey.INCREMENT_STAT, this.getComparedStatText(_local_2)).setColor(_local_3).setReplacementsColor(_local_3));
                };
            };
        }

        private function makeItemPowerText():void
        {
            var _local_1:int;
            if (this.objectXML.hasOwnProperty("feedPower"))
            {
                _local_1 = (((this.playerCanUse) || (this.player == null)) ? 0xFFFFFF : 16549442);
                this.powerText = new TextFieldDisplayConcrete().setSize(12).setColor(_local_1).setBold(true).setTextWidth((((MAX_WIDTH - this.icon.width) - 4) - 30)).setWordWrap(true);
                this.powerText.setStringBuilder(new StaticStringBuilder().setString(("Feed Power: " + this.objectXML.feedPower)));
                this.powerText.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
                waiter.push(this.powerText.textChanged);
                addChild(this.powerText);
            };
        }

        private function onKeyInfoResponse(_arg_1:KeyInfoResponse):void
        {
            this.keyInfoResponse.remove(this.onKeyInfoResponse);
            this.removeTitle();
            this.removeDesc();
            this.titleOverride = _arg_1.name;
            this.descriptionOverride = _arg_1.description;
            keyInfo[this.originalObjectType] = [_arg_1.name, _arg_1.description, _arg_1.creator];
            this.addTitle();
            this.addDescriptionText();
        }

        private function addUniqueEffectsToList():void
        {
            var _local_1:XMLList;
            var _local_2:XML;
            var _local_3:String;
            var _local_4:String;
            var _local_5:String;
            var _local_6:AppendingLineBuilder;
            if (this.objectXML.hasOwnProperty("ExtraTooltipData"))
            {
                _local_1 = this.objectXML.ExtraTooltipData.EffectInfo;
                for each (_local_2 in _local_1)
                {
                    _local_3 = _local_2.attribute("name");
                    _local_4 = _local_2.attribute("description");
                    _local_5 = (((_local_3) && (_local_4)) ? ": " : "\n");
                    _local_6 = new AppendingLineBuilder();
                    if (_local_3)
                    {
                        _local_6.pushParams(_local_3);
                    };
                    if (_local_4)
                    {
                        _local_6.pushParams(_local_4, {}, TooltipHelper.getOpenTag(16777103), TooltipHelper.getCloseTag());
                    };
                    _local_6.setDelimiter(_local_5);
                    this.uniqueEffects.push(new Effect(TextKey.BLANK, {"data":_local_6}));
                };
            };
        }

        private function isEmptyEquipSlot():Boolean
        {
            return ((this.isEquippable) && (this.curItemXML == null));
        }

        private function addIcon():void
        {
            var _local_1:XML = ObjectLibrary.xmlLibrary_[this.objectType];
            var _local_2:int = 5;
            if (((this.objectType == 4874) || (this.objectType == 4618)))
            {
                _local_2 = 8;
            };
            if (_local_1.hasOwnProperty("ScaleValue"))
            {
                _local_2 = _local_1.ScaleValue;
            };
            var _local_3:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this.objectType, 60, true, true, _local_2);
            _local_3 = BitmapUtil.cropToBitmapData(_local_3, 4, 4, (_local_3.width - 8), (_local_3.height - 8));
            this.icon = new Bitmap(_local_3);
            addChild(this.icon);
        }

        private function addTierText():void
        {
            var _local_1:* = (this.isPet() == false);
            var _local_2:* = (this.objectXML.hasOwnProperty("Consumable") == false);
            var _local_3:* = (this.objectXML.hasOwnProperty("Treasure") == false);
            var _local_4:* = (this.objectXML.hasOwnProperty("PetFood") == false);
            var _local_5:Boolean = this.objectXML.hasOwnProperty("Tier");
            if (((((_local_1) && (_local_2)) && (_local_3)) && (_local_4)))
            {
                this.tierText = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth(30).setBold(true);
                if (_local_5)
                {
                    this.tierText.setStringBuilder(new LineBuilder().setParams(TextKey.TIER_ABBR, {"tier":this.objectXML.Tier}));
                }
                else
                {
                    if (this.objectXML.hasOwnProperty("@setType"))
                    {
                        this.tierText.setColor(TooltipHelper.SET_COLOR);
                        this.tierText.setStringBuilder(new StaticStringBuilder("ST"));
                    }
                    else
                    {
                        this.tierText.setColor(TooltipHelper.UNTIERED_COLOR);
                        this.tierText.setStringBuilder(new LineBuilder().setParams(TextKey.UNTIERED_ABBR));
                    };
                };
                addChild(this.tierText);
            };
        }

        private function isPet():Boolean
        {
            var activateTags:XMLList;
            activateTags = this.objectXML.Activate.(text() == "PermaPet");
            return (activateTags.length() >= 1);
        }

        private function removeTitle():*
        {
            removeChild(this.titleText);
        }

        private function removeDesc():*
        {
            removeChild(this.descText);
        }

        private function addTitle():void
        {
            var _local_1:int = (((this.playerCanUse) || (this.player == null)) ? 0xFFFFFF : 16549442);
            this.titleText = new TextFieldDisplayConcrete().setSize(16).setColor(_local_1).setBold(true).setTextWidth((((MAX_WIDTH - this.icon.width) - 4) - 30)).setWordWrap(true);
            if (this.titleOverride)
            {
                this.titleText.setStringBuilder(new StaticStringBuilder(this.titleOverride));
            }
            else
            {
                this.titleText.setStringBuilder(new LineBuilder().setParams(ObjectLibrary.typeToDisplayId_[this.objectType]));
            };
            this.titleText.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
            waiter.push(this.titleText.textChanged);
            addChild(this.titleText);
        }

        private function buildUniqueTooltipData():String
        {
            var _local_1:XMLList;
            var _local_2:Vector.<Effect>;
            var _local_3:XML;
            if (this.objectXML.hasOwnProperty("ExtraTooltipData"))
            {
                _local_1 = this.objectXML.ExtraTooltipData.EffectInfo;
                _local_2 = new Vector.<Effect>();
                for each (_local_3 in _local_1)
                {
                    _local_2.push(new Effect(_local_3.attribute("name"), _local_3.attribute("description")));
                };
            };
            return ("");
        }

        private function makeEffectsList():void
        {
            var _local_1:AppendingLineBuilder;
            if ((((!(this.effects.length == 0)) || (!(this.comparisonResults.lineBuilder == null))) || (this.objectXML.hasOwnProperty("ExtraTooltipData"))))
            {
                this.line1 = new LineBreakDesign((MAX_WIDTH - 12), 0);
                this.effectsText = new TextFieldDisplayConcrete().setSize(14).setColor(0xB3B3B3).setTextWidth(MAX_WIDTH).setWordWrap(true).setHTML(true);
                _local_1 = this.getEffectsStringBuilder();
                this.effectsText.setStringBuilder(_local_1);
                this.effectsText.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
                if (_local_1.hasLines())
                {
                    addChild(this.line1);
                    addChild(this.effectsText);
                };
            };
        }

        private function getEffectsStringBuilder():AppendingLineBuilder
        {
            var _local_1:AppendingLineBuilder = new AppendingLineBuilder();
            this.appendEffects(this.uniqueEffects, _local_1);
            if (this.comparisonResults.lineBuilder.hasLines())
            {
                _local_1.pushParams(TextKey.BLANK, {"data":this.comparisonResults.lineBuilder});
            };
            this.appendEffects(this.effects, _local_1);
            return (_local_1);
        }

        private function appendEffects(_arg_1:Vector.<Effect>, _arg_2:AppendingLineBuilder):void
        {
            var _local_3:Effect;
            var _local_4:String;
            var _local_5:String;
            for each (_local_3 in _arg_1)
            {
                _local_4 = "";
                _local_5 = "";
                if (_local_3.color_)
                {
                    _local_4 = (('<font color="#' + _local_3.color_.toString(16)) + '">');
                    _local_5 = "</font>";
                };
                _arg_2.pushParams(_local_3.name_, _local_3.getValueReplacementsWithColor(), _local_4, _local_5);
            };
        }

        private function addFameBonusTagToEffectsList():void
        {
            var _local_1:int;
            var _local_2:uint;
            var _local_3:int;
            if (this.objectXML.hasOwnProperty("FameBonus"))
            {
                _local_1 = int(this.objectXML.FameBonus);
                _local_2 = ((this.playerCanUse) ? TooltipHelper.BETTER_COLOR : TooltipHelper.NO_DIFF_COLOR);
                if (((!(this.curItemXML == null)) && (this.curItemXML.hasOwnProperty("FameBonus"))))
                {
                    _local_3 = int(this.curItemXML.FameBonus.text());
                    _local_2 = TooltipHelper.getTextColor((_local_1 - _local_3));
                };
                this.effects.push(new Effect(TextKey.FAME_BONUS, {"percent":(this.objectXML.FameBonus + "%")}).setReplacementsColor(_local_2));
            };
        }

        private function addMpCostTagToEffectsList():void
        {
            var _local_1:int;
            var _local_2:int;
            if (this.objectXML.hasOwnProperty("MpEndCost"))
            {
                _local_2 = this.objectXML.MpEndCost;
                _local_1 = _local_2;
                if (((this.curItemXML) && (this.curItemXML.hasOwnProperty("MpEndCost"))))
                {
                    _local_2 = this.curItemXML.MpEndCost;
                };
                this.effects.push(new Effect(TextKey.MP_COST, {"cost":TooltipHelper.compare(_local_1, _local_2, false)}));
            }
            else
            {
                if (this.objectXML.hasOwnProperty("MpCost"))
                {
                    _local_2 = this.objectXML.MpCost;
                    _local_1 = _local_2;
                    if (((this.curItemXML) && (this.curItemXML.hasOwnProperty("MpCost"))))
                    {
                        _local_2 = this.curItemXML.MpCost;
                    };
                    this.effects.push(new Effect(TextKey.MP_COST, {"cost":TooltipHelper.compare(_local_1, _local_2, false)}));
                };
            };
        }

        private function addDoseTagsToEffectsList():void
        {
            if (this.objectXML.hasOwnProperty("Doses"))
            {
                this.effects.push(new Effect(TextKey.DOSES, {"dose":this.objectXML.Doses}));
            };
            if (this.objectXML.hasOwnProperty("Quantity"))
            {
                this.effects.push(new Effect("Quantity: {quantity}", {"quantity":this.objectXML.Quantity}));
            };
        }

        private function addNumProjectiles():void
        {
            var _local_1:ComPairTag = new ComPairTag(this.objectXML, this.curItemXML, "NumProjectiles", 1);
            if (((!(_local_1.a == 1)) || (!(_local_1.a == _local_1.b))))
            {
                this.effects.push(new Effect(TextKey.SHOTS, {"numShots":TooltipHelper.compare(_local_1.a, _local_1.b)}));
            };
        }

        private function addProjectileTagsToEffectsList():void
        {
            var _local_1:XML;
            if (this.objectXML.hasOwnProperty("Projectile"))
            {
                _local_1 = ((this.curItemXML == null) ? null : this.curItemXML.Projectile[0]);
                this.addProjectile(this.objectXML.Projectile[0], _local_1);
            };
        }

        private function addProjectile(_arg_1:XML, _arg_2:XML=null):void
        {
            var _local_3:XML;
            var _local_4:ComPairTag = new ComPairTag(_arg_1, _arg_2, "MinDamage");
            var _local_5:ComPairTag = new ComPairTag(_arg_1, _arg_2, "MaxDamage");
            var _local_6:ComPairTag = new ComPairTag(_arg_1, _arg_2, "Speed");
            var _local_7:ComPairTag = new ComPairTag(_arg_1, _arg_2, "LifetimeMS");
            var _local_8:ComPairTagBool = new ComPairTagBool(_arg_1, _arg_2, "Boomerang");
            var _local_9:ComPairTagBool = new ComPairTagBool(_arg_1, _arg_2, "Parametric");
            var _local_10:ComPairTag = new ComPairTag(_arg_1, _arg_2, "Magnitude", 3);
            var _local_11:Number = ((_local_9.a) ? _local_10.a : MathUtil.round((((_local_6.a * _local_7.a) / (int(_local_8.a) + 1)) / 10000), 2));
            var _local_12:Number = ((_local_9.b) ? _local_10.b : MathUtil.round((((_local_6.b * _local_7.b) / (int(_local_8.b) + 1)) / 10000), 2));
            var _local_13:Number = ((_local_5.a + _local_4.a) / 2);
            var _local_14:Number = ((_local_5.b + _local_4.b) / 2);
            var _local_15:String = ((_local_4.a == _local_5.a) ? _local_4.a : ((_local_4.a + " - ") + _local_5.a)).toString();
            this.effects.push(new Effect(TextKey.DAMAGE, {"damage":TooltipHelper.wrapInFontTag(_local_15, ("#" + TooltipHelper.getTextColor((_local_13 - _local_14)).toString(16)))}));
            this.effects.push(new Effect(TextKey.RANGE, {"range":TooltipHelper.compare(_local_11, _local_12)}));
            if (_arg_1.hasOwnProperty("MultiHit"))
            {
                this.effects.push(new Effect(TextKey.MULTIHIT, {}).setColor(TooltipHelper.NO_DIFF_COLOR));
            };
            if (_arg_1.hasOwnProperty("PassesCover"))
            {
                this.effects.push(new Effect(TextKey.PASSES_COVER, {}).setColor(TooltipHelper.NO_DIFF_COLOR));
            };
            if (_arg_1.hasOwnProperty("ArmorPiercing"))
            {
                this.effects.push(new Effect(TextKey.ARMOR_PIERCING, {}).setColor(TooltipHelper.NO_DIFF_COLOR));
            };
            if (_local_9.a)
            {
                this.effects.push(new Effect("Shots are parametric", {}).setColor(TooltipHelper.NO_DIFF_COLOR));
            }
            else
            {
                if (_local_8.a)
                {
                    this.effects.push(new Effect("Shots boomerang", {}).setColor(TooltipHelper.NO_DIFF_COLOR));
                };
            };
            if (_arg_1.hasOwnProperty("ConditionEffect"))
            {
                this.effects.push(new Effect(TextKey.SHOT_EFFECT, {"effect":""}));
            };
            for each (_local_3 in _arg_1.ConditionEffect)
            {
                this.effects.push(new Effect(TextKey.EFFECT_FOR_DURATION, {
                    "effect":_local_3,
                    "duration":_local_3.@duration
                }).setColor(TooltipHelper.NO_DIFF_COLOR));
            };
        }

        private function addRateOfFire():void
        {
            var _local_1:String;
            var _local_2:ComPairTag = new ComPairTag(this.objectXML, this.curItemXML, "RateOfFire", 1);
            if (((!(_local_2.a == 1)) || (!(_local_2.a == _local_2.b))))
            {
                _local_2.a = MathUtil.round((_local_2.a * 100), 2);
                _local_2.b = MathUtil.round((_local_2.b * 100), 2);
                _local_1 = TooltipHelper.compare(_local_2.a, _local_2.b, true, "%");
                this.effects.push(new Effect(TextKey.RATE_OF_FIRE, {"data":_local_1}));
            };
        }

        private function addCooldown():void
        {
            var _local_1:ComPairTag = new ComPairTag(this.objectXML, this.curItemXML, "Cooldown", 0.5);
            if (((!(_local_1.a == 0.5)) || (!(_local_1.a == _local_1.b))))
            {
                this.effects.push(new Effect("Cooldown: {cd}", {"cd":TooltipHelper.compareAndGetPlural(_local_1.a, _local_1.b, "second", false)}));
            };
        }

        private function addActivateTagsToEffectsList():void
        {
            var activateXML:XML;
            var val:String;
            var stat:int;
            var amt:int;
            var test:String;
            var activationType:String;
            var compareXML:XML;
            var effectColor:uint;
            var current:XML;
            var tokens:Object;
            var template:String;
            var effectColor2:uint;
            var current2:XML;
            var statStr:String;
            var tokens2:Object;
            var template2:String;
            var replaceParams:Object;
            var rNew:Number;
            var rCurrent:Number;
            var dNew:Number;
            var dCurrent:Number;
            var comparer:Number;
            var rNew2:Number;
            var rCurrent2:Number;
            var dNew2:Number;
            var dCurrent2:Number;
            var aNew2:Number;
            var aCurrent2:Number;
            var comparer2:Number;
            var alb:AppendingLineBuilder;
            for each (activateXML in this.objectXML.Activate)
            {
                test = this.comparisonResults.processedTags[activateXML.toXMLString()];
                if (this.comparisonResults.processedTags[activateXML.toXMLString()] != true)
                {
                    activationType = activateXML.toString();
                    compareXML = ((this.curItemXML == null) ? null : this.curItemXML.Activate.(text() == activationType)[0]);
                    switch (activationType)
                    {
                        case ActivationType.COND_EFFECT_AURA:
                            this.effects.push(new Effect(TextKey.PARTY_EFFECT, {"effect":new AppendingLineBuilder().pushParams(TextKey.WITHIN_SQRS, {"range":activateXML.@range}, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag())}));
                            this.effects.push(new Effect(TextKey.EFFECT_FOR_DURATION, {
                                "effect":activateXML.@effect,
                                "duration":activateXML.@duration
                            }).setColor(TooltipHelper.NO_DIFF_COLOR));
                            break;
                        case ActivationType.COND_EFFECT_SELF:
                            this.effects.push(new Effect(TextKey.EFFECT_ON_SELF, {"effect":""}));
                            this.effects.push(new Effect(TextKey.EFFECT_FOR_DURATION, {
                                "effect":activateXML.@effect,
                                "duration":activateXML.@duration
                            }));
                            break;
                        case ActivationType.STAT_BOOST_SELF:
                            this.effects.push(new Effect("{amount} {stat} for {duration} ", {
                                "amount":this.prefix(activateXML.@amount),
                                "stat":new LineBuilder().setParams(StatData.statToName(int(activateXML.@stat))),
                                "duration":TooltipHelper.getPlural(activateXML.@duration, "second")
                            }));
                            break;
                        case ActivationType.HEAL:
                            this.effects.push(new Effect(TextKey.INCREMENT_STAT, {
                                "statAmount":(("+" + activateXML.@amount) + " "),
                                "statName":new LineBuilder().setParams(TextKey.STATUS_BAR_HEALTH_POINTS)
                            }));
                            break;
                        case ActivationType.HEAL_NOVA:
                            if (((activateXML.hasOwnProperty("@damage")) && (int(activateXML.@damage) > 0)))
                            {
                                this.effects.push(new Effect("{damage} damage within {range} sqrs", {
                                    "damage":activateXML.@damage,
                                    "range":activateXML.@range
                                }));
                            };
                            this.effects.push(new Effect(TextKey.PARTY_HEAL, {"effect":new AppendingLineBuilder().pushParams(TextKey.HP_WITHIN_SQRS, {
                                    "amount":activateXML.@amount,
                                    "range":activateXML.@range
                                }, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag())}));
                            break;
                        case ActivationType.MAGIC:
                            this.effects.push(new Effect(TextKey.INCREMENT_STAT, {
                                "statAmount":(("+" + activateXML.@amount) + " "),
                                "statName":new LineBuilder().setParams(TextKey.STATUS_BAR_MANA_POINTS)
                            }));
                            break;
                        case ActivationType.MAGIC_NOVA:
                            this.effects.push(new Effect(TextKey.FILL_PARTY_MAGIC, (((activateXML.@amount + " MP at ") + activateXML.@range) + " sqrs")));
                            break;
                        case ActivationType.TELEPORT:
                            this.effects.push(new Effect(TextKey.BLANK, {"data":new LineBuilder().setParams(TextKey.TELEPORT_TO_TARGET)}));
                            break;
                        case ActivationType.BULLET_NOVA:
                            this.getSpell(activateXML, compareXML);
                            break;
                        case ActivationType.VAMPIRE_BLAST:
                            this.getSkull(activateXML, compareXML);
                            break;
                        case ActivationType.TRAP:
                            this.getTrap(activateXML, compareXML);
                            break;
                        case ActivationType.STASIS_BLAST:
                            this.effects.push(new Effect(TextKey.STASIS_GROUP, {"stasis":new AppendingLineBuilder().pushParams(TextKey.SEC_COUNT, {"duration":activateXML.@duration}, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag())}));
                            break;
                        case ActivationType.DECOY:
                            this.effects.push(new Effect(TextKey.DECOY, {"data":new AppendingLineBuilder().pushParams(TextKey.SEC_COUNT, {"duration":activateXML.@duration}, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag())}));
                            break;
                        case ActivationType.LIGHTNING:
                            this.getLightning(activateXML, compareXML);
                            break;
                        case ActivationType.POISON_GRENADE:
                            this.effects.push(new Effect(TextKey.POISON_GRENADE, {"data":""}));
                            this.effects.push(new Effect(TextKey.POISON_GRENADE_DATA, {
                                "damage":activateXML.@totalDamage,
                                "duration":activateXML.@duration,
                                "radius":activateXML.@radius
                            }).setColor(TooltipHelper.NO_DIFF_COLOR));
                            break;
                        case ActivationType.REMOVE_NEG_COND:
                            this.effects.push(new Effect(TextKey.REMOVES_NEGATIVE, {}).setColor(TooltipHelper.NO_DIFF_COLOR));
                            break;
                        case ActivationType.REMOVE_NEG_COND_SELF:
                            this.effects.push(new Effect(TextKey.REMOVES_NEGATIVE, {}).setColor(TooltipHelper.NO_DIFF_COLOR));
                            break;
                        case ActivationType.GENERIC_ACTIVATE:
                            effectColor = 16777103;
                            if (this.curItemXML != null)
                            {
                                current = this.getEffectTag(this.curItemXML, activateXML.@effect);
                                if (current != null)
                                {
                                    rNew = Number(activateXML.@range);
                                    rCurrent = Number(current.@range);
                                    dNew = Number(activateXML.@duration);
                                    dCurrent = Number(current.@duration);
                                    comparer = ((rNew - rCurrent) + (dNew - dCurrent));
                                    if (comparer > 0)
                                    {
                                        effectColor = 0xFF00;
                                    }
                                    else
                                    {
                                        if (comparer < 0)
                                        {
                                            effectColor = 0xFF0000;
                                        };
                                    };
                                };
                            };
                            tokens = {
                                "range":activateXML.@range,
                                "effect":activateXML.@effect,
                                "duration":activateXML.@duration
                            };
                            template = "Within {range} sqrs {effect} for {duration} seconds";
                            if (activateXML.@target != "enemy")
                            {
                                this.effects.push(new Effect(TextKey.PARTY_EFFECT, {"effect":LineBuilder.returnStringReplace(template, tokens)}).setReplacementsColor(effectColor));
                            }
                            else
                            {
                                this.effects.push(new Effect(TextKey.ENEMY_EFFECT, {"effect":LineBuilder.returnStringReplace(template, tokens)}).setReplacementsColor(effectColor));
                            };
                            break;
                        case ActivationType.STAT_BOOST_AURA:
                            effectColor2 = 16777103;
                            if (this.curItemXML != null)
                            {
                                current2 = this.getStatTag(this.curItemXML, activateXML.@stat);
                                if (current2 != null)
                                {
                                    rNew2 = Number(activateXML.@range);
                                    rCurrent2 = Number(current2.@range);
                                    dNew2 = Number(activateXML.@duration);
                                    dCurrent2 = Number(current2.@duration);
                                    aNew2 = Number(activateXML.@amount);
                                    aCurrent2 = Number(current2.@amount);
                                    comparer2 = (((rNew2 - rCurrent2) + (dNew2 - dCurrent2)) + (aNew2 - aCurrent2));
                                    if (comparer2 > 0)
                                    {
                                        effectColor2 = 0xFF00;
                                    }
                                    else
                                    {
                                        if (comparer2 < 0)
                                        {
                                            effectColor2 = 0xFF0000;
                                        };
                                    };
                                };
                            };
                            stat = int(activateXML.@stat);
                            statStr = LineBuilder.getLocalizedString2(StatData.statToName(stat));
                            tokens2 = {
                                "range":activateXML.@range,
                                "stat":statStr,
                                "amount":activateXML.@amount,
                                "duration":activateXML.@duration
                            };
                            template2 = "Within {range} sqrs increase {stat} by {amount} for {duration} seconds";
                            this.effects.push(new Effect(TextKey.PARTY_EFFECT, {"effect":LineBuilder.returnStringReplace(template2, tokens2)}).setReplacementsColor(effectColor2));
                            break;
                        case ActivationType.INCREMENT_STAT:
                            stat = int(activateXML.@stat);
                            amt = int(activateXML.@amount);
                            replaceParams = {};
                            if (((!(stat == StatData.HP_STAT)) && (!(stat == StatData.MP_STAT))))
                            {
                                val = TextKey.PERMANENTLY_INCREASES;
                                replaceParams["statName"] = new LineBuilder().setParams(StatData.statToName(stat));
                                this.effects.push(new Effect(val, replaceParams).setColor(16777103));
                                break;
                            };
                            val = TextKey.BLANK;
                            alb = new AppendingLineBuilder().setDelimiter(" ");
                            alb.pushParams(TextKey.BLANK, {"data":new StaticStringBuilder(("+" + amt))});
                            alb.pushParams(StatData.statToName(stat));
                            replaceParams["data"] = alb;
                            this.effects.push(new Effect(val, replaceParams));
                            break;
                    };
                };
            };
        }

        private function getSpell(_arg_1:XML, _arg_2:XML=null):void
        {
            var _local_3:ComPair = new ComPair(_arg_1, _arg_2, "numShots", 20);
            var _local_4:String = this.colorUntiered("Spell: ");
            _local_4 = (_local_4 + "{numShots} Shots");
            this.effects.push(new Effect(_local_4, {"numShots":TooltipHelper.compare(_local_3.a, _local_3.b)}));
        }

        private function getSkull(_arg_1:XML, _arg_2:XML=null):void
        {
            var _local_3:Number;
            var _local_4:int = ((this.player != null) ? this.player.wisdom_ : 10);
            var _local_5:int = this.GetIntArgument(_arg_1, "wisPerRad", 10);
            var _local_6:Number = this.GetFloatArgument(_arg_1, "incrRad", 0.5);
            var _local_7:int = this.GetIntArgument(_arg_1, "wisDamageBase", 0);
            var _local_8:int = this.GetIntArgument(_arg_1, "wisMin", 50);
            var _local_9:int = Math.max(0, (_local_4 - _local_8));
            var _local_10:int = int(((_local_7 / 10) * _local_9));
            var _local_11:Number = MathUtil.round((int((_local_9 / _local_5)) * _local_6), 2);
            var _local_12:ComPair = new ComPair(_arg_1, _arg_2, "totalDamage");
            _local_12.add(_local_10);
            var _local_13:ComPair = new ComPair(_arg_1, _arg_2, "radius");
            var _local_14:ComPair = new ComPair(_arg_1, _arg_2, "healRange", 5);
            _local_14.add(_local_11);
            var _local_15:ComPair = new ComPair(_arg_1, _arg_2, "heal");
            var _local_16:ComPair = new ComPair(_arg_1, _arg_2, "ignoreDef", 0);
            var _local_17:String = this.colorUntiered("Skull: ");
            _local_17 = (_local_17 + (("{damage}" + this.colorWisBonus(_local_10)) + " damage\n"));
            _local_17 = (_local_17 + "within {radius} squares\n");
            if (_local_15.a)
            {
                _local_17 = (_local_17 + "Steals {heal} HP");
            };
            if (((_local_15.a) && (_local_16.a)))
            {
                _local_17 = (_local_17 + " and ignores {ignoreDef} defense");
            }
            else
            {
                if (_local_16.a)
                {
                    _local_17 = (_local_17 + "Ignores {ignoreDef} defense");
                };
            };
            if (_local_15.a)
            {
                _local_17 = (_local_17 + (("\nHeals allies within {healRange}" + this.colorWisBonus(_local_11)) + " squares"));
            };
            this.effects.push(new Effect(_local_17, {
                "damage":TooltipHelper.compare(_local_12.a, _local_12.b),
                "radius":TooltipHelper.compare(_local_13.a, _local_13.b),
                "heal":TooltipHelper.compare(_local_15.a, _local_15.b),
                "ignoreDef":TooltipHelper.compare(_local_16.a, _local_16.b),
                "healRange":TooltipHelper.compare(MathUtil.round(_local_14.a, 2), MathUtil.round(_local_14.b, 2))
            }));
            var _local_18:String = _arg_1.@condEffect;
            if (_local_18)
            {
                _local_3 = this.GetFloatArgument(_arg_1, "condDuration", 2.5);
                this.effects.push(new Effect("{condition} for {duration} ", {
                    "condition":_local_18,
                    "duration":TooltipHelper.getPlural(_local_3, "second")
                }));
            };
        }

        private function getTrap(_arg_1:XML, _arg_2:XML=null):void
        {
            var _local_3:ComPair;
            var _local_4:String;
            var _local_5:ComPair = new ComPair(_arg_1, _arg_2, "totalDamage");
            var _local_6:ComPair = new ComPair(_arg_1, _arg_2, "radius");
            var _local_7:ComPair = new ComPair(_arg_1, _arg_2, "duration", 20);
            var _local_8:ComPair = new ComPair(_arg_1, _arg_2, "tilArmed", 1);
            var _local_9:ComPair = new ComPair(_arg_1, _arg_2, "sensitivity", 0.5);
            var _local_10:Number = MathUtil.round((_local_6.a * _local_9.a), 2);
            var _local_11:Number = MathUtil.round((_local_6.b * _local_9.b), 2);
            var _local_12:String = this.colorUntiered("Trap: ");
            _local_12 = (_local_12 + "{damage} damage within {radius} squares");
            this.effects.push(new Effect(_local_12, {
                "damage":TooltipHelper.compare(_local_5.a, _local_5.b),
                "radius":TooltipHelper.compare(_local_6.a, _local_6.b)
            }));
            var _local_13:String = ((_arg_1.hasOwnProperty("@condEffect")) ? _arg_1.@condEffect : "Slowed");
            if (_local_13 != "Nothing")
            {
                _local_3 = new ComPair(_arg_1, _arg_2, "condDuration", 5);
                if (_arg_2)
                {
                    _local_4 = ((_arg_2.hasOwnProperty("@condEffect")) ? _arg_2.@condEffect : "Slowed");
                    if (_local_4 == "Nothing")
                    {
                        _local_3.b = 0;
                    };
                };
                this.effects.push(new Effect("Inflicts {condition} for {duration} ", {
                    "condition":_local_13,
                    "duration":TooltipHelper.compareAndGetPlural(_local_3.a, _local_3.b, "second")
                }));
            };
            this.effects.push(new Effect("{tilArmed} to arm for {duration} ", {
                "tilArmed":TooltipHelper.compareAndGetPlural(_local_8.a, _local_8.b, "second", false),
                "duration":TooltipHelper.compareAndGetPlural(_local_7.a, _local_7.b, "second")
            }));
            this.effects.push(new Effect("Triggers within {triggerRadius} squares", {"triggerRadius":TooltipHelper.compare(_local_10, _local_11)}));
        }

        private function getLightning(_arg_1:XML, _arg_2:XML=null):void
        {
            var _local_3:String;
            var _local_4:Number;
            var _local_5:Boolean;
            var _local_6:int = ((this.player != null) ? this.player.wisdom_ : 10);
            var _local_7:ComPair = new ComPair(_arg_1, _arg_2, "decrDamage", 0);
            var _local_8:int = this.GetIntArgument(_arg_1, "wisPerTarget", 10);
            var _local_9:int = this.GetIntArgument(_arg_1, "wisDamageBase", _local_7.a);
            var _local_10:int = this.GetIntArgument(_arg_1, "wisMin", 50);
            var _local_11:int = Math.max(0, (_local_6 - _local_10));
            var _local_12:int = int((_local_11 / _local_8));
            var _local_13:int = int(((_local_9 / 10) * _local_11));
            var _local_14:ComPair = new ComPair(_arg_1, _arg_2, "maxTargets");
            _local_14.add(_local_12);
            var _local_15:ComPair = new ComPair(_arg_1, _arg_2, "totalDamage");
            _local_15.add(_local_13);
            var _local_16:String = this.colorUntiered("Lightning: ");
            _local_16 = (_local_16 + (("{targets}" + this.colorWisBonus(_local_12)) + " targets\n"));
            _local_16 = (_local_16 + (("{damage}" + this.colorWisBonus(_local_13)) + " damage"));
            if (_local_7.a)
            {
                if (_local_7.a < 0)
                {
                    _local_5 = true;
                };
                _local_3 = "reduced";
                if (_local_5)
                {
                    _local_3 = TooltipHelper.wrapInFontTag("increased", ("#" + TooltipHelper.NO_DIFF_COLOR.toString(16)));
                };
                _local_16 = (_local_16 + ((", " + _local_3) + " by \n{decrDamage} for each subsequent target"));
            };
            this.effects.push(new Effect(_local_16, {
                "targets":TooltipHelper.compare(_local_14.a, _local_14.b),
                "damage":TooltipHelper.compare(_local_15.a, _local_15.b),
                "decrDamage":TooltipHelper.compare(_local_7.a, _local_7.b, false, "", _local_5)
            }));
            var _local_17:String = _arg_1.@condEffect;
            if (_local_17)
            {
                _local_4 = this.GetFloatArgument(_arg_1, "condDuration", 5);
                this.effects.push(new Effect("{condition} for {duration} ", {
                    "condition":_local_17,
                    "duration":TooltipHelper.getPlural(_local_4, "second")
                }));
            };
        }

        private function GetIntArgument(_arg_1:XML, _arg_2:String, _arg_3:int=0):int
        {
            return ((_arg_1.hasOwnProperty(("@" + _arg_2))) ? int(_arg_1.@[_arg_2]) : _arg_3);
        }

        private function GetFloatArgument(_arg_1:XML, _arg_2:String, _arg_3:Number=0):Number
        {
            return ((_arg_1.hasOwnProperty(("@" + _arg_2))) ? Number(_arg_1.@[_arg_2]) : _arg_3);
        }

        private function GetStringArgument(_arg_1:XML, _arg_2:String, _arg_3:String=""):String
        {
            return ((_arg_1.hasOwnProperty(("@" + _arg_2))) ? _arg_1.@[_arg_2] : _arg_3);
        }

        private function colorWisBonus(_arg_1:Number):String
        {
            if (_arg_1)
            {
                return (TooltipHelper.wrapInFontTag(((" (+" + _arg_1) + ")"), ("#" + TooltipHelper.WIS_BONUS_COLOR.toString(16))));
            };
            return ("");
        }

        private function colorUntiered(_arg_1:String):String
        {
            var _local_2:Boolean = this.objectXML.hasOwnProperty("Tier");
            var _local_3:Boolean = this.objectXML.hasOwnProperty("@setType");
            if (_local_3)
            {
                return (TooltipHelper.wrapInFontTag(_arg_1, ("#" + TooltipHelper.SET_COLOR.toString(16))));
            };
            if (!_local_2)
            {
                return (TooltipHelper.wrapInFontTag(_arg_1, ("#" + TooltipHelper.UNTIERED_COLOR.toString(16))));
            };
            return (_arg_1);
        }

        private function getEffectTag(xml:XML, effectValue:String):XML
        {
            var matches:XMLList;
            var tag:XML;
            matches = xml.Activate.(text() == ActivationType.GENERIC_ACTIVATE);
            for each (tag in matches)
            {
                if (tag.@effect == effectValue)
                {
                    return (tag);
                };
            };
            return (null);
        }

        private function getStatTag(xml:XML, statValue:String):XML
        {
            var matches:XMLList;
            var tag:XML;
            matches = xml.Activate.(text() == ActivationType.STAT_BOOST_AURA);
            for each (tag in matches)
            {
                if (tag.@stat == statValue)
                {
                    return (tag);
                };
            };
            return (null);
        }

        private function addActivateOnEquipTagsToEffectsList():void
        {
            var _local_1:XML;
            var _local_2:Boolean = true;
            for each (_local_1 in this.objectXML.ActivateOnEquip)
            {
                if (_local_2)
                {
                    this.effects.push(new Effect(TextKey.ON_EQUIP, ""));
                    _local_2 = false;
                };
                if (_local_1.toString() == "IncrementStat")
                {
                    this.effects.push(new Effect(TextKey.INCREMENT_STAT, this.getComparedStatText(_local_1)).setReplacementsColor(this.getComparedStatColor(_local_1)));
                };
            };
        }

        private function getComparedStatText(_arg_1:XML):Object
        {
            var _local_2:int = int(_arg_1.@stat);
            var _local_3:int = int(_arg_1.@amount);
            return ({
                "statAmount":(this.prefix(_local_3) + " "),
                "statName":new LineBuilder().setParams(StatData.statToName(_local_2))
            });
        }

        private function prefix(_arg_1:int):String
        {
            var _local_2:String = ((_arg_1 > -1) ? "+" : "");
            return (_local_2 + _arg_1);
        }

        private function getComparedStatColor(activateXML:XML):uint
        {
            var match:XML;
            var otherAmount:int;
            var otherMatches:XMLList;
            var stat:int = int(activateXML.@stat);
            var amount:int = int(activateXML.@amount);
            var textColor:uint = ((this.playerCanUse) ? TooltipHelper.BETTER_COLOR : TooltipHelper.NO_DIFF_COLOR);
            if (this.curItemXML != null)
            {
                otherMatches = this.curItemXML.ActivateOnEquip.(@stat == stat);
            };
            if (((!(otherMatches == null)) && (otherMatches.length() == 1)))
            {
                match = XML(otherMatches[0]);
                otherAmount = int(match.@amount);
                textColor = TooltipHelper.getTextColor((amount - otherAmount));
            };
            if (amount < 0)
            {
                textColor = 0xFF0000;
            };
            return (textColor);
        }

        private function addEquipmentItemRestrictions():void
        {
            if (this.objectXML.hasOwnProperty("PetFood"))
            {
                this.restrictions.push(new Restriction("Used to feed your pet in the pet yard", 0xB3B3B3, false));
            }
            else
            {
                if (this.objectXML.hasOwnProperty("Treasure") == false)
                {
                    this.restrictions.push(new Restriction(TextKey.EQUIP_TO_USE, 0xB3B3B3, false));
                    if (((this.isInventoryFull) || (this.inventoryOwnerType == InventoryOwnerTypes.CURRENT_PLAYER)))
                    {
                        this.restrictions.push(new Restriction(TextKey.DOUBLE_CLICK_EQUIP, 0xB3B3B3, false));
                    }
                    else
                    {
                        this.restrictions.push(new Restriction(TextKey.DOUBLE_CLICK_TAKE, 0xB3B3B3, false));
                    };
                };
            };
        }

        private function addAbilityItemRestrictions():void
        {
            this.restrictions.push(new Restriction(TextKey.KEYCODE_TO_USE, 0xFFFFFF, false));
        }

        private function addConsumableItemRestrictions():void
        {
            this.restrictions.push(new Restriction(TextKey.CONSUMED_WITH_USE, 0xB3B3B3, false));
            if (((this.isInventoryFull) || (this.inventoryOwnerType == InventoryOwnerTypes.CURRENT_PLAYER)))
            {
                this.restrictions.push(new Restriction(TextKey.DOUBLE_CLICK_OR_SHIFT_CLICK_TO_USE, 0xFFFFFF, false));
            }
            else
            {
                this.restrictions.push(new Restriction(TextKey.DOUBLE_CLICK_TAKE_SHIFT_CLICK_USE, 0xFFFFFF, false));
            };
        }

        private function addReusableItemRestrictions():void
        {
            this.restrictions.push(new Restriction(TextKey.CAN_BE_USED_MULTIPLE_TIMES, 0xB3B3B3, false));
            this.restrictions.push(new Restriction(TextKey.DOUBLE_CLICK_OR_SHIFT_CLICK_TO_USE, 0xFFFFFF, false));
        }

        private function makeRestrictionList():void
        {
            var _local_1:XML;
            var _local_2:Boolean;
            var _local_3:int;
            var _local_4:int;
            this.restrictions = new Vector.<Restriction>();
            if ((((this.objectXML.hasOwnProperty("VaultItem")) && (!(this.invType == -1))) && (!(this.invType == ObjectLibrary.idToType_["Vault Chest"]))))
            {
                this.restrictions.push(new Restriction(TextKey.STORE_IN_VAULT, 16549442, true));
            };
            if (this.objectXML.hasOwnProperty("Soulbound"))
            {
                this.restrictions.push(new Restriction(TextKey.ITEM_SOULBOUND, 0xB3B3B3, false));
            };
            if (this.playerCanUse)
            {
                if (this.objectXML.hasOwnProperty("Usable"))
                {
                    this.addAbilityItemRestrictions();
                    this.addEquipmentItemRestrictions();
                }
                else
                {
                    if (this.objectXML.hasOwnProperty("Consumable"))
                    {
                        this.addConsumableItemRestrictions();
                    }
                    else
                    {
                        if (this.objectXML.hasOwnProperty("InvUse"))
                        {
                            this.addReusableItemRestrictions();
                        }
                        else
                        {
                            this.addEquipmentItemRestrictions();
                        };
                    };
                };
            }
            else
            {
                if (this.player != null)
                {
                    this.restrictions.push(new Restriction(TextKey.NOT_USABLE_BY, 16549442, true));
                };
            };
            var _local_5:Vector.<String> = ObjectLibrary.usableBy(this.objectType);
            if (_local_5 != null)
            {
                this.restrictions.push(new Restriction(TextKey.USABLE_BY, 0xB3B3B3, false));
            };
            for each (_local_1 in this.objectXML.EquipRequirement)
            {
                _local_2 = ObjectLibrary.playerMeetsRequirement(_local_1, this.player);
                if (_local_1.toString() == "Stat")
                {
                    _local_3 = int(_local_1.@stat);
                    _local_4 = int(_local_1.@value);
                    this.restrictions.push(new Restriction(((("Requires " + StatData.statToName(_local_3)) + " of ") + _local_4), ((_local_2) ? 0xB3B3B3 : 16549442), ((_local_2) ? false : true)));
                };
            };
        }

        private function makeLineTwo():void
        {
            this.line2 = new LineBreakDesign((MAX_WIDTH - 12), 0);
            addChild(this.line2);
        }

        private function makeLineThree():void
        {
            this.line3 = new LineBreakDesign((MAX_WIDTH - 12), 0);
            addChild(this.line3);
        }

        private function makeRestrictionText():void
        {
            if (this.restrictions.length != 0)
            {
                this.restrictionsText = new TextFieldDisplayConcrete().setSize(14).setColor(0xB3B3B3).setTextWidth((MAX_WIDTH - 4)).setIndent(-10).setLeftMargin(10).setWordWrap(true).setHTML(true);
                this.restrictionsText.setStringBuilder(this.buildRestrictionsLineBuilder());
                this.restrictionsText.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
                waiter.push(this.restrictionsText.textChanged);
                addChild(this.restrictionsText);
            };
        }

        private function makeSetInfoText():void
        {
            if (this.setInfo.length != 0)
            {
                this.setInfoText = new TextFieldDisplayConcrete().setSize(14).setColor(0xB3B3B3).setTextWidth((MAX_WIDTH - 4)).setIndent(-10).setLeftMargin(10).setWordWrap(true).setHTML(true);
                this.setInfoText.setStringBuilder(this.getSetBonusStringBuilder());
                this.setInfoText.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
                waiter.push(this.setInfoText.textChanged);
                addChild(this.setInfoText);
                this.makeLineThree();
            };
        }

        private function getSetBonusStringBuilder():AppendingLineBuilder
        {
            var _local_1:AppendingLineBuilder = new AppendingLineBuilder();
            this.appendEffects(this.setInfo, _local_1);
            return (_local_1);
        }

        private function buildRestrictionsLineBuilder():StringBuilder
        {
            var _local_1:Restriction;
            var _local_2:String;
            var _local_3:String;
            var _local_4:String;
            var _local_5:AppendingLineBuilder = new AppendingLineBuilder();
            for each (_local_1 in this.restrictions)
            {
                _local_2 = ((_local_1.bold_) ? "<b>" : "");
                _local_2 = _local_2.concat((('<font color="#' + _local_1.color_.toString(16)) + '">'));
                _local_3 = "</font>";
                _local_3 = _local_3.concat(((_local_1.bold_) ? "</b>" : ""));
                _local_4 = ((this.player) ? ObjectLibrary.typeToDisplayId_[this.player.objectType_] : "");
                _local_5.pushParams(_local_1.text_, {
                    "unUsableClass":_local_4,
                    "usableClasses":this.getUsableClasses(),
                    "keyCode":KeyCodes.CharCodeStrings[Parameters.data_.useSpecial]
                }, _local_2, _local_3);
            };
            return (_local_5);
        }

        private function getUsableClasses():StringBuilder
        {
            var _local_1:String;
            var _local_2:Vector.<String> = ObjectLibrary.usableBy(this.objectType);
            var _local_3:AppendingLineBuilder = new AppendingLineBuilder();
            _local_3.setDelimiter(", ");
            for each (_local_1 in _local_2)
            {
                _local_3.pushParams(_local_1);
            };
            return (_local_3);
        }

        private function addDescriptionText():void
        {
            this.descText = new TextFieldDisplayConcrete().setSize(14).setColor(0xB3B3B3).setTextWidth(MAX_WIDTH).setWordWrap(true);
            if (this.descriptionOverride)
            {
                this.descText.setStringBuilder(new StaticStringBuilder(this.descriptionOverride));
            }
            else
            {
                this.descText.setStringBuilder(new LineBuilder().setParams(String(this.objectXML.Description)));
            };
            this.descText.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
            waiter.push(this.descText.textChanged);
            addChild(this.descText);
        }

        override protected function alignUI():void
        {
            this.titleText.x = (this.icon.width + 4);
            this.titleText.y = ((this.icon.height / 2) - (this.titleText.height / 2));
            if (this.tierText)
            {
                this.tierText.y = ((this.icon.height / 2) - (this.tierText.height / 2));
                this.tierText.x = (MAX_WIDTH - 30);
            };
            this.descText.x = 4;
            this.descText.y = (this.icon.height + 2);
            if (contains(this.line1))
            {
                this.line1.x = 8;
                this.line1.y = ((this.descText.y + this.descText.height) + 8);
                this.effectsText.x = 4;
                this.effectsText.y = (this.line1.y + 8);
            }
            else
            {
                this.line1.y = (this.descText.y + this.descText.height);
                this.effectsText.y = this.line1.y;
            };
            if (this.setInfoText)
            {
                this.line3.x = 8;
                this.line3.y = ((this.effectsText.y + this.effectsText.height) + 8);
                this.setInfoText.x = 4;
                this.setInfoText.y = (this.line3.y + 8);
                this.line2.x = 8;
                this.line2.y = ((this.setInfoText.y + this.setInfoText.height) + 8);
            }
            else
            {
                this.line2.x = 8;
                this.line2.y = ((this.effectsText.y + this.effectsText.height) + 8);
            };
            var _local_1:uint = (this.line2.y + 8);
            if (this.restrictionsText)
            {
                this.restrictionsText.x = 4;
                this.restrictionsText.y = _local_1;
                _local_1 = (_local_1 + this.restrictionsText.height);
            };
            if (this.powerText)
            {
                if (contains(this.powerText))
                {
                    this.powerText.x = 4;
                    this.powerText.y = _local_1;
                };
            };
        }

        private function buildCategorySpecificText():void
        {
            if (this.curItemXML != null)
            {
                this.comparisonResults = this.slotTypeToTextBuilder.getComparisonResults(this.objectXML, this.curItemXML);
            }
            else
            {
                this.comparisonResults = new SlotComparisonResult();
            };
        }

        private function handleWisMod():void
        {
            var _local_1:XML;
            var _local_2:XML;
            var _local_3:String;
            var _local_4:String;
            if (this.player == null)
            {
                return;
            };
            var _local_5:Number = (this.player.wisdom_ + this.player.wisdomBoost_);
            if (_local_5 < 30)
            {
                return;
            };
            var _local_6:Vector.<XML> = new Vector.<XML>();
            if (this.curItemXML != null)
            {
                this.curItemXML = this.curItemXML.copy();
                _local_6.push(this.curItemXML);
            };
            if (this.objectXML != null)
            {
                this.objectXML = this.objectXML.copy();
                _local_6.push(this.objectXML);
            };
            for each (_local_2 in _local_6)
            {
                for each (_local_1 in _local_2.Activate)
                {
                    _local_3 = _local_1.toString();
                    if (_local_1.@effect != "Stasis")
                    {
                        _local_4 = _local_1.@useWisMod;
                        if (!((((_local_4 == "") || (_local_4 == "false")) || (_local_4 == "0")) || (_local_1.@effect == "Stasis")))
                        {
                            switch (_local_3)
                            {
                                case ActivationType.HEAL_NOVA:
                                    _local_1.@amount = this.modifyWisModStat(_local_1.@amount, 0);
                                    _local_1.@range = this.modifyWisModStat(_local_1.@range);
                                    _local_1.@damage = this.modifyWisModStat(_local_1.@damage, 0);
                                    break;
                                case ActivationType.COND_EFFECT_AURA:
                                    _local_1.@duration = this.modifyWisModStat(_local_1.@duration);
                                    _local_1.@range = this.modifyWisModStat(_local_1.@range);
                                    break;
                                case ActivationType.COND_EFFECT_SELF:
                                    _local_1.@duration = this.modifyWisModStat(_local_1.@duration);
                                    break;
                                case ActivationType.STAT_BOOST_AURA:
                                    _local_1.@amount = this.modifyWisModStat(_local_1.@amount, 0);
                                    _local_1.@duration = this.modifyWisModStat(_local_1.@duration);
                                    _local_1.@range = this.modifyWisModStat(_local_1.@range);
                                    break;
                                case ActivationType.GENERIC_ACTIVATE:
                                    _local_1.@duration = this.modifyWisModStat(_local_1.@duration);
                                    _local_1.@range = this.modifyWisModStat(_local_1.@range);
                                    break;
                            };
                        };
                    };
                };
            };
        }

        private function modifyWisModStat(_arg_1:String, _arg_2:Number=1):String
        {
            var _local_3:Number;
            var _local_4:int;
            var _local_5:Number;
            var _local_6:* = "-1";
            var _local_7:Number = (this.player.wisdom_ + this.player.wisdomBoost_);
            if (_local_7 < 30)
            {
                _local_6 = _arg_1;
            }
            else
            {
                _local_3 = Number(_arg_1);
                _local_4 = ((_local_3 < 0) ? -1 : 1);
                _local_5 = (((_local_3 * _local_7) / 150) + (_local_3 * _local_4));
                _local_5 = (Math.floor((_local_5 * Math.pow(10, _arg_2))) / Math.pow(10, _arg_2));
                if ((_local_5 - (int(_local_5) * _local_4)) >= ((1 / Math.pow(10, _arg_2)) * _local_4))
                {
                    _local_6 = _local_5.toFixed(1);
                }
                else
                {
                    _local_6 = _local_5.toFixed(0);
                };
            };
            return (_local_6);
        }


    }
}//package com.company.assembleegameclient.ui.tooltip

import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

class ComPair
{

    public var a:Number;
    public var b:Number;

    public function ComPair(_arg_1:XML, _arg_2:XML, _arg_3:String, _arg_4:Number=0)
    {
        this.a = (this.b = ((_arg_1.hasOwnProperty(("@" + _arg_3))) ? Number(_arg_1.@[_arg_3]) : _arg_4));
        if (_arg_2)
        {
            this.b = ((_arg_2.hasOwnProperty(("@" + _arg_3))) ? Number(_arg_2.@[_arg_3]) : _arg_4);
        };
    }

    public function add(_arg_1:Number):void
    {
        this.a = (this.a + _arg_1);
        this.b = (this.b + _arg_1);
    }


}

class ComPairTag 
{

    public var a:Number;
    public var b:Number;

    public function ComPairTag(_arg_1:XML, _arg_2:XML, _arg_3:String, _arg_4:Number=0)
    {
        this.a = (this.b = ((_arg_1.hasOwnProperty(_arg_3)) ? _arg_1[_arg_3] : _arg_4));
        if (_arg_2)
        {
            this.b = ((_arg_2.hasOwnProperty(_arg_3)) ? _arg_2[_arg_3] : _arg_4);
        };
    }

    public function add(_arg_1:Number):void
    {
        this.a = (this.a + _arg_1);
        this.b = (this.b + _arg_1);
    }


}

class ComPairTagBool 
{

    public var a:Boolean;
    public var b:Boolean;

    public function ComPairTagBool(_arg_1:XML, _arg_2:XML, _arg_3:String, _arg_4:Boolean=false)
    {
        this.a = (this.b = ((_arg_1.hasOwnProperty(_arg_3)) ? true : _arg_4));
        if (_arg_2)
        {
            this.b = ((_arg_2.hasOwnProperty(_arg_3)) ? true : _arg_4);
        };
    }

}

class Effect 
{

    public var name_:String;
    public var valueReplacements_:Object;
    public var replacementColor_:uint = 16777103;
    public var color_:uint = 0xB3B3B3;

    public function Effect(_arg_1:String, _arg_2:Object)
    {
        this.name_ = _arg_1;
        this.valueReplacements_ = _arg_2;
    }

    public function setColor(_arg_1:uint):Effect
    {
        this.color_ = _arg_1;
        return (this);
    }

    public function setReplacementsColor(_arg_1:uint):Effect
    {
        this.replacementColor_ = _arg_1;
        return (this);
    }

    public function getValueReplacementsWithColor():Object
    {
        var _local_1:String;
        var _local_2:LineBuilder;
        var _local_3:Object = {};
        var _local_4:* = "";
        var _local_5:* = "";
        if (this.replacementColor_)
        {
            _local_4 = (('</font><font color="#' + this.replacementColor_.toString(16)) + '">');
            _local_5 = (('</font><font color="#' + this.color_.toString(16)) + '">');
        };
        for (_local_1 in this.valueReplacements_)
        {
            if ((this.valueReplacements_[_local_1] is AppendingLineBuilder))
            {
                _local_3[_local_1] = this.valueReplacements_[_local_1];
            }
            else
            {
                if ((this.valueReplacements_[_local_1] is LineBuilder))
                {
                    _local_2 = (this.valueReplacements_[_local_1] as LineBuilder);
                    _local_2.setPrefix(_local_4).setPostfix(_local_5);
                    _local_3[_local_1] = _local_2;
                }
                else
                {
                    _local_3[_local_1] = ((_local_4 + this.valueReplacements_[_local_1]) + _local_5);
                };
            };
        };
        return (_local_3);
    }


}

class Restriction 
{

    public var text_:String;
    public var color_:uint;
    public var bold_:Boolean;

    public function Restriction(_arg_1:String, _arg_2:uint, _arg_3:Boolean)
    {
        this.text_ = _arg_1;
        this.color_ = _arg_2;
        this.bold_ = _arg_3;
    }

}


