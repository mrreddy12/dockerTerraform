data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"   #same path and vpc_id   path copy from vpc-parameter.ts
}
