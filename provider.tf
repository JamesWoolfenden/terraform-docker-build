provider "aws" {
    version= "1.45"
    region     = "${var.region}"
}

provider "tls" {
    version = "1.2"
}