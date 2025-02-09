## fetching vpc value from ssm parameter store ##
data "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project_name}/${var.environment}/vpc_id"
}