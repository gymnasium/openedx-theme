#!/bin/bash

cd ~  
git clone https://github.com/appsembler/configuration 
cd configuration 
git checkout appsembler/gymnasium/hawthorn/master
# install python 2.7, pip and python virtualenv
sudo apt-get update
sudo apt-get install python2.7 python-pip python-virtualenv -y
sudo pip install -r requirements.txt 
cd playbooks  

#link edx_ansible roles and libraries
ln -s ~/configuration/playbooks/roles ~/openedx-theme/deploy/roles
ln -s ~/configuration/playbooks/library ~/openedx-theme/deploy/library

#deploy
ansible-playbook -i ~/inventory --user $CIRCLE_USER -e THEME_BRANCH=$CIRCLE_BRANCH ~/openedx-theme/deploy/deploy_staging.yml -vvv
