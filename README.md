# terraform-docker-build
This old repo is an example of how you can set up infrastructure in AWS for a Docker based app. It builds infrastructure, pulls code, builds code.

This script requires that you pass in a value for your SSH key. It can take a parameter called environment so that many versions of the same result can co-exists

Next steps
====
1. Remove the build part and pull pre-built containers from a registry.
