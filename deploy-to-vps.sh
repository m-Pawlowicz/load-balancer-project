#!/bin/bash
set -e

source .venv/bin/activate
ansible-playbook -i ansible/inventory.yml ansible/deploy.yml "$@"