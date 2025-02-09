module "vpc" {
    # source = "../12-terraform-aws-vpc"
    source = "git::https://github.com/AvinDevops/12-terraform-aws-vpc.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
    frontend_subnet_cidrs = var.frontend_subnet_cidrs
    backend_subnet_cidrs = var.backend_subnet_cidrs
    database_subnet_cidrs = var.database_subnet_cidrs
    is_peering_required = var.is_peering_required
}