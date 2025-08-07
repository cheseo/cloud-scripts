variable "cidr_block" {
        type = string
        default = "10.0.0.0/16"
}

variable "public_cidr" {
        type = string
        default = "10.0.1.0/24"
}
variable "private_cidr" {  
        type = string
        default = "10.0.2.0/24"
}

variable "az" {
        type = string
        # default = "ap-south-1b"
}

variable "public_subnet_name" {
        type = string
        default = "Public-1"
}

variable "private_subnet_name" {  
        type = string
        default = "Private-1"
}

variable "name" {
        type = string
        default = "TerraVPC"
}
