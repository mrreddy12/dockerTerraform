module "backend_alb" {
  
  #session-40  create load balancer
    source = "git::https://github.com/daws-84s/terraform-aws-securitygroup.git?ref=main"
         source = "git::https://github.com/mrreddy12/terraform.git//modules-//terraform-aws-securitygroup?ref=master"
  #source = "terraform-aws-modules/alb/aws"
  version = "9.16.0"
  internal = true
  name    = "${var.project}-${var.environment}-backend-alb" #roboshop-dev-backend-alb ..update this
  vpc_id  = local.vpc_id   #update this from
  subnets = local.private_subnet_ids # update this
  create_security_group = false
  security_groups = [local.backend_alb_sg_id]
  enable_deletion_protection = false
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-backend-alb"
    }
  )
}

resource "aws_lb_listener" "backend_alb" {
  load_balancer_arn = module.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, I am from Backend ALB</h1>"
      status_code  = "200"
    }
  }
}

# resource "aws_route53_record" "backend_alb" {
#   zone_id = var.zone_id
#   name    = "*.backend-dev.${var.zone_name}"
#   type    = "A"

#   alias {
#     name                   = module.backend_alb.dns_name
#     zone_id                = module.backend_alb.zone_id # This is the ZONE ID of ALB
#     evaluate_target_health = true
#   }
# }