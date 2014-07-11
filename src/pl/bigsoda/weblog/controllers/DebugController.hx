package pl.bigsoda.weblog.controllers;

import hxangular.AngularHelper;
import hxangular.haxe.IController;
import js.Console;
/**
 * ...
 * @author tkwiatek
 */
class DebugController implements IController
{

	var scope:Dynamic;
	var rootScope:Dynamic;
	var http:Dynamic;
	var timeout:Dynamic;
	var socketData:Dynamic;
	var sce:Dynamic;
	
	@inject("$scope", "$window", "$http", "$document", "$timeout", "$rootScope", "pl.bigsoda.weblog.servicess.SocketService", "$sce")
	public function new(scope, window, http, document, timeout, rootScope, socketService, sce) 
	{
		this.scope = scope;
		this.http = http;
		this.timeout = timeout;
		this.sce = sce;
		
		
		AngularHelper.map(this.scope, this);
		socketService.getDebugData().then(onSocketData);
	}
	
	private function onSocketData(data:Dynamic):Void 
	{
		Console.log("onSocketData");
		scope.logs = data;
	}
	
	public function select(msg, id)
	{
		scope.selectedDebugItem = msg;
		scope.selectedId = id;
		//untyped __js__("alert")(msg);
	}
}