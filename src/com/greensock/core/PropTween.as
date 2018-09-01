//com.greensock.core.PropTween

package com.greensock.core
{
public final class PropTween
{

	public var _prev:PropTween;
	public var pr:int;
	public var c:Number;
	public var f:Boolean;
	public var p:String;
	public var r:Boolean;
	public var s:Number;
	public var t:Object;
	public var pg:Boolean;
	public var _next:PropTween;
	public var n:String;

	public function PropTween(_arg_1:Object, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:String, _arg_6:Boolean, _arg_7:PropTween = null, _arg_8:int = 0)
	{
		this.t = _arg_1;
		this.p = _arg_2;
		this.s = _arg_3;
		this.c = _arg_4;
		this.n = _arg_5;
		this.f = (_arg_1[_arg_2] is Function);
		this.pg = _arg_6;
		if (_arg_7)
		{
			_arg_7._prev = this;
			this._next = _arg_7;
		}
		this.pr = _arg_8;
	}

}
}//package com.greensock.core

