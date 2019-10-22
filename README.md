# Beaker Development Environment #
![](https://github.com/beaker-project/beaker-container/workflows/Docker%20Compose%20CI/badge.svg)

**Note**  
To use this setup, you need to understand containers and Beaker. The container
environment does not provide a production level setup, but is just enough to
hack on the WebUI/Client and run the tests. If you want a proper development
environment, use [Beaker in a box](https://github.com/beaker-project/beaker-in-a-box).

This repository contains container files and ansible playbooks to create a
development environment.

## Creating a development sandbox ##

### Prerequisites ###

Docker/Docker Compose or Podman/Podman Compose are required.
* [Docker](https://www.docker.com/)
* [Podman](https://podman.io/)
* [Docker Compose](https://docs.docker.com/compose/install/)
* [Podman Compose](https://github.com/containers/podman-compose)

### Configuring your environment ###

Make sure you clone the `beaker` and the `beaker-container` projects
to the same location, as the container will include the repository
(by default located at ../beaker relative to docker-compose.yml)
under `/home/dev/beaker`. This allows to hack on beaker from
your host development environment, while being able to run the
server and/or tests inside of the container.

Be sure to edit the `.env` file inside the `beaker-container` folder
and configure your user's UID and GID. This will be needed when setting
ownership of files mounted to the container.

Change the `beaker/Server/dev.cfg` file to configure sqlalchemy to connect
to the `beaker-database` container, instead of `localhost`.
Also install the git submodules for the `beaker` project.

### Running the containers ###

Use docker-compose to run the sandbox and database containers.
The images needed for the run will be built automatically in the first run.

    $ ls
    db dev docker-compose.yml LICENSE README.md
    $ docker-compose up -d

Remove the `-d` option if you want to keep docker-compose in the foreground.

### Attaching to the sandbox ###

With the containers up and running, use `exec` to start a shell in the sandbox container.

    $ docker exec -it beaker-container_sandbox_1 bash

### Bootstrapping the Server ###

If this is the first run of the containers (and it should be at this point), run the bootstrap
ansible playbook available in the sandbox.

    docker $ cd ansible
    docker $ ansible-playbook -c local bootstrap-server.yml

The playbook will create a `dev` user with proper UID and GID, assuring permissions
for files in the mounted volume. It will also connect to the database container and create
the table structure for Beaker.

After that, you can run the server by becoming the `dev` user, going to your home folder
and running the start script.

    docker $ sudo su dev
    docker $ cd
    docker $ cd beaker/Server
    docker $ ./run-server.sh

### Database Problems ###

If you run into database problems, just delete the database on the host and
re-create it in the docker environment by removing the apropriate volume
and running the bootstrap playbook again.

    $ docker volume rm beaker-container_beaker-db-data
    $ docker exec -it beaker-container_sandbox_1 bash
    docker $ cd ansible
    docker $ ansible-playbook -c local bootstrap-server.yml
