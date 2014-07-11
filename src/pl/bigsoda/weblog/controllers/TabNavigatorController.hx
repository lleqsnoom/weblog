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
	
	@inject("$scope", "$window", "$http", "$document", "$timeout", "$rootScope")
	public function new(scope, window, http, document, timeout, rootScope)
	{
		this.scope = scope;
		this.rootScope = rootScope;
	
		rootScope.selectedTab = "log";
		AngularHelper.map(this.scope, this);
	}
	
	function setClass(value) {
		return value == rootScope.selectedTab?"active":null;
	}
	
	function selectTab(value) 
	{
		rootScope.selectedTab = value;
	}
	
}