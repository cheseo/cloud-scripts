terraform {
	required_providers {
		aws = {
			source = "hashicorp/aws"
			# ~> means major same, minor can increase
			version = "~> 5.92"
		}
	}
	required_version = ">= 1.2"
}

provider "aws" {
	region = "ap-south-1"
}

module "server" {
	source = "./ec2"
	instance_type = "t2.medium"
	root_volume_size = "50"
	subnet_id = module.vpc.public_id
	security_group_ids = [module.vpc.public_sec_id]
	name = "jenkins"
	associate_public_ip_address = true
	key_name = aws_key_pair.laptop.key_name
}

module "vpc" {
	source = "./vpc"
	az = "ap-south-1b"
}

data "local_file" "ssh" {
	filename = pathexpand("~/.ssh/id_rsa.pub")
}


resource "aws_key_pair" "laptop" {
	key_name = "laptop2"
	public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8Z2GcNHY7otLm6Sb6xiXZLqaKAKwUtAD8FJb8bMuooF1nL78lhLCLkXVBpb9kJvgnnnVhzLr/OQ6ZYcFU7uWKCOBiAsXHHiEV4n5rEkK3ApksXe6ulMU1GTs1MdUPWQO7sFL58SxrgUlxxGGlA31/pSIchINcpf/IDj5Hr+QU/CEP4gCdOqaqVM0NqyLr3iF4m9StRKSA0DIcUgwBMydKuFI1pM0pR+nKxdANrvMR9PjAYNueHhj8paCOMAsW5K+VXhW+GVCxFT81Zlxz6hIvwwutWMEimpvPGt1uy9eSxzjNR0XtoB6Ko4Adqv5I9B1SEitHO0Aq0kckl+a6kMSzp/qhw07q52lLeLUPrzAqJcqZGq5sbFPgOIpvXaI1/OlA4v/buyIjkDPjhOKTbJ9l6F9kYFDt4dHzo8foPZMjjqwTRv6i61oMRWwKpaSw7u3elNolIzjN4EWCe9bw9yd7ishZEWT+28JXyfSpyhDsBSrI8ng6iziKW6EDXDzQvKc= me@laptop"
	# public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMFecY2EIR3NKfHop7VKX4vBbA3KlDZAOpelg/Atks3p me@pc"
	# public_key = data.local_file.ssh.content
}

