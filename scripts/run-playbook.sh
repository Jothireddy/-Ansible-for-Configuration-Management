#!/bin/bash
# This script runs the master playbook using the inventory file
ansible-playbook -i inventory/hosts.ini playbooks/site.yml
