package hxangular.haxe;

import haxe.macro.Expr;
import haxe.macro.Context;

/**
 * @author Bohdan Makohin
 */

class Scope
{
	macro public static function digest(scope: Expr): Expr
	{
		return makeCall(scope, "digest");
	}
	
	macro public static function broadcast(scope: Expr, name: String, ?args: Dynamic): Expr
	{
		return makeCall(scope, "broadcast");
	}
	
	#if macro
	
	static function makeCall(scope: Expr, fnName)
	{
		var _fn = { expr: EField(scope, "$" + fnName), pos: Context.currentPos() };
		return macro untyped $_fn();
	}
	
	#end
}