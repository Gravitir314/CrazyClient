//io.decagames.rotmg.pets.components.petSkinsCollection.PetSkinsCollectionMediator

package io.decagames.rotmg.pets.components.petSkinsCollection
{
import io.decagames.rotmg.pets.components.petIcon.PetIconFactory;
import io.decagames.rotmg.pets.data.PetsModel;
import io.decagames.rotmg.pets.data.family.PetFamilyKeys;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PetSkinsCollectionMediator extends Mediator 
    {

        [Inject]
        public var view:PetSkinsCollection;
        [Inject]
        public var model:PetsModel;
        [Inject]
        public var petIconFactory:PetIconFactory;


        override public function initialize():void
        {
            this.drawCollection();
        }

        private function drawCollection():void
        {
            this.view.addPetSkins(PetFamilyKeys.KEYS.Aquatic, this.model.getPetsSkinsFromFamily("Aquatic"));
            this.view.addPetSkins(PetFamilyKeys.KEYS.Automaton, this.model.getPetsSkinsFromFamily("Automaton"));
            this.view.addPetSkins(PetFamilyKeys.KEYS.Avian, this.model.getPetsSkinsFromFamily("Avian"));
            this.view.addPetSkins(PetFamilyKeys.KEYS.Canine, this.model.getPetsSkinsFromFamily("Canine"));
            this.view.addPetSkins(PetFamilyKeys.KEYS.Exotic, this.model.getPetsSkinsFromFamily("Exotic"));
            this.view.addPetSkins(PetFamilyKeys.KEYS.Farm, this.model.getPetsSkinsFromFamily("Farm"));
            this.view.addPetSkins(PetFamilyKeys.KEYS.Feline, this.model.getPetsSkinsFromFamily("Feline"));
            this.view.addPetSkins(PetFamilyKeys.KEYS.Humanoid, this.model.getPetsSkinsFromFamily("Humanoid"));
            this.view.addPetSkins(PetFamilyKeys.KEYS.Insect, this.model.getPetsSkinsFromFamily("Insect"));
            this.view.addPetSkins(PetFamilyKeys.KEYS.Penguin, this.model.getPetsSkinsFromFamily("Penguin"));
            this.view.addPetSkins(PetFamilyKeys.KEYS.Reptile, this.model.getPetsSkinsFromFamily("Reptile"));
            this.view.addPetSkins(PetFamilyKeys.KEYS.Spooky, this.model.getPetsSkinsFromFamily("Spooky"));
            this.view.addPetSkins(PetFamilyKeys.KEYS.Woodland, this.model.getPetsSkinsFromFamily("Woodland"));
            this.view.addPetSkins("? ? ? ?", this.model.getPetsSkinsFromFamily("? ? ? ?"));
        }


    }
}//package io.decagames.rotmg.pets.components.petSkinsCollection

