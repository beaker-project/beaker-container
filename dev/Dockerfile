FROM beaker-docker_devbase:latest

USER ansibledev

RUN ansible-galaxy install geerlingguy.mysql

ADD ansible/ /home/dev/ansible/
RUN cd /home/dev/ansible &&\
    PYTHONUNBUFFERED=1 ansible-playbook -c local dev-env.yml -vvv

WORKDIR /home/dev
CMD bash
