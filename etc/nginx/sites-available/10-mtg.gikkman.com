server {
	server_name mtg.gikkman.com;
	set $PORT 8080;
	include app-default;
}
