// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.pets.view.components.PetsTabContentView

package kabam.rotmg.pets.view.components
{
import flash.display.Bitmap;
import flash.display.Sprite;

import kabam.rotmg.pets.data.PetFamilyKeys;
import kabam.rotmg.pets.data.PetRarityEnum;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class PetsTabContentView extends Sprite
    {

        public var petBitmap:Bitmap;
        private var petsContent:Sprite = new Sprite();
        public var petRarityTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 13, false);
        private var tabTitleTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 15, true);
        private var petFamilyTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 13, false);
        private var petVO:PetVO;


        public function init(_arg_1:PetVO):void
        {
            this.petVO = _arg_1;
            this.petBitmap = _arg_1.getSkin();
            this.addChildren();
            this.addAbilities();
            this.positionChildren();
            this.updateTextFields();
            _arg_1.updated.add(this.onUpdate);
        }

        private function onUpdate():void
        {
            this.updatePetBitmap();
            this.petRarityTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.getRarity()));
        }

        private function updatePetBitmap():void
        {
            this.petsContent.removeChild(this.petBitmap);
            this.petBitmap = this.petVO.getSkin();
            this.petsContent.addChild(this.petBitmap);
        }

        private function addAbilities():void
        {
            var _local_1:uint;
            var _local_2:PetAbilityDisplay;
            var _local_3:uint = 3;
            _local_1 = 0;
            while (_local_1 < _local_3)
            {
                _local_2 = new PetAbilityDisplay(this.petVO.abilityList[_local_1], 171);
                _local_2.x = 3;
                _local_2.y = (72 + (17 * _local_1));
                this.petsContent.addChild(_local_2);
                _local_1++;
            }
        }

        private function getNumAbilities():uint
        {
            var _local_1:Boolean = ((this.petVO.getRarity() == PetRarityEnum.DIVINE.value) || (this.petVO.getRarity() == PetRarityEnum.LEGENDARY.value));
            if (_local_1)
            {
                return (2);
            }
            return (3);
        }

        private function updateTextFields():void
        {
            this.tabTitleTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.getName()));
            this.petRarityTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.getRarity()));
            this.petFamilyTextField.setStringBuilder(new LineBuilder().setParams(PetFamilyKeys.getTranslationKey(this.petVO.getFamily())));
        }

        private function addChildren():void
        {
            this.petsContent.addChild(this.petBitmap);
            this.petsContent.addChild(this.tabTitleTextField);
            this.petsContent.addChild(this.petRarityTextField);
            this.petsContent.addChild(this.petFamilyTextField);
            addChild(this.petsContent);
        }

        private function positionChildren():void
        {
            this.petBitmap.x = (this.petBitmap.x - 8);
            this.petBitmap.y--;
            this.petsContent.x = 7;
            this.petsContent.y = 6;
            this.tabTitleTextField.x = 45;
            this.tabTitleTextField.y = 20;
            this.petRarityTextField.x = 45;
            this.petRarityTextField.y = 33;
            this.petFamilyTextField.x = 45;
            this.petFamilyTextField.y = 47;
        }


    }
}//package kabam.rotmg.pets.view.components

