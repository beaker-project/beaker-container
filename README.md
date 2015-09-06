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

### Improving Performance ###

By default the database is kept in the container, which leads to poor
performance. You can speed up test times by keeping the database in a volume and
mount it from a tempfs directory. Change the volumes in `docker-compose.yml` for
example to:
   
    volumes:
        - ../../beaker:/workspace
        - /tmp/beaker_mysql:/var/lib/mysql/

### Bootstrapping the Server ###

You can initialise the server by running. The playbook makes sure the databases
are created and runs the beaker server init script:

    $ cd /ansible
    $ ansible-playbook -c local bootstrap-server.yml

### Database Problems ###

If you run into database problems, re-creating the database is a single
playbook run:

    $ cd /ansible
    $ ansible-playbook -c local bootstrap-server.yml

## Credits ##

* Sunil Thaha
