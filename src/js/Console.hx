package js;

/**
 * ...
 * @author tkwiatek
 */
class Console
{
	public static inline function log(d:Dynamic) 
	{
		untyped __js__("console.log")(d);
	}
	
}