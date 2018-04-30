// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.chat.control.ParseChatMessageCommand

package kabam.rotmg.chat.control
{
import com.company.assembleegameclient.game.events.ReconnectEvent;
import com.company.assembleegameclient.map.AbstractMap;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Party;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.Portal;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.board.HelpBoard;
import com.company.assembleegameclient.ui.menu.FindMenu;
import com.company.assembleegameclient.ui.options.Options;
import com.company.assembleegameclient.util.AssetLoader;
import com.company.assembleegameclient.util.CJDateUtil;

import flash.display.DisplayObject;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Point;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.utils.ByteArray;
import flash.utils.getTimer;

import kabam.rotmg.assets.EmbeddedData;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.friends.view.FriendListView;
import kabam.rotmg.game.commands.PlayGameCommand;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;
import kabam.rotmg.servers.api.Server;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.ui.model.HUDModel;

public class ParseChatMessageCommand
    {

        private static var lastMsg:String = "";
        private static var lastTell:String = "";
        private static var lastTellTo:String = "";
        private static var needed:String;
        public static var switch_:Boolean = false;
        private static var afkStart:CJDateUtil;

        [Inject]
        public var data:String;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var addTextLine:AddTextLineSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;


        private function fsCommands(_arg_1:String):Boolean
        {
            _arg_1 = _arg_1.toLowerCase();
            var _local_2:DisplayObject = Parameters.root;
            if (_arg_1 == "/fs")
            {
                if (_local_2.stage.scaleMode == StageScaleMode.EXACT_FIT)
                {
                    _local_2.stage.scaleMode = StageScaleMode.NO_SCALE;
                    Parameters.data_.stageScale = StageScaleMode.NO_SCALE;
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", "Fullscreen: On"));
                }
                else
                {
                    _local_2.stage.scaleMode = StageScaleMode.EXACT_FIT;
                    Parameters.data_.stageScale = StageScaleMode.EXACT_FIT;
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", "Fullscreen: Off"));
                }
                Parameters.save();
                _local_2.dispatchEvent(new Event(Event.RESIZE));
                return (true);
            }
            if (_arg_1 == "/mscale")
            {
                this.addTextLine.dispatch(ChatMessage.make("*Help*", (("Map Scale: " + Parameters.data_.mscale) + " - Usage: /mscale <any decimal number>.")));
                return (true);
            }
            var _local_3:Array = _arg_1.match("^/mscale (\\d*\\.*\\d+)$");
            if (_local_3 != null)
            {
                Parameters.data_.mscale = _local_3[1];
                Parameters.save();
                _local_2.dispatchEvent(new Event(Event.RESIZE));
                this.addTextLine.dispatch(ChatMessage.make("*Help*", ("Map Scale: " + _local_3[1])));
                return (true);
            }
            if (_arg_1 == "/scaleui")
            {
                Parameters.data_.uiscale = (!(Parameters.data_.uiscale));
                Parameters.save();
                _local_2.dispatchEvent(new Event(Event.RESIZE));
                this.addTextLine.dispatch(ChatMessage.make("*Help*", ("Scale UI: " + Parameters.data_.uiscale)));
                return (true);
            }
            return (false);
        }

        private function listCommands():Boolean
        {
            var _local_1:String = this.data.toLowerCase();
            return (((((this.addCommands(_local_1)) || (this.remCommands(_local_1))) || (this.lstCommands(_local_1))) || (this.defCommands(_local_1))) || (this.clrCommands(_local_1)));
        }

        private function addCommands(_arg_1:String):Boolean
        {
            var _local_2:Array;
            var _local_3:int;
            var _local_4:Boolean;
            var _local_5:int;
            _local_2 = _arg_1.match("^/aex (\\d+)$");
            if (_local_2 != null)
            {
                _local_4 = false;
                for each (_local_5 in Parameters.data_.AAException)
                {
                    if (_local_5 == _local_2[1])
                    {
                        _local_4 = true;
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (((_local_2[1] + " (") + ((ObjectLibrary.xmlLibrary_[_local_2[1]] != undefined) ? ObjectLibrary.xmlLibrary_[_local_2[1]].@id : "")) + ") already exists in exception list.")));
                        break;
                    }
                }
                if (_local_4 == false)
                {
                    if (ObjectLibrary.xmlLibrary_[_local_2[1]] != undefined)
                    {
                        Parameters.data_.AAException.push(_local_2[1]);
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (((("Added " + _local_2[1]) + " (") + ObjectLibrary.xmlLibrary_[_local_2[1]].@id) + ") to exception list.")));
                    }
                    else
                    {
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (("No mob has the type " + _local_2[1]) + ".")));
                    }
                }
                Parameters.save();
                return (true);
            }
            _local_2 = _arg_1.match("^/aig (\\d+)$");
            if (_local_2 != null)
            {
                _local_4 = false;
                for each (_local_5 in Parameters.data_.AAIgnore)
                {
                    if (_local_5 == _local_2[1])
                    {
                        _local_4 = true;
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (((_local_2[1] + " (") + ((ObjectLibrary.xmlLibrary_[_local_2[1]] != undefined) ? ObjectLibrary.xmlLibrary_[_local_2[1]].@id : "")) + ") already exists in ignore list.")));
                        break;
                    }
                }
                if (_local_4 == false)
                {
                    if (ObjectLibrary.xmlLibrary_[_local_2[1]] != undefined)
                    {
                        Parameters.data_.AAIgnore.push(_local_2[1]);
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (((("Added " + _local_2[1]) + " (") + ObjectLibrary.xmlLibrary_[_local_2[1]].@id) + ") to ignore list.")));
                    }
                    else
                    {
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (("No mob has the type " + _local_2[1]) + ".")));
                    }
                }
                Parameters.save();
                return (true);
            }
            _local_2 = _arg_1.match("^/asp (.+)$");
            if (_local_2 != null)
            {
                _local_4 = false;
                for each (_local_5 in Parameters.data_.spamFilter)
                {
                    if (_local_5 == _local_2[1])
                    {
                        _local_4 = true;
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (('"' + _local_2[1]) + '" already being filtered out.')));
                        break;
                    }
                }
                if (_local_4 == false)
                {
                    Parameters.data_.spamFilter.push(_local_2[1]);
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", (('Added "' + _local_2[1]) + '" to spamfilter list.')));
                }
                Parameters.save();
                return (true);
            }
            _local_2 = _arg_1.match("^/afr (\\w+)$");
            if (_local_2 != null)
            {
                _local_4 = false;
                for each (_local_5 in Parameters.data_.friendList2)
                {
                    if (_local_5 == _local_2[1])
                    {
                        _local_4 = true;
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (('"' + _local_2[1]) + '" already exists in friend list.')));
                        break;
                    }
                }
                if (_local_4 == false)
                {
                    Parameters.data_.friendList2.push(_local_2[1]);
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", (('Added "' + _local_2[1]) + '" to friend list.')));
                }
                Parameters.save();
                return (true);
            }
            _local_2 = _arg_1.match("^/atp (\\w+)$");
            if (_local_2 != null)
            {
                _local_4 = false;
                for each (_local_5 in Parameters.data_.tptoList)
                {
                    if (_local_5 == _local_2[1])
                    {
                        _local_4 = true;
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (('"' + _local_2[1]) + '" already exists in teleport keyword list.')));
                        break;
                    }
                }
                if (_local_4 == false)
                {
                    Parameters.data_.tptoList.push(_local_2[1]);
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", (('Added "' + _local_2[1]) + '" to teleport keyword list.')));
                }
                Parameters.save();
                return (true);
            }
            _local_2 = _arg_1.match("^/apr (\\d+)$");
            if (_local_2 != null)
            {
                _local_4 = false;
                for each (_local_5 in Parameters.data_.AAPriority)
                {
                    if (_local_5 == _local_2[1])
                    {
                        _local_4 = true;
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (((_local_2[1] + " (") + ((ObjectLibrary.xmlLibrary_[_local_2[1]] != undefined) ? ObjectLibrary.xmlLibrary_[_local_2[1]].@id : "")) + ") already exists in auto aim priority list.")));
                        break;
                    }
                }
                if (_local_4 == false)
                {
                    if (ObjectLibrary.xmlLibrary_[_local_2[1]] != undefined)
                    {
                        Parameters.data_.AAPriority.push(_local_2[1]);
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (((("Added " + _local_2[1]) + " (") + ObjectLibrary.xmlLibrary_[_local_2[1]].@id) + ") to auto aim priority list.")));
                    }
                    else
                    {
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (("No mob has the type " + _local_2[1]) + ".")));
                    }
                }
                Parameters.save();
                return (true);
            }
            _local_2 = _arg_1.match("^/ali (.+)$");
            if (_local_2 != null)
            {
                _local_3 = this.findMatch2(_local_2[1]);
                for each (_local_5 in Parameters.data_.lootIgnore)
                {
                    if (_local_5 == _local_3)
                    {
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (((_local_3 + " (") + ObjectLibrary.getIdFromType(_local_3)) + ") already exists in loot ignore list.")));
                        return (true);
                    }
                }
                if (_local_3 != 2581)
                {
                    Parameters.data_.lootIgnore.push(_local_3);
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", (((("Added " + _local_3) + " (") + ObjectLibrary.getIdFromType(_local_3)) + ") to loot ignore list.")));
                }
                else
                {
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", "No item matched the query."));
                }
                Parameters.save();
                return (true);
            }
            _local_2 = _arg_1.match("^/awn (\\w+)$");
            if (_local_2 != null)
            {
                _local_4 = false;
                for each (_local_5 in Parameters.data_.wordNotiList)
                {
                    if (_local_5 == _local_2[1])
                    {
                        _local_4 = true;
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (('"' + _local_2[1]) + '" already exists in notifier keyword list.')));
                        break;
                    }
                }
                if (_local_4 == false)
                {
                    Parameters.data_.wordNotiList.push(_local_2[1]);
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", (('Added "' + _local_2[1]) + '" to notifier keyword list.')));
                }
                Parameters.save();
                return (true);
            }
            return (false);
        }

        private function remCommands(_arg_1:String):Boolean
        {
            var _local_2:Array;
            var _local_3:Boolean;
            var _local_4:int;
            var _local_5:int;
            _local_2 = _arg_1.match("^/rig (\\d+)$");
            if (_local_2 != null)
            {
                _local_3 = false;
                _local_4 = 0;
                while (_local_4 < Parameters.data_.AAIgnore.length)
                {
                    if (Parameters.data_.AAIgnore[_local_4] == _local_2[1])
                    {
                        _local_3 = true;
                        Parameters.data_.AAIgnore.splice(_local_4, 1);
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (((_local_2[1] + " (") + ((ObjectLibrary.xmlLibrary_[_local_2[1]] != undefined) ? ObjectLibrary.xmlLibrary_[_local_2[1]].@id : "")) + ") removed from ignore list.")));
                        break;
                    }
                    _local_4++;
                }
                if (_local_3 == false)
                {
                    if (ObjectLibrary.xmlLibrary_[_local_2[1]] != undefined)
                    {
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (((_local_2[1] + " (") + ObjectLibrary.xmlLibrary_[_local_2[1]].@id) + ") not found in ignore list.")));
                    }
                    else
                    {
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (_local_2[1] + " not found in ignore list.")));
                    }
                }
                Parameters.save();
                return (true);
            }
            _local_2 = _arg_1.match("^/rex (\\d+)$");
            if (_local_2 != null)
            {
                _local_3 = false;
                _local_4 = 0;
                while (_local_4 < Parameters.data_.AAException.length)
                {
                    if (Parameters.data_.AAException[_local_4] == _local_2[1])
                    {
                        _local_3 = true;
                        Parameters.data_.AAException.splice(_local_4, 1);
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (((_local_2[1] + " (") + ((ObjectLibrary.xmlLibrary_[_local_2[1]] != undefined) ? ObjectLibrary.xmlLibrary_[_local_2[1]].@id : "")) + ") removed from exception list.")));
                        break;
                    }
                    _local_4++;
                }
                if (_local_3 == false)
                {
                    if (ObjectLibrary.xmlLibrary_[_local_2[1]] != undefined)
                    {
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (((_local_2[1] + " (") + ObjectLibrary.xmlLibrary_[_local_2[1]].@id) + ") not found in exception list.")));
                    }
                    else
                    {
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (_local_2[1] + " not found in exception list.")));
                    }
                }
                Parameters.save();
                return (true);
            }
            _local_2 = _arg_1.match("^/rsp (.+)$");
            if (_local_2 != null)
            {
                _local_3 = false;
                _local_4 = 0;
                while (_local_4 < Parameters.data_.spamFilter.length)
                {
                    if (Parameters.data_.spamFilter[_local_4] == _local_2[1])
                    {
                        _local_3 = true;
                        Parameters.data_.spamFilter.splice(_local_4, 1);
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (('"' + _local_2[1]) + '" removed from spamfilter list.')));
                        break;
                    }
                    _local_4++;
                }
                if (_local_3 == false)
                {
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", (('"' + _local_2[1]) + '" not found in spamfilter list.')));
                }
                Parameters.save();
                return (true);
            }
            _local_2 = _arg_1.match("^/rfr (\\w+)$");
            if (_local_2 != null)
            {
                _local_3 = false;
                _local_4 = 0;
                while (_local_4 < Parameters.data_.friendList2.length)
                {
                    if (Parameters.data_.friendList2[_local_4] == _local_2[1])
                    {
                        _local_3 = true;
                        Parameters.data_.friendList2.splice(_local_4, 1);
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (('"' + _local_2[1]) + '" removed from friend list.')));
                        break;
                    }
                    _local_4++;
                }
                if (_local_3 == false)
                {
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", (('"' + _local_2[1]) + '" not found in friend list.')));
                }
                Parameters.save();
                return (true);
            }
            _local_2 = _arg_1.match("^/rtp (\\w+)$");
            if (_local_2 != null)
            {
                _local_3 = false;
                _local_4 = 0;
                while (_local_4 < Parameters.data_.tptoList.length)
                {
                    if (Parameters.data_.tptoList[_local_4] == _local_2[1])
                    {
                        _local_3 = true;
                        Parameters.data_.tptoList.splice(_local_4, 1);
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (('"' + _local_2[1]) + '" removed from teleport keyword list.')));
                        break;
                    }
                    _local_4++;
                }
                if (_local_3 == false)
                {
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", (('"' + _local_2[1]) + '" not found in teleport keyword list.')));
                }
                Parameters.save();
                return (true);
            }
            _local_2 = _arg_1.match("^/rpr (\\d+)$");
            if (_local_2 != null)
            {
                _local_3 = false;
                _local_4 = 0;
                while (_local_4 < Parameters.data_.AAPriority.length)
                {
                    if (Parameters.data_.AAPriority[_local_4] == _local_2[1])
                    {
                        _local_3 = true;
                        Parameters.data_.AAPriority.splice(_local_4, 1);
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (((_local_2[1] + " (") + ((ObjectLibrary.xmlLibrary_[_local_2[1]] != undefined) ? ObjectLibrary.xmlLibrary_[_local_2[1]].@id : "")) + ") removed from auto aim priority list.")));
                        break;
                    }
                    _local_4++;
                }
                if (_local_3 == false)
                {
                    if (ObjectLibrary.xmlLibrary_[_local_2[1]] != undefined)
                    {
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (((_local_2[1] + " (") + ObjectLibrary.xmlLibrary_[_local_2[1]].@id) + ") not found in auto aim priority list.")));
                    }
                    else
                    {
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (_local_2[1] + " not found in auto aim priority list.")));
                    }
                }
                Parameters.save();
                return (true);
            }
            _local_2 = _arg_1.match("^/rli (.+)$");
            if (_local_2 != null)
            {
                _local_5 = this.findMatch2(_local_2[1]);
                _local_4 = 0;
                while (_local_4 < Parameters.data_.lootIgnore.length)
                {
                    if (Parameters.data_.lootIgnore[_local_4] == _local_5)
                    {
                        Parameters.data_.lootIgnore.splice(_local_4, 1);
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (((_local_5 + " (") + ObjectLibrary.getIdFromType(_local_5)) + ") removed from loot ignore list.")));
                        return (true);
                    }
                    _local_4++;
                }
                if (_local_5 != 2581)
                {
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", (((_local_5 + " (") + ObjectLibrary.getIdFromType(_local_5)) + ") not found in loot ignore list.")));
                }
                else
                {
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", "No item matched the query."));
                }
                Parameters.save();
                return (true);
            }
            _local_2 = _arg_1.match("^/rwn (\\w+)$");
            if (_local_2 != null)
            {
                _local_3 = false;
                _local_4 = 0;
                while (_local_4 < Parameters.data_.wordNotiList.length)
                {
                    if (Parameters.data_.wordNotiList[_local_4] == _local_2[1])
                    {
                        _local_3 = true;
                        Parameters.data_.wordNotiList.splice(_local_4, 1);
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (('"' + _local_2[1]) + '" removed from notifier keyword list.')));
                        break;
                    }
                    _local_4++;
                }
                if (_local_3 == false)
                {
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", (('"' + _local_2[1]) + '" not found in notifier keyword list.')));
                }
                Parameters.save();
                return (true);
            }
            return (false);
        }

        private function lstCommands(_arg_1:String):Boolean
        {
            var _local_2:int;
            if (_arg_1 == "/exlist")
            {
                this.addTextLine.dispatch(ChatMessage.make("*Help*", (("Auto aim exception list (" + Parameters.data_.AAException.length) + " mobs):")));
                _local_2 = 0;
                while (_local_2 < Parameters.data_.AAException.length)
                {
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", ((Parameters.data_.AAException[_local_2] + " - ") + ((ObjectLibrary.xmlLibrary_[Parameters.data_.AAException[_local_2]] != undefined) ? ObjectLibrary.xmlLibrary_[Parameters.data_.AAException[_local_2]].@id : ""))));
                    _local_2++;
                }
                return (true);
            }
            if (_arg_1 == "/iglist")
            {
                this.addTextLine.dispatch(ChatMessage.make("*Help*", (("Auto aim ignore list (" + Parameters.data_.AAIgnore.length) + " mobs):")));
                _local_2 = 0;
                while (_local_2 < Parameters.data_.AAIgnore.length)
                {
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", ((Parameters.data_.AAIgnore[_local_2] + " - ") + ((ObjectLibrary.xmlLibrary_[Parameters.data_.AAIgnore[_local_2]] != undefined) ? ObjectLibrary.xmlLibrary_[Parameters.data_.AAIgnore[_local_2]].@id : ""))));
                    _local_2++;
                }
                return (true);
            }
            if (_arg_1 == "/splist")
            {
                this.addTextLine.dispatch(ChatMessage.make("*Help*", (("Spamfilter list (" + Parameters.data_.spamFilter.length) + " filtered words):")));
                _local_2 = 0;
                while (_local_2 < Parameters.data_.spamFilter.length)
                {
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", Parameters.data_.spamFilter[_local_2]));
                    _local_2++;
                }
                return (true);
            }
            if (_arg_1 == "/frlist")
            {
                this.addTextLine.dispatch(ChatMessage.make("*Help*", (("Friend list (" + Parameters.data_.friendList2.length) + " friends):")));
                _local_2 = 0;
                while (_local_2 < Parameters.data_.friendList2.length)
                {
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", Parameters.data_.friendList2[_local_2]));
                    _local_2++;
                }
                return (true);
            }
            if (_arg_1 == "/tplist")
            {
                this.addTextLine.dispatch(ChatMessage.make("*Help*", (("Teleport keyword list (" + Parameters.data_.tptoList.length) + " keywords):")));
                _local_2 = 0;
                while (_local_2 < Parameters.data_.tptoList.length)
                {
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", Parameters.data_.tptoList[_local_2]));
                    _local_2++;
                }
                return (true);
            }
            if (_arg_1 == "/prlist")
            {
                this.addTextLine.dispatch(ChatMessage.make("*Help*", (("Auto aim priority list (" + Parameters.data_.AAPriority.length) + " mobs):")));
                _local_2 = 0;
                while (_local_2 < Parameters.data_.AAPriority.length)
                {
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", ((Parameters.data_.AAPriority[_local_2] + " - ") + ((ObjectLibrary.xmlLibrary_[Parameters.data_.AAPriority[_local_2]] != undefined) ? ObjectLibrary.xmlLibrary_[Parameters.data_.AAPriority[_local_2]].@id : ""))));
                    _local_2++;
                }
                return (true);
            }
            if (_arg_1 == "/lilist")
            {
                this.addTextLine.dispatch(ChatMessage.make("*Help*", (("Loot ignore list (" + Parameters.data_.lootIgnore.length) + " items):")));
                _local_2 = 0;
                while (_local_2 < Parameters.data_.lootIgnore.length)
                {
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", ((Parameters.data_.lootIgnore[_local_2] + " - ") + ObjectLibrary.getIdFromType(Parameters.data_.lootIgnore[_local_2]))));
                    _local_2++;
                }
                return (true);
            }
            if (_arg_1 == "/wnlist")
            {
                this.addTextLine.dispatch(ChatMessage.make("*Help*", (("Notifier keyword list (" + Parameters.data_.wordNotiList.length) + " keywords):")));
                _local_2 = 0;
                while (_local_2 < Parameters.data_.wordNotiList.length)
                {
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", Parameters.data_.wordNotiList[_local_2]));
                    _local_2++;
                }
                return (true);
            }
            return (false);
        }

        private function clrCommands(_arg_1:String):Boolean
        {
            if (_arg_1 == "/igclear")
            {
                Parameters.data_.AAIgnore = [];
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "Auto aim ignore list cleared."));
                Parameters.save();
                return (true);
            }
            if (_arg_1 == "/exclear")
            {
                Parameters.data_.AAException = [];
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "Auto aim exception list cleared."));
                Parameters.save();
                return (true);
            }
            if (_arg_1 == "/spclear")
            {
                Parameters.data_.spamFilter = [];
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "Spamfilter list cleared."));
                Parameters.save();
                return (true);
            }
            if (_arg_1 == "/frclear")
            {
                Parameters.data_.friendList2 = [];
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "Friend list cleared."));
                Parameters.save();
                return (true);
            }
            if (_arg_1 == "/tpclear")
            {
                Parameters.data_.tptoList = [];
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "Teleport keyword list cleared."));
                Parameters.save();
                return (true);
            }
            if (_arg_1 == "/prclear")
            {
                Parameters.data_.AAPriority = [];
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "Auto aim priority list cleared."));
                Parameters.save();
                return (true);
            }
            if (_arg_1 == "/liclear")
            {
                Parameters.data_.lootIgnore = [];
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "Loot ignore list cleared."));
                Parameters.save();
                return (true);
            }
            if (_arg_1 == "/wnclear")
            {
                Parameters.data_.wordNotiList = [];
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "Notifier keyword list cleared."));
                Parameters.save();
                return (true);
            }
            return (false);
        }

        private function defCommands(_arg_1:String):Boolean
        {
            if (_arg_1 == "/igdefault")
            {
                Parameters.data_.AAIgnore = [1550, 1551, 1552, 1715, 2309, 2310, 2311, 2371, 2312, 0x0909, 2370, 2392, 2393, 2400, 2401, 3335, 3336, 3337, 3338, 3413, 3418, 3419, 3420, 3421, 3427, 3454, 3638, 3645, 6157, 28715, 28716, 28717, 28718, 28719, 28730, 28731, 28732, 28733, 28734, 29306, 29568, 29594, 29597, 29710, 29711, 29742, 29743, 29746, 29748, 30001, 29752, 43702, 43708, 43709, 43710, 3389, 3390, 3391, 24223, 0x0900, 2305, 2306, 0x0600, 1537, 1538, 1539, 1540];
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "Default ignore list restored."));
                Parameters.save();
                return (true);
            }
            if (_arg_1 == "/exdefault")
            {
                Parameters.data_.AAException = [3441, 3414, 3417, 3448, 3449, 3472, 3334, 5952, 2354, 2369, 3368, 3366, 3367, 3391, 3389, 3390, 5920, 2314, 3412, 3639, 3634, 2327, 1755, 24582, 24351, 24363, 24135, 24133, 24134, 24132, 24136, 3356, 3357, 3358, 3359, 3360, 3361, 3362, 3363, 3364, 2352, 28780, 28781, 28795, 28942, 28957, 28988, 28938, 29291, 29018, 29517, 24338, 29580, 29712, 6282, 29054, 29308, 29309, 29550, 29551, 29258, 29259, 29260, 29261, 29262];
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "Default exception list restored."));
                Parameters.save();
                return (true);
            }
            if (_arg_1 == "/spdefault")
            {
                Parameters.data_.spamFilter = ["realmk!ngs", "oryx.ln", "realmpower.net", "oryxsh0p.net", "lifepot. org"];
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "Default spamfilter list restored."));
                Parameters.save();
                return (true);
            }
            if (_arg_1 == "/tpdefault")
            {
                Parameters.data_.tptoList = ["tp"];
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "Default teleport keyword list restored."));
                Parameters.save();
                return (true);
            }
            if (_arg_1 == "/prdefault")
            {
                Parameters.data_.AAPriority = [29054, 29308, 29309, 29550, 29551, 29258, 29259, 29260, 29261, 29262, 6282, 1646];
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "Default auto aim priority list restored."));
                Parameters.save();
                return (true);
            }
            if (_arg_1 == "/lidefault")
            {
                Parameters.data_.lootIgnore = [9018, 9019, 9020, 9021, 9022, 9023, 9024, 9025, 3861, 2635];
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "Default loot ignore list restored."));
                Parameters.save();
                return (true);
            }
            if (_arg_1 == "/wndefault")
            {
                Parameters.data_.wordNotiList = ["tp"];
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "Default notifier keyword list restored."));
                Parameters.save();
                return (true);
            }
            return (false);
        }

        private function cjCommands(_arg_1:String):Boolean
        {
            var _local_1:String;
            var _local_2:int;
            var _local_3:String;
            var _local_4:String;
            var _local_5:GameObject;
            var _local_6:Player;
            var _local_7:Array;
            var _local_8:Array;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:Player = this.hudModel.gameSprite.map.player_;
            var _local_13:Boolean;
            var _local_14:Array;
            var _local_15:Array;
            var _local_17:Number = NaN;
            var _local_18:int;
            var _local_19:Vector.<int>;
            var _local_20:ChatMessage;
            var _local_21:int;
            var _local_22:String;
            var _local_23:Vector.<Boolean>;
            var _local_24:GameObject;
            var _local_25:GameObject;
            var _local_26:GameServerConnection = this.hudModel.gameSprite.gsc_;
            switch (this.data.toLowerCase())
            {
                case "/status":
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.onlyGods) ? "Only Gods: On" : "Only Gods: Off")));
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.blockCubes) ? "Cubes Blocked" : "Cubes Allowed")));
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.blockPots) ? "Thirsty: On" : "Thirsty: Off")));
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.blockAbil) ? "Ability Blocked" : "Ability Allowed")));
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.blockTP) ? "Teleport Blocked" : "Teleport Allowed")));
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.statusText) ? "Status Text: On" : "Status Text: Off")));
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.dodBot) ? "Doer of Deeds Bot: On" : "Doer of Deeds Bot: Off")));
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.hideLockList) ? "Only showing locked players" : "Showing all players")));
                    this.addTextLine.dispatch(ChatMessage.make("", ("Reconnect delay set to: " + Parameters.RECONNECT_DELAY)));
                    this.addTextLine.dispatch(ChatMessage.make("", ("Auto nexus percentage set to " + Parameters.data_.AutoNexus)));
                    this.addTextLine.dispatch(ChatMessage.make("", ("Auto pot percentage set to " + Parameters.data_.autoPot)));
                    this.addTextLine.dispatch(ChatMessage.make("", ("Auto mana percentage set to " + Parameters.data_.autoMana)));
                    return (true);
                case "/vaultonly":
                    Parameters.data_.disableNexus = !Parameters.data_.disableNexus;
                    Parameters.save();
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.hideLockList) ? "Only Vault mode enabled" : "Only Vault mode disabled")));
                    return (true);
                case "/keylist":
                    Parameters.data_.keyList = !Parameters.data_.keyList;
                    Parameters.save();
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.keyList) ? "Key list enabled" : "Key list disabled")));
                    return (true);
                case "/onlygods":
                    Parameters.data_.onlyGods = (!Parameters.data_.onlyGods);
                    Parameters.save();
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.onlyGods) ? "Only Gods: On" : "Only Gods: Off")));
                    return (true);
                case "/blockcubes":
                    Parameters.data_.blockCubes = (!Parameters.data_.blockCubes);
                    Parameters.save();
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.blockCubes) ? "Cubes Blocked" : "Cubes Allowed")));
                    return (true);
                case "/blockpots":
                    Parameters.data_.blockPots = (!Parameters.data_.blockPots);
                    Parameters.save();
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.blockPots) ? "Thirsty: On" : "Thirsty: Off")));
                    return (true);
                case "/blockabil":
                    Parameters.data_.blockAbil = (!Parameters.data_.blockAbil);
                    Parameters.save();
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.blockAbil) ? "Ability Blocked" : "Ability Allowed")));
                    return (true);
                case "/blocktp":
                    Parameters.data_.blockTP = (!Parameters.data_.blockTP);
                    Parameters.save();
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.blockTP) ? "Teleport Blocked" : "Teleport Allowed")));
                    return (true);
                case "/statustext":
                    Parameters.data_.statusText = (!Parameters.data_.statusText);
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.statusText) ? "Status Text: On" : "Status Text: Off")));
                    return (true);
                case "/dodbot":
                    Parameters.data_.dodBot = (!Parameters.data_.dodBot);
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.dodBot) ? "Doer of Deeds Bot: On" : "Doer of Deeds Bot: Off")));
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.dodBot) ? "Use /aex 355 to add walls to aim list. Use /aig 1711 and /aig 1712 to add chickens to ignore list" : "")));
                    return (true);
                case "/lf":
                case "/lockfilter":
                    Parameters.data_.hideLockList = (!Parameters.data_.hideLockList);
                    this.addTextLine.dispatch(ChatMessage.make("", ((Parameters.data_.hideLockList) ? "Only showing locked players" : "Showing all players")));
                    return (true);
                case "/serv":
                    _local_26.playerText("/server");
                    return (true);
                case "/hide":
                    _local_26.playerText("/tell mreyeball hide me");
                    return (true);
                case "/friends":
                case "/fr":
                    _local_26.playerText("/tell mreyeball friends");
                    return (true);
                case "/l2m":
                case "/left2max":
                case "/lefttomax":
                    needed = "You need ";
                    _local_13 = true;
                    _local_14 = [int(((((_local_12.maxHPMax_ - _local_12.maxHP_) + _local_12.maxHPBoost_) / 5) + (((((_local_12.maxHPMax_ - _local_12.maxHP_) + _local_12.maxHPBoost_) % 5) > 0) ? 1 : 0))), int(((((_local_12.maxMPMax_ - _local_12.maxMP_) + _local_12.maxMPBoost_) / 5) + (((((_local_12.maxMPMax_ - _local_12.maxMP_) + _local_12.maxMPBoost_) % 5) > 0) ? 1 : 0))), ((_local_12.attackMax_ - _local_12.attack_) + _local_12.attackBoost_), ((_local_12.defenseMax_ - _local_12.defense_) + _local_12.defenseBoost_), ((_local_12.speedMax_ - _local_12.speed_) + _local_12.speedBoost_), ((_local_12.dexterityMax_ - _local_12.dexterity_) + _local_12.dexterityBoost_), ((_local_12.vitalityMax_ - _local_12.vitality_) + _local_12.vitalityBoost_), ((_local_12.wisdomMax_ - _local_12.wisdom_) + _local_12.wisdomBoost_)];
                    _local_15 = ["Life", "Mana", "ATT", "DEF", "SPD", "DEX", "VIT", "WIS"];
                    _local_10 = 0;
                    while (_local_10 < _local_14.length)
                    {
                        if (_local_14[_local_10] > 0)
                        {
                            needed = (needed + (((_local_14[_local_10] + " ") + _local_15[_local_10]) + ", "));
                            _local_13 = false;
                        }
                        _local_10++;
                    }
                    needed = ((_local_13) ? "You're maxed" : (needed.substr(0, (needed.length - 2)) + " to be maxed"));
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", needed));
                    return (true);
                case "/stats":
                case "/roll":
                    _local_26.playerText("/tell mreyeball stats");
                    return (true);
                case "/mates":
                    _local_26.playerText("/tell mreyeball mates");
                    return (true);
                case "/tut":
                    _local_26.playerText("/nexustutorial");
                    return (true);
                case "/tr":
                    _local_26.playerText(("/trade " + lastTellTo));
                    return (true);
                case "/sayfame":
                    _local_17 = (Math.round((((GameServerConnectionConcrete.totalfamegain / (getTimer() - PlayGameCommand.startTime)) * 60000) * 100)) / 100);
                    _local_26.playerText(("Total fame: " + GameServerConnectionConcrete.totalfamegain + ", total time: " + (Math.floor((((getTimer() - PlayGameCommand.startTime) / 60000) * 10)) / 10) + " minutes, fame per minute: " + _local_17 + ", status: " + ((_local_17 > 5) ? (_local_17 > 8 ? (_local_17 > 13 ? "Awesome" : "Good") : "Average") : "Bad")));
                    return (true);
                case "/fame":
                    _local_17 = (Math.round((((GameServerConnectionConcrete.totalfamegain / (getTimer() - PlayGameCommand.startTime)) * 60000) * 100)) / 100);
                    _local_12.notifyPlayer((((((GameServerConnectionConcrete.totalfamegain + " fame\n") + (Math.floor((((getTimer() - PlayGameCommand.startTime) / 60000) * 10)) / 10)) + " minutes\n") + _local_17) + " fame/min\n" + ((_local_17 > 5) ? (_local_17 > 8 ? (_local_17 > 13 ? "Awesome" : "Good") : "Average") : "Bad")), 0xE25F00, 3000);
                    return (true);
                case "/fameclear":
                    PlayGameCommand.startTime = getTimer();
                    GameServerConnectionConcrete.totalfamegain = 0;
                    return (true);
                case "/pos":
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", ((("X: " + _local_12.x_) + " Y: ") + _local_12.y_)));
                    return (true);
                case "/s":
                case "/switch":
                case "/swap":
                    if (_local_12.hasBackpack_)
                    {
                        switch_ = true;
                    }
                    else
                    {
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", "Whoa, that was close! Your items almost disappeared."));
                    }
                    return (true);
                case "/unname":
                case "/name":
                    Parameters.data_.fakeName = null;
                    Parameters.save();
                    this.hudModel.gameSprite.hudView.characterDetails.setName(_local_12.name_);
                    return (true);
                case "/flist":
                    this.openDialog.dispatch(new FriendListView());
                    return (true);
                case "/nexus":
                    _local_26.escapeUnsafe();
                    return (true);
                case "/follow":
                    _local_12.followTarget = null;
                    _local_12.notifyPlayer("Stopped following");
                    return (true);
                case "/cchelp":
                    this.openDialog.dispatch(new HelpBoard());
                    return (true);
                case "/afk":
                    TextHandler.afk = (!(TextHandler.afk));
                    if (!TextHandler.afk)
                    {
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", ((TextHandler.afkTells.length + " messages since ") + afkStart.getFormattedTime())));
                        for each (_local_20 in TextHandler.afkTells)
                        {
                            this.addTextLine.dispatch(_local_20);
                        }
                        TextHandler.afkTells.length = 0;
                        TextHandler.sendBacks.length = 0;
                    }
                    else
                    {
                        afkStart = new CJDateUtil();
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", "Your messages will be saved, have fun."));
                    }
                    TextHandler.afkMsg = "";
                    return (true);
                case "/re":
                    _local_26.playerText(lastMsg);
                    return (true);
                case "/record":
                    _local_26.recorded = new Vector.<Point>();
                    _local_26.record = 1;
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", "Recording your movements."));
                    return (true);
                case "/save":
                    _local_26.record = 0;
                    _local_11 = _local_26.recorded.length;
                    _local_9 = 0;
                    while (_local_9 < _local_26.recorded.length)
                    {
                        _local_10 = (_local_9 + 1);
                        while (_local_10 < _local_26.recorded.length)
                        {
                            if (((_local_26.recorded[_local_9].x == _local_26.recorded[_local_10].x) && (_local_26.recorded[_local_9].y == _local_26.recorded[_local_10].y)))
                            {
                                _local_26.recorded.splice(_local_10, 1);
                                if (_local_9 != 0)
                                {
                                    _local_9--;
                                }
                            }
                            _local_10++;
                        }
                        _local_9++;
                    }
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", ((("Save completed. Movement data compressed from " + _local_11) + " steps to ") + _local_26.recorded.length)));
                    return (true);
                case "/play":
                    _local_26.record = 2;
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", "Playing the record."));
                    return (true);
                case "/stop":
                    _local_26.record = 0;
                    _local_12.recordPointer = 0;
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", "Playback stopped."));
                    return (true);
                case "/myid":
                    this.addTextLine.dispatch(ChatMessage.make("*Help*", ("Id #" + _local_12.objectId_)));
                    return (true);
                case "/constructs":
                case "/const":
                    _local_19 = new Vector.<int>(0);
                    _local_9 = 0;
                    while (_local_9 < Parameters.data_.AAIgnore.length)
                    {
                        _local_18 = Parameters.data_.AAIgnore[_local_9];
                        if ((((_local_18 == 2309) || (_local_18 == 2310)) || (_local_18 == 2311)))
                        {
                            _local_19.push(_local_9);
                            if (_local_19.length == 3) break;
                        }
                        _local_9++;
                    }
                    if (_local_19.length == 0)
                    {
                        Parameters.data_.AAIgnore.push(2309);
                        Parameters.data_.AAIgnore.push(2310);
                        Parameters.data_.AAIgnore.push(2311);
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", "Constructs added to ignore list."));
                    }
                    else
                    {
                        _local_9 = 0;
                        while (_local_9 < _local_19.length)
                        {
                            Parameters.data_.AAIgnore.splice((_local_19[_local_9] - _local_9), 1);
                            _local_9++;
                        }
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", "Constructs removed from ignore list."));
                    }
                    Parameters.save();
                    return (true);
                default:
                    _local_7 = this.data.match("^/uitextsize (\\d*\\.*\\d+)$");
                    if (_local_7 != null) {
                        Parameters.data_.uiTextSize = _local_7[1];
                        Parameters.save();
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", ("UI-text size set to: " + Parameters.data_.uiTextSize)));
                        return (true);
                    }
                    _local_7 = this.data.match("^/recondelay (\\d*\\.*\\d+)$");
                    if (_local_7 != null) {
                        Parameters.RECONNECT_DELAY = _local_7[1];
                        Parameters.save();
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", ("Reconnect delay set to: " + Parameters.RECONNECT_DELAY)));
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/spellthreshold (\\d*\\.*\\d+)$");
                    if (_local_7 != null) {
                        Parameters.data_.spellThreshold = _local_7[1];
                        Parameters.save();
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", ("Spell threshold set to: " + Parameters.data_.spellThreshold)));
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/colo (\\d*\\.*\\d+)$");
                    if (_local_7 != null) {
                        Parameters.data_.coloOffset = _local_7[1];
                        Parameters.save();
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", ("Sword of the Colossus offset: " + Parameters.data_.coloOffset)));
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/afk (.+)$");
                    if (_local_7 != null)
                    {
                        TextHandler.afk = true;
                        TextHandler.afkMsg = _local_7[1];
                        afkStart = new CJDateUtil();
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", "Your messages will be saved, have fun."));
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/load (\\d{1,2})$");
                    if (_local_7 != null)
                    {
                        this.hudModel.gameSprite.hudView.miniMap.miniMapData_ = AssetLoader.maps[(parseInt(_local_7[1]) - 1)];
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", "Loaded from file."));
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/player (\\w+)$");
                    if (_local_7 != null)
                    {
                        navigateToURL(new URLRequest(("https://www.realmeye.com/player/" + _local_7[1])), "_blank");
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/sell (\\d{1,2})$");
                    if (_local_7 != null)
                    {
                        _local_21 = (int(_local_7[1]) + 3);
                        navigateToURL(new URLRequest((("https://www.realmeye.com/offers-to/buy/" + _local_12.equipment_[_local_21]) + "/2793")), "_blank");
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/re (\\w+)$");
                    if (_local_7 != null)
                    {
                        _local_22 = ((("/tell " + _local_7[1]) + " ") + lastTell);
                        _local_26.playerText(_local_22);
                        lastTellTo = _local_7[1];
                        lastMsg = _local_22;
                        return (true);
                    }
                    _local_7 = this.data.match("^/name (.+)$");
                    if (_local_7 != null)
                    {
                        Parameters.data_.fakeName = _local_7[1];
                        Parameters.save();
                        this.hudModel.gameSprite.hudView.characterDetails.setName("");
                        return (true);
                    }
                    _local_7 = this.data.match("^/timer (\\d+) ?(\\d*)$");
                    if (_local_7 != null) {
                        Parameters.timerActive = true;
                        Parameters.phaseChangeAt = (getTimer() + (_local_7[1] * 1000));
                        Parameters.phaseName = "Custom Timer";
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/autopot (\\d+)$");
                    if (_local_7 != null)
                    {
                        Parameters.data_.autoPot = _local_7[1];
                        Parameters.save();
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", ("Auto pot percentage set to " + Parameters.data_.autoPot)));
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/automana (\\d+)$");
                    if (_local_7 != null)
                    {
                        Parameters.data_.autoMana = _local_7[1];
                        Parameters.save();
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", ("Auto mana percentage set to " + Parameters.data_.autoMana)));
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/autonex (\\d+)$");
                    if (_local_7 != null)
                    {
                        Parameters.data_.AutoNexus = _local_7[1];
                        Parameters.save();
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", ("Auto nexus percentage set to " + Parameters.data_.AutoNexus)));
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/autoheal (\\d+)$");
                    if (_local_7 != null)
                    {
                        Parameters.data_.autoHealP = _local_7[1];
                        Parameters.save();
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", ("Auto heal percentage set to " + Parameters.data_.autoHealP)));
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/give (\\w+) (\\d{1,8})$");
                    if (_local_7 != null)
                    {
                        _local_26.playerText(((("/tell " + _local_7[1]) + " g=") + _local_7[2]));
                        _local_26.requestTrade(_local_7[1]);
                        _local_23 = new <Boolean>[false, false, false, false, false, false, false, false, false, false, false, false];
                        _local_9 = 4;
                        while (_local_9 < 12)
                        {
                            if (_local_7[2].substr((_local_9 - 4), 1) == "1")
                            {
                                _local_23[_local_9] = true;
                            }
                            _local_9++;
                        }
                        GameServerConnectionConcrete.sendingGift = _local_23;
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/find (.+)$");
                    if (_local_7 != null)
                    {
                        this.findItem(this.findMatch2(_local_7[1]));
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/take (.+)$");
                    if (_local_7 != null)
                    {
                        if (this.hudModel.gameSprite.map.name_ != "Vault")
                        {
                            this.addTextLine.dispatch(ChatMessage.make("*Help*", "Use the command in vault and run over the chest you wish to interact with."));
                            return (true);
                        }
                        if (_local_7[1] == "pots")
                        {
                            _local_12.collect = int.MAX_VALUE;
                            this.addTextLine.dispatch(ChatMessage.make("*Help*", "Taking Potion(s) from vault chests"));
                            return (true);
                        }
                        _local_12.collect = this.findMatch2(_local_7[1]);
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (("Taking " + ObjectLibrary.getIdFromType(_local_12.collect)) + "(s) from vault chests")));
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/put (.+)$");
                    if (_local_7 != null)
                    {
                        if (this.hudModel.gameSprite.map.name_ != "Vault")
                        {
                            this.addTextLine.dispatch(ChatMessage.make("*Help*", "Use the command in vault and run over the chest you wish to interact with."));
                            return (true);
                        }
                        if (_local_7[1] == "pots")
                        {
                            _local_12.collect = int.MIN_VALUE;
                            this.addTextLine.dispatch(ChatMessage.make("*Help*", "Putting Potion(s) to vault chests"));
                            return (true);
                        }
                        _local_12.collect = (0 - this.findMatch2(_local_7[1]));
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", (("Putting " + ObjectLibrary.getIdFromType((0 - _local_12.collect))) + "(s) to vault chests")));
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/buy (\\w+) ?(\\w*)$");
                    if (_local_7 != null)
                    {
                        if (_local_7[2] == "")
                        {
                            navigateToURL(new URLRequest((("https://www.realmeye.com/offers-to/sell/" + this.findMatch2(_local_7[1])) + "/2793")), "_blank");
                        }
                        else
                        {
                            navigateToURL(new URLRequest(((("https://www.realmeye.com/offers-to/sell/" + this.findMatch2(_local_7[1])) + "/") + this.findMatch2(_local_7[2]))), "_blank");
                        }
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/sell (\\w+) ?(\\w*)$");
                    if (_local_7 != null)
                    {
                        if (_local_7[2] == "")
                        {
                            navigateToURL(new URLRequest((("https://www.realmeye.com/offers-to/buy/" + this.findMatch2(_local_7[1])) + "/2793")), "_blank");
                        }
                        else
                        {
                            navigateToURL(new URLRequest(((("https://www.realmeye.com/offers-to/buy/" + this.findMatch2(_local_7[1])) + "/") + this.findMatch2(_local_7[2]))), "_blank");
                        }
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/dye1 (.+)$");
                    if (_local_7 != null)
                    {
                        if (_local_7[1] == "none")
                        {
                            Parameters.data_.setTex1 = 0;
                            Parameters.save();
                            _local_12.setTex1(0);
                        }
                        else
                        {
                            Parameters.data_.setTex1 = this.getTex1(this.findMatch2((_local_7[1] + " cloth")));
                            Parameters.save();
                            _local_12.setTex1(Parameters.data_.setTex1);
                        }
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/dye2 (.+)$");
                    if (_local_7 != null)
                    {
                        if (_local_7[1] == "none")
                        {
                            Parameters.data_.setTex2 = 0;
                            Parameters.save();
                            _local_12.setTex2(0);
                        }
                        else
                        {
                            Parameters.data_.setTex2 = this.getTex1(this.findMatch2((_local_7[1] + " cloth")));
                            Parameters.save();
                            _local_12.setTex2(Parameters.data_.setTex2);
                        }
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/dye (.+)$");
                    if (_local_7 != null)
                    {
                        if (_local_7[1] == "none")
                        {
                            Parameters.data_.setTex1 = 0;
                            Parameters.data_.setTex2 = 0;
                            Parameters.save();
                            _local_12.setTex1(0);
                            _local_12.setTex2(0);
                        }
                        else
                        {
                            _local_7[1] = this.getTex1(this.findMatch2((_local_7[1] + " cloth")));
                            Parameters.data_.setTex1 = _local_7[1];
                            Parameters.data_.setTex2 = _local_7[1];
                            Parameters.save();
                            _local_12.setTex1(Parameters.data_.setTex1);
                            _local_12.setTex2(Parameters.data_.setTex2);
                        }
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/skin (.+)$");
                    if (_local_7 != null)
                    {
                        if (_local_7[1] == "none")
                        {
                            Parameters.data_.nsetSkin[0] = "";
                            Parameters.data_.nsetSkin[1] = -1;
                            Parameters.save();
                            _local_12.size_ = 100;
                            _local_26.setPlayerSkinTemplate(_local_12, 0);
                        }
                        else
                        {
                            Parameters.data_.nsetSkin = this.findSkinIndex(_local_7[1]);
                            Parameters.save();
                        }
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/tp (\\w+)$");
                    if (_local_7 != null)
                    {
                        if (!Parameters.data_.blockTP) {
                            _local_26.teleport(this.fixedName(_local_7[1]).name_);
                        }
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/teleport (\\w+)$");
                    if (_local_7 != null)
                    {
                        if (!Parameters.data_.blockTP) {
                            _local_26.teleport(this.fixedName(_local_7[1]).name_);
                        }
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/follow (\\w+)$");
                    if (_local_7 != null)
                    {
                        _local_24 = this.fixedName(_local_7[1]);
                        _local_26.teleport(_local_24.name_);
                        _local_12.followTarget = _local_24;
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/setspd (-?\\d+)$");
                    if (_local_7 != null)
                    {
                        _local_12.speed_ = parseInt(_local_7[1]);
                        return (true);
                    }
                    _local_7 = this.data.match("^/getid (\\w+)");
                    if (_local_7 != null)
                    {
                        for each (_local_25 in _local_12.map_.goDict_)
                        {
                            if ((_local_25 is Player))
                            {
                                if (_local_7[1] == _local_25.name_.toLowerCase())
                                {
                                    this.addTextLine.dispatch(ChatMessage.make("*Help*", ((_local_25.name_ + " has id ") + _local_25.objectId_)));
                                }
                            }
                        }
                        return (true);
                    }
                    _local_7 = this.data.toLowerCase().match("^/connect ([0-9.]+)$");
                    if (_local_7 != null)
                    {
                        this.addTextLine.dispatch(ChatMessage.make("*Help*", ("Connecting to " + _local_7[1])));
                        this.hudModel.gameSprite.dispatchEvent(new ReconnectEvent(new Server().setName("Custom").setAddress(_local_7[1]).setPort(2050), -2, false, this.hudModel.gameSprite.gsc_.charId_, getTimer(), new ByteArray(), false));
                        return (true);
                    }
            }
            return (false);
        }

        private function findSkinIndex(_arg_1:String):Array
        {
            var _local_2:Array;
            var _local_3:XML;
            var _local_4:int;
            var _local_5:String;
            var _local_6:String;
            var _local_7:XML;
            var _local_8:XMLList;
            var _local_9:Array = _arg_1.split(" ");
            var _local_10:int = int.MAX_VALUE;
            _local_7 = EmbeddedData.skinsXML;
            _local_8 = _local_7.children();
            for each (_local_3 in _local_8)
            {
                _local_2 = _local_3.@id.toLowerCase().split(" ");
                _local_4 = this.scoredMatch(_local_3.@id.toString().length, _local_9, _local_2);
                if (_local_4 < _local_10)
                {
                    _local_10 = _local_4;
                    _local_5 = _local_3.AnimatedTexture.File;
                    _local_6 = _local_3.AnimatedTexture.Index;
                }
            }
            return ([_local_5, _local_6]);
        }

        private function getTex1(_arg_1:int):uint
        {
            var _local_2:XML = ObjectLibrary.xmlLibrary_[_arg_1];
            return (_local_2.Tex1);
        }

        private function fixedName(_arg_1:String):GameObject
        {
            var _local_2:int;
            var _local_3:GameObject;
            var _local_4:GameObject;
            var _local_5:int = int.MAX_VALUE;
            for each (_local_3 in this.hudModel.gameSprite.map.goDict_)
            {
                if ((_local_3 is Player))
                {
                    _local_2 = this.levenshtein(_arg_1, _local_3.name_.toLowerCase().substr(0, _arg_1.length));
                    if (_local_2 < _local_5)
                    {
                        _local_5 = _local_2;
                        _local_4 = _local_3;
                    }
                    if (_local_5 == 0) break;
                }
            }
            return (_local_4);
        }

        private function findMatch2(_arg_1:String):int
        {
            var _local_2:Array;
            var _local_3:String;
            var _local_4:int;
            var _local_5:String;
            var _local_8:int;
            var _local_6:Vector.<String> = new <String>["def", "att", "spd", "dex", "vit", "wis", "ubhp"];
            var _local_7:Vector.<int> = new <int>[2592, 2591, 2593, 2636, 2612, 2613, 2985];
            while (_local_8 < _local_6.length)
            {
                if (_arg_1 == _local_6[_local_8])
                {
                    return (_local_7[_local_8]);
                }
                _local_8++;
            }
            var _local_9:Array = _arg_1.split(" ");
            var _local_10:int = int.MAX_VALUE;
            for each (_local_3 in ObjectLibrary.itemLib)
            {
                _local_2 = _local_3.toLowerCase().split(" ");
                _local_4 = this.scoredMatch(_local_3.length, _local_9, _local_2);
                if (_local_4 < _local_10)
                {
                    _local_10 = _local_4;
                    _local_5 = _local_3;
                }
            }
            return (ObjectLibrary.idToType_[_local_5]);
        }

        private function scoredMatch(_arg_1:int, _arg_2:Array, _arg_3:Array):int
        {
            var _local_4:String;
            var _local_5:String;
            for each (_local_4 in _arg_3)
            {
                for each (_local_5 in _arg_2)
                {
                    if (_local_4.substr(0, _local_5.length) == _local_5)
                    {
                        _arg_1 = (_arg_1 - (_local_5.length * 10));
                    }
                }
            }
            return (_arg_1);
        }

        private function levenshtein(_arg_1:String, _arg_2:String):int
        {
            var _local_3:int;
            var _local_4:int;
            var _local_6:int;
            var _local_5:Array = [];
            while (_local_6 <= _arg_1.length)
            {
                _local_5[_local_6] = [];
                _local_4 = 0;
                while (_local_4 <= _arg_2.length)
                {
                    if (_local_6 != 0)
                    {
                        _local_5[_local_6].push(0);
                    }
                    else
                    {
                        _local_5[_local_6].push(_local_4);
                    }
                    _local_4++;
                }
                _local_5[_local_6][0] = _local_6;
                _local_6++;
            }
            _local_6 = 1;
            while (_local_6 <= _arg_1.length)
            {
                _local_4 = 1;
                while (_local_4 <= _arg_2.length)
                {
                    if (_arg_1.charAt((_local_6 - 1)) == _arg_2.charAt((_local_4 - 1)))
                    {
                        _local_3 = 0;
                    }
                    else
                    {
                        _local_3 = 1;
                    }
                    _local_5[_local_6][_local_4] = Math.min((_local_5[(_local_6 - 1)][_local_4] + 1), (_local_5[_local_6][(_local_4 - 1)] + 1), (_local_5[(_local_6 - 1)][(_local_4 - 1)] + _local_3));
                    _local_4++;
                }
                _local_6++;
            }
            return (_local_5[_arg_1.length][_arg_2.length]);
        }

        private function findItem(_arg_1:int):void
        {
            var _local_2:Vector.<int>;
            var _local_3:GameObject;
            var _local_4:int;
            var _local_5:Player;
            var _local_8:int;
            if (_arg_1 == 2581)
            {
                this.addTextLine.dispatch(ChatMessage.make("*Help*", "No item matched the query"));
            }
            var _local_6:Vector.<Player> = new Vector.<Player>(0);
            var _local_7:AbstractMap = this.hudModel.gameSprite.map;
            var _local_9:Player = this.hudModel.gameSprite.map.player_;
            for each (_local_3 in _local_7.goDict_)
            {
                if ((_local_3 is Player))
                {
                    _local_5 = (_local_3 as Player);
                    if (!((_local_5 == _local_7.player_) || (!(_local_5.nameChosen_))))
                    {
                        _local_2 = _local_5.equipment_;
                        _local_4 = 4;
                        while (_local_4 < 20)
                        {
                            if (_local_2[_local_4] == _arg_1)
                            {
                                _local_8++;
                            }
                            _local_4++;
                        }
                        if (_local_8 > 0)
                        {
                            _local_6.push(_local_5);
                            _local_5.lastAltAttack_ = _local_8;
                            _local_8 = 0;
                        }
                    }
                }
            }
            if (_local_6.length > 0)
            {
                this.openDialog.dispatch(new FindMenu(this.hudModel.gameSprite, _local_6, ObjectLibrary.getIdFromType(_arg_1)));
            }
            else
            {
                this.addTextLine.dispatch(ChatMessage.make("*Help*", ("No one has " + ObjectLibrary.getIdFromType(_arg_1))));
            }
        }

        private function custMessages():Boolean
        {
            var _local_1:Array = this.data.match("^/setmsg (\\d) (.+)$");
            if (_local_1 == null)
            {
                return (false);
            }
            if (_local_1[1] == "1") {
                Parameters.data_.msg1 = _local_1[2];
            } else {
                if (_local_1[1] == "2") {
                    Parameters.data_.msg2 = _local_1[2];
                } else {
                    if (_local_1[1] == "3") {
                        Parameters.data_.msg3 = _local_1[2];
                    } else {
                        if (_local_1[1] == "4") {
                            Parameters.data_.msg4 = _local_1[2];
                        } else {
                            if (_local_1[1] == "5") {
                                Parameters.data_.msg5 = _local_1[2];
                            } else {
                                if (_local_1[1] == "6") {
                                    Parameters.data_.msg6 = _local_1[2];
                                } else {
                                    if (_local_1[1] == "7") {
                                        Parameters.data_.msg7 = _local_1[2];
                                    } else {
                                        if (_local_1[1] == "8") {
                                            Parameters.data_.msg8 = _local_1[2];
                                        } else {
                                            if (_local_1[1] == "9") {
                                                Parameters.data_.msg9 = _local_1[2];
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            this.addTextLine.dispatch(ChatMessage.make("*Help*", (((("Message #" + _local_1[1]) + ' set to "') + _local_1[2]) + '"')));
            Parameters.save();
            return (true);
        }

        private function effCom():Boolean
        {
            var _local_1:Array = this.data.match("^/eff (\\d) (\\d+) (.+)$");
            if (_local_1 == null)
            {
                return (false);
            }
            if (_local_1[1] == "1")
            {
                Parameters.data_.dbPre1[0] = _local_1[3];
                Parameters.data_.dbPre1[1] = parseInt(_local_1[2]);
                Parameters.data_.dbPre1[2] = false;
            }
            else
            {
                if (_local_1[1] == "2")
                {
                    Parameters.data_.dbPre2[0] = _local_1[3];
                    Parameters.data_.dbPre2[1] = parseInt(_local_1[2]);
                    Parameters.data_.dbPre2[2] = false;
                }
                else
                {
                    if (_local_1[1] == "3")
                    {
                        Parameters.data_.dbPre3[0] = _local_1[3];
                        Parameters.data_.dbPre3[1] = parseInt(_local_1[2]);
                        Parameters.data_.dbPre3[2] = false;
                    }
                }
            }
            this.addTextLine.dispatch(ChatMessage.make("*Help*", ("A new preset was created for effect ID " + _local_1[2])));
            Parameters.save();
            return (true);
        }

        private function tellHandle():Boolean
        {
            var _local_1:Array;
            var _local_2:* = "";
            if (((this.data.substr(0, 3) == "/t ") || (this.data.substr(0, 3) == "/w ")))
            {
                _local_2 = this.data.substr(3);
            }
            else
            {
                if (this.data.substr(0, 6) == "/tell ")
                {
                    _local_2 = this.data.substr(6);
                }
                else
                {
                    if (this.data.substr(0, 9) == "/whisper ")
                    {
                        _local_2 = this.data.substr(9);
                    }
                }
            }
            if (_local_2 != "")
            {
                _local_1 = _local_2.match("(\\w+) (.+)");
                if (_local_1 != null)
                {
                    lastTellTo = _local_1[1];
                    lastTell = _local_1[2];
                    lastMsg = this.data;
                    this.hudModel.gameSprite.gsc_.playerText(this.data);
                    return (true);
                }
            }
            return (false);
        }

        public function execute():void {
            var _local_1:Object;
            var _local_2:uint;
            var _local_3:GameObject;
            var _local_4:String;
            var _local_5:* = undefined;
            if (!Options.hidden) {
                if (this.tellHandle()) {
                    return;
                }
                if (this.listCommands()) {
                    return;
                }
                if (this.cjCommands(this.data)) {
                    return;
                }
                if (this.custMessages()) {
                    return;
                }
                if (this.effCom()) {
                    return;
                }
                if (this.fsCommands(this.data)) {
                    return;
                }
            }
            if (this.data == "/help") {
                this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, TextKey.HELP_COMMAND));
            }
            else {
                if ((((this.data == "/c") || (this.data == "/class")) || (this.data == "/classes"))) {
                    _local_1 = null;
                    _local_2 = 0;
                    _local_3 = null;
                    _local_4 = null;
                    _local_5 = undefined;
                    _local_1 = {};
                    _local_2 = 0;
                    for each (_local_3 in this.hudModel.gameSprite.map.goDict_) {
                        if (_local_3.props_.isPlayer_) {
                            _local_1[_local_3.objectType_] = ((_local_1[_local_3.objectType_] != undefined) ? (_local_1[_local_3.objectType_] + 1) : uint(1));
                            _local_2++;
                        }
                    }
                    _local_4 = "";
                    for (_local_5 in _local_1) {
                        _local_4 = (_local_4 + (((" " + ObjectLibrary.typeToDisplayId_[_local_5]) + ": ") + _local_1[_local_5]));
                    }
                    this.addTextLine.dispatch(ChatMessage.make("", ((("Classes online (" + _local_2) + "):") + _local_4)));
                }
                else {
                    if (this.data == "/hidehacks") {
                        Options.toggleHax();
                        this.addTextLine.dispatch(ChatMessage.make("", ("Unrecognized command: " + this.data)));
                    } else {
                        lastMsg = this.data;
                        this.hudModel.gameSprite.gsc_.playerText(this.data);
                    }
                }
            }
        }


    }
}//package kabam.rotmg.chat.control

