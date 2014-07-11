package ;
import js.Lib;

/**
 * ...
 * @author tkwiatek
 */
class Ajax
{

	public function new(data) 
	{
		Lib.eval("jQuery").ajax(data);
	}
	
}