resource "aws_lb" "sd" {
	name = "sd-lb"
	internal = false
	load_balancer_type = "application"
	security_groups = [var.lb_sg]
	subnets = [var.launch_subnet, aws_subnet.lb.id]
}

output "dns" {
	value = aws_lb.sd.dns_name
}

resource "aws_lb_target_group" "sd" {
	name = "sd-target"
	port = 8888
	protocol = "HTTP"
	vpc_id = "vpc-0ad6181e0039214c3"
}

resource "aws_lb_listener" "fe" {
	load_balancer_arn = aws_lb.sd.arn
	port = "80"
	protocol = "HTTP"
	default_action {
		type = "forward"
		target_group_arn = aws_lb_target_group.sd.arn
	}
}

variable "lb_sg" {
	type = string
	default = "sg-0dce56f6f2aee9850"
}

variable "lb_subnet" {
	type = string
	default = "subnet-0d1ca39b5c39a8fdd"
}

resource "aws_subnet" "lb" {
	vpc_id     = "vpc-0ad6181e0039214c3"
	cidr_block = "10.0.5.0/24"
	availability_zone = "ap-south-1a"
	tags = {
		Name = "lb-subnet"
	}
}

resource "aws_route_table_association" "a" {
	subnet_id      = aws_subnet.lb.id
	route_table_id = "rtb-0dc2b9bf5f094c125"
}
