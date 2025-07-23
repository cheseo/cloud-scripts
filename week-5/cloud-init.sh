#!/bin/bash

config(){
	cat
}<<EOF
ec2.ashwink.com.np {
	reverse_proxy localhost:8080
}

EOF

wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ >  /etc/apt/sources.list.d/jenkins.list

apt update
apt install -y jenkins openjdk-21-jre docker.io caddy golang

usermod -a -G docker jenkins

config > /etc/caddy/Caddyfile

reboot
