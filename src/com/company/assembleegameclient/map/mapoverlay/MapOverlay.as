// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.map.mapoverlay.MapOverlay

package com.company.assembleegameclient.map.mapoverlay
{
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.options.Options;

import flash.display.Sprite;

import kabam.rotmg.game.view.components.QueuedStatusText;
import kabam.rotmg.game.view.components.QueuedStatusTextList;

public class MapOverlay extends Sprite
    {

        private const speechBalloons:Object = {};
        private const queuedText:Object = {};

        public function MapOverlay()
        {
            mouseEnabled = true;
            mouseChildren = true;
        }

        public function addSpeechBalloon(_arg_1:SpeechBalloon):void
        {
            var _local_2:int = _arg_1.go_.objectId_;
            var _local_3:SpeechBalloon = this.speechBalloons[_local_2];
            if (((_local_3) && (contains(_local_3))))
            {
                removeChild(_local_3);
            }
            this.speechBalloons[_local_2] = _arg_1;
            addChild(_arg_1);
        }

        public function addStatusText(_arg_1:CharacterStatusText):void
        {
            if (!Options.hidden && Parameters.lowCPUMode && _arg_1.go_ != _arg_1.go_.map_.player_){
                return;
            }
            addChild(_arg_1);
        }

        public function addQueuedText(_arg_1:QueuedStatusText):void
        {
            if (!Options.hidden && Parameters.lowCPUMode && _arg_1.go_ != _arg_1.go_.map_.player_){
                return;
            }
            this.addStatusText((_arg_1 as CharacterStatusText));
        }

        private function makeQueuedStatusTextList():QueuedStatusTextList
        {
            var _local_1:QueuedStatusTextList = new QueuedStatusTextList();
            _local_1.target = this;
            return (_local_1);
        }

        public function draw(_arg_1:Camera, _arg_2:int):void
        {
            var _local_3:IMapOverlayElement;
            var _local_4:int;
            while (_local_4 < numChildren)
            {
                _local_3 = (getChildAt(_local_4) as IMapOverlayElement);
                if (((!(_local_3)) || (_local_3.draw(_arg_1, _arg_2))))
                {
                    _local_4++;
                }
                else
                {
                    _local_3.dispose();
                }
            }
        }


    }
}//package com.company.assembleegameclient.map.mapoverlay

