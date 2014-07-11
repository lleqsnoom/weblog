package ;

import pl.bigsoda.weblog.controllers.DebugController;
import pl.bigsoda.weblog.controllers.LogController;
import pl.bigsoda.weblog.controllers.TabNavigatorController;
import pl.bigsoda.weblog.controllers.TestController;
import pl.bigsoda.weblog.servicess.SocketService;
import hxangular.Angular;
import hxangular.Angular.Module;
import js.Lib;

/**
 * ...
 * @author tkwiatek
 */

class Main 
{
	
	static function main() 
	{
		var app:Module = Angular.module("weblog", ["infinite-scroll"]);
		app.controller("pl.bigsoda.weblog.controllers.LogController", LogController);
		app.controller("pl.bigsoda.weblog.controllers.DebugController", DebugController);
		app.controller("pl.bigsoda.weblog.controllers.TestController", TestController);
		app.controller("pl.bigsoda.weblog.controllers.TabNavigatorController", TabNavigatorController);
		app.service("pl.bigsoda.weblog.servicess.SocketService", SocketService);
	}
	
}


