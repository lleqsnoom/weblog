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
import Weblog;

class Main extends Sprite{

	public function new () {
		
		super ();
		Weblog.log("Hello :)");
		Weblog.debug(new Sprite());
		Weblog.debug({a: {b: 1, c: 2}, d:"aaaa"});
		
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