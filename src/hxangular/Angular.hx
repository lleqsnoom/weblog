package hxangular;

import hxangular.haxe.IController;
import hxangular.haxe.IService;

/**
 * @author Bohdan Makohin
 */

@:native("angular")
extern class Angular
{
	public static function module(name: String, requires: Array<String>, ?configFn: Dynamic): Module;
}

extern class Module
{
	public function config(configFn: Dynamic): Module;
	public function constant(name: String, object: Dynamic): Module;
	public function controller(name: String, constructor: Class<IController>): Module;
	public function service(name: String, constructor: Class<IService>): Module;
}