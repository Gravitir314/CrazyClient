//com.company.util.MoreStringUtil

package com.company.util
{
import flash.utils.ByteArray;

public class MoreStringUtil
{


	public static function hexStringToByteArray(_arg_1:String):ByteArray
	{
		var _local_2:int;
		var _local_3:ByteArray = new ByteArray();
		while (_local_2 < _arg_1.length)
		{
			_local_3.writeByte(parseInt(_arg_1.substr(_local_2, 2), 16));
			_local_2 = (_local_2 + 2);
		}
		return (_local_3);
	}

	public static function cmp(_arg_1:String, _arg_2:String):Number
	{
		return (_arg_1.localeCompare(_arg_2));
	}

	public static function levenshtein(_arg_1:String, _arg_2:String):int
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


}
}//package com.company.util

