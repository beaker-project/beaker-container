# Beaker Development Environment #

This repository contains docker files and ansible play books to create a
development environment.

## Creating a development sandbox ##

### Prerequisites ###

* <https://docs.docker.com/compose/install/> 

### Building images ###

Build the devbase image. The image is based on beaker_base which should be build
before hand.

    $ docker-compose build devbase
    $ docker-compose build dev

The dev image is build by running an ansible playbook. It will create three
mysql databases for the server and two for running the integration tests.

### Running container ###

Make sure you have the beaker sources cloned. The docker container will include
the repository (by default located at ../../beaker relative to
docker-compose.yml) under /workspace. This allows to hack on beaker from your
host development environment, while being able to run tests etc in docker.

Use docker-compose to run the container:

    $ docker-compose run --service-ports sandbox

Keep in mind that mysqld is not running yet:

    $ sudo service mysqld start

Keep in mind that the root password for mysql is set to an empty string. The
service port is not exposed by default.

Follow the developer guide to initialize the database
<https://beaker-project.org/dev/guide/getting-started.html>.

### Save the container for future (re)use

Once the database is initialized, it is a good time to
save the progress using `docker commit`


    # create a docker image and tag it beaker_dev:<month><day>
    $ docker ps -a | grep beaker_dev_run
    # note the container id: something like beaker_dev_run_1
    $ docker commit -p -m='after db init' <container_id> beaker_dev:$(date +%m%d)
    $ docker tag beaker_dev:$(date +%m%d) beaker_dev:latest

When you start the container again it will now be using the container state at
`beaker_dev:$(date +%m%d)`. Remember, that you still need to start mysqld.


## Credits ##

* Sunil Thaha
