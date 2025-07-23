output "jumphost_ip" {
        value = module.jumphost.public_ip
}

output "server_ip" {
	value = module.server.private_ip
}

output "ssh" {
	value = "ssh -J ubuntu@${module.jumphost.public_ip} ubuntu@${module.server.private_ip}"
}
