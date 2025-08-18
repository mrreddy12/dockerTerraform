# resource "aws_route53_record" "www" {
#     //count=4  # 4 records will be creatd
#       count = length(var.instances)
#  // for_each = aws_instance.roboshop
#   zone_id = var.zone_id
#   name    = "${var.instances[count.index]}.${var.domain_name}" 
#   #name    = "${var.instances[count.index]}.${var.domain_name}"#mongodb.daws84s.site
#   type    = "A"
#   ttl     = 1
#   records = [aws_instance.roboshop[count.index].private_ip]# 4 instances..from each istnace..getting private ip
# }