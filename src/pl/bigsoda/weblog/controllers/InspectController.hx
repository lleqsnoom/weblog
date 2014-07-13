package pl.bigsoda.weblog.controllers;

import hxangular.AngularHelper;
import hxangular.haxe.IController;
import js.Console;
/**
 * ...
 * @author tkwiatek
 */
class InspectController implements IController
{

	var scope:Dynamic;
	var rootScope:Dynamic;
	var http:Dynamic;
	var timeout:Dynamic;
	var socketData:Dynamic;
	var sce:Dynamic;
	var socketService:Dynamic;
	
	@inject("$scope", "$window", "$http", "$document", "$timeout", "$rootScope", "pl.bigsoda.weblog.servicess.SocketService", "$sce")
	public function new(scope, window, http, document, timeout, rootScope, socketService, sce) 
	{
		this.scope = scope;
		this.http = http;
		this.timeout = timeout;
		this.sce = sce;
		
		this.socketService = socketService;

		AngularHelper.map(this.scope, this);
		socketService.getInspectData().then(onSocketData);


	}
	
	private function onSocketData(data:Dynamic):Void 
	{
		Console.log("onSocketData");
		scope.logs = data;
		untyped __js__("setInterval")(function(){
			select(socketService.getInspectSocketData());
	
		}, 100);

	}
	
	public function select(msg)
	{
		scope.$apply(function () {
            scope.selectedInspectItem = msg;
        });
	}
}