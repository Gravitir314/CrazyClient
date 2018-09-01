﻿//kabam.rotmg.text.view.stringBuilder.LineBuilder

package kabam.rotmg.text.view.stringBuilder
{
import com.company.assembleegameclient.objects.Player;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.language.model.StringMap;

public class LineBuilder implements StringBuilder
{

	public var key:String;
	public var tokens:Object;
	private var postfix:String = "";
	private var prefix:String = "";
	private var map:StringMap;


	public static function fromJSON(_arg_1:String):LineBuilder
	{
		var _local_2:Object = JSON.parse(_arg_1);
		return (new (LineBuilder)().setParams(_local_2.key, _local_2.tokens));
	}

	public static function getLocalizedStringFromKey(_arg_1:String, _arg_2:Object = null):String
	{
		var _local_3:LineBuilder = new (LineBuilder)();
		_local_3.setParams(_arg_1, _arg_2);
		var _local_4:StringMap = StaticInjectorContext.getInjector().getInstance(StringMap);
		_local_3.setStringMap(_local_4);
		return ((_local_3.getString() == "") ? _arg_1 : _local_3.getString());
	}

	public static function getLocalizedStringFromJSON(_arg_1:String):String
	{
		var _local_2:LineBuilder;
		var _local_3:StringMap;
		if (_arg_1.charAt(0) == "{")
		{
			_local_2 = LineBuilder.fromJSON(_arg_1);
			_local_3 = StaticInjectorContext.getInjector().getInstance(StringMap);
			_local_2.setStringMap(_local_3);
			return (_local_2.getString());
		}
		return (_arg_1);
	}

	public static function returnStringReplace(_arg_1:String, _arg_2:Object = null, _arg_3:String = "", _arg_4:String = ""):String
	{
		var _local_5:String;
		var _local_6:String;
		var _local_7:String;
		var _local_8:String = stripCurlyBrackets(_arg_1);
		for (_local_5 in _arg_2)
		{
			_local_6 = _arg_2[_local_5];
			_local_7 = (("{" + _local_5) + "}");
			while (_local_8.indexOf(_local_7) != -1)
			{
				_local_8 = _local_8.replace(_local_7, _local_6);
			}
		}
		_local_8 = _local_8.replace(/\\n/g, "\n");
		return ((_arg_3 + _local_8) + _arg_4);
	}

	public static function getLocalizedString2(_arg_1:String, _arg_2:Object = null):String
	{
		var _local_3:LineBuilder = new (LineBuilder)();
		_local_3.setParams(_arg_1, _arg_2);
		var _local_4:StringMap = StaticInjectorContext.getInjector().getInstance(StringMap);
		_local_3.setStringMap(_local_4);
		return (_local_3.getString());
	}

	private static function stripCurlyBrackets(_arg_1:String):String
	{
		var _local_2:Boolean = (((!(_arg_1 == null)) && (_arg_1.charAt(0) == "{")) && (_arg_1.charAt((_arg_1.length - 1)) == "}"));
		return ((_local_2) ? _arg_1.substr(1, (_arg_1.length - 2)) : _arg_1);
	}


	public function toJson():String
	{
		return (JSON.stringify({
			"key": this.key, "tokens": this.tokens
		}));
	}

	public function setParams(_arg_1:String, _arg_2:Object = null):LineBuilder
	{
		this.key = ((_arg_1) || (""));
		this.tokens = _arg_2;
		return (this);
	}

	public function setPrefix(_arg_1:String):LineBuilder
	{
		this.prefix = _arg_1;
		return (this);
	}

	public function setPostfix(_arg_1:String):LineBuilder
	{
		this.postfix = _arg_1;
		return (this);
	}

	public function setStringMap(_arg_1:StringMap):void
	{
		this.map = _arg_1;
	}

	public function getString():String
	{
		var _local_1:String;
		var _local_2:String;
		var _local_3:String;
		var _local_4:String = stripCurlyBrackets(this.key);
		var _local_5:String = ((this.map.getValue(_local_4)) || (""));
		for (_local_1 in this.tokens)
		{
			_local_2 = this.tokens[_local_1];
			if (((_local_2.charAt(0) == "{") && (_local_2.charAt((_local_2.length - 1)) == "}")))
			{
				_local_2 = this.map.getValue(_local_2.substr(1, (_local_2.length - 2)));
			}
			_local_3 = (("{" + _local_1) + "}");
			while (_local_5.indexOf(_local_3) != -1)
			{
				_local_5 = _local_5.replace(_local_3, _local_2);
			}
		}
		_local_5 = _local_5.replace(/\\n/g, "\n");
		return ((this.prefix + _local_5) + this.postfix);
	}

	public function getStringAlt(_arg_1:Player = null):String
	{
		var _local_2:String;
		var _local_3:String;
		var _local_4:String;
		var _local_5:String = stripCurlyBrackets(this.key);
		var _local_6:String = ((this.map.getValue(_local_5)) || (""));
		for (_local_2 in this.tokens)
		{
			_local_3 = this.tokens[_local_2];
			if (((_local_3.charAt(0) == "{") && (_local_3.charAt((_local_3.length - 1)) == "}")))
			{
				_local_3 = this.map.getValue(_local_3.substr(1, (_local_3.length - 2)));
			}
			_local_4 = (("{" + _local_2) + "}");
			while (_local_6.indexOf(_local_4) != -1)
			{
				_local_6 = _local_6.replace(_local_4, _local_3);
			}
		}
		_local_6 = _local_6.replace(/\\n/g, "\n");
		if (this.key == "server.no_teleport_new_connect")
		{
			_arg_1.startTimer(parseInt(_local_3), 1000);
		}
		return ((this.prefix + _local_6) + this.postfix);
	}


}
}//package kabam.rotmg.text.view.stringBuilder

