#!/bin/bash
PROJECT_ROOT=`pwd`

cd /usr/local/src

echo '*************************************************************'
echo 'Install Packer'
echo '*************************************************************'
# Install packer

echo 'rm /usr/local/bin/packer'
sudo rm -f /usr/local/bin/packer

echo 'wget packer'
sudo wget https://releases.hashicorp.com/packer/1.3.2/packer_1.3.2_linux_amd64.zip

echo 'unzip packer'
sudo unzip packer_*.zip

echo 'rm packer ZIP'
sudo rm -f packer_*.zip

echo 'MV PACKER'
sudo mv packer /usr/local/bin/


PACKER=`packer -v`
echo $PACKER

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
