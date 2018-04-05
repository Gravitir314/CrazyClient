// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.screens.charrects.PotionsNeededDisplay

package com.company.assembleegameclient.screens.charrects
{
import com.company.assembleegameclient.appengine.SavedCharacter;

import flash.display.Sprite;

import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.PlayerModel;

import org.swiftsuspenders.Injector;

public class PotionsNeededDisplay extends Sprite 
    {

        private var classes:ClassesModel;
        private var model:PlayerModel;
        private var needed:Array = [0, 0, 0, 0, 0, 0, 0, 0];
        private var potions:Array = [2793, 2794, 2591, 2592, 2593, 2636, 2612, 2613];

        public function PotionsNeededDisplay()
        {
            var _local_1:SavedCharacter;
            var _local_2:CharacterClass;
            var _local_3:int;
            var _local_4:int;
            var _local_5:Array;
            var _local_6:Array;
            var _local_7:int;
            var _local_8:int;
            super();
            var _local_9:Injector = StaticInjectorContext.getInjector();
            this.classes = _local_9.getInstance(ClassesModel);
            this.model = _local_9.getInstance(PlayerModel);
            var _local_10:Vector.<SavedCharacter> = this.model.getSavedCharacters();
            for each (_local_1 in _local_10)
            {
                _local_2 = this.classes.getCharacterClass(_local_1.objectType());
                _local_5 = [_local_2.hp.max, _local_2.mp.max, _local_2.attack.max, _local_2.defense.max, _local_2.speed.max, _local_2.dexterity.max, _local_2.hpRegeneration.max, _local_2.mpRegeneration.max];
                _local_6 = [_local_1.charXML_.MaxHitPoints, _local_1.charXML_.MaxMagicPoints, _local_1.charXML_.Attack, _local_1.charXML_.Defense, _local_1.charXML_.Speed, _local_1.charXML_.Dexterity, _local_1.charXML_.HpRegen, _local_1.charXML_.MpRegen];
                _local_7 = 0;
                while (_local_7 < 8)
                {
                    _local_3 = _local_5[_local_7];
                    _local_4 = _local_6[_local_7];
                    if (_local_3 > _local_4)
                    {
                        if (_local_7 > 1)
                        {
                            this.needed[_local_7] = (this.needed[_local_7] + (_local_3 - _local_4));
                        }
                        else
                        {
                            _local_8 = (_local_3 - _local_4);
                            if ((_local_8 % 5) == 0)
                            {
                                this.needed[_local_7] = (this.needed[_local_7] + int(((_local_3 - _local_4) / 5)));
                            }
                            else
                            {
                                this.needed[_local_7] = (this.needed[_local_7] + (int(((_local_3 - _local_4) / 5)) + 1));
                            }
                        }
                    }
                    _local_7++;
                }
            }
            this.drawDisplay();
        }

        private function drawDisplay():void
        {
            var _local_1:PotionNeededDisplay;
            var _local_3:int;
            var _local_2:int = 70;
            while (_local_3 < 8)
            {
                _local_1 = new PotionNeededDisplay(this.potions[_local_3], this.needed[_local_3]);
                _local_1.x = (_local_2 * _local_3);
                addChild(_local_1);
                _local_3++;
            }
        }


    }
}//package com.company.assembleegameclient.screens.charrects

