FROM beaker_devbase:latest

RUN ansible-galaxy install bennojoy.mysql

USER dev

ADD ansible/ /home/dev/ansible/
RUN cd /home/dev/ansible &&\
    PYTHONUNBUFFERED=1 ansible-playbook -c local dev-env.yml -vvv

WORKDIR /home/dev
CMD bash
