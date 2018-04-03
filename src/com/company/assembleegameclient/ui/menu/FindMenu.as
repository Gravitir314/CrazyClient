// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.menu.FindMenu

package com.company.assembleegameclient.ui.menu
{
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.DeprecatedClickableText;
import com.company.assembleegameclient.ui.PlayerGameObjectListItem;

import flash.events.MouseEvent;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;

public class FindMenu extends Frame
    {

        private const perRow:int = 5;
        private const padX:int = 130;
        private const padY:int = 28;

        public var gs_:GameSprite;
        public var closeDialogs:CloseDialogsSignal;
        public var p_:Vector.<Player>;

        public function FindMenu(_arg_1:GameSprite, _arg_2:Vector.<Player>, _arg_3:String)
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:DeprecatedClickableText;
            var _local_7:PlayerGameObjectListItem;
            var _local_8:DeprecatedClickableText;
            var _local_9:DeprecatedClickableText;
            super((_arg_3 + " (Click to trade)"), "", "");
            this.gs_ = _arg_1;
            this.p_ = _arg_2;
            _local_4 = this.p_.length;
            this.w_ = (12 + (((_local_4 < this.perRow) ? this.p_.length : this.perRow) * this.padX));
            this.h_ = ((int((_local_4 / this.perRow)) * this.padY) + 75);
            if ((_local_4 % this.perRow) > 0)
            {
                h_ = (h_ + this.padY);
            }
            this.closeDialogs = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
            while (_local_5 < _local_4)
            {
                _local_7 = new PlayerGameObjectListItem(0xB3B3B3, false, this.p_[_local_5], false, this.p_[_local_5].lastAltAttack_);
                _local_7.x = (this.padX * (_local_5 % this.perRow));
                _local_7.y = (28 + (this.padY * int((_local_5 / this.perRow))));
                addChild(_local_7);
                _local_7.addEventListener(MouseEvent.CLICK, this.onClick);
                _local_5++;
            }
            _local_6 = new DeprecatedClickableText(18, true, "Close");
            _local_6.buttonMode = true;
            _local_6.x = (w_ - 100);
            _local_6.y = (h_ - 40);
            addChild(_local_6);
            _local_6.addEventListener(MouseEvent.CLICK, this.onClose);
            if (_local_4 > 1) {
                _local_9 = new DeprecatedClickableText(18,true, "Lock");
                _local_9.buttonMode = true;
                _local_9.x = (w_ - 175);
                _local_9.y = (h_ - 40);
                addChild(_local_9);
                _local_9.addEventListener(MouseEvent.CLICK, this.lockAllFunc);
                _local_8 = new DeprecatedClickableText(18, true, "Trade");
                _local_8.buttonMode = true;
                _local_8.x = (w_ - 250);
                _local_8.y = (h_ - 40);
                addChild(_local_8);
                _local_8.addEventListener(MouseEvent.CLICK, this.tradeAllFunc);
            }
        }

        private function onClick(_arg_1:MouseEvent):void
        {
            var _local_2:GameObject = (_arg_1.currentTarget as PlayerGameObjectListItem).go;
            this.gs_.gsc_.requestTrade(_local_2.name_);
        }

        private function tradeAllFunc(_arg_1:MouseEvent):void
        {
            var _local_1:Player;
            for each (_local_1 in this.p_)
            {
                this.gs_.gsc_.requestTrade(_local_1.name_);
            };
            this.closeDialogs.dispatch();
        }

        private function lockAllFunc(_arg_1:MouseEvent):void
        {
            var _local_1:Player;
            for each (_local_1 in this.p_)
            {
                this.gs_.map.party_.lockPlayer(_local_1);
            };
            this.closeDialogs.dispatch();
        }

        private function onClose(_arg_1:MouseEvent):void
        {
            this.closeDialogs.dispatch();
        }


    }
}//package com.company.assembleegameclient.ui.menu

