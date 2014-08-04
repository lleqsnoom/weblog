package pl.bigsoda.weblog.controllers;

import hxangular.AngularHelper;
import hxangular.haxe.IController;
import js.Console;
import codemirror.CodeMirror;
import pl.bigsoda.weblog.servicess.SocketService;
/**
 * ...
 * @author tkwiatek
 */
class RemoteController implements IController
{

	var scope:Dynamic;
	var rootScope:Dynamic;
	var http:Dynamic;
	var window:Dynamic;
	var timeout:Dynamic;
	var socketData:Dynamic;
	var sce:Dynamic;
	var socketService:SocketService;
	var msg:Dynamic;
	var lastLog:String = "";
	
	@inject("$scope", "$window", "$http", "$document", "$timeout", "$rootScope", "pl.bigsoda.weblog.servicess.SocketService", "$sce")
	public function new(scope, window, http, document, timeout, rootScope, socketService, sce) 
	{
		this.scope = scope;
		this.http = http;
		this.timeout = timeout;
		this.sce = sce;
		this.socketService = socketService;
		this.window = window;
		
		
		
		AngularHelper.map(this.scope, this);
		
		
		
		AngularHelper.map(this.scope, this);
		socketService.getOutputData().then(onSocketData);
		socketService.addUpdateCallback(update);


		untyped __js__("setTimeout")(function(){
			buildEditor();
		}, 100);


		untyped __js__("setInterval")(function(){
			update();
		}, 10);

	}

	
	public function update():Void {
		scope.logs = socketService.getOutputSocketData();
		scope.commands = socketService.getCommandsSocketData();
		Console.log(socketService.getCommandsSocketData());
		//Console.log("=================== "+socketService.getOutputSocketData());
		if(scope.logs == null || scope.logs.length == 0 || scope.logs[0] == null) return;
		if(scope.logs[0].data == lastLog) return;
		lastLog = scope.last = scope.logs[0].data;
		//Console.log("+++++++++++++++++++++++++ "+socketService.getOutputSocketData());
		//scope.selectedDebugItem = socketService.getDebugSocketItem();
	}
	
	private function onSocketData(data:Dynamic):Void 
	{
		//Console.log("=================== "+socketService.getOutputSocketData());
		//Console.log("onSocketData");
		scope.logs = data;
		scope.last = scope.logs[0].data;
		//scope.selectedDebugItem = data;
	}

	public function buildEditor():Void {
	
		scope.editor = CodeMirror.fromTextArea( untyped __js__("document.getElementById")("code-haxe"), 
		{
			lineNumbers: true, 
			lineWrapping: false,	
			indentUnit: 4, 
			indentWithTabs: true, 
			mode: {
				name: "haxe", 
				globalVars: true
			}
		});
		
	}
	public function run(data:String):Void {
		window.server.addRemoteCode(
			{
				dev: socketService.getDevice(),
				code: scope.editor.getValue(),
			}
		);
		Console.log(scope.editor.getValue());
	}
}