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
import flash.geom.Matrix;

import io.decagames.rotmg.utils.colors.GreyScale;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class DailyQuestItemSlot extends Sprite
{
    public static const SELECTED_BORDER_SIZE:int = 2;
    public static const SLOT_SIZE:int = 40;

    private var _itemID:int;
    private var _type:String;
    private var bitmapFactory:BitmapTextFactory;
    private var imageContainer:Sprite;
    private var _isSlotsSelectable:Boolean;
    private var _selected:Boolean;
    private var backgroundShape:Shape;
    private var hasItem:Boolean;
    private var imageBitmap:Bitmap;

    public function DailyQuestItemSlot(_arg_1:int, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false)
    {
        this._itemID = _arg_1;
        this._type = _arg_2;
        this._isSlotsSelectable = _arg_4;
        this.hasItem = _arg_3;
        this.imageBitmap = new Bitmap();
        this.imageContainer = new Sprite();
        addChild(this.imageContainer);
        this.imageContainer.x = Math.round((SLOT_SIZE / 2));
        this.imageContainer.y = Math.round((SLOT_SIZE / 2));
        this.createBackground();
        this.renderItem();
    }

    private function createBackground():void{
        if (!this.backgroundShape){
            this.backgroundShape = new Shape();
            this.imageContainer.addChild(this.backgroundShape);
        }
        this.backgroundShape.graphics.clear();
        if (this.isSlotsSelectable){
            if (this._selected){
                this.backgroundShape.graphics.beginFill(14846006, 1);
                this.backgroundShape.graphics.drawRect(-(SELECTED_BORDER_SIZE), -(SELECTED_BORDER_SIZE), (SLOT_SIZE + (SELECTED_BORDER_SIZE * 2)), (SLOT_SIZE + (SELECTED_BORDER_SIZE * 2)));
                this.backgroundShape.graphics.beginFill(14846006, 1);
            } else {
                this.backgroundShape.graphics.beginFill(0x454545, 1);
            }
        } else {
            this.backgroundShape.graphics.beginFill(((this.hasItem) ? 0x13A000 : 0x454545), 1);
        }
        this.backgroundShape.graphics.drawRect(0, 0, SLOT_SIZE, SLOT_SIZE);
        this.backgroundShape.x = -(Math.round(((SLOT_SIZE + (SELECTED_BORDER_SIZE * 2)) / 2)));
        this.backgroundShape.y = -(Math.round(((SLOT_SIZE + (SELECTED_BORDER_SIZE * 2)) / 2)));
    }

    private function renderItem():void{
        var _local_3:BitmapData;
        var _local_4:Matrix;
        if (this.imageBitmap.bitmapData){
            this.imageBitmap.bitmapData.dispose();
        }
        var _local_1:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this._itemID, (SLOT_SIZE * 2), true);
        _local_1 = _local_1.clone();
        var _local_2:XML = ObjectLibrary.xmlLibrary_[this._itemID];
        this.bitmapFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
        if ((((_local_2) && (_local_2.hasOwnProperty("Quantity"))) && (this.bitmapFactory))){
            _local_3 = this.bitmapFactory.make(new StaticStringBuilder(String(_local_2.Quantity)), 12, 0xFFFFFF, false, new Matrix(), true);
            _local_4 = new Matrix();
            _local_4.translate(8, 7);
            _local_1.draw(_local_3, _local_4);
        }
        this.imageBitmap.bitmapData = _local_1;
        if (((this.isSlotsSelectable) && (!(this._selected)))){
            GreyScale.setGreyScale(_local_1);
        }
        if (!this.imageBitmap.parent){
            this.imageBitmap.x = -(Math.round((this.imageBitmap.width / 2)));
            this.imageBitmap.y = -(Math.round((this.imageBitmap.height / 2)));
            this.imageContainer.addChild(this.imageBitmap);
        }
    }

    public function set selected(_arg_1:Boolean):void{
        this._selected = _arg_1;
        this.createBackground();
        this.renderItem();
    }

    public function dispose():void{
        if (((this.imageBitmap) && (this.imageBitmap.bitmapData))){
            this.imageBitmap.bitmapData.dispose();
        }
    }

    public function get itemID():int
    {
        return (this._itemID);
    }

    public function get type():String
    {
        return (this._type);
    }

    public function get isSlotsSelectable():Boolean{
        return (this._isSlotsSelectable);
    }

    public function get selected():Boolean{
        return (this._selected);
    }


}
}//package io.decagames.rotmg.dailyQuests.view.slot

