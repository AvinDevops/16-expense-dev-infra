variable "project_name" {
    type = string
    default = "expense"
}

variable "environment" {
    type = string
    default = "dev"
}

variable "common_tags" {
    type = map
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = true
        Component = "web-alb"
    }
}

variable "zone_name" {
    type = string
    default = "avinexpense.online"
}

variable "zone_id" {
    type = string
    default = "Z099839639LSXUOMJUHEL"
}