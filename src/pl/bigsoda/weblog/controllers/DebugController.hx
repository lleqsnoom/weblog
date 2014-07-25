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
		socketService.getDebugData().then(onSocketData);
		socketService.addUpdateCallback(update);
		
	}

	private function updateSearch():Void {
		//search
		
	}

	public function filter():Void {
		fillWindow( filterObj(scope.msg, scope.filterStr) );
		//scope.filterStr;
		//res = JSON.search( data, '//person[name="Peter"]' );
	}

	public function filterObj(o:Dynamic, s:String):Dynamic {
		if(s == "" || s == null) return o;
		s = s.toLowerCase();

		var f = Reflect.fields(o);
		var e:Dynamic = {};
		var key:String;
		var val:Dynamic;

		for(i in 0...f.length){
			key = f[i];
			val = Reflect.field(o, key);

			if(key.toLowerCase().indexOf(s)>-1){
				Reflect.setField(e, key, val);
				continue;
			}
			if(Std.is(val, String) || Std.is(val, Float) || Std.is(val, Int) || Std.is(val, UInt) || Std.is(val, Bool) || Std.is(val, null)){
				
				if(Std.string(val).toLowerCase().indexOf(s)>-1){
					Reflect.setField(e, key, val);
					continue;
				}
			}else{

				var res = filterObj(val, s);
				if(res != null){
					Reflect.setField(e, key, res);
				}	

			}
			
			
		}

		if(Reflect.fields(e).length == 0) return null;

		return e;
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
		scope.msg = msg;
		socketService.setDebugSocketItem(msg);
		scope.selectedDebugItem = sce.trustAsHtml("<pre class='jsonprint'>" + socketService.formatJson(msg) + "</pre>");
		fillWindow( filterObj(msg, scope.filterStr) );
		scope.selectedId = id;
	}

	public function fillWindow(data:Dynamic):Void {
		//scope.selectedDebugItem = sce.trustAsHtml("<pre class='jsonprint'>" + socketService.formatJson(data) + "</pre>");
		scope.selectedDebugItem = sce.trustAsHtml("<pre class='jsonprint'>" + socketService.formatJson(data) + "</pre>");
	}

	public function clear():Void {
		socketService.clearDebugSocketData();
	}
}