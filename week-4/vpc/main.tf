resource "aws_vpc" "main" {
	cidr_block = var.cidr_block

        tags = {
                Name = var.name
                Public = true
        }
}

resource "aws_subnet" "public" {
        vpc_id     = aws_vpc.main.id
        cidr_block = var.public_cidr
        availability_zone = var.az

        tags = {
                Name = var.public_subnet_name
                Public = true
                }
}

resource "aws_internet_gateway" "gw" {
        vpc_id = aws_vpc.main.id
        tags = {
                Name = "Public gateway"  
        }
}

resource "aws_route_table" "public" {
        vpc_id = aws_vpc.main.id
        route {
                cidr_block = "0.0.0.0/0"
                gateway_id = aws_internet_gateway.gw.id
        }
}

resource "aws_route_table_association" "public" {
	subnet_id = aws_subnet.public.id
        route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "public" {
        vpc_id = aws_vpc.main.id
        name = "public-sec-group"


        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]     
        }
        ingress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }
}

resource "aws_subnet" "private" {
        vpc_id = aws_vpc.main.id
        cidr_block = var.private_cidr
        availability_zone = var.az

        tags = {
                Name = var.private_subnet_name
                Public = false
        }
}


resource "aws_security_group" "private" {
        vpc_id = aws_vpc.main.id
        name = "private-sec-group"
        
        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = [aws_vpc.main.cidr_block]
        }
}

