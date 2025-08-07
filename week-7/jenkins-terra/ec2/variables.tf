variable "ami" {
        type = string
        default = null
}

variable "name" {
        type = string
        default = "module-ec2"
}

variable "instance_type" {
        type = string
        default = "t2.micro"
}

variable "subnet_id" {
        type = string
}

variable "security_group_ids" {
        type = list
        default = null
}

variable "associate_public_ip_address" {
        type = bool
        default = false
}

variable "key_name" {
        type = string
	default = null
}

variable "user_data" {
	type = string
	default = null
}

variable "root_volume_size" {
	type = string
	default = null
}
