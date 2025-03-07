data "aws_ssm_parameter" "app_alb_sg_id" {
    name = "/${var.project_name}/${var.environment}/app_alb_sg_id"
}

data "aws_ssm_parameter" "backend_subnet_ids" {
    name = "/${var.project_name}/${var.environment}/backend_subnet_ids"
}

