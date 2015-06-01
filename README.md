Goldstone Dockerfiles and Compose Configuration
===============================================

Docker image definitions and configurations for https://github.com/Solinea/goldstone-server.

## Run Docker Compose
Docker compose allows you to run the entire envirnment, including all links between containers.
To install on Mac OSX, run `brew install docker-compose`.
From the root of repo run `docker-compose up`.

## Test Image Builds
`docker build -t docker-registry/image-name:latest`
*The latest tag is required so that docker-compose will work*

## Testing
Run `rake test` to run all Dockerfile image tests.
*Note*: If using docker-machine, services will be exposed at the IP `docker-machine ip`