

#front end===================================================
module "frontend" {

    #source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
    source = "git::https://github.com/mrreddy12/terraform.git//modules-//terraform-aws-securitygroup?ref=master"

      # source = "../../modules-/terraform-aws-securitygroup"
    project = var.project
    environment = var.environment

    sg_name = var.frontend_sg_name
    sg_description = var.frontend_sg_description
    #vpc_id = data.aws_ssm_parameter.vpc_id.value  ...store this in local and get it from local
    vpc_id = local.vpc_id
}

#bastian===================================================
module "bastion" {
    #source = "../../terraform-aws-securitygroup"
    source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = var.bastion_sg_name
    sg_description = var.bastion_sg_description
    vpc_id = local.vpc_id
}

# bastion accepting connections from my laptop
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

#load balancer===================================================
#session-40  create load balancer security group
module "backend_alb" {
    #source = "../../terraform-aws-securitygroup"
        #source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
     source = "git::https://github.com/mrreddy12/terraform.git//modules-//terraform-aws-securitygroup?ref=master"
    project = var.project
    environment = var.environment

    sg_name = "backend-alb"  # we can specify variables as well...but here we are giving directly
    sg_description = "for backend alb"
    vpc_id = local.vpc_id
}

# session-40  backend ALB accepting connections from my bastion host on port no 80
resource "aws_security_group_rule" "backend_alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id  # attache bastaian security group to this loabalander
  security_group_id = module.backend_alb.sg_id
}