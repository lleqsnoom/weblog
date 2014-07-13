package ;
import flash.Lib;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestHeader;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import haxe.Json;
import haxe.macro.Compiler;

/**
 * ...
 * @author 
 */
class Weblog{
	
	public static function log(data:Dynamic):Void {
		send(data, "log");
	}
	
	public static function debug(data:Dynamic):Void {
		send(data, "debug");
	}
	
	public static function test(data:Dynamic):Void {
		send(data, "test");
	}
	
	private static function send(data:Dynamic, type:String):Void {
		var debugip = Compiler.getDefine("debugip");
		if (debugip != null) {
			
			
			//var json:String = readObjectJson(data);
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
		}
	}
	
	private static function readObjectReflectArr(o:Iterable<Dynamic>, depth:Int = 5):Dynamic {

		if(depth == 0)return null;
		
		var a:Array<Dynamic> = new Array<Dynamic>();
		for (value in o)
		{
			a.push(readObjectReflect(value, depth-1));
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
				Reflect.setField(t, field, readObjectReflect(val, depth - 1));
				//Reflect.setField(t, field, val + "");
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

/*
		var s:String = "";
		var t:Dynamic = {};
		
		
		
		var fields = Reflect.fields(o);
		fields = fields.concat(Type.getInstanceFields(Type.getClass(o)));
		
		
		var type;
		for (j in 0...fields.length)
		{
			 //type = Type.typeof(Reflect.getProperty(o, fields[j]));
			var f = Reflect.getProperty(o, fields[j]);
			
			if(Std.is(f, Int) || Std.is(f, Float) || Std.is(f, String) || Std.is(f, Bool)){
				Reflect.setField(t, fields[j], Reflect.getProperty(o, fields[j]));
			}else{
				if(depth > 0){
					try{
						Reflect.setField(t, fields[j], readObjectReflect(Reflect.getProperty(o, fields[j]), depth - 1));	
					}catch(e:Dynamic){
						
					}
				} 
			}
			 
		}

		
		return t;*/
	}
	
	private static function readObjectJson(o:Dynamic):String {
		return Json.stringify(o);
	}
}