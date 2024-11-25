#!/bin/bash
rm -f inventory
vagrant up
wait
git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install -r requirements.txt
pip install ruamel_yaml
# Copy ``inventory/sample`` as ``inventory/mycluster``
cp -rfp inventory/sample inventory/mycluster
# Update Ansible inventory file with inventory builder
declare -a IPS=$(awk '{printf "%s ", $0} END {print ""}' ../inventory)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
ansible-playbook -i inventory/mycluster/hosts.yaml  --user=vagrant --become --become-user=root cluster.yml