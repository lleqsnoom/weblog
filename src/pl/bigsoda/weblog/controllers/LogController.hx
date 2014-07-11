package pl.bigsoda.weblog.controllers;

import hxangular.AngularHelper;
import hxangular.haxe.IController;
import js.Console;
/**
 * ...
 * @author tkwiatek
 */
class LogController implements IController
{

	var scope:Dynamic;
	var rootScope:Dynamic;
	var http:Dynamic;
	var timeout:Dynamic;
	var socketData:Dynamic;
	
	@inject("$scope", "$window", "$http", "$document", "$timeout", "$rootScope", "pl.bigsoda.weblog.servicess.SocketService")
	public function new(scope, window, http, document, timeout, rootScope, socketService) 
	{
		this.scope = scope;
		this.http = http;
		this.timeout = timeout;
		
		
		AngularHelper.map(this.scope, this);
		socketService.getLogData().then(onSocketData);
	}
	
	private function onSocketData(data:Dynamic):Void 
	{
		Console.log("onSocketData");
		scope.logs = data;
	}
	
}