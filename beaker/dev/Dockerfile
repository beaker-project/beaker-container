FROM beaker_devbase:latest

RUN ansible-galaxy install geerlingguy.mysql

USER ansibledev

ADD ansible/ /home/dev/ansible/
RUN cd /home/dev/ansible &&\
    PYTHONUNBUFFERED=1 ansible-playbook -c local dev-env.yml -vvv

WORKDIR /home/dev
CMD bash
