// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.chat.view.ChatListItem

package kabam.rotmg.chat.view
{
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.utils.getTimer;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.ui.model.HUDModel;

import org.swiftsuspenders.Injector;

public class ChatListItem extends Sprite
    {

        private static const CHAT_ITEM_TIMEOUT:uint = 20000;

        private var itemWidth:int;
        private var list:Vector.<DisplayObject>;
        private var count:uint;
        private var layoutHeight:uint;
        private var creationTime:uint;
        private var timedOutOverride:Boolean;
        public var playerObjectId:int;
        public var playerName:String = "";
        public var fromGuild:Boolean = false;
        public var isTrade:Boolean = false;
        private var rClickRealmeye:String = "";
        private var model:HUDModel;

        public function ChatListItem(_arg_1:Vector.<DisplayObject>, _arg_2:int, _arg_3:int, _arg_4:Boolean, _arg_5:int, _arg_6:String, _arg_7:Boolean, _arg_8:Boolean, _arg_9:String="")
        {
            mouseEnabled = true;
            this.itemWidth = _arg_2;
            this.layoutHeight = _arg_3;
            this.list = _arg_1;
            this.count = _arg_1.length;
            this.creationTime = getTimer();
            this.timedOutOverride = _arg_4;
            this.playerObjectId = _arg_5;
            this.playerName = _arg_6;
            this.fromGuild = _arg_7;
            this.isTrade = _arg_8;
            this.rClickRealmeye = _arg_9;
            this.layoutItems();
            this.addItems();
            var _local_10:Injector = StaticInjectorContext.getInjector();
            this.model = _local_10.getInstance(HUDModel);
            addEventListener(MouseEvent.RIGHT_CLICK, this.onRightMouseDown);
        }

        public function onRightMouseDown(_arg_1:MouseEvent):void
        {
            var _local_2:GameObject;
            var _local_3:Player;
            if (this.rClickRealmeye != "")
            {
                navigateToURL(new URLRequest(("https://www.realmeye.com/player/" + this.rClickRealmeye)), "_blank");
            }
            else
            {
                if (Parameters.data_.rclickTp)
                {
                    _local_2 = this.model.gameSprite.map.goDict_[this.playerObjectId];
                    if (((!(_local_2 == null)) && (_local_2 is Player)))
                    {
                        this.model.gameSprite.gsc_.teleport(_local_2.name_);
                    }
                }
                else
                {
                    if ((((!(this.model.gameSprite.map.goDict_[this.playerObjectId] == null)) && (this.model.gameSprite.map.goDict_[this.playerObjectId] is Player)) && (!(this.model.gameSprite.map.player_.objectId_ == this.playerObjectId))))
                    {
                        _local_3 = (this.model.gameSprite.map.goDict_[this.playerObjectId] as Player);
                        this.model.gameSprite.addChatPlayerMenu(_local_3, _arg_1.stageX, _arg_1.stageY);
                    }
                    else
                    {
                        if ((((!(this.playerName == null)) && (!(this.playerName == ""))) && (!(this.model.gameSprite.map.player_.name_ == this.playerName))))
                        {
                            if (!this.isTrade)
                            {
                                this.model.gameSprite.addChatPlayerMenu(null, _arg_1.stageX, _arg_1.stageY, this.playerName, this.fromGuild);
                            }
                            else
                            {
                                if (this.isTrade)
                                {
                                    this.model.gameSprite.addChatPlayerMenu(null, _arg_1.stageX, _arg_1.stageY, this.playerName, false, true);
                                }
                            }
                        }
                    }
                }
            }
        }

        public function isTimedOut():Boolean
        {
            return ((getTimer() > (this.creationTime + CHAT_ITEM_TIMEOUT)) || (this.timedOutOverride));
        }

        private function layoutItems():void
        {
            var _local_1:int;
            var _local_2:DisplayObject;
            var _local_3:Rectangle;
            var _local_4:int;
            var _local_5:int;
            _local_1 = 0;
            while (_local_5 < this.count)
            {
                _local_2 = this.list[_local_5];
                _local_3 = _local_2.getRect(_local_2);
                _local_2.x = _local_1;
                _local_2.y = (((this.layoutHeight - _local_3.height) * 0.5) - this.layoutHeight);
                if ((_local_1 + _local_3.width) > this.itemWidth)
                {
                    _local_2.x = 0;
                    _local_1 = 0;
                    _local_4 = 0;
                    while (_local_4 < _local_5)
                    {
                        this.list[_local_4].y = (this.list[_local_4].y - this.layoutHeight);
                        _local_4++;
                    }
                }
                _local_1 = (_local_1 + _local_3.width);
                _local_5++;
            }
        }

        private function addItems():void
        {
            var _local_1:DisplayObject;
            for each (_local_1 in this.list)
            {
                addChild(_local_1);
            }
        }


    }
}//package kabam.rotmg.chat.view

