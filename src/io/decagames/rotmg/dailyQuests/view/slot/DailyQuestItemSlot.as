// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot

package io.decagames.rotmg.dailyQuests.view.slot
{
import com.company.assembleegameclient.objects.ObjectLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;

public class DailyQuestItemSlot extends Sprite 
    {

        public static const SLOT_SIZE:int = 40;

        private var _itemID:int;
        private var _type:String;
        private var imageContainer:Sprite;

        public function DailyQuestItemSlot(_arg_1:int, _arg_2:String, _arg_3:Boolean=false)
        {
            this._itemID = _arg_1;
            this._type = _arg_2;
            this.imageContainer = new Sprite();
            addChild(this.imageContainer);
            this.imageContainer.x = Math.round((SLOT_SIZE / 2));
            this.imageContainer.y = Math.round((SLOT_SIZE / 2));
            this.createBackground(_arg_3);
            this.addItem();
        }

        private function createBackground(_arg_1:Boolean=false):void
        {
            var _local_2:Shape;
            _local_2 = new Shape();
            _local_2.graphics.beginFill(((_arg_1) ? uint(0x13A000) : uint(0x454545)), 1);
            _local_2.graphics.drawRect(0, 0, SLOT_SIZE, SLOT_SIZE);
            _local_2.x = -(Math.round((SLOT_SIZE / 2)));
            _local_2.y = -(Math.round((SLOT_SIZE / 2)));
            this.imageContainer.addChild(_local_2);
        }

        private function addItem():void
        {
            var _local_1:Bitmap;
            var _local_2:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this._itemID, (SLOT_SIZE * 2), true, false);
            _local_1 = new Bitmap(_local_2);
            _local_1.x = -(Math.round((_local_1.width / 2)));
            _local_1.y = -(Math.round((_local_1.height / 2)));
            this.imageContainer.addChild(_local_1);
        }

        public function get itemID():int
        {
            return (this._itemID);
        }

        public function get type():String
        {
            return (this._type);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.slot

