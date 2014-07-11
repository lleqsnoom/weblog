#!/usr/bin/env node
//var ws = require("nodejs-websocket");
var port = 28080;
var wsport = 28081;
var io = require('socket.io').listen(wsport);
var http = require('http');
var fs = require('fs');
var qs = require('querystring');
var ws_conn = {};

var server = http.createServer(function(request, response) {

	try{
	
		console.log((new Date()) + ' Received request for ' + request.url);
		
	   
		if (request.method == 'POST') {
			var body = '';
			request.on('data', function (data) {
				body += data;
			});
			request.on('end', function () {

				var POST = qs.parse(body);
				//console.log(POST);
				try{
					POST.device = request.headers["user-agent"];
					ws_conn.emit("data", POST);
				}catch(e){}
				// use POST
				
				response.writeHead(200);
				response.end();
				
				return;
				
			});
		}
		
		//console.log(request);
		
		if(request.url == "/"){
			try{
				var asset = fs.readFileSync("../weblog/bin" + "/index.html");
				response.writeHead(200);
				response.end(asset);
			}catch(e){
				console.log("error");
				console.log(e);
			}
		}else{
			try{
				var asset = fs.readFileSync("../weblog/bin" + request.url);
				response.writeHead(200);
				response.end(asset);
			}catch(e){
				console.log("error");
				console.log(e);
			}
		}
	
	}catch(e){}
	
});



try{
	server.listen(port, function() {
		console.log((new Date()) + ' Server is listening on port 8080');
	});
}catch(err){
	
}


process.on('uncaughtException', function(err) {
	console.log("Error: " + err);
	//alert("Error: " + err);
});



io.sockets.on('connection', function (socket) {
	ws_conn = socket;
	socket.on('data', function (data) {
		//console.log(data);
	});
});