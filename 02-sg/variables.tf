variable "project_name" {
    type = string
    default = "expense"
}

variable "environment" {
    type = string
    default = "dev"
}

# variable "sg_name" {
#     type = string
#     default = ""
# }

# variable "sg_description" {
#     type = string
#     default = " "
# }


variable "common_tags" {
    type = map
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = true

    }
}

variable "vpn_sg_rules" {
    type = list
    default = [
        {
            from_port = 943
            to_port = 943
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            from_port = 443
            to_port = 443
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            from_port = 1194
            to_port = 1194
            protocol = "udp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    ]
}