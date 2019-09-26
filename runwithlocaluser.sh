#!/bin/bash
set -xe

uid=${LOCAL_USER_ID:-1000}
gid=${LOCAL_GROUP_ID:-$uid}

echo "Found local user/gid: $uid $gid"

sudo groupadd -g $gid dev
sudo useradd -u $uid -g $gid dev
sudo usermod -aG wheel dev
sudo chown dev:dev /home/dev
sudo bash -c "echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"
sudo bash -c "echo 'Defaults:dev !requiretty' >> /etc/sudoers"
exec /usr/bin/sudo su - dev
