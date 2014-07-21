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
	private var statsSocketData:Array<Dynamic> = new Array<Dynamic>();
	private var init:Bool = false;
	private var sce:Dynamic;
	private var index:Float = 0;
	private var device:String;






	private var logsData:Map<String, LogsModel> = new Map<String, LogsModel>();
	private var max:UInt = 101;

	
	@inject("$q", "$rootScope", "$sce")
	public function new(q, rootScope, sce) 
	{
		this.rootScope = rootScope;
		this.sce = sce;


		logDeferred = q.defer();
		debugDeferred = q.defer();
		statsDeferred = q.defer();
		testDeferred = q.defer();
		inspectDeferred = q.defer();
		
		/*
		socketData = new Array<Dynamic>();
		logData = new Array<Dynamic>();
		debugData = new Array<Dynamic>();
		statsData = new Array<Dynamic>();
		inspectData = new Array<Dynamic>();
		testData = new Array<Dynamic>();
		socketData = {
			logData: logData,
			debugData: debugData,
			inspectData: inspectData,
			testData: testData,
			statsData: statsData,
		}
		*/
	




		untyped __js__("console.log('SocketService')");
		var socket:Dynamic = untyped __js__("io.connect('http://localhost:18081/')");
		socket.on("data", onSocketData);
	}
	
	public function onSocketData(data:Dynamic):Void {
		//data.data = Json.parse(data.data);

		var sdata:SocketLogModel = Json.parse(data);

		var devLogs:LogsModel;
		if(!logsData.exists(sdata.dev)){
			logsData.set(sdata.dev, {
					logData: new Array<LogLineModel>(),
					debugData: new Array<LogLineModel>(),
					testData: new Array<LogLineModel>(),
					statsData: new Array<Dynamic>(),
					inspectData: new Array<Dynamic>(),

				});
			device = sdata.dev;
		}
		devLogs = logsData.get(sdata.dev);
		device = sdata.dev;


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
					data: sce.trustAsHtml("<pre class='jsonprint'>" + formatJson(sdata.data) + "</pre>"),
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


		/*
		if (data.type == "log") {
			logData.insert(0, {
				id: index,
				time: Date.now(),
				device: data.device,
				data: data.data,
				msg: data.msg,
			});
			if (logData.length > max) logData.pop();
		}
		
		if (data.type == "stats") {
			statsSocketData.insert(0, data.data);
			statsData.insert(0, data.data);
			if (statsData.length > max) statsData.pop();
			if (statsSocketData.length > max) statsSocketData.pop();
		}
		

		if (data.type == "debug") {
			debugData.insert(0, {
				id: index,
				time: Date.now(),
				device: data.device,
				data: sce.trustAsHtml("<pre class='jsonprint'>" + formatJson(data.data) + "</pre>"),
				msg: data.msg,
			});
			if (debugData.length > max) debugData.pop();
		}
		

		if (data.type == "inspect") {
			inspectSocketData = sce.trustAsHtml("<pre class='jsonprint'>" + formatJson(data.data) + "</pre>");
			inspectData.insert(0, {
				id: index,
				time: Date.now(),
				device: data.device,
				data: sce.trustAsHtml("<pre class='jsonprint'>" + formatJson(data.data) + "</pre>"),
				msg: data.msg,
			});
			if (inspectData.length > 1) inspectData.pop();
		}
		

		if (data.type == "test") {
			testData.insert(0, {
				id: index,
				time: Date.now(),
				device: data.device,
				data: sce.trustAsHtml(formatMunit(data.data)),
				msg: data.msg,
			});
		}*/
		
		index++;
		
		logDeferred.resolve(devLogs.logData);
		debugDeferred.resolve(devLogs.debugData);
		inspectDeferred.resolve(devLogs.inspectData);
		testDeferred.resolve(devLogs.testData);
		statsDeferred.resolve(devLogs.statsData);
		
		rootScope.$apply();
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
	
	inline function formatJson(object:Dynamic):String 
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
		return logsData.get(device).inspectData[0];
		//return inspectSocketData;
	}
	public function getStatsSocketData():Dynamic {
		return logsData.get(device).statsData;
		//return statsSocketData;
	}
	public function getTestData():Dynamic {
		return testDeferred.promise;
	}
}