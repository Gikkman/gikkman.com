##
# nextmtgset.com -> static serv
#
server {
	server_name nextmtgset.com;

	listen 443 ssl;
	listen [::]:443 ssl;
	ssl_certificate		/etc/letsencrypt/live/nextmtgset.com/fullchain.pem;
	ssl_certificate_key	/etc/letsencrypt/live/nextmtgset.com/privkey.pem;

	root /var/www/nextmtgset.com/public;

	index index.html;

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ =404;
	}

    error_page 404 /404.html;
}
