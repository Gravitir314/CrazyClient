// Decompiled by AS3 Sorcerer 5.72
// www.as3sorcerer.com

//io.decagames.rotmg.ui.popups.PopupView

package io.decagames.rotmg.ui.popups{
import flash.display.DisplayObject;
import flash.display.Sprite;

public class PopupView extends Sprite {

    private var popupContainer:Sprite;
    private var fadeContainer:Sprite;
    protected var popupFadeColor:uint = 0x151515;
    protected var popupFadeAlpha:Number = 0.6;

    public function PopupView(){
        this.popupContainer = new Sprite();
        this.fadeContainer = new Sprite();
        super.addChild(this.popupContainer);
        super.addChild(this.fadeContainer);
    }

    override public function addChild(_arg_1:DisplayObject):DisplayObject{
        return (this.popupContainer.addChild(_arg_1));
    }

    override public function removeChild(_arg_1:DisplayObject):DisplayObject{
        return (this.popupContainer.removeChild(_arg_1));
    }

    public function showFade():void{
        this.fadeContainer.graphics.beginFill(this.popupFadeColor, this.popupFadeAlpha);
        this.fadeContainer.graphics.drawRect(0, 0, 800, 600);
        this.fadeContainer.graphics.endFill();
    }

    public function removeFade():void{
        this.fadeContainer.graphics.clear();
    }


}
}//package io.decagames.rotmg.ui.popups

