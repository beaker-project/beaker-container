# Beaker Development Environment #

This repository contains docker files and ansible play books to create a
development environment.

## Creating a development sandbox ##

### Prerequisites ###

* docker compose <https://docs.docker.com/compose/install/> 

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
docker-compose.yml) under `/home/dev/beaker`. This allows to hack on beaker from
your host development environment, while being able to run tests etc in docker.

Use docker-compose to run the container:

    $ ls
    base dev docker-compose.yml
    $ docker-compose run --service-ports sandbox

The database is not running yet. It's best to initialise the server as described
next.

### Bootstrapping the Server ###

The playbook makes sure the databases are created and runs the beaker server
init script:

    docker $ cd
    docker $ cd ansible
    docker $ ansible-playbook -c local bootstrap-server.yml

### Database Problems ###

If you run into database problems, just delete the database on the host and
re-create it in the docker environment by restarting the container:

    $ sudo rm -rf /tmp/beaker_mysql
    $ docker-compose run --service-ports sandbox
    docker $ cd ansible
    docker $ ansible-playbook -c local bootstrap-server.yml

## Credits ##

* Sunil Thaha
