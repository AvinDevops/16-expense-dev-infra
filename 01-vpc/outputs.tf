# output "azs" {
#     value = module.vpc.all_azs
# }

output "vpc_id" {
    value = module.vpc.vpc_id
}

output "frontend_subnet_id" {
    value = module.vpc.frontend_subnet_id
}

output "backend_subnet_id" {
    value = module.vpc.backend_subnet_id
}

