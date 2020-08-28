#!/bin/bash

cd ~  
git clone https://github.com/gymnasium/configuration 
cd configuration 
git checkout hawthorn.staging 
sudo pip install -r requirements.txt 
cd playbooks  

#link edx_ansible roles and libraries
ln -s ~/configuration/playbooks/roles ~/openedx-theme/deploy/roles
ln -s ~/configuration/playbooks/library ~/openedx-theme/deploy/library

#deploy
ansible-playbook -i ~/inventory --user $CIRCLE_USER -e THEME_BRANCH=$CIRCLE_BRANCH ~/openedx-theme/deploy/aquent_deploy.yml

