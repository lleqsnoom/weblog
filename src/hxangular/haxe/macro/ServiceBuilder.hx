package hxangular.haxe.macro;

#if macro
import haxe.macro.Expr;
#end

/**
 * ...
 * @author Bohdan Makohin
 */
class ServiceBuilder
{
	macro public static function build():Array<Field>
	{
		var helper = new BuildingHelper();
		helper.declareInjection();
		
		return helper.fields;
	}
}