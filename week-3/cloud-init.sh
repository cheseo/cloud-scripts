#!/bin/bash

config(){
    cat
} <<EOF
server{
	listen 80 default_server;
	listen [::]:80 default_server;
	server_name _;
	root /var/www/mysite;
}
EOF

html(){
    cat
}<<EOF
<!DOCTYPE html>
<html>
<head><title>My Static Site!</title>
</head>
<body>
<h1>Static Site!</h1>
<p>This site has been served using cloud-init.sh !! </p>
</body>
</html>
EOF

apt update
apt install -y nginx

mkdir /var/www/mysite
html > /var/www/mysite/index.html


config > /etc/nginx/sites-enabled/mysite
rm /etc/nginx/sites-enabled/default

nginx -s reload
