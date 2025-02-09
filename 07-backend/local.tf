locals {
    backend_subnet_id = element(split("," ,data.aws_ssm_parameter.backend_subnet_ids.value),0)
}