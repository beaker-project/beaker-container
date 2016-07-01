# Beaker Development Environment #

** Note **
To use this setup, you need to understand Docker and Beaker. The docker
environment does not provide a production level setup, but is just enough to
hack on the WebUI/Client and run the tests. If you want a proper development
environment, use [Beaker in a box](https://beaker-project.org/docs/in-a-box/).


This repository contains docker files and ansible play books to create a
development environment.

## Creating a development sandbox ##

### Prerequisites ###

* docker compose <https://docs.docker.com/compose/install/> 

### Building images ###

Build the devbase image. The image is based on beaker_base which should be build
before hand.

    $ docker-compose build

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

### Different Host User/GID than 1000###

In case your local user has a different UID than 1000 (e.g. you're using SSSD),
start the container by supplying your uid/gid:

    $ docker-compose run --service-ports -e LOCAL_USER_ID=`id -u` -e LOCAL_GROUP_ID=`id -g` sandbox

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
