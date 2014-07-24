package pl.bigsoda.weblog.controllers;

import hxangular.AngularHelper;
import hxangular.haxe.IController;
import js.Console;
import pl.bigsoda.weblog.servicess.SocketService;
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
	var socketService:SocketService;
	
	@inject("$scope", "$window", "$http", "$document", "$timeout", "$rootScope", "pl.bigsoda.weblog.servicess.SocketService", "$sce")
	public function new(scope, window, http, document, timeout, rootScope, socketService, sce) 
	{
		this.scope = scope;
		this.http = http;
		this.timeout = timeout;
		this.sce = sce;
		this.socketService = socketService;
		
		
		
		AngularHelper.map(this.scope, this);
		socketService.getDebugData().then(onSocketData);
		socketService.addUpdateCallback(update);
		
	}
	
	public function update():Void {
		scope.logs = socketService.getDebugSocketData();
		scope.selectedDebugItem = socketService.getDebugSocketItem();
	}
	
	private function onSocketData(data:Dynamic):Void 
	{
		//Console.log("onSocketData");
		scope.logs = data;
		//scope.selectedDebugItem = data;
	}
	
	public function select(msg, id)
	{
		socketService.setDebugSocketItem(msg);
		scope.selectedDebugItem = sce.trustAsHtml("<pre class='jsonprint'>" + socketService.formatJson(msg) + "</pre>");
		scope.selectedId = id;
	}
}