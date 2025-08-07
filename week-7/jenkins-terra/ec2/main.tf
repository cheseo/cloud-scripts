
resource "aws_instance" "ec2" {
        ami = var.ami != null ? var.ami : data.aws_ami.ubuntu.id
        instance_type = var.instance_type
	subnet_id = var.subnet_id
        vpc_security_group_ids = var.security_group_ids
	associate_public_ip_address = var.associate_public_ip_address

	root_block_device {
		volume_size = var.root_volume_size
	}

        key_name = var.key_name
	user_data = var.user_data	

        tags = {
                Name = var.name
                Public = false
        }
}

data "aws_ami" "ubuntu" {
        most_recent = true
        filter {
                name = "name"
                values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
        }
        owners = ["099720109477"] # Canonical
}

