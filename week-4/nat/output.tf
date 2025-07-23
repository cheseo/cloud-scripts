output "id" {
        value = aws_nat_gateway.gw.id
}

output "eip_id" {
        value = aws_eip.eip.id
}

output "route_table_id" {
        value = aws_route_table.nat.id
}

