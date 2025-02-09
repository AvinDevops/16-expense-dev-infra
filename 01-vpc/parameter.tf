### creating ssm parameter store ###
resource "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project_name}/${var.environment}/vpc_id"
    type = "String"
    value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "frontend_subnet_ids" {
    name = "/${var.project_name}/${var.environment}/frontend_subnet_ids"
    type = "StringList"
    value = join(",",module.vpc.frontend_subnet_id)
}

resource "aws_ssm_parameter" "backend_subnet_ids" {
    name = "/${var.project_name}/${var.environment}/backend_subnet_ids"
    type = "StringList"
    value = join(",",module.vpc.backend_subnet_id)
}

resource "aws_ssm_parameter" "db_subnet_group_name" {
    name = "/${var.project_name}/${var.environment}/db_subnet_group_name"
    type = "String"
    value = module.vpc.database_subnet_group_name
}