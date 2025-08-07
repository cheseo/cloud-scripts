output "id" {
        value = aws_vpc.main.id
}

output "private_id" {
        value = aws_subnet.private.id
}

output "public_id" {
        value = aws_subnet.public.id
}

output "gateway_id" {
        value = aws_internet_gateway.gw.id
}

output "public_sec_id" {
        value = aws_security_group.public.id 
}

output "private_sec_id" {
        value = aws_security_group.private.id
}
