package pl.bigsoda.weblog.servicess;
import haxe.Json;
import hxangular.haxe.IService;
import js.Console;

/**
 * ...
 * @author tkwiatek
 */
class SocketService implements IService
{
	public var socketData:Dynamic;
	public var logData:Array<Dynamic>;
	public var debugData:Array<Dynamic>;
	public var testData:Array<Dynamic>;
	private var logDeferred:Dynamic;
	private var debugDeferred:Dynamic;
	private var testDeferred:Dynamic;
	private var rootScope:Dynamic;
	private var init:Bool = false;
	private var sce:Dynamic;
	private var index:Float = 0;
	
	@inject("$q", "$rootScope", "$sce")
	public function new(q, rootScope, sce) 
	{
		this.rootScope = rootScope;
		
		logDeferred = q.defer();
		debugDeferred = q.defer();
		testDeferred = q.defer();
		
		socketData = new Array<Dynamic>();
		this.sce = sce;
		
		logData = new Array<Dynamic>();
		debugData = new Array<Dynamic>();
		testData = new Array<Dynamic>();
		socketData = {
			logData: logData,
			debugData: debugData,
			testData: testData,
		}
		
		untyped __js__("console.log('SocketService')");
		var socket:Dynamic = untyped __js__("io.connect('http://localhost:18081/')");
		socket.on("data", onSocketData);
	}
	
	public function onSocketData(data:Dynamic):Void {
		data.data = Json.parse(data.data);
		var max:UInt = 100;
		
		if (data.type == "log") {
			logData.insert(0, {
				id: index,
				time: Date.now(),
				device: data.device,
				message: data.data,
			});
			if (logData.length > max) logData.pop();
		}
		

		if (data.type == "debug") {
			debugData.insert(0, {
				id: index,
				time: Date.now(),
				device: data.device,
				message: sce.trustAsHtml("<pre id='debug'>" + formatJson(data.data) + "</pre>"),
			});
			if (debugData.length > max) debugData.pop();
		}
		

		if (data.type == "test") {
			testData.insert(0, {
				id: index,
				time: Date.now(),
				device: data.device,
				message: sce.trustAsHtml(formatMunit(data.data)),
			});
		}
		
		index++;
		
		logDeferred.resolve(logData);
		debugDeferred.resolve(debugData);
		testDeferred.resolve(testData);
		
		rootScope.$apply();
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
	public function getTestData():Dynamic {
		return testDeferred.promise;
	}
}