//kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder

package kabam.rotmg.text.view.stringBuilder
{
import kabam.rotmg.language.model.StringMap;

public class AppendingLineBuilder implements StringBuilder
{

	private var data:Vector.<LineData> = new Vector.<LineData>();
	private var delimiter:String = "\n";
	private var provider:StringMap;


	public function pushParams(_arg_1:String, _arg_2:Object = null, _arg_3:String = "", _arg_4:String = ""):AppendingLineBuilder
	{
		this.data.push(new LineData().setKey(_arg_1).setTokens(_arg_2).setOpeningTags(_arg_3).setClosingTags(_arg_4));
		return (this);
	}

	public function setDelimiter(_arg_1:String):AppendingLineBuilder
	{
		this.delimiter = _arg_1;
		return (this);
	}

	public function setStringMap(_arg_1:StringMap):void
	{
		this.provider = _arg_1;
	}

	public function getString():String
	{
		var _local_1:LineData;
		var _local_2:Vector.<String> = new Vector.<String>();
		for each (_local_1 in this.data)
		{
			_local_2.push(_local_1.getString(this.provider));
		}
		return (_local_2.join(this.delimiter));
	}

	public function hasLines():Boolean
	{
		return (!(this.data.length == 0));
	}

	public function clear():void
	{
		this.data = new Vector.<LineData>();
	}


}
}//package kabam.rotmg.text.view.stringBuilder

import kabam.rotmg.language.model.StringMap;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

class LineData
{

	public var key:String;
	public var tokens:Object;
	public var openingHTMLTags:String = "";
	public var closingHTMLTags:String = "";


	public function setKey(_arg_1:String):LineData
	{
		this.key = _arg_1;
		return (this);
	}

	public function setTokens(_arg_1:Object):LineData
	{
		this.tokens = _arg_1;
		return (this);
	}

	public function setOpeningTags(_arg_1:String):LineData
	{
		this.openingHTMLTags = _arg_1;
		return (this);
	}

	public function setClosingTags(_arg_1:String):LineData
	{
		this.closingHTMLTags = _arg_1;
		return (this);
	}

	public function getString(_arg_1:StringMap):String
	{
		var _local_2:String;
		var _local_3:String;
		var _local_4:StringBuilder;
		var _local_5:String;
		var _local_6:String = this.openingHTMLTags;
		_local_2 = _arg_1.getValue(TextKey.stripCurlyBrackets(this.key));
		if (_local_2 == null)
		{
			_local_2 = this.key;
		}
		_local_6 = _local_6.concat(_local_2);
		for (_local_3 in this.tokens)
		{
			if ((this.tokens[_local_3] is StringBuilder))
			{
				_local_4 = StringBuilder(this.tokens[_local_3]);
				_local_4.setStringMap(_arg_1);
				_local_6 = _local_6.replace((("{" + _local_3) + "}"), _local_4.getString());
			}
			else
			{
				_local_5 = this.tokens[_local_3];
				if ((((_local_5.length > 0) && (_local_5.charAt(0) == "{")) && (_local_5.charAt((_local_5.length - 1)) == "}")))
				{
					_local_5 = _arg_1.getValue(_local_5.substr(1, (_local_5.length - 2)));
				}
				_local_6 = _local_6.replace((("{" + _local_3) + "}"), _local_5);
			}
		}
		_local_6 = _local_6.replace(/\\n/g, "\n");
		return (_local_6.concat(this.closingHTMLTags));
	}


}


