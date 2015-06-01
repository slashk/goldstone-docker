Goldstone Dockerfiles and Compose Configuration
===============================================

# Build a docker image
docker build -t docker-registry/image-name:version .

For example (from the directory containing Dockerfile):
docker build -t solinea/logstash:1.4 .
docker tag IMAGEID solinea/logstash:latest

# Testing
Run `rake test` to run all Dockerfile image tests.

Note: If using docker-machine, services will be exposed at the IP `docker-machine ip`