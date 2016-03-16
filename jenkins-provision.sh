#!/bin/bash

source aws.credentials

cd jenkins/provisioning

export PYTHONUNBUFFERED=1
export ANSIBLE_FORCE_COLOR=true
export ANSIBLE_HOST_KEY_CHECKING=false
export ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null -o ControlMaster=auto -o ControlPersist=60s'
ansible-playbook --private-key=../../awsroot-ireland.pem --user=ec2-user --connection=ssh --limit='all' --inventory-file=inventory/ec2.py --sudo -vvvv playbook.yml
