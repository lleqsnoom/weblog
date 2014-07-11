package dk.xstream.modules;
import hxangular.AngularHelper;
import hxangular.haxe.IController;
import js.Console;

/**
 * ...
 * @author tkwiatek
 */
class InfinityScroll implements IController
{
	var scope:Dynamic;
	var elm:Dynamic;
	var attr:Dynamic;
	
	@inject("$scope", "$elm", "$attr")
	public function new(scope:Dynamic, elm:Dynamic, attr:Dynamic) 
	{
		Console.log("loadMore");
	}
	function scroll() {
	}
	
}