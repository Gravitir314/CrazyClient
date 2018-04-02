// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.servers.model.LiveServerModel

package kabam.rotmg.servers.model
{
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.servers.api.LatLong;
import kabam.rotmg.servers.api.Server;
import kabam.rotmg.servers.api.ServerModel;

public class LiveServerModel implements ServerModel
    {

        private const servers:Vector.<Server> = new Vector.<Server>(0);

        [Inject]
        public var model:PlayerModel;
        private var _descendingFlag:Boolean;


        public function setServers(_arg_1:Vector.<Server>):void
        {
            var _local_2:Server;
            this.servers.length = 0;
            for each (_local_2 in _arg_1)
            {
                this.servers.push(_local_2);
            };
            this._descendingFlag = false;
        }

        public function getServers():Vector.<Server>
        {
            return (this.servers);
        }

        public function getServer():Server
        {
            var _local_1:Server;
            var _local_2:int;
            var _local_3:Number;
            var _local_4:Server;
            var _local_5:Boolean = this.model.isAdmin();
            var _local_6:LatLong = this.model.getMyPos();
            var _local_7:Number = Number.MAX_VALUE;
            var _local_8:int = int.MAX_VALUE;
            for each (_local_1 in this.servers)
            {
                if (!_local_5)
                {
                    if (_local_1.name == Parameters.data_.preferredServer)
                    {
                        return (_local_1);
                    };
                    _local_2 = _local_1.priority();
                    _local_3 = LatLong.distance(_local_6, _local_1.latLong);
                    if (((_local_2 < _local_8) || ((_local_2 == _local_8) && (_local_3 < _local_7))))
                    {
                        _local_4 = _local_1;
                        _local_7 = _local_3;
                        _local_8 = _local_2;
                    };
                };
            };
            return (_local_4);
        }

        public function getServerNameByAddress(_arg_1:String):String
        {
            var _local_2:Server;
            for each (_local_2 in this.servers)
            {
                if (_local_2.address == _arg_1)
                {
                    return (_local_2.name);
                };
            };
            return ("");
        }

        public function isServerAvailable():Boolean
        {
            return (this.servers.length > 0);
        }

        private function compareServerName(_arg_1:Server, _arg_2:Server):int
        {
            if (_arg_1.name < _arg_2.name)
            {
                return ((this._descendingFlag) ? -1 : 1);
            };
            if (_arg_1.name > _arg_2.name)
            {
                return ((this._descendingFlag) ? 1 : -1);
            };
            return (0);
        }


    }
}//package kabam.rotmg.servers.model

