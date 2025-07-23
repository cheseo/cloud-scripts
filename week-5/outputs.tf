output "server_ip" {
	value = module.server.public_ip
}

output "ssh" {
	value = "ssh -J ubuntu@${module.server.public_ip}"
}
