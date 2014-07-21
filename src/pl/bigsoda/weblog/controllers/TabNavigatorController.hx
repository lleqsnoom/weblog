package pl.bigsoda.weblog.controllers;
import hxangular.AngularHelper;
import hxangular.haxe.IController;
import js.Console;

/**
 * ...
 * @author tkwiatek
 */
class TabNavigatorController implements IController
{
	var rootScope:Dynamic;
	var scope:Dynamic;
	
	@inject("$scope", "$window", "$http", "$document", "$timeout", "$rootScope", "pl.bigsoda.weblog.servicess.SocketService")
	public function new(scope, window, http, document, timeout, rootScope, socketService) 
	{
		this.scope = scope;
		this.rootScope = rootScope;
	
		rootScope.selectedTab = "log";
		AngularHelper.map(this.scope, this);



		
		untyped __js__("setInterval")(function(){
			select(socketService.getDevices());	
		}, 1000);

	}
	
	function select(devices) 
	{
		for(i in 0...devices.length){
			untyped __js__("createTab")(devices[i]);
		}
	}
	function setClass(value) {
		return value == rootScope.selectedTab?"active":null;
	}
	
	function selectTab(value) 
	{
		rootScope.selectedTab = value;
	}
	
}