Goldstone Dockerfiles and Compose Configuration
===============================================

# Build a docker image
docker build -t docker-registry/image-name:version .

For example (from the directory containing Dockerfile):
docker build -t solinea/logstash:1.4 .
docker tag IMAGEID solinea/logstash:latest

# Image Versioning
In Dockerfiles/<ImageName>/VERSION, write a single line with the image tagged version.
If the version used is from the default OS Repository, use the OS name for the version (e.g. centos7).

# Testing
Run `rake test` to run all Dockerfile image tests.

Note: If using docker-machine, services will be exposed at the IP `docker-machine ip`