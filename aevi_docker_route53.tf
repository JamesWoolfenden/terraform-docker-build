#to get zone id
#aws route53 list-hosted-zones

resource "aws_route53_record" "dms" {
   zone_id = "${var.zone_id}"
   name = "dms.${var.dnsname}"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_instance.docker-host.public_dns}"]
}

resource "aws_route53_record" "admin" {
   zone_id = "${var.zone_id}"
   name = "admin.${var.dnsname}"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_instance.docker-host.public_dns}"]
}

resource "aws_route53_record" "marketplace" {
   zone_id = "${var.zone_id}"
   name = "marketplace.${var.dnsname}"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_instance.docker-host.public_dns}"]
}
