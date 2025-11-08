##
# grs.gikkman.com -> port 8090
##

server {
	server_name grs.gikkman.com;
	listen 443 ssl;
	listen [::]:443 ssl;

	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;

	location / {
		proxy_pass http://127.0.0.1:8090$request_uri;
	}


	location /ws {
		proxy_pass http://127.0.0.1:8090$request_uri;
		
		# WebSocket support
		proxy_http_version 1.1;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection "upgrade"; 
		proxy_read_timeout 90s;
	}
}
