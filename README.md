# terraform-docker-build
A project to set up infrastructure in AWS for a Docker based app. It build code, creates DNS names and then stands up the application and its container and fills in Cassandra instance with out test data.

This script requires that you pass in a value for your SSH key. It can take a parameter called environment so that many versions of the same result can co-exists
It also expects a couple of environment variable passed thru to the VM for the Scala build

The build is only a stop gap measure until the build process is addressed.

Next steps
====
1. Remove the build part and pull pre-built containers from a registry.
2. Rename the state file inline with the environment name.
