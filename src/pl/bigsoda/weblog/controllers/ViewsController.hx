package pl.bigsoda.weblog.controllers;
import hxangular.AngularHelper;
import pl.bigsoda.weblog.servicess.SocketService;
import hxangular.haxe.IController;
import js.Console;

/**
 * ...
 * @author tkwiatek
 */
class ViewsController implements IController
{
	var rootScope:Dynamic;
	var scope:Dynamic;
	var socketService:SocketService;
	private var lastTabs:String = "";
	
	@inject("$scope", "$window", "$http", "$document", "$timeout", "$rootScope", "pl.bigsoda.weblog.servicess.SocketService")
	public function new(scope, window, http, document, timeout, rootScope, socketService) 
	{
		this.scope = scope;
		this.rootScope = rootScope;
		this.socketService = socketService;
		rootScope.view = "default";
		//rootScope.view = "logsDebug";

	}
	
	
	public function select(value) 
	{
		Console.log(value);
		rootScope.view = value;
	}
	
}