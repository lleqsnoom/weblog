(function ($hx_exports) { "use strict";
$hx_exports.pl = $hx_exports.pl || {};
$hx_exports.pl.bigsoda = $hx_exports.pl.bigsoda || {};
$hx_exports.pl.bigsoda.weblog = $hx_exports.pl.bigsoda.weblog || {};
$hx_exports.pl.bigsoda.weblog.controllers = $hx_exports.pl.bigsoda.weblog.controllers || {};
var HxOverrides = function() { };
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
var Main = function() { };
Main.main = function() {
	var app = angular.module("weblog",["nvd3ChartDirectives","infinite-scroll"]);
	app.controller("pl.bigsoda.weblog.controllers.LogController",pl.bigsoda.weblog.controllers.LogController);
	app.controller("pl.bigsoda.weblog.controllers.DebugController",pl.bigsoda.weblog.controllers.DebugController);
	app.controller("pl.bigsoda.weblog.controllers.InspectController",pl.bigsoda.weblog.controllers.InspectController);
	app.controller("pl.bigsoda.weblog.controllers.TabNavigatorController",pl.bigsoda.weblog.controllers.TabNavigatorController);
	app.controller("pl.bigsoda.weblog.controllers.ServerAdressController",pl.bigsoda.weblog.controllers.ServerAdressController);
	app.controller("pl.bigsoda.weblog.controllers.StatsController",pl.bigsoda.weblog.controllers.StatsController);
	app.service("pl.bigsoda.weblog.servicess.SocketService",pl.bigsoda.weblog.servicess.SocketService);
};
var Reflect = function() { };
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
var Type = function() { };
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
var hxangular = {};
hxangular.AngularHelper = function() { };
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
hxangular.haxe.IService = function() { };
var js = {};
js.Console = function() { };
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
	hxangular.AngularHelper.map(this.scope,this);
	socketService.getDebugData().then($bind(this,this.onSocketData));
};
pl.bigsoda.weblog.controllers.DebugController.__interfaces__ = [hxangular.haxe.IController];
pl.bigsoda.weblog.controllers.DebugController.prototype = {
	scope: null
	,rootScope: null
	,http: null
	,timeout: null
	,socketData: null
	,sce: null
	,onSocketData: function(data) {
		console.log("onSocketData");
		this.scope.logs = data;
	}
	,select: function(msg,id) {
		this.scope.selectedDebugItem = msg;
		this.scope.selectedId = id;
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
		console.log("onSocketData");
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
	hxangular.AngularHelper.map(this.scope,this);
	socketService.getStatsData().then($bind(this,this.onSocketData));
};
pl.bigsoda.weblog.controllers.StatsController.__interfaces__ = [hxangular.haxe.IController];
pl.bigsoda.weblog.controllers.StatsController.prototype = {
	scope: null
	,rootScope: null
	,http: null
	,timeout: null
	,socketData: null
	,sce: null
	,socketService: null
	,onSocketData: function(data) {
		var _g = this;
		console.log("onSocketData StatsController");
		this.scope.logs = data;
		setInterval(function() {
			_g.select(_g.socketService.getStatsSocketData());
		},1000);
	}
	,select: function(data) {
		var _g = this;
		this.scope.$apply(function() {
			var d = [{ key : "fps", values : []},{ key : "mem", values : []},{ key : "ms", values : []}];
			var _g1 = 0;
			while(_g1 < 100) {
				var i = _g1++;
				if(i > data.length - 1) {
					d[0].values[i] = [i,0];
					d[1].values[i] = [i,0];
					d[2].values[i] = [i,0];
				} else {
					d[0].values[i] = [i,data[i].fps];
					d[1].values[i] = [i,data[i].mem];
					d[2].values[i] = [i,data[i].ms];
				}
			}
			console.log(d);
			_g.scope.statsChartData = d;
		});
	}
	,__class__: pl.bigsoda.weblog.controllers.StatsController
};
pl.bigsoda.weblog.controllers.TabNavigatorController = $hx_exports.pl.bigsoda.weblog.controllers.TabNavigatorController = function(scope,window,http,document,timeout,rootScope) {
	this.scope = scope;
	this.rootScope = rootScope;
	rootScope.selectedTab = "log";
	hxangular.AngularHelper.map(this.scope,this);
};
pl.bigsoda.weblog.controllers.TabNavigatorController.__interfaces__ = [hxangular.haxe.IController];
pl.bigsoda.weblog.controllers.TabNavigatorController.prototype = {
	rootScope: null
	,scope: null
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
pl.bigsoda.weblog.controllers.TestController.__interfaces__ = [hxangular.haxe.IController];
pl.bigsoda.weblog.controllers.TestController.prototype = {
	scope: null
	,rootScope: null
	,http: null
	,timeout: null
	,socketData: null
	,onSocketData: function(data) {
		console.log("onSocketData");
		this.scope.logs = data;
	}
	,__class__: pl.bigsoda.weblog.controllers.TestController
};
pl.bigsoda.weblog.servicess = {};
pl.bigsoda.weblog.servicess.SocketService = function(q,rootScope,sce) {
	this.index = 0;
	this.init = false;
	this.statsSocketData = new Array();
	this.rootScope = rootScope;
	this.logDeferred = q.defer();
	this.debugDeferred = q.defer();
	this.statsDeferred = q.defer();
	this.testDeferred = q.defer();
	this.inspectDeferred = q.defer();
	this.socketData = new Array();
	this.sce = sce;
	this.logData = new Array();
	this.debugData = new Array();
	this.statsData = new Array();
	this.inspectData = new Array();
	this.testData = new Array();
	this.socketData = { logData : this.logData, debugData : this.debugData, inspectData : this.inspectData, testData : this.testData, statsData : this.statsData};
	console.log('SocketService');
	var socket = io.connect('http://localhost:18081/');
	socket.on("data",$bind(this,this.onSocketData));
};
pl.bigsoda.weblog.servicess.SocketService.__interfaces__ = [hxangular.haxe.IService];
pl.bigsoda.weblog.servicess.SocketService.prototype = {
	socketData: null
	,logData: null
	,debugData: null
	,statsData: null
	,inspectData: null
	,testData: null
	,logDeferred: null
	,debugDeferred: null
	,statsDeferred: null
	,inspectDeferred: null
	,testDeferred: null
	,rootScope: null
	,inspectSocketData: null
	,statsSocketData: null
	,init: null
	,sce: null
	,index: null
	,onSocketData: function(data) {
		data = JSON.parse(data);
		var max = 100;
		if(data.type == "log") {
			var x = { id : this.index, time : new Date(), device : data.device, message : data.data};
			this.logData.splice(0,0,x);
			if((function($this) {
				var $r;
				var a = $this.logData.length;
				var aNeg = a < 0;
				var bNeg = max < 0;
				$r = aNeg != bNeg?aNeg:a > max;
				return $r;
			}(this))) this.logData.pop();
		}
		if(data.type == "stats") {
			var x1 = data.data;
			this.statsSocketData.splice(0,0,x1);
			var x2 = data.data;
			this.statsData.splice(0,0,x2);
			if((function($this) {
				var $r;
				var a1 = $this.statsData.length;
				var aNeg1 = a1 < 0;
				var bNeg1 = max < 0;
				$r = aNeg1 != bNeg1?aNeg1:a1 > max;
				return $r;
			}(this))) this.statsData.pop();
			if((function($this) {
				var $r;
				var a2 = $this.statsSocketData.length;
				var aNeg2 = a2 < 0;
				var bNeg2 = max < 0;
				$r = aNeg2 != bNeg2?aNeg2:a2 > max;
				return $r;
			}(this))) this.statsSocketData.pop();
		}
		if(data.type == "debug") {
			var x3 = { id : this.index, time : new Date(), device : data.device, message : this.sce.trustAsHtml("<pre id='debug'>" + library.json.prettyPrint(data.data) + "</pre>")};
			this.debugData.splice(0,0,x3);
			if((function($this) {
				var $r;
				var a3 = $this.debugData.length;
				var aNeg3 = a3 < 0;
				var bNeg3 = max < 0;
				$r = aNeg3 != bNeg3?aNeg3:a3 > max;
				return $r;
			}(this))) this.debugData.pop();
		}
		if(data.type == "inspect") {
			this.inspectSocketData = this.sce.trustAsHtml("<pre id='debug'>" + library.json.prettyPrint(data.data) + "</pre>");
			var x4 = { id : this.index, time : new Date(), device : data.device, message : this.sce.trustAsHtml("<pre id='debug'>" + library.json.prettyPrint(data.data) + "</pre>")};
			this.inspectData.splice(0,0,x4);
			if(this.inspectData.length > 1) this.inspectData.pop();
		}
		if(data.type == "test") {
			var x5 = { id : this.index, time : new Date(), device : data.device, message : this.sce.trustAsHtml(this.formatMunit(data.data))};
			this.testData.splice(0,0,x5);
		}
		this.index++;
		this.logDeferred.resolve(this.logData);
		this.debugDeferred.resolve(this.debugData);
		this.inspectDeferred.resolve(this.inspectData);
		this.testDeferred.resolve(this.testData);
		this.statsDeferred.resolve(this.statsData);
		this.rootScope.$apply();
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
		return this.inspectSocketData;
	}
	,getStatsSocketData: function() {
		return this.statsSocketData;
	}
	,getTestData: function() {
		return this.testDeferred.promise;
	}
	,__class__: pl.bigsoda.weblog.servicess.SocketService
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
if(Array.prototype.indexOf) HxOverrides.indexOf = function(a,o,i) {
	return Array.prototype.indexOf.call(a,o,i);
};
String.prototype.__class__ = String;
Date.prototype.__class__ = Date;
pl.bigsoda.weblog.controllers.DebugController.$inject = ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService","$sce"];
pl.bigsoda.weblog.controllers.InspectController.$inject = ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService","$sce"];
pl.bigsoda.weblog.controllers.LogController.$inject = ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService"];
pl.bigsoda.weblog.controllers.ServerAdressController.$inject = ["$scope","$window","$http","$document","$timeout","$rootScope"];
pl.bigsoda.weblog.controllers.StatsController.$inject = ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService","$sce"];
pl.bigsoda.weblog.controllers.TabNavigatorController.$inject = ["$scope","$window","$http","$document","$timeout","$rootScope"];
pl.bigsoda.weblog.controllers.TestController.$inject = ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService"];
pl.bigsoda.weblog.servicess.SocketService.$inject = ["$q","$rootScope","$sce"];
pl.bigsoda.weblog.controllers.DebugController.__meta__ = { fields : { _ : { inject : ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService","$sce"]}}};
pl.bigsoda.weblog.controllers.InspectController.__meta__ = { fields : { _ : { inject : ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService","$sce"]}}};
pl.bigsoda.weblog.controllers.LogController.__meta__ = { fields : { _ : { inject : ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService"]}}};
pl.bigsoda.weblog.controllers.ServerAdressController.__meta__ = { fields : { _ : { inject : ["$scope","$window","$http","$document","$timeout","$rootScope"]}}};
pl.bigsoda.weblog.controllers.StatsController.__meta__ = { fields : { _ : { inject : ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService","$sce"]}}};
pl.bigsoda.weblog.controllers.TabNavigatorController.__meta__ = { fields : { _ : { inject : ["$scope","$window","$http","$document","$timeout","$rootScope"]}}};
pl.bigsoda.weblog.controllers.TestController.__meta__ = { fields : { _ : { inject : ["$scope","$window","$http","$document","$timeout","$rootScope","pl.bigsoda.weblog.servicess.SocketService"]}}};
pl.bigsoda.weblog.servicess.SocketService.__meta__ = { fields : { _ : { inject : ["$q","$rootScope","$sce"]}}};
Main.main();
})(typeof window != "undefined" ? window : exports);
