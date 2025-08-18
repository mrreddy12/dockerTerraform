# locals {
#   common_tags = {
#     Project = var.project
#     Environment = var.environment
#     Terraform = "true"
#   }


# tags = merge(
#     local.common_tags,
#     {
#       Name = "${var.project}-${var.environment}"
#     }
#   )
# }


locals {
  common_tags = {
    Project = var.project
    Environment = var.environment
    Terraform = "true"
  }

name_tag={
     

  Name = "${var.project}-${var.environment}"
}

#prefix=merge(local.common_tags,local.name_tag)





}

# tags = merge(
#     local.common_tags,
#     {
#       Name = "${var.project}-${var.environment}"
#     }
#   )
# }