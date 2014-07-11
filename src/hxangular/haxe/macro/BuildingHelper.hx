package hxangular.haxe.macro;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

using Lambda;
#end

/**
 * @author Bohdan Makohin
 */
class BuildingHelper
{
	var localClass: ClassType;
	public var fields(default, null): Array<Field>;
	
	public function new()
	{
		localClass = Context.getLocalClass().get();
		fields = Context.getBuildFields();
	}
	
	public function addMeta(name: String)
	{
		addMetadata(localClass, { name: name } );
	}
	
	public function declareInjection()
	{
		var localClassName = localClass.pack.concat([localClass.name]).join(".");
		
		for (field in fields) 
		{
			var meta: Metadata = field.meta;
			switch(field.kind)
			{
				case FFun(_) if (field.name == "new"):
					var injects = meta.filter(metaExists("inject"));
					var inject = null;
					
					if (injects != null && injects.length > 0 && (inject = injects[0]) != null)
					{
						fields.push(getInjectExpr(localClassName, metaToString(inject.params)));
					}
				case _:
			}
		}
	}
	
	#if macro
	
	static function addMetadata(classType: ClassType, metadata: { name: String, ?params: Array<Expr> })
	{
		var params = (metadata.params == null)
			? new Array<Expr>()
			: metadata.params;

			classType.meta.add(metadata.name, params, classType.pos);
	}
	
	static function getInjectExpr(destination: String, injections: Array<String>): Field
	{
		var untypedJs = destination + ".$inject = [" + injections.join(",") + "]";
		
		return {
			name: "__init__",
			access: [APublic, AStatic],
			kind: FFun({
				expr: macro untyped $i{untypedJs},
				args: [],
				params: [],
				ret: null
			}),
			pos: Context.currentPos()
		}
	}
	
	static function metaToString(meta: Array<Expr>)
	{
		return meta.map(function (p: Expr): String {
			return switch(p.expr)
			{
				case EConst(CString(str)): '"$str"';
				case _: "";
			}
		});
	}
	
	static function metaExists(name: String): MetadataEntry -> Bool
	{
		return function (entry: MetadataEntry) {
			return entry.name == name;
		}
	}
	
	#end
	
}