//kabam.rotmg.dailyLogin.view.ItemTileRenderer

package kabam.rotmg.dailyLogin.view
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.EquipmentTile;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;
import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix;

import kabam.rotmg.constants.ItemConstants;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.dailyLogin.config.CalendarSettings;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.swiftsuspenders.Injector;

public class ItemTileRenderer extends Sprite
    {

        protected static const DIM_FILTER:Array = [new ColorMatrixFilter([0.4, 0, 0, 0, 0, 0, 0.4, 0, 0, 0, 0, 0, 0.4, 0, 0, 0, 0, 0, 1, 0])];
        private static const IDENTITY_MATRIX:Matrix = new Matrix();
        private static const DOSE_MATRIX:Matrix = (function ():Matrix
        {
            var _local_1:* = new Matrix();
            _local_1.translate(10, 5);
            return (_local_1);
        })();

        private var itemId:int;
        private var bitmapFactory:BitmapTextFactory;
        private var tooltip:ToolTip;
        private var itemBitmap:Bitmap;

        public function ItemTileRenderer(_arg_1:int)
        {
            this.itemId = _arg_1;
            this.itemBitmap = new Bitmap();
            addChild(this.itemBitmap);
            this.drawTile();
            this.addEventListener(MouseEvent.MOUSE_OVER, this.onTileHover);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.onTileOut);
        }

        private function onTileOut(_arg_1:MouseEvent):void
        {
            var _local_2:Injector = StaticInjectorContext.getInjector();
            var _local_3:HideTooltipsSignal = _local_2.getInstance(HideTooltipsSignal);
            _local_3.dispatch();
        }

        private function onTileHover(_arg_1:MouseEvent):void
        {
            if (!stage)
            {
                return;
            }
            var _local_2:ItemTile = (_arg_1.currentTarget as ItemTile);
            this.addToolTipToTile(_local_2);
        }

        private function addToolTipToTile(_arg_1:ItemTile):void
        {
            var _local_2:String;
            if (this.itemId > 0)
            {
                this.tooltip = new EquipmentToolTip(this.itemId, null, -1, "");
            }
            else
            {
                if ((_arg_1 is EquipmentTile))
                {
                    _local_2 = ItemConstants.itemTypeToName((_arg_1 as EquipmentTile).itemType);
                }
                else
                {
                    _local_2 = TextKey.ITEM;
                }
                this.tooltip = new TextToolTip(0x363636, 0x9B9B9B, null, TextKey.ITEM_EMPTY_SLOT, 200, {"itemType":TextKey.wrapForTokenResolution(_local_2)});
            }
            this.tooltip.attachToTarget(_arg_1);
            var _local_3:Injector = StaticInjectorContext.getInjector();
            var _local_4:ShowTooltipSignal = _local_3.getInstance(ShowTooltipSignal);
            _local_4.dispatch(this.tooltip);
        }

        public function drawTile():void
        {
            var _local_1:BitmapData;
            var _local_2:XML;
            var _local_3:BitmapData;
            var _local_4:int = this.itemId;
            if (_local_4 != ItemConstants.NO_ITEM)
            {
                if (((_local_4 >= 0x9000) && (_local_4 < 0xF000)))
                {
                    _local_4 = 36863;
                }
                _local_1 = ObjectLibrary.getRedrawnTextureFromType(_local_4, CalendarSettings.ITEM_SIZE, true);
                _local_2 = ObjectLibrary.xmlLibrary_[_local_4];
                if ((((_local_2) && (_local_2.hasOwnProperty("Doses"))) && (this.bitmapFactory)))
                {
                    _local_1 = _local_1.clone();
                    _local_3 = this.bitmapFactory.make(new StaticStringBuilder(String(_local_2.Doses)), 12, 0xFFFFFF, false, IDENTITY_MATRIX, false);
                    _local_1.draw(_local_3, DOSE_MATRIX);
                }
                if ((((_local_2) && (_local_2.hasOwnProperty("Quantity"))) && (this.bitmapFactory)))
                {
                    _local_1 = _local_1.clone();
                    _local_3 = this.bitmapFactory.make(new StaticStringBuilder(String(_local_2.Quantity)), 12, 0xFFFFFF, false, IDENTITY_MATRIX, false);
                    _local_1.draw(_local_3, DOSE_MATRIX);
                }
                this.itemBitmap.bitmapData = _local_1;
                this.itemBitmap.x = (-(_local_1.width) / 2);
                this.itemBitmap.y = (-(_local_1.width) / 2);
                visible = true;
            }
            else
            {
                visible = false;
            }
        }


    }
}//package kabam.rotmg.dailyLogin.view

