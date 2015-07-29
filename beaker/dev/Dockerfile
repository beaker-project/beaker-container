FROM beaker_devbase:latest

RUN ansible-galaxy install bennojoy.mysql

USER dev

ADD ansible/ /tmp/ansible/
RUN cd /tmp/ansible &&\
    PYTHONUNBUFFERED=1 ansible-playbook -c local dev-env.yml -vvv

WORKDIR /workspace
CMD bash
