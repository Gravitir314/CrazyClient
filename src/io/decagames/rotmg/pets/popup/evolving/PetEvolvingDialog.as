//io.decagames.rotmg.pets.popup.evolving.PetEvolvingDialog

package io.decagames.rotmg.pets.popup.evolving
{
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.greensock.TimelineMax;
import com.greensock.TweenLite;
import com.greensock.easing.Sine;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import io.decagames.rotmg.pets.config.AnimationConfig;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.popups.modal.ModalPopup;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.messaging.impl.EvolvePetInfo;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class PetEvolvingDialog extends ModalPopup
    {

        private var contentInset:SliceScalingBitmap;
        private var info:EvolvePetInfo;
        private var initialPetImage:Bitmap;
        private var finalPetImage:Bitmap;
        private var animationContainer:Sprite;
        private var animationTimeline:TimelineMax;
        private var _okButton:SliceScalingButton;

        public function PetEvolvingDialog(info:EvolvePetInfo, unlockedSkin:Boolean)
        {
            var animationSpiral:SliceScalingBitmap;
            var maskImage:SliceScalingBitmap;
            var whiteRectangle:Sprite;
            var flashDuration:Number;
            var spinDuration:Number;
            var spinAngle:int;
            var hideDuration:Number;
            super(270, 180, LineBuilder.getLocalizedStringFromKey("EvolveDialog.title"));
            _popupFadeAlpha = 0.8;
            TweenPlugin.activate([TintPlugin]);
            this.info = info;
            this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", 270);
            addChild(this.contentInset);
            this.contentInset.height = 130;
            this.contentInset.x = 0;
            this.contentInset.y = 0;
            this.initialPetImage = this.getTypeBitmap(info.initialPet.skinType, 80);
            this.finalPetImage = this.getTypeBitmap(info.finalPet.skinType, 80);
            animationSpiral = TextureParser.instance.getSliceScalingBitmap("UI", "animation_spiral");
            animationSpiral.x = (this.contentInset.x + Math.round(((this.contentInset.width - animationSpiral.width) / 2)));
            animationSpiral.y = (this.contentInset.y + Math.round(((this.contentInset.height - animationSpiral.height) / 2)));
            this.animationContainer = new Sprite();
            this.animationContainer.x = this.contentInset.x;
            this.animationContainer.y = this.contentInset.y;
            addChild(this.animationContainer);
            maskImage = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", this.contentInset.width);
            maskImage.height = this.contentInset.height;
            maskImage.x = this.contentInset.x;
            maskImage.y = this.contentInset.y;
            maskImage.cacheAsBitmap = true;
            this.animationContainer.cacheAsBitmap = true;
            addChild(maskImage);
            this.animationContainer.mask = maskImage;
            this.initialPetImage.x = (this.contentInset.x + Math.round(((this.contentInset.width - this.initialPetImage.width) / 2)));
            this.initialPetImage.y = (this.contentInset.y + Math.round(((this.contentInset.height - this.initialPetImage.height) / 2)));
            this.finalPetImage.x = (this.contentInset.x + Math.round(((this.contentInset.width - this.finalPetImage.width) / 2)));
            this.finalPetImage.y = (this.contentInset.y + Math.round(((this.contentInset.height - this.finalPetImage.height) / 2)));
            this.animationContainer.addChild(this.initialPetImage);
            whiteRectangle = new Sprite();
            whiteRectangle.graphics.beginFill(0xFFFFFF);
            whiteRectangle.graphics.drawRect(0, 0, this.contentInset.width, this.contentInset.height);
            whiteRectangle.graphics.endFill();
            whiteRectangle.alpha = 0;
            flashDuration = AnimationConfig.FLASH_ANIMATION_DURATION;
            spinDuration = AnimationConfig.SPIN_ANIMATION_DURATION;
            spinAngle = AnimationConfig.SPIN_ANIMATION_ANGLE;
            hideDuration = 0.1;
            this.animationTimeline = new TimelineMax();
            this.animationTimeline.to(this.initialPetImage, 0, {"tint":0xFFFFFF});
            this.animationTimeline.to(this.initialPetImage, 0.3, {"tint":null});
            this.animationTimeline.to(this.initialPetImage, 0, {"tint":0xFFFFFF});
            this.animationTimeline.to(this.initialPetImage, 0.3, {
                "tint":null,
                "onComplete":function ():void
                {
                    animationContainer.addChild(finalPetImage);
                    animationContainer.removeChild(initialPetImage);
                    animationContainer.addChild(whiteRectangle);
                }
            });
            this.animationTimeline.to(this.finalPetImage, 0, {
                "tint":0xFFFFFF,
                "transformAroundCenter":{"scale":1.2}
            });
            this.animationTimeline.to(whiteRectangle, 0.1, {
                "alpha":1,
                "ease":Sine.easeIn,
                "onComplete":function ():void
                {
                    var textInfo:* = undefined;
                    TweenLite.to(whiteRectangle, flashDuration, {
                        "alpha":0,
                        "ease":Sine.easeOut,
                        "overwrite":false
                    });
                    TweenLite.to(finalPetImage, flashDuration, {
                        "tint":null,
                        "transformAroundCenter":{"scale":1}
                    });
                    animationContainer.addChild(animationSpiral);
                    animationContainer.addChild(finalPetImage);
                    var petNameLabel:* = new UILabel();
                    DefaultLabelFormat.petNameLabel(petNameLabel, internal::info.finalPet.rarity.color);
                    petNameLabel.y = (contentInset.y + 15);
                    petNameLabel.width = _contentWidth;
                    petNameLabel.wordWrap = true;
                    petNameLabel.text = internal::info.finalPet.name;
                    animationContainer.addChild(petNameLabel);
                    if (unlockedSkin)
                    {
                        textInfo = new UILabel();
                        DefaultLabelFormat.newSkinHatched(textInfo);
                        textInfo.y = ((contentInset.y + contentInset.height) - 30);
                        textInfo.width = _contentWidth;
                        textInfo.wordWrap = true;
                        textInfo.text = "New Pet Skin added to your Wardrobe!";
                        animationContainer.addChild(textInfo);
                    }
                    animationContainer.addChild(whiteRectangle);
                    TweenLite.to(animationSpiral, spinDuration, {
                        "transformAroundCenter":{"rotation":spinAngle},
                        "ease":Sine.easeOut
                    });
                    TweenLite.to(animationSpiral, hideDuration, {
                        "alpha":0,
                        "delay":(spinDuration - 0.2),
                        "overwrite":false,
                        "ease":Sine.easeIn,
                        "onComplete":function ():void
                        {
                            animationContainer.removeChild(whiteRectangle);
                            animationContainer.removeChild(animationSpiral);
                        }
                    });
                }
            });
            this.animationTimeline.play();
            this._okButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this._okButton.setLabel(LineBuilder.getLocalizedStringFromKey("ErrorDialog.ok"), DefaultLabelFormat.questButtonCompleteLabel);
            this._okButton.width = 149;
            this._okButton.x = Math.round(((_contentWidth - this._okButton.width) / 2));
            this._okButton.y = (_contentHeight - this._okButton.height);
            addChild(this._okButton);
        }

        public function get okButton():SliceScalingButton
        {
            return (this._okButton);
        }

        private function getTypeBitmap(_arg_1:int, _arg_2:int):Bitmap
        {
            var _local_3:String = ObjectLibrary.getIdFromType(_arg_1);
            var _local_4:XML = ObjectLibrary.getXMLfromId(_local_3);
            var _local_5:String = _local_4.AnimatedTexture.File;
            var _local_6:int = _local_4.AnimatedTexture.Index;
            var _local_7:AnimatedChar = AnimatedChars.getAnimatedChar(_local_5, _local_6);
            var _local_8:MaskedImage = _local_7.imageFromAngle(0, AnimatedChar.STAND, 0);
            var _local_9:BitmapData = TextureRedrawer.resize(_local_8.image_, _local_8.mask_, _arg_2, true, 0, 0);
            _local_9 = GlowRedrawer.outlineGlow(_local_9, 0, 6);
            return (new Bitmap(_local_9));
        }


    }
}//package io.decagames.rotmg.pets.popup.evolving

