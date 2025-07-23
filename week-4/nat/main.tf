
resource "aws_eip" "eip" {   
        domain = "vpc"
        tags = {
                Name = "nat ip"
        }
}

resource "aws_nat_gateway" "gw" {
        subnet_id = var.public_subnet
        allocation_id = aws_eip.eip.id
}

resource "aws_route_table" "nat" {
        vpc_id = var.vpc
        route {
                cidr_block = "0.0.0.0/0"
                nat_gateway_id = aws_nat_gateway.gw.id
        }
}

resource "aws_route_table_association" "b" {
        subnet_id = var.private_subnet
        route_table_id = aws_route_table.nat.id
}

