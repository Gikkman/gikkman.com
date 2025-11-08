##
# mtg.gikkman.com -> port 8080
##

server {
	server_name mtg.gikkman.com;

	listen 443 ssl;
	listen [::]:443 ssl;
	ssl_certificate		/etc/letsencrypt/live/gikkman.com/fullchain.pem;
	ssl_certificate_key	/etc/letsencrypt/live/gikkman.com/privkey.pem;

	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;

	location / {
		proxy_pass http://127.0.0.1:8080$request_uri;
	}

}
