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
import WebDebug;

public function new () {
	super ();
	
	WebDebug.log("Hello :)"); //this message will apear in Log tab
	WebDebug.debug(new Sprite()); //this message will apear in Debug tab
}

```


Project Compilation
=========
To use this library application need ip and port. 
Lime/haxe project have to copiled with additional flag:
```sh
lime test html5 -Ddebugip=localhost:28080
```