// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.ui.view.QuestHealthBar

package kabam.rotmg.ui.view
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Party;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.ui.StatusBar;
import com.company.assembleegameclient.ui.options.Options;

import flash.display.Sprite;
import flash.utils.getTimer;

import kabam.rotmg.chat.control.TextHandler;

import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;

public class QuestHealthBar extends Sprite
    {

        private var questBar:StatusBar;
        private var questBar2:StatusBar;
        private var questBar3:StatusBar;
        private var nextUpdate:int = 0;
        private var showstr:String;
        public var gs_:GameSprite;

        public function QuestHealthBar()
        {
            this.questBar = new StatusBar(194, 16, 12919330, 0x545454, "Quest", true, true);
            this.questBar2 = new StatusBar(194, 16, 12919330, 0x545454, "Quest", true, true);
            this.questBar3 = new StatusBar(194, 16, 12919330, 0x545454, "Quest", true, true);
            this.questBar.visible = false;
            this.questBar2.visible = false;
            this.questBar3.visible = false;
            this.questBar2.x = 198;
            this.questBar3.x = 396;
            addChild(this.questBar);
            addChild(this.questBar2);
            addChild(this.questBar3);
        }

        private function genClosest(_arg_1:Player):String
        {
            var _local_2:GameObject;
            var _local_3:GameObject;
            var _local_4:int;
            var _local_5:int = int.MAX_VALUE;
            for each (_local_2 in _arg_1.map_.goDict_)
            {
                if ((_local_2 is Player))
                {
                    _local_4 = Math.sqrt((((_local_2.x_ - _arg_1.questMob.x_) * (_local_2.x_ - _arg_1.questMob.x_)) + ((_local_2.y_ - _arg_1.questMob.y_) * (_local_2.y_ - _arg_1.questMob.y_))));
                    if (_local_4 < _local_5)
                    {
                        _local_5 = _local_4;
                        _local_3 = _local_2;
                    }
                }
            }
            return (((" - " + _local_3.name_) + ": ") + _local_5);
        }

        public function update(_arg_1:Player):void
        {
            if ((!Parameters.data_.questHUD) || (Options.hidden))
            {
                this.questBar.visible = false;
                this.questBar2.visible = false;
                this.questBar3.visible = false;
                return;
            }
            var _local_2:GameObject;
            var _local_3:int;
            var _local_4:* = "";
            if (((!(_arg_1.questMob == null)) || (!(_arg_1.questMob1 == null))))
            {
                _local_2 = ((_arg_1.questMob1) || (_arg_1.questMob));
                this.questBar.draw(_local_2.hp_, _local_2.maxHP_, 0);
                _local_3 = _local_2.objectType_;
                if (_local_3 == 3368)
                {
                    _local_4 = ((((Parameters.data_.tombHack) && (Parameters.data_.curBoss == 3368)) && (_local_2 == _arg_1.questMob1)) ? ": Active" : "");
                }
                if (!(_arg_1.questMob == null))
                {
                    if (this.nextUpdate <= getTimer())
                    {
                        this.showstr = this.genClosest(_arg_1);
                        this.nextUpdate = (getTimer() + 250);
                    }
                    _local_4 = this.showstr;
                }
                this.questBar.setLabelText((ObjectLibrary.typeToDisplayId_[_local_2.objectType_] + _local_4));
                this.questBar.visible = true;
            }
            else
            {
                this.questBar.visible = false;
            }
            if (_arg_1.questMob2 != null)
            {
                this.questBar2.draw(_arg_1.questMob2.hp_, _arg_1.questMob2.maxHP_, 0);
                _local_4 = (((Parameters.data_.tombHack) && (Parameters.data_.curBoss == 3366)) ? ": Active" : "");
                this.questBar2.setLabelText((ObjectLibrary.typeToDisplayId_[_arg_1.questMob2.objectType_] + _local_4));
                this.questBar2.visible = true;
            }
            else
            {
                this.questBar2.visible = false;
            }
            if (_arg_1.questMob3 != null)
            {
                this.questBar3.draw(_arg_1.questMob3.hp_, _arg_1.questMob3.maxHP_, 0);
                _local_4 = (((Parameters.data_.tombHack) && (Parameters.data_.curBoss == 3367)) ? ": Active" : "");
                this.questBar3.setLabelText((ObjectLibrary.typeToDisplayId_[_arg_1.questMob3.objectType_] + _local_4));
                this.questBar3.visible = true;
            }
            else
            {
                this.questBar3.visible = false;
            }
        }


    }
}//package kabam.rotmg.ui.view

