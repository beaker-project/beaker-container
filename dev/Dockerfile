FROM centos:centos7

RUN yum install -y zsh vim sudo lsof nc less curl && \
    echo 'ansibledev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    echo 'Defaults:ansibledev !requiretty' >> /etc/sudoers && \
    useradd -u 1002 ansibledev && \
    usermod -aG wheel ansibledev && \
    yum clean all

### ansible setup ###

RUN yum clean all && \
    yum install -y \
        https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum -y install \
        PyYAML python-jinja2 python-httplib2 python-keyczar \
        gcc libyaml-devel python-devel python-crypto pyasn1 \
        python-paramiko python-setuptools git python-pip \
        libselinux-python && \
    yum clean all

RUN pip install --upgrade setuptools

RUN mkdir /etc/ansible/ && \
    echo -e '[local]\nlocalhost' > /etc/ansible/hosts && \
    pip install ansible && \
    pip uninstall -y pycrypto && \
    yum erase -y python-crypto && \
    yum install -y python-crypto python-paramiko && \
    yum remove -y epel-release && \
    yum clean all

USER ansibledev

ADD ansible/ /home/ansibledev/ansible/

RUN cd /home/ansibledev/ansible &&\
    PYTHONUNBUFFERED=1 ansible-playbook -c local dev-env.yml -vvv

WORKDIR /home/ansibledev

CMD tail -f /dev/null
