//kabam.rotmg.arena.service.ArenaLeaderboardFactory

package kabam.rotmg.arena.service
{
import com.company.util.ConversionUtil;

import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
import kabam.rotmg.arena.model.CurrentArenaRunModel;
import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.pets.data.PetVO;

public class ArenaLeaderboardFactory 
    {

        [Inject]
        public var classesModel:ClassesModel;
        [Inject]
        public var factory:CharacterFactory;
        [Inject]
        public var currentRunModel:CurrentArenaRunModel;


        public function makeEntries(_arg_1:XMLList):Vector.<ArenaLeaderboardEntry>
        {
            var _local_2:XML;
            var _local_3:Vector.<ArenaLeaderboardEntry> = new Vector.<ArenaLeaderboardEntry>();
            var _local_4:int = 1;
            for each (_local_2 in _arg_1)
            {
                _local_3.push(this.makeArenaEntry(_local_2, _local_4));
                _local_4++;
            }
            _local_3 = this.removeDuplicateUser(_local_3);
            return (this.addCurrentRun(_local_3));
        }

        private function addCurrentRun(_arg_1:Vector.<ArenaLeaderboardEntry>):Vector.<ArenaLeaderboardEntry>
        {
            var _local_2:Boolean;
            var _local_3:Boolean;
            var _local_4:ArenaLeaderboardEntry;
            var _local_5:Vector.<ArenaLeaderboardEntry> = new Vector.<ArenaLeaderboardEntry>();
            if (this.currentRunModel.hasEntry())
            {
                _local_2 = false;
                _local_3 = false;
                for each (_local_4 in _arg_1)
                {
                    if (((!(_local_2)) && (this.currentRunModel.entry.isBetterThan(_local_4))))
                    {
                        this.currentRunModel.entry.rank = _local_4.rank;
                        _local_5.push(this.currentRunModel.entry);
                        _local_2 = true;
                    }
                    if (_local_4.isPersonalRecord)
                    {
                        _local_3 = true;
                    }
                    if (_local_2)
                    {
                        _local_4.rank++;
                    }
                    _local_5.push(_local_4);
                }
                if ((((_local_5.length < 20) && (!(_local_2))) && (!(_local_3))))
                {
                    this.currentRunModel.entry.rank = (_local_5.length + 1);
                    _local_5.push(this.currentRunModel.entry);
                }
            }
            return ((_local_5.length > 0) ? _local_5 : _arg_1);
        }

        private function removeDuplicateUser(_arg_1:Vector.<ArenaLeaderboardEntry>):Vector.<ArenaLeaderboardEntry>
        {
            var _local_2:Boolean;
            var _local_3:ArenaLeaderboardEntry;
            var _local_4:ArenaLeaderboardEntry;
            var _local_5:int = -1;
            if (this.currentRunModel.hasEntry())
            {
                _local_2 = false;
                _local_3 = this.currentRunModel.entry;
                for each (_local_4 in _arg_1)
                {
                    if (((_local_4.isPersonalRecord) && (_local_3.isBetterThan(_local_4))))
                    {
                        _local_5 = (_local_4.rank - 1);
                        _local_2 = true;
                    }
                    else
                    {
                        if (_local_2)
                        {
                            _local_4.rank--;
                        }
                    }
                }
            }
            if (_local_5 != -1)
            {
                _arg_1.splice(_local_5, 1);
            }
            return (_arg_1);
        }

        private function makeArenaEntry(_arg_1:XML, _arg_2:int):ArenaLeaderboardEntry
        {
            var _local_3:PetVO;
            var _local_4:XML;
            var _local_5:ArenaLeaderboardEntry = new ArenaLeaderboardEntry();
            _local_5.isPersonalRecord = _arg_1.hasOwnProperty("IsPersonalRecord");
            _local_5.runtime = _arg_1.Time;
            _local_5.name = _arg_1.PlayData.CharacterData.Name;
            _local_5.rank = ((_arg_1.hasOwnProperty("Rank")) ? _arg_1.Rank : _arg_2);
            var _local_6:int = _arg_1.PlayData.CharacterData.Texture;
            var _local_7:int = _arg_1.PlayData.CharacterData.Class;
            var _local_8:CharacterClass = this.classesModel.getCharacterClass(_local_7);
            var _local_9:CharacterSkin = _local_8.skins.getSkin(_local_6);
            var _local_10:int = ((_arg_1.PlayData.CharacterData.hasOwnProperty("Tex1")) ? _arg_1.PlayData.CharacterData.Tex1 : 0);
            var _local_11:int = ((_arg_1.PlayData.CharacterData.hasOwnProperty("Tex2")) ? _arg_1.PlayData.CharacterData.Tex2 : 0);
            _local_5.playerBitmap = this.factory.makeIcon(_local_9.template, ((_local_9.is16x16) ? 50 : 100), _local_10, _local_11);
            _local_5.equipment = ConversionUtil.toIntVector(_arg_1.PlayData.CharacterData.Inventory);
            _local_5.slotTypes = _local_8.slotTypes;
            _local_5.guildName = _arg_1.PlayData.CharacterData.GuildName;
            _local_5.guildRank = _arg_1.PlayData.CharacterData.GuildRank;
            _local_5.currentWave = _arg_1.WaveNumber;
            if (_arg_1.PlayData.hasOwnProperty("Pet"))
            {
                _local_3 = new PetVO();
                _local_4 = new XML(_arg_1.PlayData.Pet);
                _local_3.apply(_local_4);
                _local_5.pet = _local_3;
            }
            return (_local_5);
        }


    }
}//package kabam.rotmg.arena.service

