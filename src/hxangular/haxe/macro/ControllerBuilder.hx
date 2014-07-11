package hxangular.haxe.macro;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type.ClassType;
#end

/**
 * ...
 * @author Bohdan Makohin
 */
class ControllerBuilder
{
	macro public static function build():Array<Field>
	{
		var helper = new BuildingHelper();
		helper.addMeta(":expose");
		helper.declareInjection();
		
		return helper.fields;
	}
}