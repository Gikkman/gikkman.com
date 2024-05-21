server {
	server_name grs.gikkman.com;
	set $PORT 8090;
	include app-default;

	location /ws {
		proxy_pass http://127.0.0.1:$PORT$request_uri;
		
		# WebSocket support
		proxy_http_version 1.1;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection "upgrade"; 
	}
}
