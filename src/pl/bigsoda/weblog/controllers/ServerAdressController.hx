package pl.bigsoda.weblog.controllers;
import hxangular.AngularHelper;
import hxangular.haxe.IController;
import js.Console;

/**
 * ...
 * @author tkwiatek
 */
class ServerAdressController implements IController
{
	var rootScope:Dynamic;
	var scope:Dynamic;
	var serverIP:Dynamic;
	
	@inject("$scope", "$window", "$http", "$document", "$timeout", "$rootScope")
	public function new(scope, window, http, document, timeout, rootScope)
	{
		this.scope = scope;
		this.rootScope = rootScope;
	
		rootScope.selectedTab = "log";
		AngularHelper.map(this.scope, this);
		//Console.log(window.server);

		window.server.getNetworkIP(function (error, ip) {
			scope.$apply(function () {
	            scope.serverIP = ip;
	        });
			
		    if (error) {
		        //console.log('error:', error);
		    }
		});
	}
	
}