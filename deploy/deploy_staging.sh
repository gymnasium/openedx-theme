#!/bin/bash

cd ~  
git clone https://github.com/appsembler/configuration 
cd configuration 
git checkout appsembler/hawthorn/master 
sudo pip3 install -r requirements.txt 
cd playbooks  

#link edx_ansible roles and libraries
ln -s ~/configuration/playbooks/roles ~/openedx-theme/deploy/roles
ln -s ~/configuration/playbooks/library ~/openedx-theme/deploy/library

#deploy
ansible-playbook -i ~/inventory --user $CIRCLE_USER -e THEME_BRANCH=$CIRCLE_BRANCH ~/openedx-theme/deploy/aquent_deploy.yml

