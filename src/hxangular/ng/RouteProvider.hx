package hxangular.ng;
import hxangular.haxe.IController;

/**
 * ...
 * @author Bohdan Makohin
 */
extern class RouteProvider
{
	public function when(path: String, route: RouteMapping): RouteProvider;
	public function otherwise(route: RouteMapping): RouteProvider;
}

typedef RouteMapping =
{
	? controller: Class<IController>,
	? template: String,
	? templateUrl: String,
	? redirectTo: Dynamic
}