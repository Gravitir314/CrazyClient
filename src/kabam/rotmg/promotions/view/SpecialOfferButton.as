//kabam.rotmg.promotions.view.SpecialOfferButton

package kabam.rotmg.promotions.view
{
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.assets.services.IconFactory;
import kabam.rotmg.packages.view.BasePackageButton;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.ui.UIUtils;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class SpecialOfferButton extends BasePackageButton
{

	public static const NOTIFICATION_BACKGROUND_WIDTH:Number = 120;
	public static const NOTIFICATION_BACKGROUND_HEIGHT:Number = 25;
	private static const FONT_SIZE:int = 16;

	public var clicked:Signal;
	private var goldIcon:DisplayObject;
	private var clickArea:Sprite;
	private var buttonLabel:TextFieldDisplayConcrete;
	private var _isSpecialOfferAvailable:Boolean;
	private var _isPackageOffer:Boolean;

	public function SpecialOfferButton(_arg_1:Boolean)
	{
		this._isPackageOffer = _arg_1;
		this.init();
	}

	private function init():void
	{
		this.clicked = new NativeMappedSignal(this, MouseEvent.CLICK);
		tabChildren = false;
		tabEnabled = false;
		this.makeUI();
		this.makeLabelText();
	}

	public function destroy():void
	{
		parent.removeChild(this);
	}

	private function makeUI():void
	{
		this.clickArea = UIUtils.makeHUDBackground(NOTIFICATION_BACKGROUND_WIDTH, NOTIFICATION_BACKGROUND_HEIGHT);
		addChild(this.clickArea);
		this.goldIcon = new Bitmap(IconFactory.makeCoin());
		this.goldIcon.x = 3;
		this.goldIcon.y = 3;
		addChild(this.goldIcon);
	}

	private function makeLabelText():void
	{
		this.buttonLabel = new TextFieldDisplayConcrete().setSize(FONT_SIZE).setColor(0xFFFFFF);
		this.buttonLabel.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
		this.buttonLabel.textChanged.addOnce(this.onTextChanged);
		this.buttonLabel.setStringBuilder(new StaticStringBuilder("Special Offer"));
		addChild(this.buttonLabel);
	}

	private function onTextChanged():void
	{
		positionText(this.goldIcon, this.buttonLabel);
	}

	public function get isSpecialOfferAvailable():Boolean
	{
		return (this._isSpecialOfferAvailable);
	}

	public function set isSpecialOfferAvailable(_arg_1:Boolean):void
	{
		this._isSpecialOfferAvailable = _arg_1;
	}

	public function get isPackageOffer():Boolean
	{
		return (this._isPackageOffer);
	}

}
}//package kabam.rotmg.promotions.view

