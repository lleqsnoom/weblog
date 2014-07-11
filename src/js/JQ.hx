package ;

/**
 * ...
 * @author tkwiatek
 */
class JQ
{
	
	static public var window(get_window, null):Dynamic;
	static public var document(get_document, null):Dynamic;
	
	private static function get_window():Dynamic
	{
		return untyped __js__("$(window)");
	}
	
	private static function get_document():Dynamic
	{
		return untyped __js__("$(document)");
	}
	
	
}