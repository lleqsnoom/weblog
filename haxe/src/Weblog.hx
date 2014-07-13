package ;

import haxe.Json;
import haxe.macro.Compiler;

/**
 * ...
 * @author tkwiatek
 */
class Weblog{
	private static var _inspectable:Dynamic = null;
	private static var _isRunning:Bool = false;

	public static function log(data:Dynamic):Void {
		send(data, "log");
	}
	
	public static function debug(data:Dynamic):Void {
		send(data, "debug");
	}
	
	public static function inspect(data:Dynamic):Void {
		_inspectable = data;
		if(_isRunning) return;
		runInspect();
	}
	private static function runInspect():Void {
		if(_inspectable == null) {
			_isRunning = false;
			return;
		}
		send(_inspectable, "inspect");
		haxe.Timer.delay(function():Void{
			runInspect();
		}, 100);
	}

	public static function test(data:Dynamic):Void {
		send(data, "test");
	}
	
	private static function send(data:Dynamic, type:String):Void {
		var debugip = Compiler.getDefine("debugip");
		if (debugip != null) {
			
			var r:haxe.Http = new haxe.Http("http://" + debugip);
			r.addHeader("Accept" , "application/json");
			r.setPostData( Json.stringify({
					data: readObjectReflect(data),
					append: true,
					type: type,
				})
			);
			r.request(true);


			/*
			var json:String = Json.stringify(readObjectReflect(data));
			var l:URLLoader = new URLLoader();
			var r:URLRequest = new URLRequest("http://" + debugip);
			r.requestHeaders = [new URLRequestHeader("Accept", "application/json")];
			r.method = URLRequestMethod.POST;
			var urlVars:URLVariables = new URLVariables();
			urlVars.data = json;
			urlVars.append = true;
			urlVars.type = type;
			urlVars.device = "mobile";
			r.data = urlVars;			
			l.load(r);
			*/
		}
	}
	
	private static function readObjectReflectArr(o:Iterable<Dynamic>, depth:Int = 5):Dynamic {

		if(depth == 0)return null;

		var a:Array<Dynamic> = new Array<Dynamic>();
		for (val in o)
		{
			if(Reflect.isFunction(val)) continue;
			a.push(readObjectReflect(val, depth-1));
		}
		return a;

	}
	
	private static function readObjectReflectObj(o:Dynamic, depth:Int = 5):Dynamic {

			if(depth == 0)return null;

			var t:Dynamic = {};

			var fields:Array<String>;
			var c = Type.getClass(o);
			if (c == null) {
				fields = Reflect.fields(o);
			} else {
				fields = Type.getInstanceFields(c);
			}

			for (field in fields){
				var val:Dynamic = Reflect.field(o,field);
				if(Reflect.isFunction(val)) continue;
				Reflect.setField(t, field, readObjectReflect(val, depth - 1));
			}

			return t;

	}
	private static function readObjectReflect(o:Dynamic, depth:Int = 5):Dynamic {


		if(depth == 0)return null;

		if(o == null){

			return null;

		}else if(Std.is(o, String) || Std.is(o, Int) || Std.is(o, Float) || Std.is(o, Bool)){

			return o;

		}else if(Std.is(o, Array) || Std.is(o, List)){

			return readObjectReflectArr(o, depth - 1);

		}else if(Reflect.isFunction(o)){

			return "function";

		}else if(Reflect.isObject(o)){

			return readObjectReflectObj(o, depth - 1);

		}else{

			return "unknown";

		}

		return null;
	}
	
	private static function readObjectJson(o:Dynamic):String {
		return Json.stringify(o);
	}
}