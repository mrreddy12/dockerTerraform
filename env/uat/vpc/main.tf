module "vpc" {
    source = "../../../modules-/vpc"
    

        ////below two per vpc creation
        project = var.project
    environment = var.environment
     public_subnet_cidrs = var.public_subnet_cidrs
        private_subnet_cidrs = var.private_subnet_cidrs
    database_subnet_cidrs = var.database_subnet_cidrs
   # source = "git::https://github.com/daws-84s/terraform-aws-vpc.git?ref=main"
    /* project = "roboshop"
    environment = "dev"
    public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"] */
    # project = var.project
    # environment = var.environment
    # public_subnet_cidrs = var.public_subnet_cidrs
    # private_subnet_cidrs = var.private_subnet_cidrs
    # database_subnet_cidrs = var.database_subnet_cidrs

    # is_peering_required = true
}