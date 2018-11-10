#!/bin/bash
PROJECT_ROOT=`pwd`

cd /usr/local/src

echo '*************************************************************'
echo 'Install Packer'
echo '*************************************************************'
# Install packer
sudo wget https://releases.hashicorp.com/packer/1.3.1/packer_1.3.1_linux_386.zip
sudo unzip packer_1.3.1_linux_386.zip
sudo rm -f packer_1.3.1_linux_386.zip
sudo mv packer /usr/local/bin/
sodo packer -v


cd $PROJECT_ROOT


echo '*************************************************************'
echo 'RUN PACKER TESTS'
echo '*************************************************************'
cd $PROJECT_ROOT
sudo packer validate -var-file=packer/variables.json.example packer/app.json
sudo packer validate -var-file=packer/variables.json.example packer/db.json
sudo packer validate -var-file=packer/variables.json.example packer/immutable.json
sudo packer validate -var-file=packer/variables.json.example packer/ubuntu16.json


echo '*************************************************************'
echo 'END TESTS'
echo '*************************************************************'
