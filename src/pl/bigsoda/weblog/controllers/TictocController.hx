package pl.bigsoda.weblog.controllers;

import hxangular.AngularHelper;
import hxangular.haxe.IController;
import js.Console;
import pl.bigsoda.weblog.servicess.SocketService;
/**
 * ...
 * @author tkwiatek
 */
class TictocController implements IController
{

	var scope:Dynamic;
	var rootScope:Dynamic;
	var http:Dynamic;
	var timeout:Dynamic;
	var socketData:Dynamic;
	var sce:Dynamic;
	var socketService:SocketService;
	var msg:Dynamic;
	
	@inject("$scope", "$window", "$http", "$document", "$timeout", "$rootScope", "pl.bigsoda.weblog.servicess.SocketService", "$sce")
	public function new(scope, window, http, document, timeout, rootScope, socketService, sce) 
	{
		this.scope = scope;
		this.http = http;
		this.timeout = timeout;
		this.sce = sce;
		this.socketService = socketService;
		
		
		
		AngularHelper.map(this.scope, this);
		socketService.getTictocData().then(onSocketData);
		socketService.addUpdateCallback(update);
		
	}
	public function update():Void {
		var data = socketService.getTictocSocketData();
		scope.max = findMax(data);
		scope.logs = data;
	}
	
	private function onSocketData(data:Dynamic):Void 
	{
		scope.max = findMax(data);
		scope.logs = data;
	}
	
	
	private function findMaxLogs():Float {
		var data:Array<Dynamic> = scope.logs;
		if(data == null) return 0;
		if(data.length < 1) return 0;
		var mmax:Float = 0;
		for(i in 0...data.length){
			mmax = Math.max(mmax, data[i].val);
		}
		return mmax;
	}
	
	private function findMax(data:Array<Dynamic>):Float {
		if(data == null) return 0;
		if(data.length < 1) return 0;
		var mmax:Float = 0;
		for(i in 0...data.length){
			mmax = Math.max(mmax, data[i].val);
		}
		return mmax;
	}


}