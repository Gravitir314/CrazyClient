//io.decagames.rotmg.pets.components.petSkinsCollection.PetSkinsCollection

package io.decagames.rotmg.pets.components.petSkinsCollection
{
import flash.display.Sprite;

import io.decagames.rotmg.pets.components.petSkinSlot.PetSkinSlot;
import io.decagames.rotmg.pets.data.vo.SkinVO;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.gird.UIGrid;
import io.decagames.rotmg.ui.gird.UIGridElement;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.scroll.UIScrollbar;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;
import io.decagames.rotmg.utils.colors.Tint;

public class PetSkinsCollection extends Sprite
    {

        public static var COLLECTION_WIDTH:int = 360;
        public static const COLLECTION_HEIGHT:int = 425;

        private var collectionContainer:Sprite;
        private var contentInset:SliceScalingBitmap;
        private var contentTitle:SliceScalingBitmap;
        private var title:UILabel;
        private var contentGrid:UIGrid;
        private var contentElement:UIGridElement;
        private var petGrid:UIGrid;

        public function PetSkinsCollection(_arg_1:int, _arg_2:int)
        {
            var _local_3:SliceScalingBitmap;
            var _local_4:UILabel;
            super();
            this.contentGrid = new UIGrid((COLLECTION_WIDTH - 40), 1, 15);
            this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", COLLECTION_WIDTH);
            addChild(this.contentInset);
            this.contentInset.height = COLLECTION_HEIGHT;
            this.contentInset.x = 0;
            this.contentInset.y = 0;
            this.contentTitle = TextureParser.instance.getSliceScalingBitmap("UI", "content_title_decoration", COLLECTION_WIDTH);
            addChild(this.contentTitle);
            this.contentTitle.x = 0;
            this.contentTitle.y = 0;
            this.title = new UILabel();
            this.title.text = "Collection";
            DefaultLabelFormat.petNameLabel(this.title, 0xFFFFFF);
            this.title.width = COLLECTION_WIDTH;
            this.title.wordWrap = true;
            this.title.y = 4;
            this.title.x = 0;
            addChild(this.title);
            _local_3 = TextureParser.instance.getSliceScalingBitmap("UI", "content_divider_smalltitle_white", 94);
            Tint.add(_local_3, 0x333333, 1);
            addChild(_local_3);
            _local_3.x = Math.round(((COLLECTION_WIDTH - _local_3.width) / 2));
            _local_3.y = 23;
            _local_4 = new UILabel();
            DefaultLabelFormat.wardrobeCollectionLabel(_local_4);
            _local_4.text = ((_arg_1 + "/") + _arg_2);
            _local_4.width = _local_3.width;
            _local_4.wordWrap = true;
            _local_4.y = (_local_3.y + 1);
            _local_4.x = _local_3.x;
            addChild(_local_4);
            this.createScrollview();
        }

        private function createScrollview():void
        {
            var _local_1:Sprite;
            var _local_2:UIScrollbar;
            var _local_3:Sprite;
            _local_1 = new Sprite();
            this.collectionContainer = new Sprite();
            this.collectionContainer.x = this.contentInset.x;
            this.collectionContainer.y = 2;
            this.collectionContainer.addChild(this.contentGrid);
            _local_1.addChild(this.collectionContainer);
            _local_2 = new UIScrollbar((COLLECTION_HEIGHT - 57));
            _local_2.mouseRollSpeedFactor = 1;
            _local_2.scrollObject = this;
            _local_2.content = this.collectionContainer;
            _local_1.addChild(_local_2);
            _local_2.x = ((this.contentInset.x + this.contentInset.width) - 25);
            _local_2.y = 7;
            _local_3 = new Sprite();
            _local_3.graphics.beginFill(0);
            _local_3.graphics.drawRect(0, 0, COLLECTION_WIDTH, 380);
            _local_3.x = this.collectionContainer.x;
            _local_3.y = this.collectionContainer.y;
            this.collectionContainer.mask = _local_3;
            _local_1.addChild(_local_3);
            addChild(_local_1);
            _local_1.y = 42;
        }

        private function sortByName(_arg_1:SkinVO, _arg_2:SkinVO):int
        {
            if (_arg_1.name > _arg_2.name)
            {
                return (1);
            }
            return (-1);
        }

        private function sortByRarity(_arg_1:SkinVO, _arg_2:SkinVO):int
        {
            if (_arg_1.rarity.ordinal == _arg_2.rarity.ordinal)
            {
                return (this.sortByName(_arg_1, _arg_2));
            }
            if (_arg_1.rarity.ordinal > _arg_2.rarity.ordinal)
            {
                return (1);
            }
            return (-1);
        }

        public function addPetSkins(_arg_1:String, _arg_2:Vector.<SkinVO>):void
        {
            var _local_5:SkinVO;
            if (_arg_2 == null)
            {
                return;
            }
            var _local_3:int;
            var _local_4:int;
            this.petGrid = new UIGrid((COLLECTION_WIDTH - 40), 7, 5);
            _arg_2 = _arg_2.sort(this.sortByRarity);
            for each (_local_5 in _arg_2)
            {
                this.petGrid.addGridElement(new PetSkinSlot(_local_5, true));
                _local_3++;
                if (_local_5.isOwned)
                {
                    _local_4++;
                }
            }
            this.petGrid.x = 10;
            this.petGrid.y = 25;
            var _local_6:PetFamilyContainer = new PetFamilyContainer(_arg_1, _local_4, _local_3);
            _local_6.addChild(this.petGrid);
            this.contentGrid.addGridElement(_local_6);
        }


    }
}//package io.decagames.rotmg.pets.components.petSkinsCollection

