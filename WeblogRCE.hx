
package ;

import haxe.Json;

#if hscript
	import hscript.Parser;
	import hscript.Interp;
#end

class WeblogRCE 
{
	private static var commands:Map<String, Dynamic> = new Map<String, Dynamic>();

	private static var canInstanciate:Bool;
	public static var instance(get_instance, null):WeblogRCE;

	private static function get_instance():WeblogRCE {
	   if (null == instance) {
	       canInstanciate = true;
	       instance = new WeblogRCE();
	       canInstanciate = false;
	   }
	   return instance;
	}

	public function listCommands():Array<String> {
		var a:Array<String> = new Array<String>();

		for(key in commands.keys()){
			a.push(key);
		}

		return a;

	}

	public function new():Void {
	   if (false == canInstanciate) {
	       throw "Invalid Singleton access. Use WeblogRCE.instance.";
	   }
	}


	public function map(alias:String, element:Dynamic):Void {
		commands.set(alias, element);
	}

	#if hscript
	public function execute(str:String):Void {
		if(str == null || str == "") return;
		var data:Array<Dynamic> = Json.parse(str);
		
		if(data == null) return;
		if(!Std.is(data, Array)) return;

		for(i in 0...data.length){
			try{			
				var expr = data[i].code;
				var parser = new hscript.Parser();
				var ast = parser.parseString(expr);
				var interp = new hscript.Interp();

				for(key in commands.keys()){
					//Weblog.log(key);
	 				interp.variables.set(key, commands.get(key));
				}

				Weblog.output(interp.execute(ast));
			}catch(e:Dynamic){
				Weblog.output("Error when running: " + data[i].code);
			}
		}
	}
	#end


}