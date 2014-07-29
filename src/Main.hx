package ;

import pl.bigsoda.weblog.controllers.DebugController;
import pl.bigsoda.weblog.controllers.InspectController;
import pl.bigsoda.weblog.controllers.LogController;
import pl.bigsoda.weblog.controllers.TabNavigatorController;
import pl.bigsoda.weblog.controllers.ServerAdressController;
import pl.bigsoda.weblog.controllers.TestController;
import pl.bigsoda.weblog.controllers.TictocController;
import pl.bigsoda.weblog.controllers.StatsController;
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
		var app:Module = Angular.module("weblog", ["infinite-scroll", "sf.virtualScroll"]);
		app.controller("pl.bigsoda.weblog.controllers.LogController", LogController);
		app.controller("pl.bigsoda.weblog.controllers.DebugController", DebugController);
		app.controller("pl.bigsoda.weblog.controllers.InspectController", InspectController);
		app.controller("pl.bigsoda.weblog.controllers.TabNavigatorController", TabNavigatorController);
		app.controller("pl.bigsoda.weblog.controllers.ServerAdressController", ServerAdressController);
		app.controller("pl.bigsoda.weblog.controllers.TictocController", TictocController);
		app.controller("pl.bigsoda.weblog.controllers.StatsController", StatsController);
		app.service("pl.bigsoda.weblog.servicess.SocketService", SocketService);

	}
	
}


