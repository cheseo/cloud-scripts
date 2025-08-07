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
	key_name = "ec2-test.pem"
}

module "vpc" {
	source = "./vpc"
	az = "ap-south-1b"
}

