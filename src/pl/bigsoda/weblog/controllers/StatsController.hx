package pl.bigsoda.weblog.controllers;

import hxangular.AngularHelper;
import hxangular.haxe.IController;
import js.Console;
/**
 * ...
 * @author tkwiatek
 */
class StatsController implements IController
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
		socketService.getStatsData().then(onSocketData);

	}
	
	private function onSocketData(data:Dynamic):Void 
	{
		Console.log("onSocketData StatsController");
		scope.logs = data;
		//scope.selectedDebugItem = data;
		untyped __js__("setInterval")(function(){
			select(socketService.getStatsSocketData());	
		}, 1000);
	}
	
	public function select(data:Array<Dynamic>):Void
	{
		//Console.log(data);
		scope.$apply(function () {

			var d = [
				{
					key: "fps",
					values: [],
				},
				{
					key: "mem",
					values: [],
				},
				{
					key: "ms",
					values: [],
				}
			];

			for(i in 0...100){
				if(i > data.length - 1){
					d[0].values[i] = [i, 0];
					d[1].values[i] = [i, 0];
					d[2].values[i] = [i, 0];
				}else{
					d[0].values[i] = [i, data[i].fps];
					d[1].values[i] = [i, data[i].mem];
					d[2].values[i] = [i, data[i].ms];
				}
			}

			Console.log(d);

			scope.statsChartData = d;
        });
	}
}