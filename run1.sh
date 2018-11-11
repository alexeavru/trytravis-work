#!/bin/bash
set -e
PROJECT_ROOT=`pwd`

cd /usr/local/src

echo '*************************************************************'
echo 'Install Ansible-lint'
echo '*************************************************************'
# Install Ansible-lint
sudo pip install ansible-lint
ansible-lint --version

echo '*************************************************************'
echo 'Install Terraform'
echo '*************************************************************'
# Install Terraform
sudo wget https://releases.hashicorp.com/terraform/0.11.9/terraform_0.11.9_linux_386.zip
sudo unzip terraform_*.zip
sudo rm -f terraform_*.zip
sudo mv /usr/local/src/terraform /usr/local/bin/
terraform -v

echo '*************************************************************'
echo 'Install Tflint'
echo '*************************************************************'
# Install tflint
sudo wget https://github.com/wata727/tflint/releases/download/v0.7.2/tflint_linux_386.zip
sudo unzip tflint_*.zip
sudo rm -f tflint_*.zip
sudo mv /usr/local/src/tflint /usr/local/bin/
tflint -v

echo '*************************************************************'
echo 'Install Packer'
echo '*************************************************************'
# Install packer
sudo wget https://releases.hashicorp.com/packer/1.3.1/packer_1.3.1_linux_386.zip
sudo unzip packer_1.3.1_linux_386.zip
sudo rm -f packer_1.3.1_linux_386.zip
sudo mv packer /usr/local/bin/
OUTPUT="$(packer -v)"
echo $OUTPUT

cd $PROJECT_ROOT

# Run TESTS
echo '**** RUN TESTS ****'

echo '*************************************************************'
echo 'RUN ANSIBLE-LINT TESTS'
echo '*************************************************************'
ansible-lint --exclude=roles/jdauphant.nginx ansible/playbooks/*.yml

echo '*************************************************************'
echo 'RUN PACKER TESTS'
echo '*************************************************************'
cd $PROJECT_ROOT
packer validate -var-file=packer/variables.json.example packer/app.json
echo $?
packer validate -var-file=packer/variables.json.example packer/db.json
echo $?
packer validate -var-file=packer/variables.json.example packer/immutable.json
echo $?
packer validate -var-file=packer/variables.json.example packer/ubuntu16.json
echo $?

echo '*************************************************************'
echo 'END TESTS'
echo '*************************************************************'
