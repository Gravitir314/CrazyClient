// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.account.ui.OfferRadioButtons

package com.company.assembleegameclient.account.ui
{
import com.company.assembleegameclient.account.ui.components.Selectable;
import com.company.assembleegameclient.account.ui.components.SelectionGroup;
import com.company.assembleegameclient.util.offer.Offer;
import com.company.assembleegameclient.util.offer.Offers;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.lib.ui.api.Layout;
import kabam.lib.ui.impl.VerticalLayout;
import kabam.rotmg.account.core.model.MoneyConfig;

public class OfferRadioButtons extends Sprite 
    {

        private var offers:Offers;
        private var config:MoneyConfig;
        private var choices:Vector.<OfferRadioButton>;
        private var group:SelectionGroup;

        public function OfferRadioButtons(_arg_1:Offers, _arg_2:MoneyConfig)
        {
            this.offers = _arg_1;
            this.config = _arg_2;
            this.makeGoldChoices();
            this.alignGoldChoices();
            this.makeSelectionGroup();
        }

        public function getChoice():OfferRadioButton
        {
            return (this.group.getSelected() as OfferRadioButton);
        }

        private function makeGoldChoices():void
        {
            var _local_1:int;
            var _local_2:int = this.offers.offerList.length;
            this.choices = new Vector.<OfferRadioButton>(_local_2, true);
            while (_local_1 < _local_2)
            {
                this.choices[_local_1] = this.makeGoldChoice(this.offers.offerList[_local_1]);
                _local_1++;
            }
        }

        private function makeGoldChoice(_arg_1:Offer):OfferRadioButton
        {
            var _local_2:OfferRadioButton = new OfferRadioButton(_arg_1, this.config);
            _local_2.addEventListener(MouseEvent.CLICK, this.onSelected);
            addChild(_local_2);
            return (_local_2);
        }

        private function onSelected(_arg_1:MouseEvent):void
        {
            var _local_2:Selectable = (_arg_1.currentTarget as Selectable);
            this.group.setSelected(_local_2.getValue());
        }

        private function alignGoldChoices():void
        {
            var _local_1:Vector.<DisplayObject> = this.castChoicesToDisplayList();
            var _local_2:Layout = new VerticalLayout();
            _local_2.setPadding(5);
            _local_2.layout(_local_1);
        }

        private function castChoicesToDisplayList():Vector.<DisplayObject>
        {
            var _local_1:int;
            var _local_2:int = this.choices.length;
            var _local_3:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
            while (_local_1 < _local_2)
            {
                _local_3[_local_1] = this.choices[_local_1];
                _local_1++;
            }
            return (_local_3);
        }

        private function makeSelectionGroup():void
        {
            var _local_1:Vector.<Selectable> = this.castBoxesToSelectables();
            this.group = new SelectionGroup(_local_1);
            this.group.setSelected(this.choices[0].getValue());
        }

        private function castBoxesToSelectables():Vector.<Selectable>
        {
            var _local_1:int;
            var _local_2:int = this.choices.length;
            var _local_3:Vector.<Selectable> = new Vector.<Selectable>(0);
            while (_local_1 < _local_2)
            {
                _local_3[_local_1] = this.choices[_local_1];
                _local_1++;
            }
            return (_local_3);
        }

        public function showBonuses(_arg_1:Boolean):void
        {
            var _local_2:int = this.choices.length;
            while (_local_2--)
            {
                this.choices[_local_2].showBonus(_arg_1);
            }
        }


    }
}//package com.company.assembleegameclient.account.ui

