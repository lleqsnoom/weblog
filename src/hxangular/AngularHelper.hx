package hxangular;

/**
 * ...
 * @author tkwiatek
 */
class AngularHelper
{
	
	public static function map(scope:Dynamic, instance:Dynamic) 
	{
		var fields = Type.getInstanceFields(Type.getClass(instance));
		for (i in 0...fields.length) 
		{
			Reflect.setField(scope, fields[i], Reflect.field(instance, fields[i]));
		}
	}
	
}