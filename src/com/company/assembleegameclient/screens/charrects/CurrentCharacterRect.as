//com.company.assembleegameclient.screens.charrects.CurrentCharacterRect

package com.company.assembleegameclient.screens.charrects
{
import com.company.assembleegameclient.appengine.CharacterStats;
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.ui.tooltip.MyPlayerToolTip;
import com.company.assembleegameclient.util.FameUtil;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import io.decagames.rotmg.pets.data.vo.PetVO;

import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;

public class CurrentCharacterRect extends CharacterRect
{

    private static var toolTip_:MyPlayerToolTip = null;
    public static var charnames:Vector.<String> = new Vector.<String>(0);
    public static var charids:Vector.<int> = new Vector.<int>(0);

    public const selected:Signal = new Signal();
    public const deleteCharacter:Signal = new Signal();
    public const showToolTip:Signal = new Signal(Sprite);
    public const hideTooltip:Signal = new Signal();

    public var charName:String;
    public var charStats:CharacterStats;
    public var char:SavedCharacter;
    public var myPlayerToolTipFactory:MyPlayerToolTipFactory = new MyPlayerToolTipFactory();
    private var charType:CharacterClass;
    private var icon:DisplayObject;
    private var petIcon:Bitmap;

    public function CurrentCharacterRect(_arg_1:String, _arg_2:CharacterClass, _arg_3:SavedCharacter, _arg_4:CharacterStats)
    {
        var _local_7:int;
        var _local_8:int;
        super();
        this.charName = _arg_1;
        this.charType = _arg_2;
        this.char = _arg_3;
        this.charStats = _arg_4;
        var _local_5:Array = [this.charType.hp.max, this.charType.mp.max, this.charType.attack.max, this.charType.defense.max, this.charType.speed.max, this.charType.dexterity.max, this.charType.hpRegeneration.max, this.charType.mpRegeneration.max];
        var _local_6:Array = [this.char.charXML_.MaxHitPoints, this.char.charXML_.MaxMagicPoints, this.char.charXML_.Attack, this.char.charXML_.Defense, this.char.charXML_.Speed, this.char.charXML_.Dexterity, this.char.charXML_.HpRegen, this.char.charXML_.MpRegen];
        while (_local_8 < _local_6.length)
        {
            if (_local_6[_local_8] == _local_5[_local_8])
            {
                _local_7++;
            }
            _local_8++;
        }
        var _local_9:String = _arg_2.name;
        var _local_10:* = (_local_7 + "/8");
        super.className = new LineBuilder().setParams(TextKey.CURRENT_CHARACTER_DESCRIPTION, {
            "className":_local_9,
            "level":_local_10
        });
        this.setCharCon(_local_9.toLowerCase(), this.char.charId());
        super.color = 0x5C5C5C;
        super.overColor = 0x7F7F7F;
        super.init();
        this.makeTagline();
        this.addEventListeners();
    }

    private function makePetIcon():void
    {
        var _local_1:PetVO = this.char.getPetVO();
        if (_local_1)
        {
            this.petIcon = _local_1.getSkinBitmap();
            if (this.petIcon == null)
            {
                return;
            }
            this.petIcon.x = -3;
            this.petIcon.y = 12;
            selectContainer.addChild(this.petIcon);
        }
    }

    public function setIcon(_arg_1:DisplayObject):void
    {
        ((this.icon) && (selectContainer.removeChild(this.icon)));
        this.icon = _arg_1;
        this.icon.x = CharacterRectConstants.ICON_POS_X;
        this.icon.y = 0;
        ((this.icon) && (selectContainer.addChild(this.icon)));
        this.makePetIcon();
    }

    private function setCharCon(_arg_1:String, _arg_2:int):void
    {
        var _local_3:int;
        while (_local_3 < charnames.length)
        {
            if (charnames[_local_3] == _arg_1)
            {
                if (charids[_local_3] < _arg_2)
                {
                    _arg_1 = (_arg_1 + "2");
                    charnames.push(_arg_1);
                    charids.push(_arg_2);
                }
                else
                {
                    _arg_1 = (_arg_1 + "2");
                    charnames.push(_arg_1);
                    charids.push(charids[_local_3]);
                    charids[_local_3] = _arg_2;
                }
                return;
            }
            _local_3++;
        }
        charnames.push(_arg_1);
        charids.push(_arg_2);
    }

    private function addEventListeners():void
    {
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        selectContainer.addEventListener(MouseEvent.CLICK, this.onSelect);
        selectContainer.addEventListener(MouseEvent.RIGHT_CLICK, this.onSelectVault);
        selectContainer.addEventListener(MouseEvent.MIDDLE_CLICK, this.onDelete);
    }

    private function onSelect(_arg_1:MouseEvent):void
    {
        this.selected.dispatch(this.char);
    }

    private function onSelectVault(_arg_1:MouseEvent):void
    {
        GameServerConnectionConcrete.vaultSelect = true;
        this.selected.dispatch(this.char);
    }

    private function onDelete(_arg_1:MouseEvent):void
    {
        this.deleteCharacter.dispatch(this.char);
    }

    private function makeTagline():void
    {
        if (this.getNextStarFame() > 0)
        {
            super.makeTaglineIcon();
            super.makeTaglineText(new LineBuilder().setParams((((this.char.fame() + "/") + this.getNextStarFame()) + " Fame")));
            taglineText.x = (taglineText.x + taglineIcon.width);
        }
        else
        {
            super.makeTaglineText(new LineBuilder().setParams((this.char.fame() + " Fame")));
        }
    }

    private function getNextStarFame():int
    {
        return (FameUtil.nextStarFame(((this.charStats == null) ? 0 : this.charStats.bestFame()), this.char.fame()));
    }

    override protected function onMouseOver(_arg_1:MouseEvent):void
    {
        super.onMouseOver(_arg_1);
        this.removeToolTip();
        toolTip_ = this.myPlayerToolTipFactory.create(this.charName, this.char.charXML_, this.charStats);
        toolTip_.createUI();
        this.showToolTip.dispatch(toolTip_);
    }

    override protected function onRollOut(_arg_1:MouseEvent):void
    {
        super.onRollOut(_arg_1);
        this.removeToolTip();
    }

    private function onRemovedFromStage(_arg_1:Event):void
    {
        selectContainer.removeEventListener(MouseEvent.CLICK, this.onSelect);
        selectContainer.removeEventListener(MouseEvent.RIGHT_CLICK, this.onSelectVault);
        selectContainer.removeEventListener(MouseEvent.MIDDLE_CLICK, this.onDelete);
        this.removeToolTip();
    }

    private function removeToolTip():void
    {
        this.hideTooltip.dispatch();
    }


}
}//package com.company.assembleegameclient.screens.charrects

