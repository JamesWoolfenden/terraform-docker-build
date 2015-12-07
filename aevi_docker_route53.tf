#to get zone id
#aws route53 list-hosted-zones

resource "aws_route53_record" "dms" {
   zone_id = "${var.zone_id}"
   name = "dms.${var.environment}.${var.domain}"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_instance.docker-host.public_dns}"]
}

resource "aws_route53_record" "admin" {
   zone_id = "${var.zone_id}"
   name = "admin.${var.environment}.${var.domain}"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_instance.docker-host.public_dns}"]
}

resource "aws_route53_record" "marketplace" {
   zone_id = "${var.zone_id}"
   name = "marketplace.${var.environment}.${var.domain}"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_instance.docker-host.public_dns}"]
}
