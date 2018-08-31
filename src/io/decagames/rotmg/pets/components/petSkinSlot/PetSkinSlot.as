//io.decagames.rotmg.pets.components.petSkinSlot.PetSkinSlot

package io.decagames.rotmg.pets.components.petSkinSlot
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import io.decagames.rotmg.pets.components.tooltip.PetTooltip;
import io.decagames.rotmg.pets.data.vo.IPetVO;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.gird.UIGridElement;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.utils.colors.GreyScale;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;

import org.osflash.signals.Signal;

public class PetSkinSlot extends UIGridElement implements TooltipAble
    {

        public static const SLOT_SIZE:int = 40;

        private var _skinVO:IPetVO;
        private var skinBitmap:Bitmap;
        private var _isSkinSelectableSlot:Boolean;
        private var _selected:Boolean;
        private var _manualUpdate:Boolean;
        private var newLabel:Sprite;
        public var hoverTooltipDelegate:HoverTooltipDelegate = new HoverTooltipDelegate();
        public var updatedVOSignal:Signal = new Signal();

        public function PetSkinSlot(_arg_1:IPetVO, _arg_2:Boolean)
        {
            this._skinVO = _arg_1;
            this._isSkinSelectableSlot = _arg_2;
            this.renderSlotBackground();
            this.updateTooltip();
        }

        private function updateTooltip():void
        {
            if (this._skinVO)
            {
                if (!this.hoverTooltipDelegate.getDisplayObject())
                {
                    this.hoverTooltipDelegate.setDisplayObject(this);
                }
                this.hoverTooltipDelegate.tooltip = new PetTooltip(this._skinVO);
            }
        }

        public function set selected(_arg_1:Boolean):void
        {
            this._selected = _arg_1;
            this.renderSlotBackground();
        }

        private function renderSlotBackground():void
        {
            this.graphics.clear();
            this.graphics.beginFill(((this._selected) ? 15306295 : (((this._isSkinSelectableSlot) && (this._skinVO.isOwned)) ? this._skinVO.rarity.backgroundColor : 0x1D1D1D)));
            this.graphics.drawRect(0, 0, SLOT_SIZE, SLOT_SIZE);
        }

        public function get skinVO():IPetVO
        {
            return (this._skinVO);
        }

        public function set skinVO(_arg_1:IPetVO):void
        {
            this._skinVO = _arg_1;
            this.updateTooltip();
            this.updatedVOSignal.dispatch();
        }

        public function addSkin(_arg_1:BitmapData):void
        {
            this.clearSkinBitmap();
            if (_arg_1 == null)
            {
                this.graphics.clear();
                return;
            }
            this.renderSlotBackground();
            this.clearNewLabel();
            if (((this._isSkinSelectableSlot) && (!(this._skinVO.isOwned))))
            {
                _arg_1 = GreyScale.setGreyScale(_arg_1);
            }
            this.skinBitmap = new Bitmap(_arg_1);
            this.skinBitmap.x = Math.round(((SLOT_SIZE - _arg_1.width) / 2));
            this.skinBitmap.y = Math.round(((SLOT_SIZE - _arg_1.height) / 2));
            addChild(this.skinBitmap);
            if (this._skinVO.isNew)
            {
                this.newLabel = this.createNewLabel(24);
                addChild(this.newLabel);
            }
        }

        private function createNewLabel(_arg_1:int):Sprite{

            var _local_2:Sprite = new Sprite();
            _local_2.graphics.beginFill(0xFFFFFF);
            _local_2.graphics.drawRect(0, 0, _arg_1, 9);
            _local_2.graphics.endFill();
            var _local_3:UILabel = new UILabel();
            DefaultLabelFormat.newSkinLabel(_local_3);
            _local_3.width = _arg_1;
            _local_3.wordWrap = true;
            _local_3.text = "NEW";
            _local_3.y = -1;
            _local_2.addChild(_local_3);
            return (_local_2);
        }

        public function clearNewLabel():void
        {
            if (((this.newLabel) && (this.newLabel.parent)))
            {
                removeChild(this.newLabel);
            }
        }

        override public function dispose():void
        {
            this.clearSkinBitmap();
            super.dispose();
        }

        public function get isSkinSelectableSlot():Boolean
        {
            return (this._isSkinSelectableSlot);
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

        private function clearSkinBitmap():void
        {
            if (((this.skinBitmap) && (this.skinBitmap.bitmapData)))
            {
                this.skinBitmap.bitmapData.dispose();
            }
        }

        public function get manualUpdate():Boolean
        {
            return (this._manualUpdate);
        }

        public function set manualUpdate(_arg_1:Boolean):void
        {
            this._manualUpdate = _arg_1;
        }


    }
}//package io.decagames.rotmg.pets.components.petSkinSlot

