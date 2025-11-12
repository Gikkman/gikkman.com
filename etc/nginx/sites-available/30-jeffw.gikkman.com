##
# nextmtgset.com -> static serv
##
server {
	server_name jeffw.gikkman.com;

	listen 443 ssl;
	listen [::]:443 ssl;
	ssl_certificate		/etc/letsencrypt/live/gikkman.com/fullchain.pem;
	ssl_certificate_key	/etc/letsencrypt/live/gikkman.com/privkey.pem;

	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;

	root /var/www/jeffw.gikkman.com/public;

	index index.html;

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ =404;
	}

    error_page 404 /404.html;
}
