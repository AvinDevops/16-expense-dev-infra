### creating db sg ###
module "db" {
    source = "../../15-terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_name = "db"
    description = "SG for DB MySQL Instances"
    common_tags = var.common_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value


}

### creating backend sg ###
module "backend" {
    source = "../../15-terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_name = "backend"
    description = "SG for Backend Instances"
    common_tags = var.common_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value


}

### creating frontend sg ###
module "frontend" {
    source = "../../15-terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_name = "frontend"
    description = "SG for Frontend Instances"
    common_tags = var.common_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value

}


### creating bastion sg ###
module "bastion" {
    source = "../../15-terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_name = "bastion"
    description = "SG for Bastion Instances"
    common_tags = var.common_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value

}

### creating vpn sg ###
module "vpn" {
    source = "../../15-terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_name = "vpn"
    description = "SG for VPN Instances"
    common_tags = var.common_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    inbound_rules = var.vpn_sg_rules

}

### creating app-alb sg ###
module "app_alb" {
    source = "../../15-terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_name = "app-alb"
    description = "SG for app-alb Instances"
    common_tags = var.common_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value

}

### creating web-alb sg ###
module "web_alb" {
    source = "../../15-terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_name = "web-alb"
    description = "SG for web-alb Instances"
    common_tags = var.common_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value

}



### creating sg rules ###
###db ###
## db accepting connection from backend ##
resource "aws_security_group_rule" "db_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = module.db.sg_id
  source_security_group_id = module.backend.sg_id
}

## db accepting connection from bastion ##
resource "aws_security_group_rule" "db_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = module.db.sg_id
  source_security_group_id = module.bastion.sg_id
}

## db accepting connection from vpn ##
resource "aws_security_group_rule" "db_vpn" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = module.db.sg_id
  source_security_group_id = module.vpn.sg_id
}

### backend ###
## backend accepting connection from bastion ##
resource "aws_security_group_rule" "backend_bastion" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_group_id = module.backend.sg_id
    source_security_group_id = module.bastion.sg_id
}

## backend accepting connection from vpn_ssh ##
resource "aws_security_group_rule" "backend_vpn_ssh" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_group_id = module.backend.sg_id
    source_security_group_id = module.vpn.sg_id
}

## backend accepting connection from vpn_http ##
resource "aws_security_group_rule" "backend_vpn_http" {
    type = "ingress"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_group_id = module.backend.sg_id
    source_security_group_id = module.vpn.sg_id
}

## backend accepting connection from app-alb ##
resource "aws_security_group_rule" "backend_app_alb" {
    type = "ingress"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_group_id = module.backend.sg_id
    source_security_group_id = module.app_alb.sg_id
}

### app-alb ###
## app-alb accepting connection from vpn ##
resource "aws_security_group_rule" "app_alb_vpn" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_group_id = module.app_alb.sg_id
    source_security_group_id = module.vpn.sg_id 
}

## app-alb accepting connection from frontend instances ##
resource "aws_security_group_rule" "app_alb_frontend" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_group_id = module.app_alb.sg_id
    source_security_group_id = module.frontend.sg_id 
}

## app-alb accepting connection from bastion ##
resource "aws_security_group_rule" "app_alb_bastion" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_group_id = module.app_alb.sg_id
    source_security_group_id = module.bastion.sg_id 
}

### frontend ###
## frontend accepting connection from web-alb ##
resource "aws_security_group_rule" "frontend_web_alb" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_group_id = module.frontend.sg_id
    source_security_group_id = module.web_alb.sg_id
}

## frontend accepting connection from bastion ##
resource "aws_security_group_rule" "frontend_bastion" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_group_id = module.frontend.sg_id
    source_security_group_id = module.bastion.sg_id
}

## frontend accepting connection from vpn ##
resource "aws_security_group_rule" "frontend_vpn" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_group_id = module.frontend.sg_id
    source_security_group_id = module.vpn.sg_id
}

### web-alb ###
## web-alb accepting connection from public ##
resource "aws_security_group_rule" "web_alb_public" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = module.web_alb.sg_id 
}

## web-alb accepting connection from public_https ##
resource "aws_security_group_rule" "web-alb_public_https" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = module.web_alb.sg_id 
}

### bastion ###
## bastion accepting connection from public ##
resource "aws_security_group_rule" "bastion_public" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = module.bastion.sg_id 
}

### tools ###
## backend accepting connection from default_vpc ##
resource "aws_security_group_rule" "backend_default_subnet" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["172.31.16.0/20"]
    security_group_id = module.backend.sg_id 
}

