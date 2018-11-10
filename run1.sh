#!/bin/bash
PROJECT_ROOT=`pwd`

cd /usr/local/src

echo '*************************************************************'
echo 'Install Packer'
echo '*************************************************************'
# Install packer
sudo wget https://releases.hashicorp.com/packer/1.3.2/packer_1.3.2_linux_amd64.zip
sudo unzip packer_*.zip
sudo rm -f packer_*.zip
sudo mv packer /usr/local/bin/
packer -v

echo 'Step 111111111111111111111111111111111111111'

cd $PROJECT_ROOT

echo '*************************************************************'
echo 'RUN PACKER TESTS'
echo '*************************************************************'
cd $PROJECT_ROOT
packer validate -var-file=packer/variables.json.example packer/app.json
packer validate -var-file=packer/variables.json.example packer/db.json
packer validate -var-file=packer/variables.json.example packer/immutable.json
packer validate -var-file=packer/variables.json.example packer/ubuntu16.json

echo '*************************************************************'
echo 'END TESTS'
echo '*************************************************************'
