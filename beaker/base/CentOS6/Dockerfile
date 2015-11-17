FROM centos:centos6.6

RUN yum install -y zsh vim sudo lsof nc less curl && \
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    echo 'Defaults:dev !requiretty' >> /etc/sudoers && \
    useradd -u 1000 dev && \
    usermod -aG wheel dev && \
    chown dev:dev /home/dev && \
    yum clean all

### ansible setup ###

RUN yum clean all && \
    yum install -y \
        https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
    yum -y install \
        PyYAML python-jinja2 python-httplib2 python-keyczar \
        gcc libyaml-devel python-devel python-crypto pyasn1 \
        python-paramiko python-setuptools git python-pip \
        libselinux-python && \
    yum clean all


RUN mkdir /etc/ansible/ && \
    echo -e '[local]\nlocalhost' > /etc/ansible/hosts && \
    pip install ansible && \
    pip uninstall -y pycrypto && \
    yum erase -y python-crypto && \
    yum install -y python-crypto python-paramiko && \
    yum remove -y epel-release && \
    yum clean all

CMD bash
