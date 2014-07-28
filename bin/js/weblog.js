(function ($hx_exports) { "use strict";
$hx_exports.pl = $hx_exports.pl || {};
$hx_exports.pl.bigsoda = $hx_exports.pl.bigsoda || {};
$hx_exports.pl.bigsoda.weblog = $hx_exports.pl.bigsoda.weblog || {};
$hx_exports.pl.bigsoda.weblog.controllers = $hx_exports.pl.bigsoda.weblog.controllers || {};
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.indexOf = function(a,obj,i) {
	var len = a.length;
	if(i < 0) {
		i += len;
		if(i < 0) i = 0;
	}
	while(i < len) {
		if(a[i] === obj) return i;
		i++;
	}
	return -1;
};
HxOverrides.remove = function(a,obj) {
	var i = HxOverrides.indexOf(a,obj,0);
	if(i == -1) return false;
	a.splice(i,1);
	return true;
};
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var Main = function() { };
Main.__name__ = true;
Main.main = function() {
	var app = angular.module("weblog",["infinite-scroll"]);
	app.controller("pl.bigsoda.weblog.controllers.LogController",pl.bigsoda.weblog.controllers.LogController);
	app.controller("pl.bigsoda.weblog.controllers.DebugController",pl.bigsoda.weblog.controllers.DebugController);
	app.controller("pl.bigsoda.weblog.controllers.InspectController",pl.bigsoda.weblog.controllers.InspectController);
	app.controller("pl.bigsoda.weblog.controllers.TabNavigatorController",pl.bigsoda.weblog.controllers.TabNavigatorController);
	app.controller("pl.bigsoda.weblog.controllers.ServerAdressController",pl.bigsoda.weblog.controllers.ServerAdressController);
	app.controller("pl.bigsoda.weblog.controllers.TictocController",pl.bigsoda.weblog.controllers.TictocController);
	app.controller("pl.bigsoda.weblog.controllers.StatsController",pl.bigsoda.weblog.controllers.StatsController);
	app.service("pl.bigsoda.weblog.servicess.SocketService",pl.bigsoda.weblog.servicess.SocketService);
};
var IMap = function() { };
IMap.__name__ = true;
Math.__name__ = true;
var Reflect = function() { };
Reflect.__name__ = true;
Reflect.field = function(o,field) {
	try {
		return o[field];
	} catch( e ) {
		return null;
	}
};
Reflect.setField = function(o,field,value) {
	o[field] = value;
};
Reflect.fields = function(o) {
	var a = [];
	if(o != null) {
		var hasOwnProperty = Object.prototype.hasOwnProperty;
		for( var f in o ) {
		if(f != "__id__" && f != "hx__closures__" && hasOwnProperty.call(o,f)) a.push(f);
		}
	}
	return a;
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
};
var Type = function() { };
Type.__name__ = true;
Type.getClass = function(o) {
	if(o == null) return null;
	if((o instanceof Array) && o.__enum__ == null) return Array; else return o.__class__;
};
Type.getInstanceFields = function(c) {
	var a = [];
	for(var i in c.prototype) a.push(i);
	HxOverrides.remove(a,"__class__");
	HxOverrides.remove(a,"__properties__");
	return a;
};
var _UInt = {};
_UInt.UInt_Impl_ = function() { };
_UInt.UInt_Impl_.__name__ = true;
var haxe = {};
haxe.ds = {};
haxe.ds.StringMap = function() {
	this.h = { };
};
haxe.ds.StringMap.__name__ = true;
haxe.ds.StringMap.__interfaces__ = [IMap];
haxe.ds.StringMap.prototype = {
	h: null
	,set: function(key,value) {
		this.h["$" + key] = value;
	}
	,get: function(key) {
		return this.h["$" + key];
	}
	,exists: function(key) {
		return this.h.hasOwnProperty("$" + key);
	}
	,remove: function(key) {
		key = "$" + key;
		if(!this.h.hasOwnProperty(key)) return false;
		delete(this.h[key]);
		return true;
	}
	,keys: function() {
		var a = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) a.push(key.substr(1));
		}
		return HxOverrides.iter(a);
	}
	,__class__: haxe.ds.StringMap
};
var hxangular = {};
hxangular.AngularHelper = function() { };
hxangular.AngularHelper.__name__ = true;
hxangular.AngularHelper.map = function(scope,instance) {
	var fields = Type.getInstanceFields(Type.getClass(instance));
	var _g1 = 0;
	var _g = fields.length;
	while(_g1 < _g) {
		var i = _g1++;
		Reflect.setField(scope,fields[i],Reflect.field(instance,fields[i]));
	}
};
hxangular.haxe = {};
hxangular.haxe.IController = function() { };
hxangular.haxe.IController.__name__ = true;
hxangular.haxe.IService = function() { };
hxangular.haxe.IService.__name__ = true;
var js = {};
js.Boot = function() { };
js.Boot.__name__ = true;
js.Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) return Array; else return o.__class__;
};
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js.Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) str2 += ", \n";
		str2 += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
js.Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js.Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js.Boot.__interfLoop(cc.__super__,cl);
};
js.Boot.__instanceof = function(o,cl) {
	if(cl == null) return false;
	switch(cl) {
	case Int:
		return (o|0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return typeof(o) == "boolean";
	case String:
		return typeof(o) == "string";
	case Array:
		return (o instanceof Array) && o.__enum__ == null;
	case Dynamic:
		return true;
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) return true;
				if(js.Boot.__interfLoop(js.Boot.getClass(o),cl)) return true;
			}
		} else return false;
		if(cl == Class && o.__name__ != null) return true;
		if(cl == Enum && o.__ename__ != null) return true;
		return o.__enum__ == cl;
	}
};
js.Console = function() { };
js.Console.__name__ = true;
js.Console.log = function(d) {
	console.log(d);
};
var pl = {};
pl.bigsoda = {};
pl.bigsoda.weblog = {};
pl.bigsoda.weblog.controllers = {};
pl.bigsoda.weblog.controllers.DebugController = $hx_exports.pl.bigsoda.weblog.controllers.DebugController = function(scope,window,http,document,timeout,rootScope,socketService,sce) {
	this.scope = scope;
	this.http = http;
	this.timeout = timeout;
	this.sce = sce;
	this.socketService = socketService;
	hxangular.AngularHelper.map(this.scope,this);
	socketService.getDebugData().then($bind(this,this.onSocketData));
	socketService.addUpdateCallback($bind(this,this.update));
};
pl.bigsoda.weblog.controllers.DebugController.__name__ = true;
pl.bigsoda.weblog.controllers.DebugController.__interfaces__ = [hxangular.haxe.IController];
pl.bigsoda.weblog.controllers.DebugController.prototype = {
	scope: null
	,rootScope: null
	,http: null
	,timeout: null
	,socketData: null
	,sce: null
	,socketService: null
	,msg: null
	,filter: function() {
		this.fillWindow(this.filterObj(this.scope.msg,this.scope.filterStr));
		this.socketService.setFilterObj(this.scope.filterStr);
	}
	,filterObj: function(o,s) {
		if(s == "" || s == null) return o;
		s = s.toLowerCase();
		var f = Reflect.fields(o);
		var e = { };
		var key;
		var val;
		var _g1 = 0;
		var _g = f.length;
		while(_g1 < _g) {
			var i = _g1++;
			key = f[i];
			val = Reflect.field(o,key);
			if(key.toLowerCase().indexOf(s) > -1) {
				e[key] = val;
				continue;
			}
			if(typeof(val) == "string" || typeof(val) == "number" || ((val | 0) === val) || js.Boot.__instanceof(val,_UInt.UInt_Impl_) || typeof(val) == "boolean" || js.Boot.__instanceof(val,null)) {
				if(Std.string(val).toLowerCase().indexOf(s) > -1) {
					e[key] = val;
					continue;
				}
			} else {
				var res = this.filterObj(val,s);
				if(res != null) e[key] = res;
			}
		}
		if(Reflect.fields(e).length == 0) return null;
		return e;
	}
	,update: function() {
		this.scope.logs = this.socketService.getDebugSocketData();
		this.scope.msg = this.socketService.getDebugSocketItem();
		this.scope.filterStr = this.socketService.getFilterObj();
		this.filter();
	}
	,onSocketData: function(data) {
		this.scope.logs = data;
	}
	,select: function(msg,id) {
		this.scope.msg = msg;
		this.socketService.setDebugSocketItem(msg);
		this.fillWindow(this.filterObj(msg,this.scope.filterStr));
		this.scope.selectedId = id;
	}
	,fillWindow: function(data) {
		this.scope.selectedDebugItem = this.sce.trustAsHtml("<pre class='jsonprint'>" + library.json.prettyPrint(data) + "</pre>");
	}
	,clear: function() {
		this.socketService.clearDebugSocketData();
	}
	,__class__: pl.bigsoda.weblog.controllers.DebugController
};
pl.bigsoda.weblog.controllers.InspectController = $hx_exports.pl.bigsoda.weblog.controllers.InspectController = function(scope,window,http,document,timeout,rootScope,socketService,sce) {
	this.scope = scope;
	this.http = http;
	this.timeout = timeout;
	this.sce = sce;
	this.socketService = socketService;
	hxangular.AngularHelper.map(this.scope,this);
	socketService.getInspectData().then($bind(this,this.onSocketData));
};
pl.bigsoda.weblog.controllers.InspectController.__name__ = true;
pl.bigsoda.weblog.controllers.InspectController.__interfaces__ = [hxangular.haxe.IController];
pl.bigsoda.weblog.controllers.InspectController.prototype = {
	scope: null
	,rootScope: null
	,http: null
	,timeout: null
	,socketData: null
	,sce: null
	,socketService: null
	,onSocketData: function(data) {
		var _g = this;
		this.scope.logs = data;
		setInterval(function() {
			_g.select(_g.socketService.getInspectSocketData());
		},100);
	}
	,select: function(msg) {
		var _g = this;
		this.scope.$apply(function() {
			_g.scope.selectedInspectItem = msg;
		});
	}
	,__class__: pl.bigsoda.weblog.controllers.InspectController
};
pl.bigsoda.weblog.controllers.LogController = $hx_exports.pl.bigsoda.weblog.controllers.LogController = function(scope,window,http,document,timeout,rootScope,socketService) {
	this.scope = scope;
	this.http = http;
	this.timeout = timeout;
	hxangular.AngularHelper.map(this.scope,this);
	socketService.getLogData().then($bind(this,this.onSocketData));
};
pl.bigsoda.weblog.controllers.LogController.__name__ = true;
pl.bigsoda.weblog.controllers.LogController.__interfaces__ = [hxangular.haxe.IController];
pl.bigsoda.weblog.controllers.LogController.prototype = {
	scope: null
	,rootScope: null
	,http: null
	,timeout: null
	,socketData: null
	,onSocketData: function(data) {
		console.log("onSocketData");
		this.scope.logs = data;
	}
	,__class__: pl.bigsoda.weblog.controllers.LogController
};
pl.bigsoda.weblog.controllers.ServerAdressController = $hx_exports.pl.bigsoda.weblog.controllers.ServerAdressController = function(scope,window,http,document,timeout,rootScope) {
	this.scope = scope;
	this.rootScope = rootScope;
	rootScope.selectedTab = "log";
	hxangular.AngularHelper.map(this.scope,this);
	console.log(window.server);
	window.server.getNetworkIP(function(error,ip) {
		scope.$apply(function() {
			scope.serverIP = ip;
		});
		if(error) {
		}
	});
};
pl.bigsoda.weblog.controllers.ServerAdressController.__name__ = true;
pl.bigsoda.weblog.controllers.ServerAdressController.__interfaces__ = [hxangular.haxe.IController];
pl.bigsoda.weblog.controllers.ServerAdressController.prototype = {
	rootScope: null
	,scope: null
	,serverIP: null
	,__class__: pl.bigsoda.weblog.controllers.ServerAdressController
};
pl.bigsoda.weblog.controllers.StatsController = $hx_exports.pl.bigsoda.weblog.controllers.StatsController = function(scope,window,http,document,timeout,rootScope,socketService,sce) {
	this.scope = scope;
	this.http = http;
	this.timeout = timeout;
	this.sce = sce;
	this.socketService = socketService;
	scope.config = { title : "Products", tooltips : true, labels : false, mouseover : function() {
	}, mouseout : function() {
	}, click : function() {
	}, legend : { display : true, position : "right"}};
	hxangular.AngularHelper.map(this.scope,this);
	socketService.getStatsData().then($bind(this,this.onSocketData));
	socketService.addUpdateCallback($bind(this,this.update));
};
pl.bigsoda.weblog.controllers.StatsController.__name__ = true;
pl.bigsoda.weblog.controllers.StatsController.__interfaces__ = [hxangular.haxe.IController];
pl.bigsoda.weblog.controllers.StatsController.prototype = {
	scope: null
	,rootScope: null
	,http: null
	,timeout: null
	,socketData: null
	,sce: null
	,socketService: null
	,update: function() {
	}
	,onSocketData: function(data) {
		var _g = this;
		this.scope.logs = data;
		setInterval(function() {
			_g.select(_g.socketService.getStatsSocketData());
		},300);
	}
	,drawData: function(data,field,max,fillColor,lineColor,ctx,width,height,offset) {
		var ho = height / 3 + offset;
		ctx.beginPath();
		ctx.fillStyle = fillColor;
		ctx.strokeStyle = lineColor;
		ctx.lineWidth = 1;
		ctx.moveTo(0,ho);
		var _g = 0;
		while(_g < 101) {
			var i = _g++;
			if(i > data.length - 1) ctx.lineTo(width / 100 * i,ho); else {
				var val = Reflect.field(data[i],field) / max;
				var sval = val * (height / 3 - 10);
				ctx.lineTo(width / 100 * i,(height / 3 - sval | 0) + offset);
			}
		}
		ctx.lineTo(width,ho);
		ctx.closePath();
		ctx.stroke();
		ctx.fill();
	}
	,select: function(data) {
		var _g = this;
		if(data == null) return;
		this.scope.$apply(function() {
			var c = document.getElementById("statsCanvas");
			var height = $('#stats_box').height() - 135;
			var width = $('#stats_box').width();
			$('#statsCanvas').width(width).height(height);
			$('#statsCanvas').attr("width",width).attr("height",height);
			var ctx = c.getContext("2d");
			ctx.fillStyle = "#f5f5f5";
			ctx.fillRect(0,0,width,height);
			var maxMEM = 0.0;
			var maxFPS = 0.0;
			var maxMS = 0.0;
			var _g1 = 0;
			var _g2 = data.length;
			while(_g1 < _g2) {
				var i = _g1++;
				maxFPS = Math.max(maxFPS,data[i].fps);
				maxMEM = Math.max(maxMEM,data[i].mem);
				maxMS = Math.max(maxMS,data[i].ms);
			}
			_g.drawData(data,"fps",maxFPS,"rgba(255, 0, 0, 0.3)","rgba(255, 0, 0, 1)",ctx,width,height,height * 0 | 0);
			_g.drawData(data,"ms",maxMS,"rgba(255, 198, 0, 0.3)","rgba(255, 198, 0, 1)",ctx,width,height,height * 0.33333333333333331 | 0);
			_g.drawData(data,"mem",maxMEM,"rgba(0, 138, 255, 0.3)","rgba(0, 138, 255, 1)",ctx,width,height,height * 0.66666666666666663 | 0);
			ctx.fillStyle = "#f5f5f5";
			ctx.fillRect(0,(height * 0.33333333333333331 | 0) - 1,width,3);
			ctx.fillRect(0,(height * 0.66666666666666663 | 0) - 1,width,3);
			ctx.fillRect(0,(height * 1. | 0) - 1,width,3);
			ctx.fillStyle = "rgba(255, 0, 0, 1)";
			ctx.fillRect(0,(height * 0.33333333333333331 | 0) - 1,width,1);
			ctx.fillStyle = "rgba(255, 198, 0, 1)";
			ctx.fillRect(0,(height * 0.66666666666666663 | 0) - 1,width,1);
			ctx.fillStyle = "rgba(0, 138, 255, 1)";
			ctx.fillRect(0,(height * 1. | 0) - 1,width,1);
			try {
				_g.scope.fps = data[0].fps;
				_g.scope.mem = data[0].mem;
				_g.scope.ms = data[0].ms;
			} catch( err ) {
				_g.scope.fps = "";
				_g.scope.mem = "";
				_g.scope.ms = "";
			}
		});
	}
	,__class__: pl.bigsoda.weblog.controllers.StatsController
};
pl.bigsoda.weblog.controllers.TabNavigatorController = $hx_exports.pl.bigsoda.weblog.controllers.TabNavigatorController = function(scope,window,http,document,timeout,rootScope,socketService) {
	this.lastTabs = "";
	var _g = this;
	this.scope = scope;
	this.rootScope = rootScope;
	this.socketService = socketService;
	rootScope.selectedTab = "log";
	hxangular.AngularHelper.map(this.scope,this);
	setInterval(function() {
		_g.select(socketService.getDevices());
	},100);
	socketService.addUpdateCallback($bind(this,this.update));
};
pl.bigsoda.weblog.controllers.TabNavigatorController.__name__ = true;
pl.bigsoda.weblog.controllers.TabNavigatorController.__interfaces__ = [hxangular.haxe.IController];
pl.bigsoda.weblog.controllers.TabNavigatorController.prototype = {
	rootScope: null
	,scope: null
	,socketService: null
	,lastTabs: null
	,update: function() {
		this.scope.currentId = this.socketService.getDevice();
	}
	,tabCloseClick: function(id) {
		this.socketService.delDevice(id);
	}
	,tabClick: function(id) {
		if(!this.socketService.deviceExists(id)) return;
		this.socketService.setCurrDevice(id);
		this.scope.currentId = id;
	}
	,select: function(devices) {
		var _g = this;
		if(this.lastTabs == devices.toString()) return;
		this.lastTabs = devices.toString();
		var titems = new Array();
		var _g1 = 0;
		var _g2 = devices.length;
		while(_g1 < _g2) {
			var i = _g1++;
			titems.push({ id : devices[i]});
		}
		this.scope.$apply(function() {
			_g.scope.items = titems;
		});
	}
	,setClass: function(value) {
		if(value == this.rootScope.selectedTab) return "active"; else return null;
	}
	,selectTab: function(value) {
		this.rootScope.selectedTab = value;
	}
	,__class__: pl.bigsoda.weblog.controllers.TabNavigatorController
};
pl.bigsoda.weblog.controllers.TestController = $hx_exports.pl.bigsoda.weblog.controllers.TestController = function(scope,window,http,document,timeout,rootScope,socketService) {
	this.scope = scope;
	this.http = http;
	this.timeout = timeout;
	hxangular.AngularHelper.map(this.scope,this);
	socketService.getTestData().then($bind(this,this.onSocketData));
};
pl.bigsoda.weblog.controllers.TestController.__name__ = true;
pl.bigsoda.weblog.controllers.TestController.__interfaces__ = [hxangular.haxe.IController];
pl.bigsoda.weblog.controllers.TestController.prototype = {
	scope: null
	,rootScope: null
	,http: null
	,timeout: null
	,socketData: null
	,onSocketData: function(data) {
		this.scope.logs = data;
	}
	,__class__: pl.bigsoda.weblog.controllers.TestController
};
pl.bigsoda.weblog.controllers.TictocController = $hx_exports.pl.bigsoda.weblog.controllers.TictocController = function(scope,window,http,document,timeout,rootScope,socketService,sce) {
	this.scope = scope;
	this.http = http;
	this.timeout = timeout;
	this.sce = sce;
	this.socketService = socketService;
	hxangular.AngularHelper.map(this.scope,this);
	socketService.getTictocData().then($bind(this,this.onSocketData));
	socketService.addUpdateCallback($bind(this,this.update));
};
pl.bigsoda.weblog.controllers.TictocController.__name__ = true;
pl.bigsoda.weblog.controllers.TictocController.__interfaces__ = [hxangular.haxe.IController];
pl.bigsoda.weblog.controllers.TictocController.prototype = {
	scope: null
	,rootScope: null
	,http: null
	,timeout: null
	,socketData: null
	,sce: null
	,socketService: null
	,msg: null
	,update: function() {
		var data = this.socketService.getTictocSocketData();
		this.scope.max = this.findMax(data);
		this.scope.logs = data;
	}
	,onSocketData: function(data) {
		this.scope.max = this.findMax(data);
		this.scope.logs = data;
	}
	,findMaxLogs: function() {
		var data = this.scope.logs;
		if(data == null) return 0;
		if(data.length < 1) return 0;
		var mmax = 0;
		var _g1 = 0;
		var _g = data.length;
		while(_g1 < _g) {
			var i = _g1++;
			mmax = Math.max(mmax,data[i].val);
		}
		return mmax;
	}
	,findMax: function(data) {
		if(data == null) return 0;
		if(data.length < 1) return 0;
		var mmax = 0;
		var _g1 = 0;
		var _g = data.length;
		while(_g1 < _g) {
			var i = _g1++;
			mmax = Math.max(mmax,data[i].val);
		}
		return mmax;
	}
	,__class__: pl.bigsoda.weblog.controllers.TictocController
};
pl.bigsoda.weblog.servicess = {};
pl.bigsoda.weblog.servicess.SocketService = function(q,rootScope,sce) {
	this.updateArr = new Array();
	this.max = 1001;
	this.logsData = new haxe.ds.StringMap();
	this.index = 0;
	this.init = false;
	this.rootScope = rootScope;
	this.sce = sce;
	this.q = q;
	rootScope.view = "default";
	this.logDeferred = q.defer();
	this.debugDeferred = q.defer();
	this.statsDeferred = q.defer();
	this.testDeferred = q.defer();
	this.inspectDeferred = q.defer();
	this.tictocDeferred = q.defer();
	console.log('SocketService');
	var socket = io.connect('http://localhost:18081/');
	socket.on("data",$bind(this,this.onSocketData));
};
pl.bigsoda.weblog.servicess.SocketService.__name__ = true;
pl.bigsoda.weblog.servicess.SocketService.__interfaces__ = [hxangular.haxe.IService];
pl.bigsoda.weblog.servicess.SocketService.prototype = {
	socketData: null
	,logData: null
	,debugData: null
	,statsData: null
	,inspectData: null
	,testData: null
	,tictocDeferred: null
	,logDeferred: null
	,debugDeferred: null
	,statsDeferred: null
	,inspectDeferred: null
	,testDeferred: null
	,rootScope: null
	,inspectSocketData: null
	,init: null
	,sce: null
	,index: null
	,device: null
	,q: null
	,logsData: null
	,max: null
	,setCurrDevice: function(id) {
		var _g = this;
		var devLogs;
		devLogs = this.logsData.get(id);
		if(devLogs == null) return;
		this.device = id;
		this.logDeferred = this.q.defer();
		this.debugDeferred = this.q.defer();
		this.statsDeferred = this.q.defer();
		this.testDeferred = this.q.defer();
		this.inspectDeferred = this.q.defer();
		this.tictocDeferred = this.q.defer();
		this.logDeferred.resolve(devLogs.logData);
		this.debugDeferred.resolve(devLogs.debugData);
		this.inspectDeferred.resolve(devLogs.inspectData);
		this.testDeferred.resolve(devLogs.testData);
		this.tictocDeferred.resolve(devLogs.statsData);
		this.statsDeferred.resolve(devLogs.tictocData);
		var _g1 = 0;
		var _g2 = this.updateArr.length;
		while(_g1 < _g2) {
			var i = _g1++;
			this.updateArr[i]();
		}
		try {
			setTimeout(function() {
				_g.rootScope.$apply();
			},1);
		} catch( e ) {
		}
	}
	,onSocketData: function(data) {
		var sdata = JSON.parse(data);
		var did = null;
		var devLogs;
		if(!this.logsData.exists(sdata.dev)) {
			var value = { logData : new Array(), debugData : new Array(), testData : new Array(), tictocData : new Array(), statsData : new Array(), inspectData : new Array(), debugDataItem : null, filterObj : null, filterInsp : null};
			this.logsData.set(sdata.dev,value);
			did = this.device = sdata.dev;
		}
		devLogs = this.logsData.get(sdata.dev);
		var _g = sdata.type;
		switch(_g) {
		case "tictoc":
			var x = { id : this.index, time : new Date(), data : sdata.data, msg : sdata.data.id, val : sdata.data.time};
			devLogs.tictocData.splice(0,0,x);
			if((function($this) {
				var $r;
				var a = devLogs.tictocData.length;
				var b = $this.max;
				var aNeg = a < 0;
				var bNeg = b < 0;
				$r = aNeg != bNeg?aNeg:a > b;
				return $r;
			}(this))) devLogs.tictocData.pop();
			break;
		case "log":
			var x1 = { id : this.index, time : new Date(), data : sdata.data, msg : sdata.msg};
			devLogs.logData.splice(0,0,x1);
			if((function($this) {
				var $r;
				var a1 = devLogs.logData.length;
				var b1 = $this.max;
				var aNeg1 = a1 < 0;
				var bNeg1 = b1 < 0;
				$r = aNeg1 != bNeg1?aNeg1:a1 > b1;
				return $r;
			}(this))) devLogs.logData.pop();
			break;
		case "debug":
			var x2 = { id : this.index, time : new Date(), data : sdata.data, msg : sdata.msg};
			devLogs.debugData.splice(0,0,x2);
			if((function($this) {
				var $r;
				var a2 = devLogs.debugData.length;
				var b2 = $this.max;
				var aNeg2 = a2 < 0;
				var bNeg2 = b2 < 0;
				$r = aNeg2 != bNeg2?aNeg2:a2 > b2;
				return $r;
			}(this))) devLogs.debugData.pop();
			break;
		case "test":
			var x3 = { id : this.index, time : new Date(), data : this.sce.trustAsHtml(this.formatMunit(sdata.data)), msg : sdata.msg};
			devLogs.testData.splice(0,0,x3);
			if((function($this) {
				var $r;
				var a3 = devLogs.testData.length;
				var b3 = $this.max;
				var aNeg3 = a3 < 0;
				var bNeg3 = b3 < 0;
				$r = aNeg3 != bNeg3?aNeg3:a3 > b3;
				return $r;
			}(this))) devLogs.testData.pop();
			break;
		case "stats":
			var x4 = sdata.data;
			devLogs.statsData.splice(0,0,x4);
			if(devLogs.statsData.length > 101) devLogs.statsData.pop();
			break;
		case "inspect":
			var x5 = this.sce.trustAsHtml("<pre class='jsonprint'>" + library.json.prettyPrint(sdata.data) + "</pre>");
			devLogs.inspectData.splice(0,0,x5);
			if(devLogs.inspectData.length > 101) devLogs.inspectData.pop();
			break;
		}
		this.index++;
		this.logDeferred.resolve(devLogs.logData);
		this.debugDeferred.resolve(devLogs.debugData);
		this.inspectDeferred.resolve(devLogs.inspectData);
		this.testDeferred.resolve(devLogs.testData);
		this.statsDeferred.resolve(devLogs.statsData);
		this.tictocDeferred.resolve(devLogs.tictocData);
		this.rootScope.$apply();
		if(did != null) this.setCurrDevice(did);
	}
	,updateArr: null
	,addUpdateCallback: function(f) {
		this.updateArr.push(f);
	}
	,delDevice: function(id) {
		console.log("DELETE DEVICE");
		this.logsData.remove(id);
		js.Console.log(this.getDevices());
		var devs = this.getDevices();
		this.device = devs[devs.length - 1];
		this.setCurrDevice(this.device);
	}
	,getDevice: function() {
		return this.device;
	}
	,deviceExists: function(id) {
		var $it0 = this.logsData.keys();
		while( $it0.hasNext() ) {
			var i = $it0.next();
			if(id == i) return true;
		}
		return false;
	}
	,getDevices: function() {
		var a = new Array();
		var $it0 = this.logsData.keys();
		while( $it0.hasNext() ) {
			var i = $it0.next();
			a.push(i);
		}
		return a;
	}
	,getDebugFor: function(id) {
		return this.logsData.get(id).debugData;
	}
	,formatMunit: function(object) {
		object = object.split("------------------------------")[1];
		var ao = object.split("==============================");
		var desc = ao[0];
		var result = ao[1];
		return "<p><b>" + desc + "</b></p><p>" + result + "</p>";
	}
	,formatJson: function(object) {
		return library.json.prettyPrint(object);
	}
	,getLogData: function() {
		return this.logDeferred.promise;
	}
	,getTictocData: function() {
		return this.tictocDeferred.promise;
	}
	,getDebugData: function() {
		return this.debugDeferred.promise;
	}
	,getStatsData: function() {
		return this.statsDeferred.promise;
	}
	,getInspectData: function() {
		return this.inspectDeferred.promise;
	}
	,getInspectSocketData: function() {
		if(!this.logsData.exists(this.device)) return null;
		return this.logsData.get(this.device).inspectData[0];
	}
	,clearDebugSocketData: function() {
		console.log("clearDebugSocketData");
		if(!this.logsData.exists(this.device)) return;
		console.log("clearDebugSocketData!!!");
		this.logsData.get(this.device).debugData = new Array();
		this.logsData.get(this.device).logData = new Array();
		this.setCurrDevice(this.device);
	}
	,getDebugSocketData: function() {
		if(!this.logsData.exists(this.device)) return null;
		return this.logsData.get(this.device).debugData;
	}
	,getTictocSocketData: function() {
		if(!this.logsData.exists(this.device)) return null;
		return this.logsData.get(this.device).tictocData;
	}
	,setDebugSocketItem: function(item) {
		if(!this.logsData.exists(this.device)) return null;
		this.logsData.get(this.device).debugDataItem = item;
	}
	,getDebugSocketItem: function() {
		if(!this.logsData.exists(this.device)) return null;
		return this.logsData.get(this.device).debugDataItem;
	}
	,getStatsSocketData: function() {
		if(!this.logsData.exists(this.device)) return null;
		return this.logsData.get(this.device).statsData;
	}
	,getTestData: function() {
		return this.testDeferred.promise;
	}
	,getFilterObj: function() {
		if(!this.logsData.exists(this.device)) return null;
		return this.logsData.get(this.device).filterObj;
	}
	,setFilterObj: function(s) {
		if(!this.logsData.exists(this.device)) return;
		this.logsData.get(this.device).filterObj = s;
	}
	,getFilterInsp: function() {
		if(!this.logsData.exists(this.device)) return null;
		return this.logsData.get(this.device).filterInsp;
	}
	,setFilterInsp: function(s) {
		if(!this.logsData.exists(this.device)) return;
		this.logsData.get(this.device).filterObj = s;
	}
	,__class__: pl.bigsoda.weblog.servicess.SocketService
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
if(Array.prototype.indexOf) HxOverrides.indexOf = function(a,o,i) {
	return Array.prototype.indexOf.call(a,o,i);
};
Math.NaN = Number.NaN;
Math.NEGATIVE_INFINITY = Number.NEGATIVE_INFINITY;
Math.POSITIVE_INFINITY = Number.POSITIVE_INFINITY;
Math.isFinite = function(i) {
	return isFinite(i);
};
Math.isNaN = function(i1) {
	return isNaN(i1);
};
String.prototype.__class__ = String;
String.__name__ = true;
Array.__name__ = true;
Date.prototype.__class__ = Date;
Date.__name__ = ["Date"];
var Int = { __name__ : ["Int"]};
var Dynamic = { __name__ : ["Dynamic"]};
var Float = Number;
Float.__name__ = ["Float"];
var Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = { __name__ : ["Class"]};
var Enum = { };
pl.bigsoda.weblog.controllers.DebugController.$inject = ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService","$sce"];
pl.bigsoda.weblog.controllers.InspectController.$inject = ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService","$sce"];
pl.bigsoda.weblog.controllers.LogController.$inject = ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService"];
pl.bigsoda.weblog.controllers.ServerAdressController.$inject = ["$scope","$window","$http","$document","$timeout","$rootScope"];
pl.bigsoda.weblog.controllers.StatsController.$inject = ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService","$sce"];
pl.bigsoda.weblog.controllers.TabNavigatorController.$inject = ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService"];
pl.bigsoda.weblog.controllers.TestController.$inject = ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService"];
pl.bigsoda.weblog.controllers.TictocController.$inject = ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService","$sce"];
pl.bigsoda.weblog.servicess.SocketService.$inject = ["$q","$rootScope","$sce"];
pl.bigsoda.weblog.controllers.DebugController.__meta__ = { fields : { _ : { inject : ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService","$sce"]}}};
pl.bigsoda.weblog.controllers.InspectController.__meta__ = { fields : { _ : { inject : ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService","$sce"]}}};
pl.bigsoda.weblog.controllers.LogController.__meta__ = { fields : { _ : { inject : ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService"]}}};
pl.bigsoda.weblog.controllers.ServerAdressController.__meta__ = { fields : { _ : { inject : ["$scope","$window","$http","$document","$timeout","$rootScope"]}}};
pl.bigsoda.weblog.controllers.StatsController.__meta__ = { fields : { _ : { inject : ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService","$sce"]}}};
pl.bigsoda.weblog.controllers.TabNavigatorController.__meta__ = { fields : { _ : { inject : ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService"]}}};
pl.bigsoda.weblog.controllers.TestController.__meta__ = { fields : { _ : { inject : ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService"]}}};
pl.bigsoda.weblog.controllers.TictocController.__meta__ = { fields : { _ : { inject : ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService","$sce"]}}};
pl.bigsoda.weblog.servicess.SocketService.__meta__ = { fields : { _ : { inject : ["$q","$rootScope","$sce"]}}};
Main.main();
})(typeof window != "undefined" ? window : exports);
