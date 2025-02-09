locals {
    frontend_subnet_id = element(split("," ,data.aws_ssm_parameter.frontend_subnet_ids.value),0)
}