// Decompiled by AS3 Sorcerer 5.64
// www.as3sorcerer.com

//kabam.rotmg.ui.view.CharacterDetailsView

package kabam.rotmg.ui.view{
import flash.display.Sprite;
import org.osflash.signals.Signal;
import com.company.assembleegameclient.ui.icons.IconButtonFactory;
import com.company.assembleegameclient.objects.ImageFactory;
import flash.display.Bitmap;
import com.company.assembleegameclient.ui.icons.IconButton;
import io.decagames.rotmg.ui.labels.UILabel;
import org.osflash.signals.natives.NativeSignal;
import flash.events.MouseEvent;
import com.company.assembleegameclient.ui.BoostPanelButton;
import com.company.assembleegameclient.ui.ExperienceBoostTimerPopup;
import kabam.rotmg.text.model.TextKey;
import com.company.assembleegameclient.objects.Player;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;

public class CharacterDetailsView extends Sprite {

    public static const NEXUS_BUTTON:String = "NEXUS_BUTTON";
    public static const OPTIONS_BUTTON:String = "OPTIONS_BUTTON";
    public static const IMAGE_SET_NAME:String = "lofiInterfaceBig";
    public static const NEXUS_IMAGE_ID:int = 6;
    public static const OPTIONS_IMAGE_ID:int = 5;

    public var gotoNexus:Signal = new Signal();
    public var gotoOptions:Signal = new Signal();
    public var iconButtonFactory:IconButtonFactory;
    public var imageFactory:ImageFactory;
    private var portrait_:Bitmap = new Bitmap(null);
    private var button:IconButton;
    private var nameText_:UILabel;
    private var nexusClicked:NativeSignal = new NativeSignal(button, MouseEvent.CLICK);
    private var optionsClicked:NativeSignal = new NativeSignal(button, MouseEvent.CLICK);
    private var boostPanelButton:BoostPanelButton;
    private var expTimer:ExperienceBoostTimerPopup;
    public var friendsBtn:IconButton;
    private var indicator:Sprite;


    public function init(_arg_1:String, _arg_2:String):void{
        this.indicator = new Sprite();
        this.indicator.graphics.beginFill(823807);
        this.indicator.graphics.drawCircle(0, 0, 4);
        this.indicator.graphics.endFill();
        this.indicator.x = 13;
        this.indicator.y = -5;
        this.createPortrait();
        this.createNameText(_arg_1);
        this.createButton(_arg_2);
    }

    private function createButton(_arg_1:String):void{
        if (_arg_1 == NEXUS_BUTTON){
            this.button = this.iconButtonFactory.create(this.imageFactory.getImageFromSet(IMAGE_SET_NAME, NEXUS_IMAGE_ID), "", TextKey.CHARACTER_DETAILS_VIEW_NEXUS, "escapeToNexus", 6);
            this.nexusClicked = new NativeSignal(this.button, MouseEvent.CLICK, MouseEvent);
            this.nexusClicked.add(this.onNexusClick);
        } else {
            if (_arg_1 == OPTIONS_BUTTON){
                this.button = this.iconButtonFactory.create(this.imageFactory.getImageFromSet(IMAGE_SET_NAME, OPTIONS_IMAGE_ID), "", TextKey.CHARACTER_DETAILS_VIEW_OPTIONS, "options", 6);
                this.optionsClicked = new NativeSignal(this.button, MouseEvent.CLICK, MouseEvent);
                this.optionsClicked.add(this.onOptionsClick);
            };
        };
        this.button.x = 172;
        this.button.y = 12;
        addChild(this.button);
    }

    public function addInvitationIndicator():void{
        if (this.friendsBtn){
            this.friendsBtn.addChild(this.indicator);
        };
    }

    public function clearInvitationIndicator():void{
        if (((this.indicator) && (this.indicator.parent))){
            this.indicator.parent.removeChild(this.indicator);
        };
    }

    public function initFriendList(_arg_1:ImageFactory, _arg_2:IconButtonFactory, _arg_3:Function, _arg_4:Boolean):void{
        this.friendsBtn = _arg_2.create(_arg_1.getImageFromSet("lofiInterfaceBig", 13), "", TextKey.OPTIONS_FRIEND, "", 6);
        this.friendsBtn.x = 146;
        this.friendsBtn.y = 12;
        this.friendsBtn.addEventListener(MouseEvent.CLICK, _arg_3);
        addChild(this.friendsBtn);
        if (_arg_4){
            this.addInvitationIndicator();
        };
    }

    private function createPortrait():void{
        this.portrait_.x = -2;
        this.portrait_.y = -8;
        addChild(this.portrait_);
    }

    private function createNameText(_arg_1:String):void{
        this.nameText_ = new UILabel();
        this.nameText_.x = 35;
        this.nameText_.y = 6;
        this.setName(_arg_1);
        addChild(this.nameText_);
    }

    public function update(_arg_1:Player):void{
        this.portrait_.bitmapData = _arg_1.getPortrait();
    }

    public function draw(_arg_1:Player):void{
        if (this.expTimer){
            this.expTimer.update(_arg_1.xpTimer);
        };
        if (((_arg_1.tierBoost) || (_arg_1.dropBoost))){
            this.boostPanelButton = ((this.boostPanelButton) || (new BoostPanelButton(_arg_1)));
            if (this.portrait_){
                this.portrait_.x = 13;
            };
            if (this.nameText_){
                this.nameText_.x = 47;
            };
            this.boostPanelButton.x = 6;
            this.boostPanelButton.y = 5;
            addChild(this.boostPanelButton);
        } else {
            if (this.boostPanelButton){
                removeChild(this.boostPanelButton);
                this.boostPanelButton = null;
                this.portrait_.x = -2;
                this.nameText_.x = 36;
            };
        };
    }

    private function onNexusClick(_arg_1:MouseEvent):void{
        this.gotoNexus.dispatch();
    }

    private function onOptionsClick(_arg_1:MouseEvent):void{
        this.gotoOptions.dispatch();
    }

    public function setName(_arg_1:String):void{
        this.nameText_.text = _arg_1;
        DefaultLabelFormat.characterViewNameLabel(this.nameText_);
    }


}
}//package kabam.rotmg.ui.view

