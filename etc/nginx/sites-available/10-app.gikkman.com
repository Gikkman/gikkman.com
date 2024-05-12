server {
	root /var/www/html2;
	index index.html;

	server_name app.gikkman.com;

	location / {
		try_files $uri $uri/ =404;
	}

	include app-default;
}
