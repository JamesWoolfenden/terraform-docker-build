# terraform-docker-build
This repo is an example of how you can set up infrastructure in AWS for a Docker based app. It builds infrastructure, pulls code, builds code, creates DNS names and then stands up the application and its container and inserts data into Cassandra instance.

This script requires that you pass in a value for your SSH key. It can take a parameter called environment so that many versions of the same result can co-exists
It also expects a couple of environment variable passed thru to the VM for the Scala build

The build is only a stop gap measure until the build process is addressed.

Next steps
====
1. Remove the build part and pull pre-built containers from a registry.
2. Rename the state file inline with the environment name.
3. Handling Secrets, maybe from Vault. Currently a file is excluded from the repo called secrets.tf:

variable "public_key"
{
   default="your private key"
}

variable "zone_id" {
  description  ="route53Zone"
  default="yourdomainzoneid"
}
