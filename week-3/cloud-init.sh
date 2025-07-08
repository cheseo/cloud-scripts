#!/bin/bash

config(){
    cat
} <<EOF
ec2.ashwink.com.np {
	root * /var/www/mysite
	file_server
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
apt install -y caddy

mkdir /var/www/mysite
html > /var/www/mysite/index.html


config > /etc/caddy/Caddyfile
caddy reload --config /etc/caddy/Caddyfile
