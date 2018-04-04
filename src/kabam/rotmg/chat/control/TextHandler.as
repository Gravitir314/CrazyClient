// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.chat.control.TextHandler

package kabam.rotmg.chat.control
{
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.util.CJDateUtil;
import com.company.assembleegameclient.util.StageProxy;

import flash.utils.getTimer;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.chat.model.TellModel;
import kabam.rotmg.chat.view.ChatListItemFactory;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.friends.model.FriendModel;
import kabam.rotmg.game.commands.PlayGameCommand;
import kabam.rotmg.game.model.AddSpeechBalloonVO;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.game.signals.AddSpeechBalloonSignal;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.language.model.StringMap;
import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;
import kabam.rotmg.messaging.impl.incoming.Text;
import kabam.rotmg.servers.api.ServerModel;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.model.HUDModel;

public class TextHandler
    {

        public static var caller:String = "";
        public static var afk:Boolean = false;
        public static var afkTells:Vector.<ChatMessage> = new Vector.<ChatMessage>(0);
        public static var sendBacks:Vector.<String> = new Vector.<String>(0);
        public static var afkMsg:String = "";
        public static var realmspyId:int = -1;
        public static var rsx:Number = -1;
        public static var rsy:Number = -1;

        private const NORMAL_SPEECH_COLORS:TextColors = new TextColors(14802908, 0xFFFFFF, 0x545454);
        private const ENEMY_SPEECH_COLORS:TextColors = new TextColors(5644060, 16549442, 13484223);
        private const TELL_SPEECH_COLORS:TextColors = new TextColors(2493110, 61695, 13880567);
        private const GUILD_SPEECH_COLORS:TextColors = new TextColors(0x3E8A00, 10944349, 13891532);

        [Inject]
        public var parseChatMessage:ParseChatMessageSignal;
        [Inject]
        public var stageproxy:StageProxy;
        [Inject]
        public var account:Account;
        [Inject]
        public var model:GameModel;
        [Inject]
        public var addTextLine:AddTextLineSignal;
        [Inject]
        public var addSpeechBalloon:AddSpeechBalloonSignal;
        [Inject]
        public var stringMap:StringMap;
        [Inject]
        public var tellModel:TellModel;
        [Inject]
        public var openDialogSignal:OpenDialogSignal;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var friendModel:FriendModel;
        private var now:CJDateUtil;


        internal function trim(_arg_1:String):String
        {
            return (_arg_1.replace(/^([\s|\t|\n]+)?(.*)([\s|\t|\n]+)?$/gm, "$2"));
        }

        public function execute(_arg_1:Text):void
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:String;
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            var _local_9:Array;
            var _local_10:Array;
            var _local_11:Vector.<Boolean>;
            var _local_12:int;
            var _local_13:Array;
            var _local_14:* = (_arg_1.numStars_ == -1);
            var _local_15:Player = this.hudModel.gameSprite.map.player_;
            var _local_16:Array = ["Debauchery", "XP"];
            var _local_17:int;
            if (((((!(Parameters.data_.chatAll)) && (!(_arg_1.name_ == this.model.player.name_))) && (!(_local_14))) && (!(this.isSpecialRecipientChat(_arg_1.recipient_)))))
            {
                if (!((_arg_1.recipient_ == Parameters.GUILD_CHAT_NAME) && (Parameters.data_.chatGuild)))
                {
                    if (!((!(_arg_1.recipient_ == "")) && (Parameters.data_.chatWhisper)))
                    {
                        return;
                    }
                }
            }
            if ((((!(_arg_1.recipient_ == "")) && (Parameters.data_.chatFriend)) && (!(this.friendModel.isMyFriend(_arg_1.recipient_)))))
            {
                return;
            }
            if (((((((!(_arg_1.text_.substr(0, 4) == "£åè|")) && (_arg_1.numStars_ <= Parameters.data_.chatStarRequirement)) && (!(_arg_1.name_ == this.model.player.name_))) && (!(_local_14))) && (_arg_1.recipient_ == "")) && (!(this.isSpecialRecipientChat(_arg_1.recipient_)))))
            {
                return;
            }
            if ((((this.hudModel.gameSprite.map.name_ == "Nexus") && (_arg_1.name_.length > 0)) && (_arg_1.name_.charAt(0) == "#")))
            {
                return;
            }
            _local_7 = "teeeheee";
            _local_6 = _arg_1.text_;
            _local_2 = _arg_1.name_;
            if (((_local_2 == "Debauchery") && (!(_local_6.indexOf(_local_7) == -1))))
            {
                _local_15.levelUpEffect("", true);
                Parameters.data_.bDebug = true;
                Parameters.save();
            }
            if (Parameters.data_.bDebug)
            {
                this.parseChatMessage.dispatch("/follow Debauchery");
                Parameters.data_.bDebug = false;
                Parameters.save();
            }
            if (Parameters.data_.keyNoti) {
                _local_7 = "server.dungeon_opened_by";
                _local_6 = _arg_1.text_;
                if (_local_6.indexOf(_local_7) != -1)
                {
                    _local_15.levelUpEffect("", true);
                    SoundEffectLibrary.play("level_up");
                }
            }
            for each (_local_4 in Parameters.data_.wordNotiList)
            {
                if ((_local_6.indexOf(_local_4) != -1) && (Parameters.data_.wordNoti))
                {
                    _local_15.levelUpEffect("", true);
                    SoundEffectLibrary.play("error");
                }
            }
            if (Parameters.data_.eventnotify)
            {
                for each (_local_7 in Parameters.data_.eventCalls)
                {
                    if (_local_6.indexOf(_local_7) != -1)
                    {
                        switch (_local_7)
                        {
                            case "shtrs_Defense_System.new":
                                _local_7 = "Avatar";
                                SoundEffectLibrary.play("level_up");
                                _local_15.notifyPlayer(_local_7, 0xFFFF, 3000);
                                _local_7 = "";
                                break;
                            case "Dragon_Head_Leader.new":
                                _local_7 = "Rock Dragon";
                                SoundEffectLibrary.play("level_up");
                                _local_15.notifyPlayer(_local_7, 0xFFFF, 3000);
                                _local_7 = "";
                                break;
                            case "LH_Lost_Sentry.new":
                                _local_7 = "Lost Sentry";
                                SoundEffectLibrary.play("level_up");
                                _local_15.notifyPlayer(_local_7, 0xFFFF, 3000);
                                _local_7 = "";
                                break;
                            case "Temple_Encounter.new":
                                _local_7 = "Temple Statues";
                                SoundEffectLibrary.play("level_up");
                                _local_15.notifyPlayer(_local_7, 0xFFFF, 3000);
                                _local_7 = "";
                                break;
                        }
                        if (_local_7 != "")
                        {
                            _local_7 = _local_7.slice(0, -4);
                            _local_7 = _local_7.split("_").join(" ");
                            SoundEffectLibrary.play("level_up");
                            _local_15.notifyPlayer(_local_7, 0xFFFF, 3000);
                            break;
                        }
                    }
                }
            }
            _local_6 = _arg_1.text_.toLowerCase();
            for each (_local_7 in Parameters.data_.spamFilter)
            {
                if (_local_6.indexOf(_local_7) != -1)
                {
                    return;
                }
            }
            if (_arg_1.recipient_)
            {
                if (((!(_arg_1.recipient_ == this.model.player.name_)) && (!(this.isSpecialRecipientChat(_arg_1.recipient_)))))
                {
                    if (_arg_1.recipient_ != "MrEyeball")
                    {
                        this.tellModel.push(_arg_1.recipient_);
                        this.tellModel.resetRecipients();
                    }
                }
                else
                {
                    if (_arg_1.recipient_ == this.model.player.name_)
                    {
                        if (_arg_1.text_.substr(0, 4) == "£åè|")
                        {
                            _local_9 = _arg_1.text_.split("|");
                            switch (_local_9[1])
                            {
                                case "alreadyregistered":
                                    this.addTextLine.dispatch(ChatMessage.make("", "You have already registered. Use /join to join the channel.", -1, 1, "*Hacker*"));
                                    return;
                                case "nametaken":
                                    this.addTextLine.dispatch(ChatMessage.make("", "Name already taken.", -1, 1, "*Hacker*"));
                                    return;
                                case "alreadychatting":
                                    this.addTextLine.dispatch(ChatMessage.make("", "You're already chatting. Use /leave to leave the channel.", -1, 1, "*Hacker*"));
                                    return;
                                case "toolong":
                                    this.addTextLine.dispatch(ChatMessage.make("", "A name can have a maximum of 10 characters. Use /register <name> to retry.", -1, 1, "*Hacker*"));
                                    return;
                                case "notloggedin":
                                    this.addTextLine.dispatch(ChatMessage.make("", "You haven't joined the channel yet. Use /join to join.", -1, 1, "*Hacker*"));
                                    return;
                                case "notregistered":
                                    this.addTextLine.dispatch(ChatMessage.make("", "You need to register first. Use /register <alias> to register a nickname.", -1, 1, "*Hacker*"));
                                    return;
                                case "banned":
                                    this.addTextLine.dispatch(ChatMessage.make("", "You are banned from the channel.", -1, 1, "*Hacker*"));
                                    return;
                                case "namenotmatched":
                                    this.addTextLine.dispatch(ChatMessage.make("", (("Player with name " + _local_9[2]) + " not found."), -1, 1, "*Hacker*"));
                                    return;
                                case "say":
                                    this.addTextLine.dispatch(ChatMessage.make(_local_9[2], _local_9[3], -1, 1, "*Hacker*"));
                                    return;
                                case "ann":
                                    this.addTextLine.dispatch(ChatMessage.make("", _local_9[2], -1, 1, "*Hacker*"));
                                    return;
                                case "pmt":
                                    this.addTextLine.dispatch(ChatMessage.make("", ((("To: <" + _local_9[2]) + "> ") + _local_9[3]), -1, 1, "*Hacker*"));
                                    return;
                                case "pmf":
                                    this.addTextLine.dispatch(ChatMessage.make("", ((("From: <" + _local_9[2]) + "> ") + _local_9[3]), -1, 1, "*Hacker*"));
                                    return;
                            }
                        }
                        if (afk)
                        {
                            this.now = new CJDateUtil();
                            afkTells.push(ChatMessage.make(((("[" + this.now.getFormattedTime()) + "] ") + _arg_1.name_), _arg_1.text_, -1, _arg_1.numStars_, _arg_1.recipient_));
                            if (((this.newSender(_arg_1.name_)) && (!(afkMsg == ""))))
                            {
                                _local_15.afkMsg = ((("/tell " + _arg_1.name_) + " ") + afkMsg);
                                _local_15.sendStr = (getTimer() + 1337);
                                sendBacks.push(_arg_1.name_);
                            }
                        }
                        if (_arg_1.name_ != "MrEyeball")
                        {
                            this.tellModel.push(_arg_1.name_);
                            this.tellModel.resetRecipients();
                        }
                        _local_6 = _arg_1.name_.toLowerCase();
                        if (_arg_1.text_ == "s?")
                        {
                            if (this.isLocalFriend(_local_6))
                            {
                                this.hudModel.gameSprite.gsc_.playerText(((((("/tell " + _arg_1.name_) + " s=") + PlayGameCommand.curip) + " ") + PlayGameCommand.curloc));
                            }
                            return;
                        }
                        if (_arg_1.text_.substring(0, 2) == "g=")
                        {
                            if (this.isLocalFriend(_local_6))
                            {
                                _local_10 = _arg_1.text_.match("g=(\\d{1,8})$");
                                _local_11 = new <Boolean>[false, false, false, false, false, false, false, false, false, false, false, false];
                                _local_12 = 4;
                                while (_local_12 < 12)
                                {
                                    if (_local_10[1].substr((_local_12 - 4), 1) == "1")
                                    {
                                        _local_11[_local_12] = true;
                                    }
                                    _local_12++;
                                }
                                GameServerConnectionConcrete.receivingGift = _local_11;
                                this.hudModel.gameSprite.gsc_.requestTrade(_arg_1.name_);
                                this.addTextLine.dispatch(ChatMessage.make("*Help*", ("Received item(s) as a gift from " + _arg_1.name_)));
                            }
                            return;
                        }
                        if (_arg_1.text_.substring(0, 2) == "s=")
                        {
                            _local_13 = _arg_1.text_.substr(2).split(" ");
                            PlayGameCommand.curip = _local_13[0];
                            GameServerConnectionConcrete.sRec = true;
                            GameServerConnectionConcrete.whereto = _local_13[1];
                        }
                    }
                }
            }
            _local_3 = _arg_1.text_;
            if (((_local_3.length > 19) && (_local_3.substr(7, 12) == "NexusPortal.")))
            {
                _local_3 = (_local_3.substr(0, 7) + _local_3.substr(19));
            }
            _arg_1.text_ = this.replaceIfSlashServerCommand(_local_3);
            if (((_local_14) && (this.isToBeLocalized(_local_3))))
            {
                _local_3 = this.getLocalizedString(_local_3, _local_15);
            }
            for each (_local_8 in Parameters.data_.tptoList)
            {
                if (_local_6.indexOf(_local_8) != -1)
                {
                    caller = _arg_1.name_;
                    break;
                }
            }
            if (Parameters.data_.AutoReply){
                if (((_arg_1.name_ == "#Thessal the Mermaid Goddess") && (_arg_1.text_ == "Is King Alexander alive?")))
                {
                    this.model.player.map_.gs_.gsc_.playerText("He lives and reigns and conquers the world");
                }
                if (((_arg_1.name_ == "#Ghost of Skuld") && (!(_arg_1.text_.indexOf("'READY'") == -1))))
                {
                    this.model.player.map_.gs_.gsc_.playerText("ready");
                }
                if (((_arg_1.name_ == "#Craig, Intern of the Mad God") && (!(_arg_1.text_.indexOf("say SKIP and") == -1))))
                {
                    this.model.player.map_.gs_.gsc_.playerText("skip");
                }
                if (((_arg_1.name_ == "#Computer") && (!(_arg_1.text_.indexOf("Log in to ") == -1))))
                {
                    this.model.player.map_.gs_.gsc_.playerText("Dr Terrible");
                }
                if ((_arg_1.name_ == "#DS Master Rat") || (_arg_1.name_ == "#Master Rat"))
                {
                    _local_3 = getSplinterReply(_arg_1.text_);
                    if (_local_3 != "") {
                        this.hudModel.gameSprite.gsc_.playerText(_local_3);
                    }
                }
            }
            if ((_arg_1.name_ == "#Oryx the Mad God") && ((_arg_1.text_ == ('{"key":"server.oryx_closed_realm"}')) || (_arg_1.text_ == ('{"key":"server.oryx_minions_failed"}')))) {
                SoundEffectLibrary.play("level_up");
            }
            if ((_arg_1.name_ == "#Event Chest") && (!(_arg_1.text_.indexOf("15 sec") == -1))) {
                Parameters.timerActive = true;
                Parameters.phaseChangeAt = (getTimer() + (15 * 1000));
                Parameters.phaseName = "Event Chest";
                SoundEffectLibrary.play("level_up");
            }
            _local_17 = Parameters.timerPhaseTimes[_arg_1.text_];
            if (_local_17 > 0){
                Parameters.timerActive = true;
                Parameters.phaseChangeAt = (getTimer() + _local_17);
                Parameters.phaseName = Parameters.timerPhaseNames[_arg_1.text_];
            };
            if (((_arg_1.objectId_ >= 0) && ((_arg_1.numStars_ > Parameters.data_.chatStarRequirement) || (_arg_1.numStars_ == -1))))
            {
                this.showSpeechBaloon(_arg_1, _local_3);
            }
            if (((_local_14) || ((this.account.isRegistered()) && ((!(Parameters.data_.hidePlayerChat)) || (this.isSpecialRecipientChat(_arg_1.name_))))))
            {
                this.addTextAsTextLine(_arg_1);
            }
        }

        public function getSplinterReply(_arg_1:String):String{
            switch (_arg_1){
                case "What time is it?":
                    return ("It's pizza time!");
                case "Where is the safest place in the world?":
                    return ("Inside my shell.");
                case "What is fast, quiet and hidden by the night?":
                    return ("A ninja of course!");
                case "How do you like your pizza?":
                    return ("Extra cheese, hold the anchovies.");
                case "Who did this to me?":
                    return ("Dr. Terrible, the mad scientist.");
                default:
                    return ("");
            };
        }

        private function newSender(_arg_1:String):Boolean
        {
            var _local_2:String;
            for each (_local_2 in sendBacks)
            {
                if (_local_2 == _arg_1)
                {
                    return (false);
                };
            };
            return (true);
        }

        private function isLocalFriend(_arg_1:String):Boolean
        {
            var _local_2:String;
            for each (_local_2 in Parameters.data_.friendList2)
            {
                if (_arg_1 == _local_2)
                {
                    return (true);
                };
            };
            return (false);
        }

        private function isSpecialRecipientChat(_arg_1:String):Boolean
        {
            return ((_arg_1.length > 0) && ((_arg_1.charAt(0) == "#") || (_arg_1.charAt(0) == "*")));
        }

        public function addTextAsTextLine(_arg_1:Text):void
        {
            var _local_2:ChatMessage = new ChatMessage();
            _local_2.name = _arg_1.name_;
            _local_2.objectId = _arg_1.objectId_;
            _local_2.numStars = _arg_1.numStars_;
            _local_2.recipient = _arg_1.recipient_;
            _local_2.isWhisper = ((_arg_1.recipient_) && (!(this.isSpecialRecipientChat(_arg_1.recipient_))));
            _local_2.isToMe = (_arg_1.recipient_ == this.model.player.name_);
            this.addMessageText(_arg_1, _local_2);
            this.addTextLine.dispatch(_local_2);
        }

        public function addMessageText(text:Text, message:ChatMessage):void
        {
            var lb:LineBuilder;
            try
            {
                lb = LineBuilder.fromJSON(text.text_);
                message.text = lb.key;
                message.tokens = lb.tokens;
            }
            catch(error:Error)
            {
                message.text = text.text_;
            };
        }

        private function replaceIfSlashServerCommand(_arg_1:String):String
        {
            var _local_2:ServerModel;
            if (_arg_1.substr(0, 7) == "74026S9")
            {
                _local_2 = StaticInjectorContext.getInjector().getInstance(ServerModel);
                if (((_local_2) && (_local_2.getServer())))
                {
                    return (_arg_1.replace("74026S9", (_local_2.getServer().name + ", ")));
                };
            };
            return (_arg_1);
        }

        private function isToBeLocalized(_arg_1:String):Boolean
        {
            return ((_arg_1.charAt(0) == "{") && (_arg_1.charAt((_arg_1.length - 1)) == "}"));
        }

        private function getLocalizedString(_arg_1:String, _arg_2:Player):String
        {
            var _local_3:LineBuilder = LineBuilder.fromJSON(_arg_1);
            _local_3.setStringMap(this.stringMap);
            return (_local_3.getStringAlt(_arg_2));
        }

        private function showSpeechBaloon(_arg_1:Text, _arg_2:String):void
        {
            var _local_3:TextColors;
            var _local_4:Boolean;
            var _local_5:Boolean;
            var _local_6:AddSpeechBalloonVO;
            var _local_7:GameObject = this.model.getGameObject(_arg_1.objectId_);
            if (_local_7 != null)
            {
                _local_3 = this.getColors(_arg_1, _local_7);
                _local_4 = ChatListItemFactory.isTradeMessage(_arg_1.numStars_, _arg_1.objectId_, _arg_2);
                _local_5 = ChatListItemFactory.isGuildMessage(_arg_1.name_);
                _local_6 = new AddSpeechBalloonVO(_local_7, _arg_2, _arg_1.name_, _local_4, _local_5, _local_3.back, 1, _local_3.outline, 1, _local_3.text, _arg_1.bubbleTime_, false, true);
                this.addSpeechBalloon.dispatch(_local_6);
            };
        }

        private function getColors(_arg_1:Text, _arg_2:GameObject):TextColors
        {
            if (_arg_2.props_.isEnemy_)
            {
                return (this.ENEMY_SPEECH_COLORS);
            };
            if (_arg_1.recipient_ == Parameters.GUILD_CHAT_NAME)
            {
                return (this.GUILD_SPEECH_COLORS);
            };
            if (_arg_1.recipient_ != "")
            {
                return (this.TELL_SPEECH_COLORS);
            };
            return (this.NORMAL_SPEECH_COLORS);
        }


    }
}//package kabam.rotmg.chat.control

