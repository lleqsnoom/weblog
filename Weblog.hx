package ;


#if openfl
	import openfl.events.Event;
	import openfl.net.URLLoader;
	import openfl.net.URLRequest;
	import openfl.net.URLRequestHeader;
	import openfl.net.URLRequestMethod;
	import openfl.net.URLVariables;
	import openfl.Lib;
	import openfl.system.System;
#end 

#if flash
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.Lib;
	import flash.system.System;
#end 

import haxe.Json;
import haxe.macro.Compiler;


#if neko
	import neko.vm.Thread;
#end

#if cpp
	import cpp.vm.Thread;
#end

/**
 * ...
 * @author tkwiatek
 */

typedef Stats = {
    var fps:Int;
    var ms:Int;
    var mem:Float;
    var memMax:Float;
}

class Weblog{
	private static var _inspectable:Dynamic = null;
	private static var _isRunning:Bool = false;

	private static var timeCurr:Int;
	private static var timeLast:Int;
	private static var mem:Float;
	private static var memMax:Float;
	private static var ms:Int;
	private static var fps:Int;
	
	public static var synchronous:Bool = false;
	
	
	
	private static var stats:Stats = {
	    fps: 0,
	    ms: 0,
	    mem: 0,
	    memMax: 0
	}
	
	private static var tictoc:Map<String, Float> = new Map<String, Float>();


	public static function tic(id:String = ""):Void {
		tictoc.set(id, haxe.Timer.stamp());
	}

	public static function toc(id:String = ""):Void {
		if(!tictoc.exists(id)) return;
		var t:Float = tictoc.get(id);
		//trace("toc: " + t);
		send({
			id: id,
			time: haxe.Timer.stamp() - t,
			}, "tictoc");
		tictoc.remove(id);
	}

	#if (openfl || flash)

	public static function statsStart():Void {
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, updateStats);
	}

	private static function updateStats(e:Event = null):Void {
		timeCurr = Lib.getTimer();
		//one second
		if(timeCurr - 1000 > timeLast){

			mem = System.totalMemory / 1048576;
			memMax = Math.max(memMax, mem);
			stats.mem = mem;
			stats.memMax = memMax;

			stats.fps = fps;

			//reset
			fps = 0;
			timeLast = timeCurr;

			send(stats, "stats");
		}
		
		stats.ms = timeCurr - ms;
		ms = timeCurr;

		fps++;
	}

	#end






	public static function log(data:Dynamic):Void {
		//send(data, "log");
		debug(data);
	}
	
	public static function debug(data:Dynamic):Void {
		send(data, "debug");
	}
	
	
	
	public static function inspect(data:Dynamic):Void {
		_inspectable = data;
		if(_isRunning) return;
		runInspect();
	}
	
	#if (neko || cpp)
	private static function inspectThread():Void {
		while (_inspectable != null) {
			sendData(_inspectable, "inspect");
			Sys.sleep(100 / 1000);
		}				
		_isRunning = false;
	}
    #end
	
	private static function runInspect():Void {
		if(_inspectable == null) {
			_isRunning = false;
			return;
		}
		_isRunning = true;
		
		#if (neko || cpp)
			if(!synchronous) {
				Thread.create(inspectThread);
			}
        #else       
            haxe.Timer.delay(function():Void {
				send(_inspectable, "inspect");
                runInspect();
            }, 100);
        #end		
	}

	public static function test(data:Dynamic):Void {
		send(data, "test");
	}
	
	private static function send(data:Dynamic, type:String):Void {
	

		#if (neko || cpp)
			if(synchronous) {
				sendData(data, type);
			}else{
				Thread.create(function():Void{ sendData(data, type); });
			}
            
        #else       
            sendData(data, type);
        #end
	}

	private static function sendData(data:Dynamic, type:String):Void{

		var debugip = Compiler.getDefine("debugip");
		if (debugip == null) return;
		
		var msg:String = "";
		
		if(data == null){
			msg = "null";
		}else if(Std.is(data, String) || Std.is(data, Int) || Std.is(data, Float) || Std.is(data, Bool)){
			msg = Std.string(data);
		}else if(Std.is(data, Array) || Std.is(data, List)){
			msg = "Array";
		}else if(Reflect.isFunction(data)){
			msg = "function";
		}else if(Reflect.isObject(data)){
			msg = "Object";
		}else{
			msg = "unknown";
		}
		
		if(Compiler.getDefine("weblogid") != null){
			device = Compiler.getDefine("weblogid");
		}
		
		
		var r:haxe.Http = new haxe.Http("http://" + debugip);
		r.addHeader("Accept" , "application/json");
		r.setPostData( Json.stringify({
				data: readObjectReflect(data),
				msg: msg,
				append: true,
				type: type,
				dev: device,
			})
		);
		r.request(true);
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
	
	
	#if flash
	public static var device:String = "Flash_" + Std.int(Math.random() * 10000);
	#elseif js
	public static var device:String = "JavaScript_" + Std.int(Math.random() * 10000);
	#elseif html5
	public static var device:String = "HTML5_" + Std.int(Math.random() * 10000);
	#elseif php
	public static var device:String = "PHP_" + Std.int(Math.random() * 10000);
	#elseif ios
	public static var device:String = "IOS_" + Std.int(Math.random() * 10000);
	#elseif android
	public static var device:String = "Android_" + Std.int(Math.random() * 10000);
	#elseif mac
	public static var device:String = "Mac_" + Std.int(Math.random() * 10000);
	#elseif windows
	public static var device:String = "Windows_" + Std.int(Math.random() * 10000);
	#elseif linux
	public static var device:String = "Linux_" + Std.int(Math.random() * 10000);
	#elseif tizen
	public static var device:String = "Tizen_" + Std.int(Math.random() * 10000);
	#elseif blackberry
	public static var device:String = "BlackBerry_" + Std.int(Math.random() * 10000);
	#elseif neko
	public static var device:String = "Neko_" + Std.int(Math.random() * 10000);
	#elseif cpp
	public static var device:String = "Cpp_" + Std.int(Math.random() * 10000);
	#else
	public static var device:String = "Unknown_" + Std.int(Math.random() * 10000);
	#end
	
	
	
	
	

}