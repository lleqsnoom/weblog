package pl.bigsoda.weblog.servicess;
import haxe.Json;
import hxangular.haxe.IService;
import js.Console;

/**
 * ...
 * @author tkwiatek
 */

typedef SocketLogModel = {
	var data:Dynamic;
	var msg:String;
	var append:Bool;
	var type:String;
	var dev:String;
}

typedef LogsModel = {
	var logData:Array<LogLineModel>;
	var debugData:Array<LogLineModel>;
	var testData:Array<LogLineModel>;
	var statsData:Array<Dynamic>;
	var inspectData:Array<Dynamic>;
	var debugDataItem:Dynamic;
	var filterObj:String;
	var filterInsp:String;
}

typedef LogLineModel = {
	var id:Float;
	var time:Date;
	var data:String;
	var msg:String;
}





class SocketService implements IService
{
	public var socketData:Dynamic;
	public var logData:Array<Dynamic>;
	public var debugData:Array<Dynamic>;
	public var statsData:Array<Dynamic>;
	public var inspectData:Array<Dynamic>;
	public var testData:Array<Dynamic>;
	private var logDeferred:Dynamic;
	private var debugDeferred:Dynamic;
	private var statsDeferred:Dynamic;
	private var inspectDeferred:Dynamic;
	private var testDeferred:Dynamic;
	private var rootScope:Dynamic;
	private var inspectSocketData:Dynamic;
	private var init:Bool = false;
	private var sce:Dynamic;
	private var index:Float = 0;
	private var device:String;
	private var q:Dynamic;






	private var logsData:Map<String, LogsModel> = new Map<String, LogsModel>();
	private var max:UInt = 101;

	
	@inject("$q", "$rootScope", "$sce")
	public function new(q, rootScope, sce) 
	{
		this.rootScope = rootScope;
		this.sce = sce;
		this.q = q;


		logDeferred = q.defer();
		debugDeferred = q.defer();
		statsDeferred = q.defer();
		testDeferred = q.defer();
		inspectDeferred = q.defer();


		untyped __js__("console.log('SocketService')");
		var socket:Dynamic = untyped __js__("io.connect('http://localhost:18081/')");
		socket.on("data", onSocketData);
	}
	
	public function setCurrDevice(id):Void {
		

		var devLogs:LogsModel;
		devLogs = logsData.get(id);
		if (devLogs == null) return;
		device = id;
		
		
		logDeferred = q.defer();
		debugDeferred = q.defer();
		statsDeferred = q.defer();
		testDeferred = q.defer();
		inspectDeferred = q.defer();
		
		
		logDeferred.resolve(devLogs.logData);
		debugDeferred.resolve(devLogs.debugData);
		inspectDeferred.resolve(devLogs.inspectData);
		testDeferred.resolve(devLogs.testData);
		statsDeferred.resolve(devLogs.statsData);
		
		for (i in 0...updateArr.length) {
			updateArr[i]();
		}
		
		try{
			untyped __js__("setTimeout")(function(){ rootScope.$apply(); }, 1);
		}catch(e:Dynamic){}
		
	}
	
	public function onSocketData(data:Dynamic):Void {
		//data.data = Json.parse(data.data);

		var sdata:SocketLogModel = Json.parse(data);
		var did:String = null;
		var devLogs:LogsModel;
		if(!logsData.exists(sdata.dev)){
			logsData.set(sdata.dev, {
					logData: new Array<LogLineModel>(),
					debugData: new Array<LogLineModel>(),
					testData: new Array<LogLineModel>(),
					statsData: new Array<Dynamic>(),
					inspectData: new Array<Dynamic>(),
					debugDataItem: null,
					filterObj: null,
					filterInsp: null,
				});
			did = device = sdata.dev;
		}
		devLogs = logsData.get(sdata.dev);
		//device = sdata.dev;


		switch(sdata.type){
			case "log":
				devLogs.logData.insert(0, {
					id: index,
					time: Date.now(),
					data: sdata.data,
					msg: sdata.msg,
				});
				if (devLogs.logData.length > max) devLogs.logData.pop();
			case "debug":
				devLogs.debugData.insert(0, {
					id: index,
					time: Date.now(),
					//data: sce.trustAsHtml("<pre class='jsonprint'>" + formatJson(sdata.data) + "</pre>"),
					data: sdata.data,
					msg: sdata.msg,
				});
				if (devLogs.debugData.length > max) devLogs.debugData.pop();
			case "test":
				devLogs.testData.insert(0, {
					id: index,
					time: Date.now(),
					data: sce.trustAsHtml(formatMunit(sdata.data)),
					msg: sdata.msg,
				});
				if (devLogs.testData.length > max) devLogs.testData.pop();
			case "stats":
				devLogs.statsData.insert(0, sdata.data);
				if (devLogs.statsData.length > max) devLogs.statsData.pop();
			case "inspect":
				devLogs.inspectData.insert(0, sce.trustAsHtml("<pre class='jsonprint'>" + formatJson(sdata.data) + "</pre>"));
				if (devLogs.inspectData.length > max) devLogs.inspectData.pop();
		}

		index++;
		
		logDeferred.resolve(devLogs.logData);
		debugDeferred.resolve(devLogs.debugData);
		inspectDeferred.resolve(devLogs.inspectData);
		testDeferred.resolve(devLogs.testData);
		statsDeferred.resolve(devLogs.statsData);
		
		rootScope.$apply();
		
		if (did != null) setCurrDevice(did);
	}
	private var updateArr:Array<Dynamic> = new Array<Dynamic>();
	public function addUpdateCallback(f:Dynamic):Void {
		updateArr.push(f);
	}
	public function delDevice(id):Void {
		Console.log("DELETE DEVICE");
		logsData.remove(id);
		Console.log(getDevices());
		var devs = getDevices();
		device = devs[devs.length - 1];
		setCurrDevice(device);
	}
	public function getDevice():String {
		return device;
	}
	public function deviceExists(id):Bool {
		for(i in logsData.keys()){
			if(id == i) return true;
		}
		return false;
	}
	public function getDevices():Array<String> {
		var a:Array<String> = new Array<String>();
		for(i in logsData.keys()){
			a.push(i);
		}
		return a;
	}
	
	public function getDebugFor(id:String):Dynamic {
		return logsData.get(id).debugData;
	}

	inline function formatMunit(object:String):String 
	{
		object = object.split("------------------------------")[1];
		var ao = object.split("==============================");
		var desc:String = ao[0];
		var result:String = ao[1];
		return "<p><b>" + desc + "</b></p><p>" + result + "</p>";
	}
	
	inline public function formatJson(object:Dynamic):String 
	{
		return untyped __js__("library.json.prettyPrint")(object);
	}
	
	public function getLogData():Dynamic {
		return logDeferred.promise;
	}
	public function getDebugData():Dynamic {
		return debugDeferred.promise;
	}
	public function getStatsData():Dynamic {
		return statsDeferred.promise;
	}
	public function getInspectData():Dynamic {
		return inspectDeferred.promise;
	}
	public function getInspectSocketData():Dynamic {
		if(!logsData.exists(device))return null;
		return logsData.get(device).inspectData[0];
		//return inspectSocketData;
	}
	public function clearDebugSocketData():Void {
		Console.log("clearDebugSocketData");
		if(!logsData.exists(device))return;
		Console.log("clearDebugSocketData!!!");
		logsData.get(device).debugData = new Array<LogLineModel>();
		logsData.get(device).logData = new Array<LogLineModel>();
		setCurrDevice(device);
	}

	public function getDebugSocketData():Dynamic {
		if(!logsData.exists(device))return null;
		return logsData.get(device).debugData;
		//return inspectSocketData;
	}
	public function setDebugSocketItem(item:Dynamic):Void {
		if(!logsData.exists(device))return null;
		logsData.get(device).debugDataItem = item;
		//return inspectSocketData;
	}
	public function getDebugSocketItem():Dynamic {
		if(!logsData.exists(device))return null;
		return logsData.get(device).debugDataItem;
		//return inspectSocketData;
	}
	public function getStatsSocketData():Dynamic {
		if(!logsData.exists(device))return null;
		return logsData.get(device).statsData;
		//return statsSocketData;
	}
	public function getTestData():Dynamic {
		return testDeferred.promise;
	}


	public function getFilterObj():String {
		if(!logsData.exists(device)) return null;
		return logsData.get(device).filterObj;
	}
	public function setFilterObj(s:String):Void {
		if(!logsData.exists(device)) return;
		logsData.get(device).filterObj = s;
	}

	public function getFilterInsp():String {
		if(!logsData.exists(device)) return null;
		return logsData.get(device).filterInsp;
	}
	public function setFilterInsp(s:String):Void {
		if(!logsData.exists(device)) return;
		logsData.get(device).filterObj = s;
	}


}