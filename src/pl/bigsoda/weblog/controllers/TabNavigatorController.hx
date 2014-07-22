package pl.bigsoda.weblog.controllers;
import hxangular.AngularHelper;
import pl.bigsoda.weblog.servicess.SocketService;
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
	var socketService:SocketService;
	private var lastTabs:String = "";
	
	@inject("$scope", "$window", "$http", "$document", "$timeout", "$rootScope", "pl.bigsoda.weblog.servicess.SocketService")
	public function new(scope, window, http, document, timeout, rootScope, socketService) 
	{
		this.scope = scope;
		this.rootScope = rootScope;
		this.socketService = socketService;
	
		rootScope.selectedTab = "log";
		AngularHelper.map(this.scope, this);

		untyped __js__("setInterval")(function(){
			select(socketService.getDevices());	
		}, 100);
		socketService.addUpdateCallback(update);

	}
	
	public function update():Void {
		scope.currentId = socketService.getDevice();
	}
	
	function tabCloseClick(id) 
	{
		socketService.delDevice(id);
	}
	
	function tabClick(id) 
	{
		if(!socketService.deviceExists(id)) return;

		socketService.setCurrDevice(id);
		scope.currentId = id;
	}
	
	function select(devices:Array<String>) 
	{
		if (lastTabs == devices.toString()) return;
		lastTabs = devices.toString();
		var titems:Array<Dynamic> = new Array<Dynamic>();
		for(i in 0...devices.length){
			//untyped __js__("createTab")(devices[i]);
			titems.push( {
				id: devices[i],
			});
		}
		
		scope.$apply(function () {
            scope.items = titems;
        });
		
	}

	function setClass(value) {
		return value == rootScope.selectedTab?"active":null;
	}
	
	function selectTab(value) 
	{
		rootScope.selectedTab = value;
	}
	
}