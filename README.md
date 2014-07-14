<p align="center"><img src="webloglogo.png"/></p>

WebLog
============

Haxe remote debugging tool.
This project require node-webkit.
```sh
haxelib install node-webkit
```




Installation
=========
```sh
haxelib git weblog https://github.com/zasmarkany/weblog.git
```



Launch
=========
```sh
haxelib run weblog
```


Usage
=========
```haxe
package ;

import flash.display.Sprite;
import flash.events.Event;
import openfl.geom.Point;
import Weblog;

class Main extends Sprite{

	var p:Point = new Point();
	
	public function new () {
		
		super ();

		Weblog.log("Hello :)");

		Weblog.debug(new Sprite());
		Weblog.debug({a: {b: 1, c: 2}, d:"aaaa"});

		Weblog.inspect(p);
		
		stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	function onEnterFrame(e:Event):Void{
		p.x = Math.random()*1000;
		p.y = Math.random()*1000;
	}

}
```


Project Compilation
=========
To use this library application need ip and port. 
Lime/haxe project have to copiled with additional flag:
```sh
lime test [platform] -Ddebugip=WEBLOG_IP:18080
```